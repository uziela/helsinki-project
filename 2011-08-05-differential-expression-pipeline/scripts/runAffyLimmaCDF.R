# The script runs affy and limma with cdf
# arguments:
# - number of instances in phenotype 1
# - number of instances in phenotype 2
# - CDF name
# - output file (array_table.RData)

cargs <- commandArgs(trailingOnly = TRUE)
n1 <- cargs[1]
n2 <- cargs[2]
mycdf <- cargs[3]
outfile <- cargs[4]

library(affy)
Data <- ReadAffy(cdfname = mycdf)
eset <- rma(Data)

library(limma)

conds <- character(0)
for(i in 1:n1) {
	conds <- c(conds,1)
}
for(i in 1:n2) {
	conds <- c(conds,2)
}

design <- model.matrix(~ 0+factor(conds))
colnames(design) <- c("phen1", "phen2")
fit <- lmFit(eset, design)
contrast.matrix <- makeContrasts(phen2-phen1, levels=design)
fit2 <- contrasts.fit(fit, contrast.matrix)
fit2 <- eBayes(fit2)

array_table <- topTable(fit2, coef=1, adjust="BH",1000000)

save(array_table, file=outfile)
