# Arguments:
# 1. _count.RData file
# 2. "median" or "mean". Do you want to use mean of probe expressions or median?
# Output:
# Table with estimated expressions for each gene. Output is in the same folder as input and has _gene_expr.RData extension.

cargs <- commandArgs(trailingOnly = TRUE)

inputFile <- paste(cargs[1], ".RData", sep="")
outputFile <- paste(cargs[1], "_gene_expr.RData", sep="")
mode <- cargs[2]

load(inputFile)

library(plyr)

millionsMapped <- sum(probe_counts$counts)/1e+06
probe_counts$counts <- probe_counts$counts / millionsMapped 

gene_expr <- character(0)

if (mode == "mean") {
	gene_expr <- ddply(probe_counts, "Probe.Set.Name", function(df)mean(df$counts))
} else if (mode == "median") {
	gene_expr <- ddply(probe_counts, "Probe.Set.Name", function(df)median(df$counts))
} else {
	print("ERROR: incorrect mode. Select 'mean' or 'median'")
	quit()
}

names(gene_expr) <- c("Gene_ID", "PREBS")

gene_expr$Gene_ID <- as.character(gene_expr$Gene_ID)
gene_expr$Gene_ID <- substr(gene_expr$Gene_ID, 1, nchar(gene_expr$Gene_ID)-3)

gene_expr$PREBS <- log2(gene_expr$PREBS)

save(gene_expr, file=outputFile)
