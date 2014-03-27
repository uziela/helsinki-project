# Prepares ranked lists for GSEA

load("fixed.RData")

array_logfc <- cbind(merged_fixed$Gene_ID, merged_fixed$logFC)
rna_logfc <- cbind(merged_fixed$Gene_ID, merged_fixed$log2FoldChange)

write.table(array_logfc, file='array_logfc.rnk', quote=FALSE, row.names=FALSE, col.names=FALSE, sep='\t')
write.table(rna_logfc, file='rna_logfc.rnk', quote=FALSE, row.names=FALSE, col.names=FALSE, sep='\t')
