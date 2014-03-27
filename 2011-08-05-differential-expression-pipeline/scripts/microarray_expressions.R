# The script runs affy and calculates logfc manually. Working directory should contain phen1 and phen2 subdirectories with .CEL files.
# arguments:
# - CDF name 1
# - CDF name 2
# - output file (array_table.RData)

cargs <- commandArgs(trailingOnly = TRUE)
mycdf1 <- cargs[1]
mycdf2 <- cargs[2]
outfile <- cargs[3]

library(affy)

Data1 <- ReadAffy(cdfname = mycdf1,celfile.path="./phen1")
eset1 <- rma(Data1)
means1 <- rowMeans(exprs(eset1), na.rm=TRUE)

Data2 <- ReadAffy(cdfname = mycdf2,celfile.path="./phen2")
eset2 <- rma(Data2)
means2 <- rowMeans(exprs(eset2), na.rm=TRUE)

array_expr <- merge(means1, means2, by="row.names")
names(array_expr) = c("Gene_ID", "array_expr1", "array_expr2")
array_expr$Gene_ID <- substr(array_expr$Gene_ID, 1, nchar(array_expr$Gene_ID)-3)

save(array_expr, file=outfile)
