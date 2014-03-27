# calculates rna_table vs rna_table expression correlation and plots expressions 

cargs <- commandArgs(trailingOnly = TRUE)

input_file1 <- cargs[1]
input_file2 <- cargs[2]
output_file1 <- cargs[3]
output_file2 <- cargs[4]


load(input_file1)
rna_table <- rna_table[!is.na(rna_table$log2FoldChange),]
rna_table <- rna_table[!is.infinite(rna_table$log2FoldChange),]

rna_table$baseMeanA <- log(rna_table$baseMeanA)
rna_table$baseMeanB <- log(rna_table$baseMeanB)

rna1 <- rna_table

load(input_file2)
rna_table <- rna_table[!is.na(rna_table$log2FoldChange),]
rna_table <- rna_table[!is.infinite(rna_table$log2FoldChange),]

rna_table$baseMeanA <- log(rna_table$baseMeanA)
rna_table$baseMeanB <- log(rna_table$baseMeanB)

rna2 <- rna_table

rna1a <- data.frame(id=rna1$id, exp1=rna1$baseMeanA, exp2=rna1$baseMeanB)

#head(rna1)
#head(rna2)


m <- merge(rna1a,rna2)

cor1 <- cor(m$exp1, m$baseMeanA)
cor1 <- round(cor1, 2)
print(cor1)
cor2 <- cor(m$exp2, m$baseMeanB)
cor2 <- round(cor2, 2)
print(cor2)


png(output_file1)
plot(m$exp1, m$baseMeanA, xlab=input_file1, ylab=input_file2, main=output_file1, sub=paste("Correlation: ", cor1, sep=""))
dev.off()

png(output_file2)
plot(m$exp2, m$baseMeanB, xlab=input_file1, ylab=input_file2, main=output_file2, sub=paste("Correlation: ", cor2, sep=""))
dev.off()
