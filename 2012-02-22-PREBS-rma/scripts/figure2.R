#! /usr/bin/Rscript

# Written by Karolis Uziela in 2013

plot_graph <- function(stats_file, my_title) {
	N <- 6
	load(stats_file)
	plot(1:N, my_stats[1,], type="o", ylim=c(0,1), xaxt='n', xlab="Percentage filter", ylab="Pearson correlation", pch="x", col="green", sub=my_title, font.sub=2)
	lines(1:N, my_stats[2,], col="red", type="o", pch="x")
	lines(1:N, my_stats[3,], col="blue", type="o", pch="x")
	legend("bottomright",c("PREBS", "Read counting", "MMSEQ"),lwd=c(2.5,2.5,2.5), col=c("blue", "red", "green"))
	axis(side=1, at=c(1:N), labels=colnames(my_stats)) # , las=2)
}


cargs <- commandArgs(trailingOnly = TRUE)

Marioni_dir <- cargs[1]
LAML_dir <- cargs[2]
output_abs <- cargs[3]
output_diff <- cargs[4]
output_cross_diff <- cargs[5]

MY_WIDTH=10
MY_HEIGHT=5


# Absolute expression graph
pdf(output_abs, width=MY_WIDTH, height=MY_HEIGHT)
old.par <- par
par(mfrow=c(1,2))

plot_graph(paste(Marioni_dir, "/absolute_stats.RData", sep=""), "(a) Marioni dataset")
plot_graph(paste(LAML_dir, "/absolute_stats.RData", sep=""), "(b) LAML dataset")

par(old.par)
dev.off()

# Differential expression graph
pdf(output_diff, width=MY_WIDTH, height=MY_HEIGHT)
old.par <- par
par(mfrow=c(1,2))

plot_graph(paste(Marioni_dir, "/diff_stats.RData", sep=""), "(a) Marioni dataset")
plot_graph(paste(LAML_dir, "/diff_stats.RData", sep=""), "(b) LAML dataset")

par(old.par)
dev.off()

# Cross-platform differential expression graph
pdf(output_cross_diff, width=MY_WIDTH, height=MY_HEIGHT)
old.par <- par
par(mfrow=c(1,2))

plot_graph(paste(Marioni_dir, "/cross_diff_stats.RData", sep=""), "(a) Marioni dataset")
plot_graph(paste(LAML_dir, "/cross_diff_stats.RData", sep=""), "(b) LAML dataset")

par(old.par)
dev.off()


