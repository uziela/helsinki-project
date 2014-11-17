# Authors: Karolis Uziela, Antti Honkela

########################################### Libraries #################################################

#library(GenomicAlignments)
#library(GenomicRanges)
#library(affy)
#library(parallel)

######################################## Function definitions #########################################

#' PREBS package
#'
#' The prebs package aims at making RNA-sequencing (RNA-seq)
#' data more comparable to microarray data. The comparability is achieved
#' by summarizing sequencing-based expressions of probe regions using
#' a modified version of RMA algorithm. The pipeline takes mapped reads
#' in BAM format as an input and produces either gene expressions or
#' original microarray probe set expressions as an output.
#'
#' The package has only one public function: \code{calc_prebs}. 
#' Type help(calc_prebs) for more information on the usage.
#' @importFrom GenomicAlignments readGAlignmentsFromBam readGAlignmentPairs
#' @importFrom stats optim
#' @importFrom parallel parLapply
#' @importFrom methods setClass setMethod
#' @importFrom affy xy2indices
#' @importClassesFrom GenomicRanges GRanges
#' @importClassesFrom IRanges IRanges
#' @importMethodsFrom IRanges countOverlaps
#' @importFrom affy getCdfInfo
#' @docType package
#' @name prebs
NULL

## Take "_mapping.txt" filename and return the name of respective package ("HGU133Plus2_Hs_ENSG_mapping.txt" -> "hgu133plus2hsensgcdf")
cdf_package_name <- function(mapping_txt_file) {
  my_cdf <- basename(mapping_txt_file)
  my_cdf <- sub("_mapping.txt", "", my_cdf)
  my_cdf <- gsub("_", "", my_cdf)
  my_cdf <- tolower(my_cdf)
  my_cdf <- paste(my_cdf, "cdf", sep="")
  message(paste("Inferred name for CDF package: ", basename(mapping_txt_file), " -> ", my_cdf, "\n", sep=""))
  return(my_cdf)
}

# Check if a package is installed
is.installed <- function(mypkg) {
  is.element(mypkg, installed.packages()[,1]) 
}

# Check if the input files exist and if the CDF package is installed
check_input <- function(bam_files, probe_mapping_file, cdf_name) {
  if (! is.installed(cdf_name)) {
    stop(paste("CDF package `", cdf_name, "` is not installed. Please, install the package before running `calc_prebs`\n", sep=""))
  }
  if (! file.exists(probe_mapping_file) ) {
    stop(paste("Probe mapping file `", probe_mapping_file, "` does not exist.\n", sep=""))
  }
  for (i in 1:length(bam_files)) {
    if (! file.exists(bam_files[i]) ) {
      stop(paste("BAM file `", bam_files[i], "` does not exist. If you are running the code from examples, please, install `prebsdata` package first.\n", sep=""))
    }
  }
}

## Read CDF probe mapping file and create GRanges object from it
granges_from_cdf <- function(probe_mapping_file, CDF_NAME) {
  old.scipen <- getOption("scipen")
  options("scipen" = 100) # Avoid exponential number expressions in probe_id

  # Read probe mapping file
  probes <- read.table(probe_mapping_file, sep = "\t", header=TRUE)

  # create GRanges object
  PROBE_SEQ_LENGTH = 25
  probe_id <- xy2indices(probes$Probe.X, probes$Probe.Y, cdf=CDF_NAME)
  chromosome <- probes$Chr
  range_start <- probes$Chr.From
  range_end <- range_start + PROBE_SEQ_LENGTH - 1
  strand_id <- probes$Chr.Strand
  my_ranges <- GRanges(seqnames=Rle(chromosome), ranges = IRanges(range_start, range_end, names=probe_id), strand = Rle(strand_id))
  
  options("scipen" = old.scipen)  
  
  return(my_ranges)
}

