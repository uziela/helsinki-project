# Arguments:
# - input file (run_name.RData)
# - output dir 

cargs <- commandArgs(trailingOnly = TRUE)

input_file=cargs[1]
output_dir=cargs[2]

load(input_file)

png(paste(output_dir,"/fold_changes.png", sep=""))
plot(merged_fixed$logFC, merged_fixed$log2FoldChange, main="Comparing fold changes", xlab="Microarray", ylab="RNA-seq")
dev.off()

#png(paste(output_dir,"/p_values.png", sep=""))
#plot(merged_fixed$adj.P.Val, merged_fixed$padj, main="Comparing adjusted P-values", xlab="Microarray", ylab="RNA-seq")
#dev.off()

png(paste(output_dir,"/array_avg_exp_vs_fold_change.png", sep=""))
plot(merged_fixed$AveExpr, abs(merged_fixed$logFC), main="Microarray avg. expression vs abs(log2 fold Change)", xlab="avg expression", ylab="abs(log2 fold change)")
dev.off()

png(paste(output_dir,"/rna_avg_exp_vs_fold_change.png", sep=""))
plot(log10(merged_fixed$baseMean), abs(merged_fixed$log2FoldChange), main="RNA-seq avg. expression vs abs(log2 fold Change)", xlab="avg expression", ylab="abs(log2 fold change)")
dev.off()

png(paste(output_dir,"/array_gene_length_vs_fold_change.png", sep=""))
plot(merged_fixed$GeneLengthKB, abs(merged_fixed$logFC), main="Microarray Gene Length vs abs(log2 fold Change)", xlab="Gene Length in KB", ylab="abs(log2 fold change)")
dev.off()

png(paste(output_dir,"/rna_gene_length_vs_fold_change.png", sep=""))
plot(merged_fixed$GeneLengthKB, abs(merged_fixed$log2FoldChange), main="RNA-seq Gene Length vs abs(log2 fold Change)", xlab="Gene Length in KB", ylab="abs(log2 fold change)")
dev.off()

#png(paste(output_dir,"/array_pval_vs_fold_change.png", sep=""))
#plot(log10(merged_fixed$adj.P.Val), abs(merged_fixed$logFC), main="Microarray adj P-val vs abs(log2 fold Change)", xlab="log10(adj P-val)", ylab="abs(log2 fold change)")
#dev.off()

png(paste(output_dir,"/rna_pval_vs_fold_change.png", sep=""))
plot(log10(merged_fixed$padj), abs(merged_fixed$log2FoldChange), main="RNA-seq adj P-val vs abs(log2 fold Change)", xlab="log10(adj P-val)", ylab="abs(log2 fold change)")
dev.off()
