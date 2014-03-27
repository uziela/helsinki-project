# The script forms count table suitable for DESeq package.
# The first argument should be ouput file name
# The rest of the arguments should be input files (*_counts.RData files)
# The beginning of file name (phen1_ or phen2_) determines to which phenotype the file belongs

cargs <- commandArgs(trailingOnly = TRUE)

count_table <- numeric(0)

for(i in 2:length(cargs)) {
	load(cargs[i])
	names(counts) <- names(rpkm)
	count_table <- cbind(count_table, counts)
}

conds <- character(0)

for(i in 2:length(cargs)) {
	if (length(grep("phen1_",cargs[i])) != 0) {
		conds <- c(conds,"phen1")
	} else {
		conds <- c(conds,"phen2")
	}
}

colnames(count_table) <- 1:ncol(count_table)

save(count_table, conds, file=cargs[1])
