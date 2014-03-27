# Arguments:
# 1. input file (probe_counts.RData)
# 2. output file (*runname*_PREBS.RData)


cargs <- commandArgs(trailingOnly = TRUE)

inputFile <- cargs[1]
outputFile <- cargs[2]

load(inputFile)

library(plyr)

millionsMapped <- sum(probe_counts$counts)/1e+06
probe_counts$counts <- (probe_counts$counts) / millionsMapped 

gene_expr1 <- NULL
gene_expr2 <- NULL


gene_expr1 <- ddply(probe_counts, "Probe.Set.Name", function(df)mean(df$counts))
gene_expr2 <- ddply(probe_counts, "Probe.Set.Name", function(df)median(df$counts))


names(gene_expr1) <- c("Gene_ID", "PREBS_mean")
names(gene_expr2) <- c("Gene_ID", "PREBS_median")

gene_expr <- merge(gene_expr1, gene_expr2)

gene_expr$Gene_ID <- as.character(gene_expr$Gene_ID)
gene_expr$Gene_ID <- substr(gene_expr$Gene_ID, 1, nchar(gene_expr$Gene_ID)-3)

gene_expr$PREBS_mean <- log2(gene_expr$PREBS_mean)
gene_expr$PREBS_median <- log2(gene_expr$PREBS_median)

save(gene_expr, file=outputFile)
