# first argument - input file (count_table.RData)
# second argument - output file (rna_table.RData)

cargs <- commandArgs(trailingOnly = TRUE)

library("DESeq")
load(cargs[1])
cds <- newCountDataSet( count_table, conds )
cds <- estimateSizeFactors(cds)
if (length(conds) > 2) {
	cds <- estimateVarianceFunctions( cds )
} else {
	cds <- estimateVarianceFunctions( cds, method='blind')
}
rna_table <- nbinomTest( cds, "phen1", "phen2" )
save(rna_table, file=cargs[2])
