#! /cs/fs2/home/uziela/software/R-3.1.0/bin/Rscript 
cargs <- commandArgs(trailingOnly = TRUE)

cel_dir <- cargs[1] # B-cells/all-cel 
cdf_name <- cargs[2] # HGFocus_Hs_ENSG
output_file <- cargs[3] # "B-cells/array_expr.RData"

library(RPA)
library(affy)

Data <- ReadAffy(cdfname = cdf_name, celfile.path = cel_dir)
probe_expr <- exprs(Data)

array_expr_eset <- rpa(cdf = cdf_name, cel.path = cel_dir)
array_expr <- exprs(array_expr_eset)

#head(eset)
save(array_expr, probe_expr, file=output_file)


