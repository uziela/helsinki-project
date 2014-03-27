#! /usr/bin/Rscript 

cargs <- commandArgs(trailingOnly = TRUE)

input_file <- cargs[1]
output_file <- cargs[2]
mode <- cargs[3]

load(input_file)

if (mode == "SUM_DUPLICATES") {
	library(plyr)

	probe_table <- as.data.frame(probe_table)

	probe_table$id <- rownames(probe_table)

	#probe_table <- tail(probe_table, 100)

	correct <- ddply(probe_table, "id", function(df)c(sum(df$kidney),sum(df$liver)))

	colnames(correct) <- c("id", "kidney", "liver")

	probe_table_mat <- matrix(c(correct$kidney, correct$liver),ncol=2)
	colnames(probe_table_mat) <- c("kidney","liver")
	rownames(probe_table_mat) <- correct$id
	probe_table <- probe_table_mat
} else if (mode == "REMOVE_DUPLICATES") {
	rn <- rownames(probe_table)
	dupl <- rn[duplicated(rn)]
	probe_table <- probe_table[!is.element(rownames(probe_table), dupl),]
}

save(probe_table, file=output_file)
