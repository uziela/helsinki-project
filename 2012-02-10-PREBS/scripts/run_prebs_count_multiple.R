#! /cs/fs2/home/uziela/software/R-3.1.0/bin/Rscript

library(prebs)
library(parallel)
library(GenomicAlignments)
library(GenomicRanges)
library(affy)


sessionInfo()

cargs <- commandArgs(trailingOnly = TRUE)

probe_mapping_file <- cargs[1]

output_file <- cargs[2]

input_bam_files <- cargs[3:length(cargs)]

#==============

#N_CORES = 16

#CLUSTER <- makeCluster(N_CORES)

print(cargs)

Sys.time()

#prebs_values <- calc_prebs(input_bam_files, probe_mapping_file, output_eset=FALSE, cluster=CLUSTER, paired_ended_reads = TRUE, ignore_strand = TRUE)
#prebs_values <- calc_prebs(input_bam_files, probe_mapping_file, output_eset=FALSE, paired_ended_reads = TRUE, ignore_strand = TRUE)
prebs_values <- calc_prebs(input_bam_files, probe_mapping_file, output_eset=FALSE, paired_ended_reads = FALSE, ignore_strand = TRUE, count_multiple = TRUE)
#prebs_values <- calc_prebs(input_bam_files, probe_mapping_file, output_eset=FALSE, paired_ended_reads = TRUE, ignore_strand = TRUE, count_multiple = TRUE)

Sys.time()

write.table(prebs_values, file=output_file, quote=FALSE, row.names = FALSE)
