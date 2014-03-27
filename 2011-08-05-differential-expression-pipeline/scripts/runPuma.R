# The script runs affy and calculates logfc manually. Working directory should contain phen1 and phen2 subdirectories with .CEL files.
# arguments:
# - CDF name 1
# - CDF name 2
# - output file (puma_table.RData)

cargs <- commandArgs(trailingOnly = TRUE)
mycdf1 <- cargs[1]
mycdf2 <- cargs[2]
outfile <- cargs[3]

library(affy)
library(puma)

Data1 <- ReadAffy(cdfname = mycdf1,celfile.path="./phen1")
eset1 <- mmgmos(Data1)
means1 <- rowMeans(exprs(eset1), na.rm=TRUE)

Data2 <- ReadAffy(cdfname = mycdf2,celfile.path="./phen2")
eset2 <- mmgmos(Data2)
means2 <- rowMeans(exprs(eset2), na.rm=TRUE)

puma_table <- merge(means1, means2, by="row.names")
names(puma_table) = c("Gene_ID", "puma_expr1", "puma_expr2")
puma_table$puma_AveExpr <- (puma_table$puma_expr1 + puma_table$puma_expr2) / 2
puma_table$puma_logFC <- puma_table$puma_expr2 - puma_table$puma_expr1


puma_table$Gene_ID <- substr(puma_table$Gene_ID, 1, nchar(puma_table$Gene_ID)-3)

save(puma_table, file=outfile)