## Read a single BAM file and count overlaps with probe regions
read_bam_and_count_overlaps <- function(bam_file, probe_ranges, paired_ended_reads, ignore_strand) {
  #library(GenomicAlignments)
  #library(GenomicRanges)
  if (paired_ended_reads) {
    bam_aligns <- readGAlignmentPairs(bam_file)
  } else {
    bam_aligns <- readGAlignmentsFromBam(bam_file)
  }

  if (! ("X" %in% names(seqlengths(bam_aligns)))) {
    stop("Unrecognized chromosome names. You are probably using a bam file whose reads were mapped to UCSC genome. Currently only bam files with reads mapped to ENSEMBL genome are supported. ENSEMBL reference genomes can be downloaded from ENSEMBL FTP server.")
  }  

  counts <- countOverlaps(probe_ranges, bam_aligns, ignore.strand=ignore_strand) 

  rm(bam_aligns)
  gc()
  print(paste("Finished:",bam_file))
  return(counts)
}

## Read all BAM files and calculate read overlaps with probe regions
count_overlaps_from_bam <- function(bam_files, probe_mapping_file, CDF_NAME, CLUSTER, paired_ended_reads, ignore_strand) {

  my_ranges <- granges_from_cdf(probe_mapping_file, CDF_NAME)
  
  if (is.null(CLUSTER)) {
    counts <- lapply(bam_files, read_bam_and_count_overlaps, probe_ranges=my_ranges, paired_ended_reads=paired_ended_reads, ignore_strand = ignore_strand)
  } else {
    counts <- parLapply(CLUSTER, bam_files, read_bam_and_count_overlaps, probe_ranges=my_ranges, paired_ended_reads=paired_ended_reads, ignore_strand = ignore_strand)
  }
  probe_table <- do.call(cbind, counts)
  colnames(probe_table) <- basename(bam_files)
  rownames(probe_table) <- names(my_ranges)
  
  return(probe_table)
}

## This function is used for optimization of Bayesian prior
fr <- function(x,k) {
  alpha <- x[1]
  beta <- x[2]
  -sum(alpha*log(beta) - (alpha+k)*log(beta+1) + lgamma(alpha+k) - lgamma(k+1) - lgamma(alpha))
}

## This function sums rows with duplicate ids. Rows shouldn't have any duplicate ids in when using Custom CDF files.
## However, when using manufacturer's CDF files, duplicate row ids may arise bacause bowtie might map probe sequence to several
## different locations. In that case, we have to sum probe region counts from all of these locations.
sum_duplicates <- function(probe_table) {
  if (sum(duplicated(rownames(probe_table))) > 0) {
    message("Note: Some probe IDs contain duplicates.\n")
    
    unique_row_names <- unique(rownames(probe_table))
    unique_probe_table <- matrix(data=0, nrow=length(unique_row_names), ncol=ncol(probe_table))
    rownames(unique_probe_table) <- unique_row_names
    colnames(unique_probe_table) <- colnames(probe_table)

    rn <- rownames(probe_table)
    last_id <- ""
    last_row <- NULL
    j <- 1

    for (i in 1:nrow(probe_table)) {
      new_row <- probe_table[i,]
      new_id <- rn[i]
      if (new_id == last_id) {
        last_row = last_row + new_row
      } else {
        if (!is.null(last_row)) {
          unique_probe_table[j,] <- last_row
          j = j + 1
        }
        last_row <- new_row
        last_id <- new_id
      }
    }
    unique_probe_table[j,] <- last_row
    
    return(unique_probe_table)
  } else {
    return(probe_table)
  }
}

## Convert raw counts to expression values using statistical model
probe_table_expressions <- function(probe_table) {
  # Combine all probe level expressions into a single vector (k) and find optimal Alpha and Beta parameters for the vector 
  k <- c(probe_table)
  opt <- optim(c(0.2,0.03), fr, NULL, k, method="L-BFGS-B", lower=0.0001, upper=10)
  ALPHA <- opt$par[1]
  BETA <- opt$par[2]
  
  # Print alpha and beta
  message("Estimated values for Bayesian prior:\n")
  message(paste("Alpha=", ALPHA, "\n", sep=""))
  message(paste("Beta=", BETA, "\n", sep=""))

  # Update probe-level expressions taking prior into account
  probe_table <- (probe_table + ALPHA) / (1 + BETA)
  return(probe_table)
}

