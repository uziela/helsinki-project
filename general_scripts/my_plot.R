my_cor <- function(var1, var2, my_method) {
	cor_x <- cor(var1, var2, method=my_method)
	cor_x <- round(cor_x, 2)
	return(cor_x)
}

my_plot <- function(var1, var2, my_file, my_xlab, my_ylab, red_points=NULL) {
	cor1 <- my_cor(var1, var2, "pearson")
	cor2 <- my_cor(var1, var2, "spearman")
	#print(paste("file", my_file))
	#print(paste(my_xlab, "vs", my_ylab))
	#print(paste(cor1,cor2))
	n <- length(var1)
	png(my_file, width = 360, height = 360)
	#png(my_file, width = 360, height = 360, pointsize=14)
	#png(my_file, width = 180, height = 180, pointsize=6)
	#png(my_file, pointsize=18)
	#png(my_file, width = 10, height = 10, units="cm", res=600)
	#pdf(my_file, width=5, height=5)
	#plot(var1, var2, xlab=my_xlab, ylab=my_ylab, sub=paste("Pearson correlation: ",cor1," Spearman correlation: ", cor2, " Number of points: ", n, sep=""))
	plot(var1, var2, xlab=my_xlab, ylab=my_ylab)
	
	r = paste("r =", cor1)
	s = paste("s =", cor2)
	n = paste("n =", n)
	
	legend(x="topleft", legend=c(r, s, n))
	
	points(var1[red_points], var2[red_points], col="red")
	
	dev.off()
}

my_hist <- function(var1, my_file, my_xlab, nbreaks) {
	#png(my_file)
	pdf(my_file, width=5, height=5)
	hist(var1, xlab=my_xlab, breaks=nbreaks, main="")
	dev.off()
}

my_venn <- function(venn_input, my_file) {
	library(gplots)
	
	#pdf(my_file)
	pdf(my_file, pointsize=16)
	#png(my_file, width = 360, height = 360)
	venn(venn_input)
	dev.off()
}
