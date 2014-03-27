#! /usr/bin/Rscript 

#source("~/general_scripts/my_plot.R")
cargs <- commandArgs(trailingOnly = TRUE)

output_dir <- cargs[1]
input_dirs <- cargs # input directories including merged_with_probes.RData files

prebs_rma_file <- paste(output_dir,"/PREBS_RMA.RData", sep="")
load(prebs_rma_file)

for (i in 2:length(input_dirs)) {
	sample_name <- strsplit(input_dirs[i], "/")
	sample_name <- sample_name[[1]][2]
	
	prebs_subset <- prebs_rma[,colnames(prebs_rma)==sample_name | colnames(prebs_rma)=="Gene_ID" ]
	colnames(prebs_subset) <- c("PREBS_RMA","Gene_ID")
	#print(head(prebs_subset))
	
	merged_file <- paste(input_dirs[i], "/merged_with_probes.RData", sep="")
	load(merged_file)
	
	merged_with_rma <- merge(merged_with_probes, prebs_subset)
	
	# Experiment: replace PREBS gene expressions with microarray gene expressions having corresponding ranks
	#array_rank <- data.frame(expr_val=merged_with_rma$array_expr, expr_rank=rank(merged_with_rma$array_expr, ties.method="random"))
	#prebs_rank <- data.frame(Gene_ID=merged_with_rma$Gene_ID, expr_rank=rank(merged_with_rma$PREBS_RMA, ties.method="random"))
	#prebs_rank <- merge(array_rank, prebs_rank)
	#merged_with_rma <- merge(merged_with_rma, prebs_rank)
	#merged_with_rma$PREBS_RMA <- merged_with_rma$expr_val
	#merged_with_rma <- subset(merged_with_rma, select=-c(expr_val,expr_rank))
	#print(head(merged_with_rma[order(merged_with_rma$PREBS_RMA),],100))
	
	save(merged_with_rma, file=paste(output_dir, "/", sample_name, "_merged.RData", sep=""))
}