# Check if all probe sequence ids are present in probe_table. 
# When working with Custom CDF it should always be the case, as long as you are using the latest version cdf package and _mapping.txt file
# When working with Manufacturer's CDF, some probe IDs might be missing in _mapping.txt file
# because the file is manually created and some probe sequences fail to be mapped to genome.
check_probe_table <- function(probe_table, all_probes_vec) {
  vec_names <- all_probes_vec[,1]
  pr_names <- rownames(probe_table)
  missing_n <- sum(!is.element(vec_names, pr_names))
  if (missing_n > 0) {
    message(paste("Note: ", missing_n, " probe sequences are missing in _mapping.txt file.\n", sep=""))
    missing_probes <- vec_names[!is.element(vec_names, pr_names)]
    dummy_matrix <- matrix(data=0, nrow=missing_n, ncol=ncol(probe_table))
    for (i in 1:ncol(dummy_matrix)) {
      dummy_matrix[,i] <- min(probe_table[,i])
    }
    rownames(dummy_matrix) <- missing_probes
    probe_table <- rbind(probe_table, dummy_matrix)
  }
  return(probe_table)
}

# Create an object for extracting information about perfect match probe ids
setClass("CDFName", representation(cdfName="character"), prototype=(cdfName=''))

setMethod("initialize", "CDFName", function(.Object, name) {
  .Object@cdfName <- name
  .Object
})

setMethod("cdfName", "CDFName", function(object) object@cdfName)

## Extract necessary information from CDF files and perform RMA algorithm
perform_rma <- function(probe_table, CDF_NAME, output_eset) {
  # Get CDF environment containing information about perfect match probe ids
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
  
  # Check if all probe ids are present in probe_table. Some might be missing for manually created _mapping.txt files
  probe_table <- check_probe_table(probe_table, all_probes_vec)

  # Select pm probes in probe_table
  probe_table_mapped <- probe_table[all_probes_vec,,drop=FALSE]
  row.names(probe_table_mapped) <- row.names(all_probes_vec)

  # Create pNList and ngenes input variables
  pNList <- sub("(.*_at)[0-9]+","\\1",rownames(probe_table_mapped))
  pNList <- split(0:(length(pNList) - 1), pNList)
  ngenes <- length(pNList)

  # Set RMA parameters
  verbose = TRUE; normalize = TRUE; background = FALSE; bgversion = 2

  # Apply RMA
  prebs_values <- .Call("rma_c_complete_copy", probe_table_mapped, pNList, ngenes, normalize, background, bgversion, verbose, PACKAGE = "affy")

  # Save the results
  coln <- colnames(probe_table)
  coln[duplicated(coln)] <- paste(coln[duplicated(coln)],1:length(coln[duplicated(coln)]), sep="") # rename duplicated columns
  colnames(prebs_values) <- coln

  if (output_eset) {
    rownames(prebs_values) <- substr(rownames(prebs_values), 1, nchar(rownames(prebs_values))-3) # remove trailing _at from identifiers
    prebs_values <- new("ExpressionSet", annotation = CDF_NAME, exprs = prebs_values)
  } else {
    prebs_values <- as.data.frame(prebs_values)
    prebs_values$ID <- substr(rownames(prebs_values), 1, nchar(rownames(prebs_values))-3) 
    rownames(prebs_values) <- 1:nrow(prebs_values)
  }

  return(prebs_values)
}

