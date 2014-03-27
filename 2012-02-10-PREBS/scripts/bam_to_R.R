# Arguments:
# 1. Input file (.bam)
# 2. Output file (.RData)

library(Rsamtools);

cargs <- commandArgs(trailingOnly = TRUE)
input_file <- cargs[1]
output_file <- cargs[2]

print(paste("Processing", input_file))

aligns <- readBamGappedAlignments(input_file)

#levels(seqnames(aligns))[levels(seqnames(aligns))=="M"] <- "MT"

save(aligns, file=output_file)

print(paste("Processed", input_file))
