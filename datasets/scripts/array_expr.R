#! /usr/bin/Rscript 
cargs <- commandArgs(trailingOnly = TRUE)

cel_dir <- cargs[1] # B-cells/all-cel 
cdf_name <- cargs[2] # HGFocus_Hs_ENSG
output_file <- cargs[3] # "B-cells/array_expr.RData"
mode <- cargs[4] # "TOGETHER or SEPARATE". Should .cel files be normalized together or separately?

library(affy)

Data <- ReadAffy(cdfname = cdf_name, celfile.path = cel_dir)
probe_expr <- exprs(Data)

array_expr <- NULL
if (mode == "TOGETHER") {
	eset <- rma(Data)
	array_expr <- exprs(eset)
} else if (mode == "SEPARATE") {
	#print("ERROR: Not implemented yet")
	for (i in 1:ncol(probe_expr)) {
		array_expr <- cbind(array_expr, exprs(rma(Data[,i])))
	}
} else if (mode == "SUBSET") {
	allg <- geneNames(Data)
	subset <- allg[substr(allg,1,4) != "AFFX"]
	eset <- rma(Data, subset)
	array_expr <- exprs(eset)
}

#head(eset)
save(array_expr, probe_expr, file=output_file)


