#! /usr/bin/Rscript

cargs <- commandArgs(trailingOnly = TRUE)

input_file <- cargs[1]
output_file <- cargs[2]

stderr <- function(x) sd(x)/sqrt(length(x))

data <- read.table(input_file, sep=",")
data <- as.data.frame(data)

#std_mean_errors <- c(stderr(data$RPKM), stderr(data$MMSEQ), stderr(data$PREBS))

#write.table(std_mean_errors, file=output_file, col.names=F, row.names=F)

std_mean_errors <- data.frame(MMSEQ=stderr(data$MMSEQ), RPKM=stderr(data$RPKM), PREBS=stderr(data$PREBS))

rownames(std_mean_errors) <- "std_mean_error"

write.table(std_mean_errors, file=output_file, col.names=T, row.names=T, quote=F, sep=",")
