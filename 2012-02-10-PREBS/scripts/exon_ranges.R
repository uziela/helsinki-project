#! /cs/fs2/home/uziela/software/R-3.1.0/bin/Rscript
# Reads exon ranges from UCSC server and stores them in RData file

library(GenomicFeatures)

#txdb <- makeTranscriptDbFromUCSC(genome="hg19", tablename="ensGene") # Creates a TranscriptDb object from transcript annotations available at the UCSC Genome Browser.
txdb <- makeTranscriptDbFromBiomart(biomart="ensembl", dataset="hsapiens_gene_ensembl")

exonRanges <- exonsBy(txdb, "gene") # Stores exon data as a GRangesList object.

save(file="exons.RData", exonRanges)
#saveFeatures(txdb, "exons.sqlite")
