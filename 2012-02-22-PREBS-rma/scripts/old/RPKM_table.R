#! /usr/bin/Rscript

cargs <- commandArgs(trailingOnly = TRUE)

output_file <- cargs[1]	# RPKM_table.RData
input_files <- cargs	# accepted_hits_counts.RData files

RPKM_table <- NULL
samples <- NULL

for (i in 2:length(input_files)) {
	sample_name <- strsplit(input_files[i], "/")
	sample_name <- sample_name[[1]][2]
	#print(sample_name)
	load(input_files[i])
	RPKM_table <- cbind(RPKM_table, log2(rpkm))
	samples <- c(samples, sample_name)
}
colnames(RPKM_table) <- samples

save(RPKM_table, file=output_file)
