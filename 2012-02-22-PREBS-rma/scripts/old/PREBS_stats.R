#! /usr/bin/Rscript 

cargs <- commandArgs(trailingOnly = TRUE)

merged_files <- cargs # all merged_with_probes.RData files

prebs_cors <- NULL
prebs_cors2 <- NULL
mmseq_cors <- NULL
rpkm_cors <- NULL

for (i in 1:length(merged_files)) {
	load(merged_files[i])
	prebs_cors <- c(prebs_cors, cor(merged_with_probes$PREBS_mean, merged_with_probes$array_expr))
	prebs_cors2 <- c(prebs_cors2, cor(merged_with_probes$PREBS_mean, merged_with_probes$Probes_mean_raw))
	mmseq_cors <- c(mmseq_cors, cor(merged_with_probes$mmseq_expr, merged_with_probes$array_expr))
	rpkm_cors  <- c(rpkm_cors, cor(merged_with_probes$RPKM, merged_with_probes$array_expr))
}

prebs_table <- data.frame(RPKM=round(rpkm_cors,2), mmseq=round(mmseq_cors,2), PREBS1=round(prebs_cors,2), PREBS2=round(prebs_cors2,2), Improvement1=(100 * round((prebs_cors - mmseq_cors) / (1-mmseq_cors),4)), Improvement2=(100 * round((prebs_cors2 - mmseq_cors) / (1-mmseq_cors),4)))
print(prebs_table)

print("")
print(paste("Average PREBS correlation with microarray:", round(mean(prebs_cors),2)))
print(paste("Average PREBS correlation with microarray (not normalized):", round(mean(prebs_cors2),2)))
print(paste("Average mmseq correlation with microarray:", round(mean(mmseq_cors),2)))
print(paste("Average RPKM correlation with microarray:", round(mean(rpkm_cors),2)))

improve <- 100 * round((mean(prebs_cors) - mean(mmseq_cors)) / (1-mean(mmseq_cors)),4)
improve2 <- 100 * round((mean(prebs_cors) - mean(rpkm_cors)) / (1-mean(rpkm_cors)),4)

improve3 <- 100 * round((mean(prebs_cors2) - mean(mmseq_cors)) / (1-mean(mmseq_cors)),4)

print("")
print(paste("Compared to mmseq, PREBS improves the correlation on average by: ", improve," %", sep=""))
print(paste("(Not normalized microarray) Compared to mmseq, PREBS improves the correlation on average by: ", improve3," %", sep=""))
print(paste("Compared to RPKM, PREBS improves the correlation on average by: ", improve2," %", sep=""))

