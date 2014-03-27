# calculates differential expression between two bitseq output files
# Arguments:
# - first .mean.genes file
# - second .mean.genes file
# - output file

cargs <- commandArgs(trailingOnly = TRUE)

input_file1 <- cargs[1]
input_file2 <- cargs[2]
output_file <- cargs[3]

mm1 <- read.csv(file=input_file1,head=FALSE,sep=" ")
mm2 <- read.csv(file=input_file2,head=FALSE,sep=" ")

colnames(mm1) <- c('gene_id', 'expr1')

colnames(mm2) <- c('gene_id', 'expr2')

mm <- merge(mm1, mm2)

mm$logfc = log2(mm$expr2 / mm$expr1)


rna_table <- data.frame(id=mm$gene_id, log2FoldChange=mm$logfc, baseMeanA=mm$expr1, baseMeanB=mm$expr2)

save(rna_table, file=output_file)

