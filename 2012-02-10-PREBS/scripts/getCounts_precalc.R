#! /cs/fs2/home/uziela/software/R-3.1.0/bin/Rscript
#options(error=recover)

library(GenomicRanges);
#library(GenomicFeatures);
library(Rsamtools);

cargs <- commandArgs(trailingOnly = TRUE)
input_file <- cargs[1]
output_file <- cargs[2]
load(input_file)
load("exons.RData")

# chromosomes <- as.factor(c(1:22,"X","Y","MT"))
# aligns[is.element(as.vector(seqnames(aligns)),chromosomes)]
# is.element(names(seqlengths(aligns2)), chromosomes)

#if (! is.na(seqlengths(aligns)['HSCHR19LRC_LRC_J_CTG1'])) {
#	seqlengths(aligns)['HSCHR19LRC_LRC_J_CTG1'] <- seqlengths(exonRanges)['HSCHR19LRC_LRC_J_CTG1'] # a little hack, because something is going wrong :/
#}

print(paste("Processing", input_file))
#counts <- countOverlaps(exonRanges, aligns) # Counts matching reads per transcript.

hits <- findOverlaps(aligns, exonRanges, ignore.strand=TRUE)
perm <- sample(length(hits))
features <- rep(NA_integer_, queryLength(hits))
features[queryHits(hits)[perm]] <- subjectHits(hits)[perm] # If a read overlaps with several probe regions, we pick a random one
counts_temp <- tabulate(features)
counts <- rep(0, length(exonRanges))
counts[1:length(counts_temp)] <- counts_temp

numBases <- sum(width(exonRanges)) # Number of bases per exonRanges element.
geneLengthsInKB <- (numBases/1000) # Conversion to kbp.
millionsMapped <- sum(counts)/1e+06 # Factor for converting to million of mapped reads.
rpk <- (counts+1)/geneLengthsInKB # RPK: reads per kilobase of exon model.
rpkm <- rpk/millionsMapped # RPKM: reads per kilobase of exon model per million mapped reads. Note: the results are stored in a named vector that matches the index of the initial GRangesList object!!!

#warnings()

save(counts, rpk, rpkm, file=output_file)

