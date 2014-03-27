#! /usr/bin/Rscript

# Written by Karolis Uziela in 2013

plot_graph <- function(stats_file, stderr_file, my_title) {
	N <- 6
    MY_LWD=1
    MY_CEX=0.2
    MY_CAP=0.020
    load(stderr_file)
    my_stderr <- my_stats
	load(stats_file)
	plot(1:N, my_stats[1,], type="b", ylim=c(0,1), xaxt='n', xlab="Fraction of top expressed genes analysed", ylab="Pearson correlation", sub=my_title, font.sub=2, lty=3, cex=MY_CEX, lwd=MY_LWD, col="green", pch=19)
    errbar(1:N, my_stats[1,], my_stats[1,] + my_stderr[1,], my_stats[1,] - my_stderr[1,], add=T, col="green", pch="", errbar.col="green", lwd=MY_LWD, cap=MY_CAP)
	lines(1:N, my_stats[2,], type="b", lty=2, cex=MY_CEX, lwd=MY_LWD, col="red", pch=19)
    errbar(1:N, my_stats[2,], my_stats[2,] + my_stderr[2,], my_stats[2,] - my_stderr[2,], add=T, col="red", pch="", errbar.col="red", lwd=MY_LWD, cap=MY_CAP)
	lines(1:N, my_stats[3,], type="b", lty=1, cex=MY_CEX, lwd=MY_LWD, col="blue", pch=19)
    errbar(1:N, my_stats[3,], my_stats[3,] + my_stderr[3,], my_stats[3,] - my_stderr[3,], add=T, col="blue", pch="", errbar.col="blue", lwd=MY_LWD, cap=MY_CAP)
	legend("bottomright",c("PREBS", "Read counting", "MMSEQ"), lty=c(1,2,3), cex=0.8, col=c("blue", "red", "green"))
	axis(side=1, at=c(1:N), labels=colnames(my_stats)) # , las=2)
}

plot_graph_no_bars <- function(stats_file, my_title) {
	N <- 6
    MY_LWD=1
    MY_CEX=0.6
	load(stats_file)
	plot(1:N, my_stats[1,], type="b", ylim=c(0,1), xaxt='n', xlab="Fraction of top expressed genes analysed", ylab="Pearson correlation", sub=my_title, font.sub=2, lty=3, cex=MY_CEX, lwd=MY_LWD, col="green")
	lines(1:N, my_stats[2,], type="b", lty=2, cex=MY_CEX, lwd=MY_LWD, col="red")
	lines(1:N, my_stats[3,], type="b", lty=1, cex=MY_CEX, lwd=MY_LWD, col="blue")
	legend("bottomright",c("PREBS", "Read counting", "MMSEQ"), lty=c(1,2,3), cex=0.8, col=c("blue", "red", "green"))
	axis(side=1, at=c(1:N), labels=colnames(my_stats)) # , las=2)
}

cargs <- commandArgs(trailingOnly = TRUE)

Marioni_dir <- cargs[1]
LAML_dir <- cargs[2]
output_abs <- cargs[3]
output_diff <- cargs[4]
output_cross_diff <- cargs[5]

MY_WIDTH=5
MY_HEIGHT=2.5
MY_CEX=0.68
#MY_CEX=0.5

library(Hmisc) # for `errbar` function

# Absolute expression graph
pdf(output_abs, width=MY_WIDTH, height=MY_HEIGHT)
old.par <- par
par(mfrow=c(1,2), mar=c(5, 4, 1, 1) + 0.1, cex=MY_CEX)

plot_graph(paste(Marioni_dir, "/absolute_stats.RData", sep=""), paste(Marioni_dir, "/absolute_stderr.RData", sep=""), "(a) Marioni data set")
plot_graph(paste(LAML_dir, "/absolute_stats.RData", sep=""), paste(LAML_dir, "/absolute_stderr.RData", sep=""), "(b) LAML data set")

par(old.par)
dev.off()

# Differential expression graph
pdf(output_diff, width=MY_WIDTH, height=MY_HEIGHT)
old.par <- par
par(mfrow=c(1,2), mar=c(5, 4, 1, 1) + 0.1, cex=MY_CEX)

plot_graph_no_bars(paste(Marioni_dir, "/diff_stats.RData", sep=""), "(a) Marioni data set")
plot_graph(paste(LAML_dir, "/diff_stats.RData", sep=""), paste(LAML_dir, "/diff_stderr.RData", sep=""), "(b) LAML data set")

par(old.par)
dev.off()

# Cross-platform differential expression graph
pdf(output_cross_diff, width=MY_WIDTH, height=MY_HEIGHT)
old.par <- par
par(mfrow=c(1,2), mar=c(5, 4, 1, 1) + 0.1, cex=MY_CEX)

plot_graph_no_bars(paste(Marioni_dir, "/cross_diff_stats.RData", sep=""), "(a) Marioni data set")
plot_graph(paste(LAML_dir, "/cross_diff_stats.RData", sep=""), paste(LAML_dir, "/cross_diff_stderr.RData", sep=""), "(b) LAML data set")

par(old.par)
dev.off()


