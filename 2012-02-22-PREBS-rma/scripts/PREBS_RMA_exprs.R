#! /usr/bin/Rscript 

fr <- function(x,k) {
  alpha <- x[1]
	beta <- x[2]
	-sum(alpha*log(beta) - (alpha+k)*log(beta+1) + lgamma(alpha+k) - lgamma(k+1) - lgamma(alpha))
}

cargs <- commandArgs(trailingOnly = TRUE)

cel_dir <- cargs[1] # Directory with (dummy) cel files
cdf_name <- cargs[2] # cdf name
probe_table <- cargs[3] # Table with probe-level expressions
out_file <- cargs[4] # Ouptut file with PREBS values

# Load file with probe-level expressions
load(probe_table)

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

# Read the probe level expressions from cel files. These read-in values are dummy and will be replaced by values in probe_table variable. 
# We need to read in these values only to get the data structure apropriate for "rma_c_complete_copy" function in Bioconductor's affy package.
# The only requirements for CEL files are that the CDF is format is suitable for us and the number of CEL files have to be equal or larger than the number of columns in probe_table
library(affy)
Data <- ReadAffy(celfile.path=cel_dir, cdfname=cdf_name)
Data <- Data[,1:ncol(probe_table)]

# The following line is neccessary only if we do not remove AFFX values from the table (then we set them to 1)
exprs(Data)[,1:ncol(probe_table)] = 1

# Replace the values!
exprs(Data)[rownames(probe_table),] <- probe_table

# Take subset of genes not starting with AFFX
allg <- geneNames(Data)
subset <- allg[substr(allg,1,4) != "AFFX"]
ngenes <- length(subset)

# Calculate RMA using "rma_c_complete_copy" function from affy package
verbose = TRUE; normalize = TRUE; background = FALSE; bgversion = 2

pNList <- probeNames(Data, subset)
pNList <- split(0:(length(pNList) - 1), pNList)

pm_probes <- pm(Data, subset)
#save(pm_probes, pNList, file="test_probes.RData")
prebs_rma <- .Call("rma_c_complete_copy", pm_probes, pNList, ngenes, normalize, background, bgversion, verbose, PACKAGE = "affy")

# Save the results
prebs_rma <- as.data.frame(prebs_rma)
colnames(prebs_rma) <- colnames(probe_table)
prebs_rma$Gene_ID <- substr(rownames(prebs_rma), 1, nchar(rownames(prebs_rma))-3) # remove trailing _at from identifiers
rownames(prebs_rma) <- 1:nrow(prebs_rma)

save(prebs_rma, file=out_file)


