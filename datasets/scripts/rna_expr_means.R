#! /usr/bin/Rscript 
cargs <- commandArgs(trailingOnly = TRUE)

output_file <- cargs[1]
mmseq_files <- cargs # mmseq gene expression files

rna_expr_means <- numeric(0)
rna_expr_errors <- numeric(0)

file_names <- character(0)


for (i in 2:length(mmseq_files)) {
	mmseqFile <- mmseq_files[i]
	
	mmseq <- read.csv(mmseqFile, sep = "\t", comment.char = "#")
	
	rna_expr_means <- cbind(rna_expr_means, mmseq$log_mu_gibbs / log(2))
	rna_expr_errors <- cbind(rna_expr_errors, mmseq$mcse)

	rownames(rna_expr_means) <- mmseq$gene_id
	rownames(rna_expr_errors) <- mmseq$gene_id
	
	file_name <- strsplit(mmseq_files[i], "/")
	file_name <- file_name[[1]][4]
	file_names <- c(file_names, file_name)
}

colnames(rna_expr_means) <- file_names
colnames(rna_expr_errors) <- file_names

save(rna_expr_means, rna_expr_errors, file=output_file)
