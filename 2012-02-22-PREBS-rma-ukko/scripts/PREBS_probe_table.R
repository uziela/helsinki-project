#! /usr/bin/Rscript 

options("scipen"=100, "digits"=4)


cargs <- commandArgs(trailingOnly = TRUE)

output_file <- cargs[1]
cdf_package_name <- cargs[2] # hgu133plus2hsensgcdf, hgfocushsensgcdf, etc.
probe_count_files <- cargs # probe_counts.RData files

probe_table <- numeric(0)

file_names <- character(0)


for (i in 3:length(probe_count_files)) {
	probeFile <- probe_count_files[i]
	
	load(probeFile)	
	
	#millionsMapped <- sum(probe_counts$counts)/1e+06
	#probe_counts$counts <- (probe_counts$counts + 1) / millionsMapped
	
	probe_table <- cbind(probe_table, probe_counts$counts)
	
	file_name <- strsplit(probe_count_files[i], "/")
	file_name <- file_name[[1]][2]
	file_names <- c(file_names, file_name)
}

colnames(probe_table) <- file_names

library(affy)
rownames(probe_table) <- xy2indices(probe_counts$Probe.X, probe_counts$Probe.Y, cdf=cdf_package_name)

# Experiment: replace PREBS probe expressions with microarray probe expressions having corresponding ranks
if (FALSE) {
	load("../datasets/Marioni/array_expr_means.RData")
	probe_table <- as.data.frame(probe_table)
	probe_table$probe_id <- rownames(probe_table)
	probe_table$kidney_rank <- rank(probe_table$kidney, ties.method="random")
	probe_table$liver_rank <- rank(probe_table$liver, ties.method="random")
	#head(probe_table)
	probe_expr_means <- as.data.frame(probe_expr_means)
	probe_expr_means <- probe_expr_means[is.element(rownames(probe_expr_means), rownames(probe_table)),]
	kidney_array <- data.frame(kidney_arr=probe_expr_means$kidney, kidney_rank=rank(probe_expr_means$kidney, ties.method="random"))
	liver_array <- data.frame(liver_arr=probe_expr_means$liver, liver_rank=rank(probe_expr_means$liver, ties.method="random"))
	probe_table <- merge(probe_table, kidney_array)
	probe_table <- merge(probe_table, liver_array)
	probe_table$kidney <- probe_table$kidney_arr
	probe_table$liver <- probe_table$liver_arr
	rownames(probe_table) <- probe_table$probe_id
	#head(probe_table)
	#probe_table <- as.matrix(probe_table)
	probe_table_mat <- matrix(c(probe_table$kidney, probe_table$liver),ncol=2)
	colnames(probe_table_mat) <- c("kidney","liver")
	rownames(probe_table_mat) <- rownames(probe_table)
	probe_table <- probe_table_mat
	#head(probe_table)
}

save(probe_table, file=output_file)	# .RData file

output_csv <- substr(output_file,1,nchar(output_file)-6)
output_csv <- paste(output_csv, ".csv", sep="")
write.table(probe_table, file=output_csv, sep=" ", quote=FALSE)

