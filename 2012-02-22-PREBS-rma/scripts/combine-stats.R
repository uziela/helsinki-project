#! /usr/bin/Rscript

#library(xtable)

cargs <- commandArgs(trailingOnly = TRUE)

base_file <- cargs[1]
out_file <- cargs[2]
dir_names <- cargs[3:length(cargs)]

N <- 6

#thresh <- gsub(".*basic-([0-9]+)-([0-9]+).*", "\\1-\\2%", dir_names)
thresh <- gsub(".*-[0-9]+-([0-9]+).*", "\\1%", dir_names)

#print(thresh)

my_stats <- NULL

#for (i in 1:length(dir_names)) {
for (i in 1:6) {
	stat_file <- paste(dir_names[i], "/", base_file, sep="")
	my_tab <- read.csv(stat_file)
	#print(my_tab)
	my_stats <- cbind(my_stats, t(my_tab[1,]))
}

colnames(my_stats) <- thresh[1:6]

save(my_stats, file=out_file)


