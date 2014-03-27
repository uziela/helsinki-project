#! /usr/bin/Rscript 

#
# Written by Karolis Uziela in 2013
#
# The script calculates PREBS values for given .bam files
#
# Arguments:
# 1) A list of bam files separated by ";"
# 2) File from Custom CDF contain probe mappings (such as "HGU133Plus2_Hs_ENSG_mapping.txt")
# 3) Output file with PREBS values
# 4) Number of CPU cores to use
#
# Example run:
# ./PREBS.R "input1.bam;input2.bam" cdf_dir/HGU133Plus2_Hs_ENSG_mapping.txt PREBS_output.RData 2
#
# NOTE: before running the script CDF package has to be downloaded and installed from Custom CDF website: http://brainarray.mbni.med.umich.edu/CustomCDF
#

######################################## Function definitions #########################################

# This function is used for optimization of Bayesian prior
fr <- function(x,k) {
  alpha <- x[1]
  beta <- x[2]
  -sum(alpha*log(beta) - (alpha+k)*log(beta+1) + lgamma(alpha+k) - lgamma(k+1) - lgamma(alpha))
}

# This function takes "_mapping.txt" filename and returns the name of respective package ("HGU133Plus2_Hs_ENSG_mapping.txt" -> "hgu133plus2hsensgcdf")
cdf_package_name <- function(mapping_txt_file) {
	my_cdf <- basename(mapping_txt_file)
	my_cdf <- sub("_mapping.txt", "", my_cdf)
	my_cdf <- gsub("_", "", my_cdf)
	my_cdf <- tolower(my_cdf)
	my_cdf <- paste(my_cdf, "cdf", sep="")
	return(my_cdf)
}

########################################### Initialization #############################################

cargs <- commandArgs(trailingOnly = TRUE)

bam_files <- cargs[1]         # list of bam files separated by ";"
cdf_mapping_file <- cargs[2]  # NOTE: CDF package has to be first downloaded and installed from Custom CDF website: http://brainarray.mbni.med.umich.edu/CustomCDF
output_PREBS_file <- cargs[3] # output file with PREBS expressions
N_CORES <- as.numeric(cargs[4])           # number of cores

library(Rsamtools)
library(GenomicRanges)
library(affy)
library(parallel)

#CL <- makeCluster(N_CORES)
CDF_NAME <- cdf_package_name(cdf_mapping_file)

#################### Read BAM files and calculate read overlaps with probe regions ######################

# Read .bam files
bam_files <- strsplit(bam_files, ";")[[1]]

#bam_aligns <- parLapply(CL, bam_files, readBamGappedAlignments)
bam_aligns <- lapply(bam_files, readBamGappedAlignments)

probes <- read.table(cdf_mapping_file, sep = "\t", header=TRUE)

# create GRanges object
old.scipen <- getOption("scipen")
options("scipen" = 100) # Avoid exponential number expressions in probe_id
probe_id <- xy2indices(probes$Probe.X, probes$Probe.Y, cdf=CDF_NAME)
chromosome <- probes$Chr
range_start <- probes$Chr.From
range_end <- range_start + 24
strand_id <- probes$Chr.Strand
my_ranges <- GRanges(seqnames=Rle(chromosome), ranges = IRanges(range_start, range_end, names=probe_id), strand = Rle(strand_id))
options("scipen" = old.scipen)

# count overlaps
#probe_table <- parLapply(CL, bam_aligns, countOverlaps, query=my_ranges)
probe_table <- lapply(bam_aligns, countOverlaps, query=my_ranges)
probe_table <- do.call(cbind, probe_table)
colnames(probe_table) <- bam_files

#stopCluster(CL)

################### Convert raw counts to expression values using statistical model ###################

# Combine all probe level expressions into a single vector (k) and find optimal Alpha and Beta parameters for the vector 
k <- c(probe_table)
opt <- optim(c(0.2,0.03), fr, NULL, k, method="L-BFGS-B", lower=0.0001, upper=10)
ALPHA <- opt$par[1]
BETA <- opt$par[2]

print("Estimated alpha and beta:")
print(ALPHA)
print(BETA)

# Update probe-level expressions taking prior into account
probe_table <- (probe_table + ALPHA) / (1 + BETA)

########## Extract necessary information from CDF files and prepare input for RMA function ############

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
prebs_rma <- .Call("rma_c_complete_copy", probe_table_mapped, pNList, ngenes, normalize, background, bgversion, verbose, PACKAGE = "affy")

# Save the results
prebs_rma <- as.data.frame(prebs_rma)
colnames(prebs_rma) <- colnames(probe_table)
prebs_rma$Gene_ID <- substr(rownames(prebs_rma), 1, nchar(rownames(prebs_rma))-3) # remove trailing _at from identifiers
rownames(prebs_rma) <- 1:nrow(prebs_rma)

save(prebs_rma, file=output_PREBS_file)

