#! /usr/bin/Rscript 

source("/triton/ics/scratch/uzielak1/general_scripts/my_plot.R")

cargs <- commandArgs(trailingOnly = TRUE)

prebs_rma_file <- cargs[1]
array_expr_means_file <- cargs[2]
output_dir <- cargs[3]

prebs_cors <- NULL

load(prebs_rma_file)
load(array_expr_means_file)

for (i in 1:ncol(array_expr_means)) {
	sample_name <- colnames(array_expr_means)[i]
	my_plot(prebs_rma[,i], array_expr_means[,i], paste(output_dir, "/plots/", sample_name, "_PREBS_RMA_vs_array_stock.png", sep=""), "PREBS_RMA value", "Microarray expression")
	prebs_cors <- c(prebs_cors, cor(prebs_rma[,i], array_expr_means[,i]))
	if (i == 1) {
		prebs_rma1 <- prebs_rma[,i]
		array_expr_means1 <- array_expr_means[,i]
	}
	if (i == 2) {
		prebs_rma2 <- prebs_rma[,i]
		array_expr_means2 <- array_expr_means[,i]
	}
}

prebs_log2fc <- prebs_rma2 - prebs_rma1
array_log2fc <- array_expr_means2 - array_expr_means1

my_plot(prebs_log2fc, array_log2fc, paste(output_dir, "/plots-diff/", "PREBS_RMA_vs_array_stock_log2fc.png", sep=""), "PREBS Log2FC", "Microarray Log2FC")

cor_file <- paste(output_dir, "/cor.txt", sep="")

cat(paste("Average PREBS_RMA correlation with microarray (stock cdf):", round(mean(prebs_cors),2)), file=cor_file)

