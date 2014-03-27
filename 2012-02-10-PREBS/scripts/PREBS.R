# Authors: Karolis Uziela, Antti Honkela

########################################### Libraries #################################################

library(Rsamtools)
library(GenomicRanges)
library(affy)
library(parallel)

######################################## Function definitions #########################################

## Take "_mapping.txt" filename and return the name of respective package ("HGU133Plus2_Hs_ENSG_mapping.txt" -> "hgu133plus2hsensgcdf")
cdf_package_name <- function(mapping_txt_file) {
  my_cdf <- basename(mapping_txt_file)
  my_cdf <- sub("_mapping.txt", "", my_cdf)
  my_cdf <- gsub("_", "", my_cdf)
  my_cdf <- tolower(my_cdf)
  my_cdf <- paste(my_cdf, "cdf", sep="")
  return(my_cdf)
}

## Read CDF probe mapping file and create GRanges object from it
granges_from_cdf <- function(cdf_mapping_file, CDF_NAME) {
  old.scipen <- getOption("scipen")
  options("scipen" = 100) # Avoid exponential number expressions in probe_id

  # Read probe mapping file
  probes <- read.table(cdf_mapping_file, sep = "\t", header=TRUE)

  # create GRanges object
  probe_id <- xy2indices(probes$Probe.X, probes$Probe.Y, cdf=CDF_NAME)
  chromosome <- probes$Chr
  range_start <- probes$Chr.From
  range_end <- range_start + 24
  strand_id <- probes$Chr.Strand
  my_ranges <- GRanges(seqnames=Rle(chromosome), ranges = IRanges(range_start, range_end, names=probe_id), strand = Rle(strand_id))
  
  options("scipen" = old.scipen)  
  
  return(my_ranges)
}

## Read a single BAM file and count overlaps with probe regions
read_bam_and_count_overlaps <- function(bam_file, probe_ranges) {
  library(Rsamtools)
  bam_aligns <- readBamGappedAlignments(bam_file)
  counts <- countOverlaps(probe_ranges, bam_aligns)
  rm(bam_aligns)
  gc()
  return(counts)
}

## Read all BAM files and calculate read overlaps with probe regions
count_overlaps_from_bam <- function(bam_files, cdf_mapping_file, CDF_NAME, N_CORES) {
  CLUSTER <- makeCluster(N_CORES)

  my_ranges <- granges_from_cdf(cdf_mapping_file, CDF_NAME)
    
  counts <- parLapply(CLUSTER, bam_files, read_bam_and_count_overlaps, probe_ranges=my_ranges)
  probe_table <- do.call(cbind, counts)
  colnames(probe_table) <- bam_files

  stopCluster(CLUSTER)
  
  return(probe_table)
}

## This function is used for optimization of Bayesian prior
fr <- function(x,k) {
  alpha <- x[1]
  beta <- x[2]
  -sum(alpha*log(beta) - (alpha+k)*log(beta+1) + lgamma(alpha+k) - lgamma(k+1) - lgamma(alpha))
}

## Convert raw counts to expression values using statistical model
probe_table_expressions <- function(probe_table) {
  # Combine all probe level expressions into a single vector (k) and find optimal Alpha and Beta parameters for the vector 
  k <- c(probe_table)
  opt <- optim(c(0.2,0.03), fr, NULL, k, method="L-BFGS-B", lower=0.0001, upper=10)
  ALPHA <- opt$par[1]
  BETA <- opt$par[2]
  
  # Print alpha and beta
  print("Estimated alpha and beta for Bayesian prior:")
  print(ALPHA)
  print(BETA)

  # Update probe-level expressions taking prior into account
  probe_table <- (probe_table + ALPHA) / (1 + BETA)
  return(probe_table)
}

## Extract necessary information from CDF files and perform RMA algorithm
perform_rma <- function(probe_table, CDF_NAME) {
  # Extract information about perfect match probe ids from CDF files
  setClass("CDFName", representation(cdfName="character"), prototype=(cdfName=''))

  setMethod("initialize", "CDFName", function(.Object, name) {
    .Object@cdfName <- name
    .Object
  })

  setMethod("cdfName", "CDFName", function(object)
            object@cdfName)

  cdn <- new("CDFName", CDF_NAME)
  cdf_env <- getCdfInfo(cdn)

  # Map probe identifiers in probe_table to the ones in CDF files
  all_sets <- grep('AFFX', ls(cdf_env), value=TRUE, invert=TRUE)

  # Extract pm probes for each gene
  all_probes <- lapply(mget(all_sets, cdf_env),
                       function(x) as.matrix(as.character(x[,1])))

  # Create names for probes
  for (i in seq_along(all_probes)) {
    row.names(all_probes[[i]]) <- paste(names(all_probes)[i],
                                        seq_along(all_probes[[i]]), sep='')
  }
  all_probes_vec <- do.call(rbind, all_probes)
  probe_table_mapped <- probe_table[all_probes_vec,]
  row.names(probe_table_mapped) <- row.names(all_probes_vec)

  # Create pNList and ngenes input variables
  pNList <- substr(rownames(probe_table_mapped),1,18)
  pNList <- split(0:(length(pNList) - 1), pNList)
  ngenes <- length(pNList)

  # Set RMA parameters
  verbose = TRUE; normalize = TRUE; background = FALSE; bgversion = 2

  # Apply RMA
  prebs_values <- .Call("rma_c_complete_copy", probe_table_mapped, pNList, ngenes, normalize, background, bgversion, verbose, PACKAGE = "affy")

  # Save the results
  prebs_values <- as.data.frame(prebs_values)
  colnames(prebs_values) <- colnames(probe_table)
  prebs_values$Gene_ID <- substr(rownames(prebs_values), 1, nchar(rownames(prebs_values))-3) # remove trailing _at from identifiers
  rownames(prebs_values) <- 1:nrow(prebs_values)
  
  return(prebs_values)
}

## Calculate PREBS values for given BAM files
## Arguments:
## 1) A vector containing .bam files
## 2) A file containing probe mappings in the genome (such as "HGU133Plus2_Hs_ENSG_mapping.txt")
## 3) Number of CPU cores to use
## NOTE: CDF package has to be first downloaded and installed from Custom CDF website: http://brainarray.mbni.med.umich.edu/CustomCDF
prebs <- function(bam_files, cdf_mapping_file, N_CORES = 1) {
  CDF_NAME <- cdf_package_name(cdf_mapping_file) # Get CDF package name from the filename of cdf mapping file
  
  probe_table <- count_overlaps_from_bam(bam_files, cdf_mapping_file, CDF_NAME, N_CORES) # Read bam files and calculate read overlaps with probe regions
  
  probe_table <- probe_table_expressions(probe_table) # Convert raw probe region counts to probe region expressions using statistical model
  
  prebs_values <- perform_rma(probe_table, CDF_NAME) # Perform RMA on probe region expressions
  
  return(prebs_values)
}


