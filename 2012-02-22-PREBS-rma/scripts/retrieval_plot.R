#! /usr/bin/Rscript

cargs <- commandArgs(trailingOnly = TRUE)

input_file <- cargs[1]
output_file <- cargs[2]

N <- 7

my_table <- read.table(input_file)

#print(my_table)

prebs <- my_table[my_table$V1=="PREBS_RMA",c(2,3)]
rpkm <- my_table[my_table$V1=="RPKM",c(2,3)]
mmseq <- my_table[my_table$V1=="mmseq_expr",c(2,3)]

colnames(mmseq) <- c("filter_n", "MMSEQ")
colnames(rpkm) <- c("filter_n", "RPKM")
colnames(prebs) <- c("filter_n", "PREBS")

merged <- merge(mmseq, rpkm)
merged <- merge(merged, prebs)

merged <- merged[merged$filter_n != 50,]

#print(merged)

pdf(output_file)
plot(1:N, merged$MMSEQ, type="o", ylim=c(0,100), xaxt='n', xlab="Number of top genes used in retrieval", ylab="Retrieval accuracy", pch="x", col="green")
lines(1:N, merged$RPKM, col="red", type="o", pch="x")
lines(1:N, merged$PREBS, col="blue", type="o", pch="x")
legend("bottomright",c("PREBS","Read counting", "MMSEQ"),lwd=c(2.5,2.5,2.5),col=c("blue", "red", "green"))
axis(side=1, at=c(1:N), labels=merged$filter_n)
dev.off()


