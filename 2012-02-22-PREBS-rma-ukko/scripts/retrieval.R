#! /usr/bin/Rscript

cargs <- commandArgs(trailingOnly = TRUE)

array_expr_means_file <- cargs[1]

cname <- cargs[2]

FILTER_N <- cargs[3]

out_file <- cargs[4]

merged_files <- cargs[5:length(cargs)]

COR_METHOD <- "pearson"

#cname <- 'PREBS_RMA'

my_score <- 0

load(array_expr_means_file)

N <- length(merged_files)
N2 <- ncol(array_expr_means)

array_expr_means <- as.data.frame(array_expr_means)
array_expr_means$Gene_ID <- row.names(array_expr_means)

for (i in 1:N) {
	sample_name <- basename(merged_files[i])
	sample_name <- strsplit(sample_name, "_")
	sample_name <- sample_name[[1]][1]
	#print(sample_name)
	load(merged_files[i])
	max_cor <- -1
	max_sample <- 0
	for (j in 1:N2) {
		sample_name2 <- colnames(array_expr_means)[j]
		#print(sample_name2)
		merged_filtered <- merged_with_rma[order(merged_with_rma[,cname], decreasing=TRUE),]
		merged_filtered <- merged_filtered[1:FILTER_N,]
		merged_both <- merge(merged_filtered, array_expr_means)
		#print(head(merged_both))
		#print(nrow(merged_both))
		my_cor <- cor(merged_both[,cname], merged_both[,sample_name2], method=COR_METHOD)
		if (my_cor > max_cor) {
			max_cor <- my_cor
			max_sample <- sample_name2
		}
	}
	if (max_sample == sample_name) {
		my_score <- my_score+1
	} else {	
		print("curent sample, max sample")
		print(sample_name)
		print(max_sample)
	}
}

print("my_score:")
print(my_score)

out_df <- data.frame(Method=cname, filter_n=FILTER_N, score=(100*my_score/N))

write.table(out_df, file=out_file, col.names=FALSE, row.names=FALSE, quote=FALSE)

