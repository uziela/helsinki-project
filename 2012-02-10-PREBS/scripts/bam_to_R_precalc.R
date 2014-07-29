#! /cs/fs2/home/uziela/software/R-3.1.0/bin/Rscript

# Arguments:
# 1. Input file (.bam)
# 2. Output file (.RData)
# 3. Mode (PAIRED or UNPAIRED)

library(GenomicAlignments)

cargs <- commandArgs(trailingOnly = TRUE)
input_file <- cargs[1]
output_file <- cargs[2]
mode <- cargs[3]

print(paste("Processing", input_file))

if ( mode == "PAIRED") {
  aligns <- readGAlignmentPairs(input_file)
} else if ( mode == "UNPAIRED") {
  aligns <- readGAlignmentsFromBam(input_file)
} else {
  print("ERROR: incorrect mode parameter")
  print(paste("mode=",mode))
  quit()
}

#aligns <- readBamGappedAlignments(input_file)

#levels(seqnames(aligns))[levels(seqnames(aligns))=="M"] <- "MT"

save(aligns, file=output_file)

print(paste("Processed", input_file))
