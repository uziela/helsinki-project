#! /usr/bin/Rscript

#library(xtable)

cargs <- commandArgs(trailingOnly = TRUE)

out_file <- cargs[1]
base_file <- cargs[2]
my_caption <- cargs[3]
dir_names <- cargs[4:length(cargs)]

N <- 6

#thresh <- gsub(".*basic-([0-9]+)-([0-9]+).*", "\\1-\\2%", dir_names)
thresh <- gsub(".*-[0-9]+-([0-9]+).*", "\\1%", dir_names)

#print(thresh)

my_stats <- NULL

for (i in 1:length(dir_names)) {
	stat_file <- paste(dir_names[i], "/", base_file, sep="")
	my_tab <- read.csv(stat_file)
	#print(my_tab)
	my_stats <- cbind(my_stats, t(my_tab[1,]))
}

colnames(my_stats) <- thresh
#print(my_stats)

#tab <- xtable(my_stats, caption=my_caption, align=c("|c","|c","|c","|c","|c","|c|"))

#print(tab,file=out_file,append=T,table.placement = "ht", caption.placement="bottom", hline.after=seq(from=-1,to=nrow(tab),by=1))

print(head(my_stats))

pdf(out_file)
#pdf(out_file, width=5, height=5)
plot(1:N, my_stats[1,], type="o", ylim=c(0,1), xaxt='n', xlab="Percentage filter", ylab="Pearson correlation", pch="x", col="green")
#plot(1:7, my_stats[1,], type="l", xaxt='n', xlab="Percentage filter", ylab="Pearson correlation", main=my_caption)
lines(1:N, my_stats[2,], col="red", type="o", pch="x")
#points(1:7, my_stats[2,], col="red", pch="A")
lines(1:N, my_stats[3,], col="blue", type="o", pch="x")
legend("bottomright",c("PREBS", "RPKM", "MMSEQ"),lwd=c(2.5,2.5,2.5), col=c("blue", "red", "green"))
axis(side=1, at=c(1:N), labels=colnames(my_stats)) # , las=2)
dev.off()


