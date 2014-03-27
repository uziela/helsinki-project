# The script runs affy and calculates logfc manually. Working directory should contain phen1 and phen2 subdirectories with .CEL files.
# arguments:
# - CDF name 1
# - CDF name 2
# - output file (array_table.RData)

cargs <- commandArgs(trailingOnly = TRUE)
mycdf1 <- cargs[1]
mycdf2 <- cargs[2]
outfile <- cargs[3]
dir1 <- cargs[4]
dir2 <- cargs[5]

library(affy)

Data1 <- ReadAffy(cdfname = mycdf1,celfile.path=dir1)
eset1 <- rma(Data1)
means1 <- rowMeans(exprs(eset1), na.rm=TRUE)

Data2 <- ReadAffy(cdfname = mycdf2,celfile.path=dir2)
eset2 <- rma(Data2)
means2 <- rowMeans(exprs(eset2), na.rm=TRUE)

array_expr <- merge(means1, means2, by="row.names")
names(array_expr) = c("ID", "expr1", "expr2")
array_expr$AveExpr <- (array_expr$expr1 + array_expr$expr2) / 2
array_expr$logFC <- log2(2^array_expr$expr2/2^array_expr$expr1)

array_table <- data.frame(ID=array_expr$ID, logFC=array_expr$logFC, AveExpr=array_expr$AveExpr, t=0, P.Value=0, adj.P.Val=0, B=0)

save(array_table, file=outfile)