perform_rpa <- function(probe_table, CDF_NAME, output_eset) {
  # Get CDF env to find out what is the maximum probe index
  cdn <- new("CDFName", CDF_NAME)
  cdf_env <- getCdfInfo(cdn)  
  max_ind <- max(sapply(mget(ls(cdf_env), cdf_env), max))

  # Create a full matrix of probe expressions instead of sparse matrix
  min_value <- min(probe_table)
  sample_n <- ncol(probe_table)
  probe_table_full <- matrix(data=min_value,nrow=max_ind, ncol=sample_n)
  rownames(probe_table_full) <- 1:max_ind
  colnames(probe_table_full) <- paste("sample", 1:ncol(probe_table_full), sep="") # Avoid duplicate column names in RPA input
  probe_table_full[rownames(probe_table),] <- probe_table

  # Convert the matrix of probe table expressions to AffyBatch object
  eset <- ExpressionSet(assayData=probe_table_full, annotation = CDF_NAME)
  ad <- assayData(eset)
  abatch <- new("AffyBatch", cdfName = CDF_NAME, assayData=ad)
  
  # Apply RPA
  prebs_values <- rpa(abatch, bg.method="none", cdf=CDF_NAME)
  prebs_values <- exprs(prebs_values)
  prebs_values <- prebs_values[substr(rownames(prebs_values),1,4) != "AFFX",] # Remove AFFX probes

  # Save the results
  coln <- colnames(probe_table)
  coln[duplicated(coln)] <- paste(coln[duplicated(coln)],1:length(coln[duplicated(coln)]), sep="") # rename duplicated columns
  colnames(prebs_values) <- coln
  
  if (output_eset) {
    rownames(prebs_values) <- substr(rownames(prebs_values), 1, nchar(rownames(prebs_values))-3) # remove trailing _at from identifiers
    prebs_values <- new("ExpressionSet", annotation = CDF_NAME, exprs = prebs_values)
  } else {
    prebs_values <- as.data.frame(prebs_values)
    prebs_values$ID <- substr(rownames(prebs_values), 1, nchar(rownames(prebs_values))-3)
    rownames(prebs_values) <- 1:nrow(prebs_values)
  }

  return(prebs_values)
}
    
