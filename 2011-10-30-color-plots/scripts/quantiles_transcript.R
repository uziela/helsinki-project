load("merged_with_counts.RData")
load("marioni.RData")

N = 10

cors = numeric()
difs = numeric()
bar_names = numeric()
array_expr = numeric()
rna_expr = numeric()

temp1 <- data.frame(id=merged_fixed$Gene_ID, array_expr=merged_fixed$AveExpr, rna_expr=log(merged_fixed$baseMean))
me <- merge(me, temp1)


for(i in 1:N) {
	q1 = quantile(me$tr_count, (i-1)/N)
	q2 = quantile(me$tr_count, i/N)
	quant <- me
	if (i>1) {
		quant <- quant[quant$tr_count > q1,]
	}
	quant <- quant[quant$tr_count <= q2,] 
	
	
	cors[i] <- cor(quant$log2FoldChange, quant$logFC)
	difs[i] <- mean(abs(quant$log2FoldChange - quant$logFC))
	bar_names[i] <- i/N
	
	array_expr[i] <- mean(quant$array_expr)
	rna_expr[i] <- mean(quant$rna_expr)
	
	print(i)
	#print("q1")
	#print(q1)
	#print("q2")
	#print(q2)
	#print("min")
	#print(min(quant$tr_count))
	print("max")
	print(max(quant$tr_count))
	print("nrow")
	print(nrow(quant))
	print("-")
}

cor1 <- cor(me$tr_count, abs(me$log2FoldChange - me$logFC))
cor1 <- round(cor1, 2)
print(cor1)

cor2 <- cor(cors, 1:N)
cor2 <- round(cor2, 2)
print(cor2)

cor3 <- cor(difs, 1:N)
cor3 <- round(cor3, 2)
print(cor3)

png("output_hist/tr_corr.png")
barplot(cors, names.arg=bar_names, xlab = "Transcript count", ylab="Correlation for the quantile", ylim=c(0,1), sub=paste("Correlation: ",cor2,sep=""))
dev.off()

png("output_hist/tr_diff.png")
barplot(difs, names.arg=bar_names, xlab = "Transcript count", ylab="Average absolute difference in Log2FC", ylim=c(0,1), sub=paste("Correlation: ",cor3,sep=""))
dev.off()

png("output_hist/tr_array_expr.png")
barplot(array_expr, names.arg=bar_names, xlab = "Transcript count", ylab="Average microarray expression (log scale)")
dev.off()

png("output_hist/tr_rna_expr.png")
barplot(array_expr, names.arg=bar_names, xlab = "Transcript count", ylab="Average rna-seq expression (log scale)")
dev.off()

