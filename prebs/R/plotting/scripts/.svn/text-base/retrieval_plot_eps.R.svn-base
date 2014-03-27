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

setEPS()
postscript(output_file, height=3, width=3)
par(mar=c(4, 4, 1, 1) + 0.1, cex=0.62)
plot(1:N, merged$MMSEQ, type="b", ylim=c(0,100), xaxt='n', xlab="Number of genes in retrieval signature", ylab="Retrieval accuracy", lty=3, cex=0.7)
lines(1:N, merged$RPKM, type="b", lty=2, cex=0.7)
lines(1:N, merged$PREBS, type="b", lty=1, cex=0.7)
legend("bottomright",c("PREBS","Read counting", "MMSEQ"), lty=c(1,2,3))
axis(side=1, at=c(1:N), labels=merged$filter_n)
dev.off()


