# Arguments:
# - input file (run_name.RData)
# - output dir 

cargs <- commandArgs(trailingOnly = TRUE)

input_file=cargs[1]
output_dir=cargs[2]

load(input_file)

png(paste(output_dir,"/RNA-seq-pval-histogram", sep=""))
hist(log10(merged_fixed$padj), breaks=99, main='Histogram of RNA-seq adj P-values', xlab='Log(P-value)')
dev.off()

#png(paste(output_dir,"/Microarray-pval-histogram", sep=""))
#hist(log10(merged_fixed$adj.P.Val), breaks=99, main='Histogram of Microarray adjusted P-values', xlab='Log(P-value)')
#dev.off()

png(paste(output_dir,"/RNA-seq-log2foldchange-histogram", sep=""))
hist(abs(merged_fixed$log2FoldChange), breaks=99, main='Histogram of RNA-seq Log2FoldChanges (absolute values)', xlab='abs(Log2FoldChange)')
dev.off()

png(paste(output_dir,"/Microarray-log2foldchange-histogram", sep=""))
hist(abs(merged_fixed$logFC), breaks=99, main='Histogram of Microarray Log2FoldChanges (absolute values)', xlab='abs(Log2FoldChange)')
dev.off()

png(paste(output_dir,"/RNA-seq-pval-ecdf", sep=""))
rna_p <- sort(log10(merged_fixed$padj))
ecdf <- (1:length(rna_p))/length(rna_p)
plot(rna_p, ecdf, type="n", main='Empirical cumulative density function of RNA-seq adjusted P-values', xlab='Log(P-value)', ylab='Cumulative density')
lines(rna_p, ecdf)
dev.off()

#png(paste(output_dir,"/Microarray-seq-pval-ecdf", sep=""))
#array_p <- sort(log10(merged_fixed$adj.P.Val))
#plot(array_p, ecdf, type="n", main='Empirical cumulative density function of Microarray adjusted P-values', xlab='Log(P-value)', ylab='Cumulative density')
#lines(array_p, ecdf)
#dev.off()
