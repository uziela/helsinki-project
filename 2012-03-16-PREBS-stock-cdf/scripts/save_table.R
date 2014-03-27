#! /usr/bin/Rscript 

cargs <- commandArgs(trailingOnly = TRUE)

input_file <- cargs[1]

output_file <- cargs[2]

probe_table <- read.csv(input_file, sep=" ")
probe_table <- as.matrix(probe_table)
save(probe_table, file=output_file)
