# The script creates "fixed" tables. Those tables contain only genes which have positive expression both in Microarray and RNA-seq methods. It removes genes from RNA-seq which have values NA or Inf

cargs <- commandArgs(trailingOnly = TRUE)

array_file=cargs[1]	# array_table.RData
rna_file=cargs[2]	# rna_table.RData
out_file=cargs[3]	# merged_table.RData
out_table=cargs[4]	# merged.table

load(array_file)
load(rna_file)

array_table$Gene_ID <- substr(array_table$ID, 1, nchar(array_table$ID)-3)
array_table <- array_table[,-1]
rna_table$Gene_ID <- rna_table$id
rna_table <- rna_table[,-1]

rna_table <- rna_table[!is.na(rna_table$log2FoldChange),]
rna_table <- rna_table[!is.infinite(rna_table$log2FoldChange),]

merged_fixed = merge(array_table, rna_table)

array_fixed <- array_table[is.element(array_table$Gene_ID, merged_fixed$Gene_ID),]
rna_fixed <- rna_table[is.element(rna_table$Gene_ID, merged_fixed$Gene_ID),]

# add Gene lengths
library(GenomicRanges)
load("exons.RData")

numBases <- sum(width(exonRanges))
geneLengthsInKB <- (numBases/1000)

row.names(array_fixed) <- array_fixed$Gene_ID
array_fixed <- merge(array_fixed, geneLengthsInKB, by="row.names")
array_fixed <- array_fixed[,-1]
lastCol <- ncol(array_fixed)
colnames(array_fixed)[lastCol] <- "GeneLengthKB"

row.names(rna_fixed) <- rna_fixed$Gene_ID
rna_fixed <- merge(rna_fixed, geneLengthsInKB, by="row.names")
rna_fixed <- rna_fixed[,-1]
lastCol <- ncol(rna_fixed)
colnames(rna_fixed)[lastCol] <- "GeneLengthKB"

row.names(merged_fixed) <- merged_fixed$Gene_ID
merged_fixed <- merge(merged_fixed, geneLengthsInKB, by="row.names")
merged_fixed <- merged_fixed[,-1]
lastCol <- ncol(merged_fixed)
colnames(merged_fixed)[lastCol] <- "GeneLengthKB"

write.table(merged_fixed, quote = FALSE, sep = " ", file=out_table)
save(array_fixed, rna_fixed, merged_fixed, file=out_file)
