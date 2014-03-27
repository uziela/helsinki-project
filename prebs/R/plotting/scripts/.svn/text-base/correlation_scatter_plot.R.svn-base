#! /usr/bin/Rscript

cargs <- commandArgs(trailingOnly = TRUE)

input_file_10 <- cargs[1]
input_file_60 <- cargs[2]
input_file_log2fc_10 <- cargs[3]
input_file_log2fc_60 <- cargs[4]
output_file <- cargs[5]

MY_WIDTH=5
MY_HEIGHT=2.5
MY_CEX=0.68

pdf(output_file, width=MY_WIDTH, height=MY_HEIGHT)
old.par <- par
par(mfrow=c(1,2), mar=c(5, 4, 1, 1) + 0.1, cex=MY_CEX)

cor_table <- read.table(input_file_10, header=TRUE, sep=",")
smoothScatter(cor_table$MMSEQ, cor_table$PREBS, xlab="MMSEQ vs microarray correlation", ylab="PREBS vs microarray correlation", xlim=c(0,1), ylim=c(0,1), sub="10% top expressed genes", font.sub=2)
abline(a=0,b=1)

cor_table <- read.table(input_file_60, header=TRUE, sep=",")
smoothScatter(cor_table$MMSEQ, cor_table$PREBS, xlab="MMSEQ vs microarray correlation", ylab="PREBS vs microarray correlation", xlim=c(0,1), ylim=c(0,1), sub="60% top expressed genes", font.sub=2)
abline(a=0,b=1)

#cor_table <- read.table(input_file_log2fc_10, header=TRUE, sep=",")
#smoothScatter(cor_table$MMSEQ, cor_table$PREBS, xlab="MMSEQ vs microarray correlation", ylab="PREBS vs microarray correlation", xlim=c(0,1), ylim=c(0,1), sub="Differential expression, 10% top expressed genes", font.sub=2)
#abline(a=0,b=1)

#cor_table <- read.table(input_file_log2fc_60, header=TRUE, sep=",")
#smoothScatter(cor_table$MMSEQ, cor_table$PREBS, xlab="MMSEQ vs microarray correlation", ylab="PREBS vs microarray correlation", xlim=c(0,1), ylim=c(0,1), sub="Differential expression, 60% top expressed genes", font.sub=2)
#abline(a=0,b=1)

par(old.par)
dev.off()
