# Note: output folder is "output_hist"
# Script arguments:
# 1. "ARRAY" or "RNA" - do you want to plot microarray or rna-seq values?


cargs <- commandArgs(trailingOnly = TRUE)
mode <- cargs[1]

if (mode == "RNA") {
	load("gct.RData")
} else if (mode == "ARRAY") {
	load("gct.RData")
	load("probes_gc2.RData")
	gct <- merge(gct, probes_gc)
	gct$gc <- gct$gc_mean
} else {
	print("ERROR: incorrect arguments")
	stop()
}

load("marioni.RData")

my_cor <- function(var1, var2) {
	cor_x <- cor(var1, var2)
	cor_x <- round(cor_x, 2)
	print(cor_x)
	return(cor_x)
}

my_slope <- function(free, response) {
	fit_x <- lm(response ~ free)
	slope_x <- fit_x$coefficients[[2]]
	slope_x <- round(slope_x, 4)
	return(slope_x)
}

N = 10

cors = numeric()
difs = numeric()
bar_names = numeric()
array_expr = numeric()
rna_expr = numeric()
quantiles = numeric()

temp1 <- data.frame(Gene_ID=merged_fixed$Gene_ID, array_expr=merged_fixed$AveExpr, rna_expr=log(merged_fixed$baseMean))
gct <- merge(gct, temp1)
head(gct)


# plot %GC content histograms (in sequances or in probes depending on whether "mode" is RNA or ARRAY)
for(i in 1:N) {
	q1 = quantile(gct$gc, (i-1)/N)
	q2 = quantile(gct$gc, i/N)
	quant <- gct
	quant <- quant[quant$gc >= q1,]
	if (i<N) {
		quant <- quant[quant$gc < q2,] 
	}
	
	cors[i] <- cor(quant$log2FoldChange, quant$logFC)
	difs[i] <- mean(abs(quant$log2FoldChange - quant$logFC))
	bar_names[i] <- i/N
	
	array_expr[i] <- mean(quant$array_expr)
	rna_expr[i] <- mean(quant$rna_expr)	
	
	quantiles <- c(quantiles, round(max(quant$gc),2))
	
	#print(i)
	#print("min")
	#print(min(quant$gc))
	#print("max")
	#print(max(quant$gc))
	#print("nrow")
	#print(nrow(quant))	
	#print("-")
}

temp_id <- 1:N
quant_frame <- data.frame(id=temp_id, max_gc=quantiles)
write.table(quant_frame, file="output_hist/quantiles.table", sep=" ", quote=FALSE, row.names=FALSE)

alldif <- abs(gct$log2FoldChange - gct$logFC)
arit <- 1:N

cor1 <- my_cor(gct$gc, alldif)
slope1 <- my_slope(gct$gc, alldif)

#cor1a <- my_cor(gct$gc, gct$array_expr)
#slope1a <- my_slope(gct$gc, gct$rna_expr)

cor2 <- my_cor(arit, cors)
slope2 <- my_slope(arit, cors)

cor3 <- my_cor(arit, difs)
slope3 <- my_slope(arit, difs)

cor4 <- my_cor(arit, array_expr)
slope4 <- my_slope(arit, array_expr)

cor5 <- my_cor(arit, rna_expr)
slope5 <- my_slope(arit, rna_expr)

png("output_hist/gc_diff_points.png")
plot(gct$gc, alldif, xlab = "%GC content", ylab="Average absolute difference in Log2FC", sub=paste("Correlation: ",cor1," Slope: ", slope1, sep=""))
dev.off()

png("output_hist/gc_corr.png")
barplot(cors, names.arg=bar_names, xlab = "%GC content quantile", ylab="Correlation for the quantile", ylim=c(0,1), sub=paste("Correlation: ",cor2," Slope: ", slope2, sep=""))
dev.off()

png("output_hist/gc_diff.png")
barplot(difs, names.arg=bar_names, xlab = "%GC content quantile", ylab="Average absolute difference in Log2FC", ylim=c(0,1), sub=paste("Correlation: ",cor3," Slope: ", slope3, sep=""))
dev.off()

