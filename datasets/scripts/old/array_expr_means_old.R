#! /usr/bin/Rscript
cargs <- commandArgs(trailingOnly = TRUE)
array_expr_file <- cargs[1] # array_expr.RData
dict_file <- cargs[2]  # ./array-dict/dict_array_short.txt
output_file <- cargs[3] # array_expr_means.RData


load(array_expr_file)

dict <- read.table(dict_file, sep=":")
colnames(dict) <- c("SAMPLE","cel_indexes")

array_expr_means <- numeric(0)
probe_expr_means <- numeric(0)

for (i in 1:nrow(dict)) {
	#SAMPLE <- as.character(dict[i,]$SAMPLE)
	cel_indexes <- as.character(dict[i,]$cel_indexes)
	#print(SAMPLE)
	#print(cel_indexes)
	cel_indexes <- as.numeric(unlist(strsplit(cel_indexes,",")))
	array_expr_subset <- array_expr[,cel_indexes]
	probe_expr_subset <- probe_expr[,cel_indexes]
	
	if (length(cel_indexes) == 1) {
		means <- array_expr_subset
		probe_means <- probe_expr_subset
	} else {
		means <- rowMeans(array_expr_subset, na.rm=TRUE)
		probe_means <- rowMeans(probe_expr_subset, na.rm=TRUE)
	}
	
	array_expr_means <- cbind(array_expr_means, means)
	probe_expr_means <- cbind(probe_expr_means, probe_means)
}

colnames(array_expr_means) <- dict$SAMPLE
rownames(array_expr_means) <- substr(rownames(array_expr), 1, nchar(rownames(array_expr))-3)

colnames(probe_expr_means) <- dict$SAMPLE

save(array_expr_means, probe_expr_means, file=output_file)