#' @title Calculate PREBS values
#'
#' @description
#' \code{calc_prebs} calculates PREBS values for given set of BAM files.
#'
#' @details
#' \code{calc_prebs} is the main function of \code{prebs} package that implements the whole
#' pipeline. The function takes mapped reads in BAM format and probe sequence
#' mappings as an input. The output depends on \code{output_eset} option. If \code{output_eset=TRUE} then
#' \code{calc_prebs} returns ExpressionSet object  (ExpressionSet object is defined in
#' \code{affy} package). Otherwise it returns a data frame containing PREBS values.
#'
#' For running \code{calc_prebs} with custom CDF, the custom CDF package has to be 
#' downloaded and installed from Custom CDF website:   
#' http://brainarray.mbni.med.umich.edu/CustomCDF
#'
#' For running \code{calc_prebs} with manufacturer's CDF, the manufacturer's CDF package 
#' can be installed from Bioconductor, for example:
#' biocLite("GenomicRanges"); 
#' biocLite("hgu133plus2cdf")
#'
#' For a detailed input specification, please refer to the \code{prebs} vignette.
#'
#' @param bam_files A vector containing .bam files.
#' @param probe_mapping_file A file containing probe mappings in the genome. 
#' @param cdf_name A name of CDF package to use in RMA algorithm. If cdf_name=NULL, the package name is inferred from the name of probe_mapping_file ("HGU133Plus2_Hs_ENSG_mapping.txt" -> "hgu133plus2hsensgcdf")
#' @param cluster A cluster object created using "makeCluster" function from "parellel" package. If cluster=NULL, no parallelization is used.
#' @param output_eset If set to TRUE, the output of \code{calc_prebs} will be ExpressionSet object. Otherwise, the output will be a data frame.
#' @param paired_ended_reads Set it to TRUE if your data contains paired-ended reads. Otherwise, the two read mates will be treated as independent units.
#' @param ignore_strand If set to TRUE, then the strand is ignored while counting read overlaps with probe regions. If you use strand-specific RNA-seq protocol, set to FALSE, otherwise set it to TRUE.
#' @return ExpressionSet object or a data frame containing PREBS values
#' @export
#' @examples 
#' if (require(prebsdata)) {
#'   # Get full paths to data files in \code{prebsdata} package
#'   bam_file1 <- system.file(file.path("sample_bam_files", "input1.bam"), package="prebsdata")
#'   bam_file2 <- system.file(file.path("sample_bam_files", "input2.bam"), package="prebsdata")
#'   bam_files <- c(bam_file1, bam_file2)
#'   custom_cdf_mapping1 <- system.file(file.path("custom-cdf", "HGU133Plus2_Hs_ENSG_mapping.txt"), 
#'                                      package="prebsdata")
#'   custom_cdf_mapping2 <- system.file(file.path("custom-cdf", "HGU133A2_Hs_ENSG_mapping.txt"), 
#'                                      package="prebsdata")
#'   manufacturer_cdf_mapping <- system.file(file.path("manufacturer-cdf", "HGU133Plus2_mapping.txt"), 
#'                                           package="prebsdata")
#'   if (interactive()) {
#'     # Run PREBS using custom CDF without parallelization
#'     prebs_values <- calc_prebs(bam_files, custom_cdf_mapping1)
#'     head(exprs(prebs_values))
#'  
#'     # Run PREBS using custom CDF with parallelization
#'     library(parallel)
#'     N_CORES = 2
#'     CLUSTER <- makeCluster(N_CORES)
#'     prebs_values <- calc_prebs(bam_files, custom_cdf_mapping1, cluster=CLUSTER)
#'     stopCluster(CLUSTER)
#'     
#'     # Run PREBS using another custom CDF
#'     prebs_values <- calc_prebs(bam_files, custom_cdf_mapping2)
#'     
#'     # Run PREBS and return data frame instead of ExpressionSet object
#'     prebs_values <- calc_prebs(bam_files, custom_cdf_mapping1, output_eset=FALSE)
#'     head(prebs_values)
#'   }
#'
#'   # Run PREBS using Manufacturer's CDF (outputs probe set expressions)
#'   prebs_values <- calc_prebs(bam_files, manufacturer_cdf_mapping)
#'   head(exprs(prebs_values))
#'
#'   # Same as above, but state CDF package name explicitly
#'   prebs_values <- calc_prebs(bam_files, manufacturer_cdf_mapping, cdf_name="hgu133plus2cdf")
#' }

calc_prebs <- function(bam_files, probe_mapping_file, cdf_name = NULL, cluster = NULL, output_eset=TRUE, paired_ended_reads=FALSE, ignore_strand=TRUE, sum.method="rma") {
  if (is.null(cdf_name)) {
    cdf_name <- cdf_package_name(probe_mapping_file) # Get CDF package name from the filename of cdf mapping file
  }
  check_input(bam_files, probe_mapping_file, cdf_name)

  probe_table <- count_overlaps_from_bam(bam_files, probe_mapping_file, cdf_name, cluster, paired_ended_reads, ignore_strand) # Read bam files and calculate read overlaps with probe regions
  
  probe_table <- sum_duplicates(probe_table) # Sum duplicate row ids. Required only for manufacturer's CDF

  probe_table <- probe_table_expressions(probe_table) # Convert raw probe region counts to probe region expressions using statistical model
  
  if (sum.method == "rma") {
    prebs_values <- perform_rma(probe_table, cdf_name, output_eset) # Perform RMA on probe region expressions
  } else if (sum.method == "rpa") {
    prebs_values <- perform_rpa(probe_table, cdf_name, output_eset)
  } else {
    stop("Invalid sum.method parameter. Has to be either 'rma' or 'rpa'")
  }

  return(prebs_values)
}