png("output_hist/gc_array_expr.png")
barplot(array_expr, names.arg=bar_names, xlab = "%GC content quantile", ylab="Average microarray expression (log scale)", sub=paste("Correlation: ",cor4," Slope: ", slope4, sep=""))
dev.off()

png("output_hist/gc_rna_expr.png")
barplot(rna_expr, names.arg=bar_names, xlab = "%GC content quantile", ylab="Average rna-seq expression (log scale)", sub=paste("Correlation: ",cor5," Slope: ", slope5, sep=""))
dev.off()

# plot probe count histograms
if (mode == "ARRAY") {
	N=8
	
	cors = numeric()
	difs = numeric()
	bar_names = numeric()
	array_expr = numeric()
	rna_expr = numeric()
	quantiles = numeric()
	
	for(i in 1:N) {
		q1 = quantile(gct$probe_count, (i-1)/N)
		q2 = quantile(gct$probe_count, i/N)
		quant <- gct
		quant <- quant[quant$probe_count >= q1,]
		if (i<N) {
			quant <- quant[quant$probe_count < q2,] 
		}
	
		cors[i] <- cor(quant$log2FoldChange, quant$logFC)
		difs[i] <- mean(abs(quant$log2FoldChange - quant$logFC))
		bar_names[i] <- i/N
	
		array_expr[i] <- mean(quant$array_expr)
		rna_expr[i] <- mean(quant$rna_expr)	
	
		quantiles <- c(quantiles, round(max(quant$probe_count),2))
	
		#print(i)
		#print("min")
		#print(min(quant$gc))
		#print("max")
		#print(max(quant$probe_count))
		#print("nrow")
		#print(nrow(quant))	
		#print("-")
	}
	temp_id <- 1:N
	quant_frame <- data.frame(id=temp_id, max_probe=quantiles)
	write.table(quant_frame, file="output_hist_probe/quantiles_probe_count.table", sep=" ", quote=FALSE, row.names=FALSE)	
	
	alldif <- abs(gct$log2FoldChange - gct$logFC)
	arit <- 1:N

	cor1 <- my_cor(gct$probe_count, alldif)
	slope1 <- my_slope(gct$probe_count, alldif)
	
	
	arit <- 1:N
	cor2 <- my_cor(arit, cors)
	slope2 <- my_slope(arit, cors)

	cor3 <- my_cor(arit, difs)
	slope3 <- my_slope(arit, difs)
	
	cor4 <- my_cor(arit, array_expr)
	slope4 <- my_slope(arit, array_expr)

	cor5 <- my_cor(arit, rna_expr)
	slope5 <- my_slope(arit, rna_expr)

	png("output_hist_probe/probe_count_diff_points.png")
	plot(gct$probe_count, alldif, xlab = "#probes", ylab="Average absolute difference in Log2FC", sub=paste("Correlation: ",cor1," Slope: ", slope1, sep=""))
	dev.off()
	
	png("output_hist_probe/probe_count_corr.png")
	barplot(cors, names.arg=bar_names, xlab = "#probes quantile", ylab="Correlation for the quantile", ylim=c(0,1), sub=paste("Correlation: ",cor2," Slope: ", slope2, sep=""))
	dev.off()

	png("output_hist_probe/probe_count_diff.png")
	barplot(difs, names.arg=bar_names, xlab = "#probes quantile", ylab="Average absolute difference in Log2FC", ylim=c(0,1), sub=paste("Correlation: ",cor3," Slope: ", slope3, sep=""))
	dev.off()	
	
	png("output_hist_probe/probe_count_array_expr.png")
	barplot(array_expr, names.arg=bar_names, xlab = "#probes content quantile", ylab="Average microarray expression (log scale)", sub=paste("Correlation: ",cor4," Slope: ", slope4, sep=""))
	dev.off()

	png("output_hist_probe/probe_count_rna_expr.png")
	barplot(rna_expr, names.arg=bar_names, xlab = "#probes content quantile", ylab="Average rna-seq expression (log scale)", sub=paste("Correlation: ",cor5," Slope: ", slope5, sep=""))
	dev.off()	
}

