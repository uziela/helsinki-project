#! /usr/bin/Rscript 

fr <- function(x,k) {
  alpha <- x[1]
	beta <- x[2]
	-sum(alpha*log(beta) - (alpha+k)*log(beta+1) + lgamma(alpha+k) - lgamma(k+1) - lgamma(alpha))
}

cargs <- commandArgs(trailingOnly = TRUE)

cel_dir <- cargs[1] 
cdf_name <- cargs[2]
probe_table <- cargs[3]
out_file <- cargs[4]
#ALPHA <- as.numeric(cargs[5])
#BETA <- as.numeric(cargs[6])

#ALPHA <- 0.6
#BETA <- 0.001

load(probe_table)
k <- c(probe_table)
opt <- optim(c(0.2,0.03), fr, NULL, k, method="L-BFGS-B", lower=0.0001, upper=10)
ALPHA <- opt$par[1]
BETA <- opt$par[2]

print("Estimated alpha and beta:")
print(ALPHA)
print(BETA)

library(affy)

Data <- ReadAffy(celfile.path=cel_dir, cdfname=cdf_name)

Data <- Data[,1:ncol(probe_table)]

probe_table <- (probe_table + ALPHA) / (1 + BETA)
#probe_table <- probe_table + 1
#probe_table <- probe_table + runif(length(probe_table)) * 1

#head(probe_table)
#probe_table[,1] <- probe_table[,1] * 10
#head(probe_table)

#head(exprs(Data))
exprs(Data)[,1:ncol(probe_table)] = 1
#head(exprs(Data))

exprs(Data)[rownames(probe_table),] <- probe_table

# Take subset of genes not starting with AFFX
allg <- geneNames(Data)
subset <- allg[substr(allg,1,4) != "AFFX"]
ngenes <- length(subset)

verbose = TRUE; normalize = TRUE; background = FALSE; bgversion = 2

pNList <- probeNames(Data, subset)
pNList <- split(0:(length(pNList) - 1), pNList)

pm_probes <- pm(Data, subset)

prebs_rma <- .Call("rma_c_complete_copy", pm_probes, pNList, ngenes, normalize, background, bgversion, verbose, PACKAGE = "affy")

prebs_rma <- as.data.frame(prebs_rma)
colnames(prebs_rma) <- colnames(probe_table)
prebs_rma$Gene_ID <- substr(rownames(prebs_rma), 1, nchar(rownames(prebs_rma))-3)
rownames(prebs_rma) <- 1:nrow(prebs_rma)

save(prebs_rma, file=out_file)


