# Arguments:
# 1. Gapped read alignment file in .RData format 
# 2. Output file (it will contain counts for each probe)
# 3. Probe mapping file from custom cdf (e.g. "cdf/HGFocus/HGFocus_Hs_ENSG_mapping.txt")

library(GenomicRanges);

cargs <- commandArgs(trailingOnly = TRUE)

inputFile <- cargs[1]
outputFile <- cargs[2]
cdfFile <- cargs[3]

mode <- "ENSEMBL" # should we use chromosome names as in UCSC or ENSEMBL?

# load data
load(inputFile)
probes <- read.csv(cdfFile, sep = "\t")

if (mode == "UCSC") {
	levels(probes$Chr)[levels(probes$Chr)=="MT"] <- "M"
	probes$Chr <- paste("chr",probes$Chr,sep="")
}

# create GRanges object
probe_id <- paste("xy", "_", probes$Probe.X, "_", probes$Probe.Y, sep="")


chromosome <- probes$Chr
range_start <- probes$Chr.From
range_end <- range_start + 24
strand_id <- probes$Chr.Strand

my_ranges <- GRanges(seqnames=Rle(chromosome), ranges = IRanges(range_start, range_end, names=probe_id), strand = Rle(strand_id))

# count overlaps
counts <- countOverlaps(my_ranges, aligns)

# join tables
probe_counts <- cbind(probes, counts)

save(probe_counts, file=outputFile)
