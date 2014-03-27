#! /usr/bin/Rscript

library(GenomicRanges);
#library(GenomicFeatures);
library(Rsamtools);

cargs <- commandArgs(trailingOnly = TRUE)
input_file <- cargs[1]
probe_mapping_file <- cargs[2]
output_file <- cargs[3]

load(input_file)
load("exons.RData")
probes <- read.csv(probe_mapping_file, sep = "\t")

# Get gene region counts
#tree <- IntervalTree(aligns)
mapped_to_gene_regions <- sum(!is.na(findOverlaps(aligns, exonRanges, select = "first")))


# Get probe region counts
probe_id <- paste("xy", "_", probes$Probe.X, "_", probes$Probe.Y, sep="")
chromosome <- probes$Chr
range_start <- probes$Chr.From
range_end <- range_start + 24
strand_id <- probes$Chr.Strand

my_ranges <- GRanges(seqnames=Rle(chromosome), ranges = IRanges(range_start, range_end, names=probe_id), strand = Rle(strand_id))

mapped_to_probe_regions <- sum(!is.na(findOverlaps(aligns, my_ranges, select = "first")))

# count total mapped

mapped_total <- length(aligns)

# Output results

#print(paste("Number of reads mapped to probe regions:", mapped_to_probe_regions))
#print(paste("Number of reads mapped to gene regions:", mapped_to_gene_regions))
#print(paste("Total amount of mapped reads:", mapped_total))

#print(paste("Ratio: probe_region_mapped/total_mapped", mapped_to_probe_regions/mapped_total))
#print(paste("Ratio: gene_region_mapped/total_mapped", mapped_to_gene_regions/mapped_total))
#print(paste("Ratio: probe_region_mapped/gene_region_mapped", mapped_to_probe_regions/mapped_to_gene_regions))

#save(mapped_to_probe_regions, mapped_to_gene_regions, mapped_total, file=output_file)

cat(paste(mapped_total, " ", mapped_to_gene_regions, " ", mapped_to_probe_regions, "\n", sep=""))
