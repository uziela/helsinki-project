#! /usr/bin/Rscript

cargs <- commandArgs(trailingOnly = TRUE)

merged_files <- cargs[1:length(cargs)]

COR_METHOD <- "spearman"

SAMPLE_SIZE = 2500
ITERATIONS = 1000

for (i in 1:length(merged_files)) {
	load(merged_files[i])
	merged_filt <- merged_with_rma
	merged_filt <- merged_filt[is.finite(merged_filt$mmseq_expr),]
	merged_filt <- merged_filt[is.finite(merged_filt$RPKM),]
	
	prebs_cors <- NULL
	mmseq_cors <- NULL
	rpkm_cors <- NULL	
	ranks <- NULL
	for (j in 1:ITERATIONS) {
		mysample <- merged_filt[sample(1:nrow(merged_filt), SAMPLE_SIZE, replace=FALSE),]
		
		prebs_cor <- cor(mysample$PREBS_RMA, mysample$array_expr, method=COR_METHOD)
		mmseq_cor <- cor(mysample$mmseq_expr, mysample$array_expr, method=COR_METHOD)
		rpkm_cor <- cor(mysample$RPKM, mysample$array_expr, method=COR_METHOD)

		prebs_cors <- c(prebs_cors, prebs_cor)
		mmseq_cors <- c(mmseq_cors, mmseq_cor)
		rpkm_cors <- c(rpkm_cors, rpkm_cor)

		ranks <- rbind(ranks, rank(c(prebs_cor, mmseq_cor, rpkm_cor)))
		#print(c(prebs_cor, mmseq_cor, rpkm_cor))
		#print(rank(c(prebs_cor, mmseq_cor, rpkm_cor)))
	}
	#print(ranks)
	print("PREBS is first out of 1000 times:")
	print(nrow(ranks[ranks[,1]==3,]))
	print("MMSEQ is second out of 1000 times:")
	print(nrow(ranks[ranks[,2]==2,]))
	print(summary(ranks))
}

