# calculates rna_table vs rna_table correlation and plots log2FC 

cargs <- commandArgs(trailingOnly = TRUE)

input_file1 <- cargs[1]
input_file2 <- cargs[2]
output_file <- cargs[3]


load(input_file1)
rna_table <- rna_table[!is.na(rna_table$log2FoldChange),]
rna_table <- rna_table[!is.infinite(rna_table$log2FoldChange),]
rna1 <- rna_table

load(input_file2)
rna_table <- rna_table[!is.na(rna_table$log2FoldChange),]
rna_table <- rna_table[!is.infinite(rna_table$log2FoldChange),]
rna2 <- rna_table

rna1a <- data.frame(id=rna1$id, logfc1=rna1$log2FoldChange)

#head(rna1)
#head(rna2)


m <- merge(rna1a,rna2)

cor1 <- cor(m$logfc1, m$log2FoldChange)
cor1 <- round(cor1, 2)
#print(cor1)

png(output_file)
plot(m$logfc1, m$log2FoldChange, xlab=input_file1, ylab=input_file2, sub=paste("Correlation: ", cor1, sep=""))
dev.off()
