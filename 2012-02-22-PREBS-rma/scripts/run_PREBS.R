#! /usr/bin/Rscript

# Written by Karolis Uziela in 2013

cargs <- commandArgs(trailingOnly = TRUE)

mapping_file <- cargs[1]
output_file <- cargs[2]
bam_files <- cargs[3:length(cargs)]

library(prebs)
prebs_values <- calc_prebs(bam_files, mapping_file)
save(prebs_values, file=output_file)
