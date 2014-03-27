#! /usr/bin/Rscript

plot_graph <- function(stats_file, my_title) {
	N <- 6
	load(stats_file)
	plot(1:N, my_stats[1,], type="o", ylim=c(0,1), xaxt='n', xlab="Fraction of top expressed genes analysed", ylab="Pearson correlation", pch="x", col="green", sub=my_title, font.sub=2)
	lines(1:N, my_stats[2,], col="red", type="o", pch="x")
	lines(1:N, my_stats[3,], col="blue", type="o", pch="x")
	legend("bottomright",c("PREBS", "Read counting", "MMSEQ"),lwd=c(2.5,2.5,2.5), col=c("blue", "red", "green"))
	axis(side=1, at=c(1:N), labels=colnames(my_stats)) # , las=2)
}

cargs <- commandArgs(trailingOnly = TRUE)

input_file <- cargs[1]
output_file <- cargs[2]

pdf(output_file)
old.par <- par
#par(mfrow=c(1,2))

ratios_table <- read.table(input_file, header=FALSE, sep=" ")
#head(ratios_table)
ratios_table <- ratios_table[order(ratios_table[,1]),]

N <- nrow(ratios_table)
plot(1:N, ratios_table[,1], type="o", ylim=c(0, max(ratios_table)), xlab="Sample", ylab="Reads mapped", pch="x", col="blue", sub="Number of mapped reads", font.sub=2)
lines(1:N, ratios_table[,2], col="red", type="o", pch="x")
lines(1:N, ratios_table[,3], col="green", type="o", pch="x")
legend("topleft",c("Whole genome", "Gene regions", "Probe regions"),lwd=c(2.5,2.5,2.5), col=c("blue", "red", "green"))

#smoothScatter(cor_table$MMSEQ, cor_table$PREBS, xlab="MMSEQ vs microarray correlation", ylab="PREBS vs microarray correlation", xlim=c(0,1), ylim=c(0,1), sub="Absolute expression, 10% top expressed genes", font.sub=2)

#par(old.par)
dev.off()

mapped_total <- round(mean(ratios_table[,1]), digits = 0)
mapped_to_gene_regions <- round(mean(ratios_table[,2]), digits = 0)
mapped_to_probe_regions <- round(mean(ratios_table[,3]), digits = 0)

print(paste("Average number of reads mapped to probe regions:", mapped_to_probe_regions))
print(paste("Average number of reads mapped to gene regions:", mapped_to_gene_regions))
print(paste("Average number of reads mapped to the whole genome:", mapped_total))

print(paste("Proportion of reads mapped to probe regions compared to all mapped reads: ", round(100 * mapped_to_probe_regions/mapped_total, digits=2), "%"))
print(paste("Proportion of reads mapped to gene regions compared to all mapped reads: ", round(100 * mapped_to_gene_regions/mapped_total, digits=2), "%"))
print(paste("Proportion of reads mapped to probe regions compared to reads mapped to gene regions: ", round(100 * mapped_to_probe_regions/mapped_to_gene_regions, digits=2), "%"))

