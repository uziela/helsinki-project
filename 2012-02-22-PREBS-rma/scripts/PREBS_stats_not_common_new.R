#! /usr/bin/Rscript 

my_filter <- function(merged_filtered, mode, percentage_upper, percentage_lower) {
	GENES_N <- nrow(merged_filtered)
	#FILTER_N <- floor(percentage / 100 * GENES_N)
	upper <- floor(percentage_upper / 100 * GENES_N)
	lower <- floor(percentage_lower / 100 * GENES_N)
	#print("number of genes taken:")
	#print(FILTER_N)
	if (mode == "PREBS_BEST") {
		merged_filtered <- merged_filtered[order(merged_filtered$PREBS_RMA, decreasing=TRUE),]
	}

	if (mode == "MMSEQ_BEST") {
		merged_filtered <- merged_filtered[order(merged_filtered$mmseq_expr, decreasing=TRUE),]
	}

	if (mode == "RPKM_BEST") {
		merged_filtered <- merged_filtered[order(merged_filtered$RPKM, decreasing=TRUE),]
	}

	if (mode == "PREBS_MEAN") {
		merged_filtered <- merged_filtered[is.finite(merged_filtered$prebs_log2fc),]
		merged_filtered <- merged_filtered[order(merged_filtered$PREBS_RMA1+merged_filtered$PREBS_RMA2, decreasing=TRUE),]
	}

	if (mode == "MMSEQ_MEAN") {
		merged_filtered <- merged_filtered[is.finite(merged_filtered$mmseq_log2fc),]
		merged_filtered <- merged_filtered[order(merged_filtered$mmseq_expr1+merged_filtered$mmseq_expr2, decreasing=TRUE),]
	}

	if (mode == "RPKM_MEAN") {
		merged_filtered <- merged_filtered[is.finite(merged_filtered$rpkm_log2fc),]
		merged_filtered <- merged_filtered[order(merged_filtered$RPKM1+merged_filtered$RPKM2, decreasing=TRUE),]
	}

	if ((mode == "PREBS_BEST") || (mode == "MMSEQ_BEST") || (mode == "RPKM_BEST") || (mode == "PREBS_MEAN") || (mode == "RPKM_MEAN") || (mode == "MMSEQ_MEAN")) {
		merged_filtered <- merged_filtered[upper:lower,]
	}
	return(merged_filtered)
}

write_results <- function(file_base) {
	table_dir <- paste(output_dir, "/tables", sep="")

	#rpkm_cors  <- c(round(mean(rpkm_cors1),2), round(mean(rpkm_cors2), 2))
	#mmseq_cors <- c(round(mean(mmseq_cors1),2), round(mean(mmseq_cors2),2))
	#prebs_cors <- c(round(mean(prebs_cors1),2), round(mean(prebs_cors2),2))

	rpkm_cors  <- c(mean(rpkm_cors1), mean(rpkm_cors2))
	mmseq_cors <- c(mean(mmseq_cors1), mean(mmseq_cors2))
	prebs_cors <- c(mean(prebs_cors1), mean(prebs_cors2))
	
	output_table <- data.frame(MMSEQ=mmseq_cors, RPKM=rpkm_cors, PREBS=prebs_cors)
	rownames(output_table) <- c("Pearson cor.", "Spearman cor.")
	write.table(output_table, file=paste(table_dir, "/", file_base ,"_stats.csv", sep=""), sep=",", quote=FALSE)

	improve1 <- 100 * round((mean(prebs_cors1) - mean(mmseq_cors1)) / (1-mean(mmseq_cors1)),4)
	improve_rpkm1 <- 100 * round((mean(prebs_cors1) - mean(rpkm_cors1)) / (1-mean(rpkm_cors1)),4)

	improve2 <- 100 * round((mean(prebs_cors2) - mean(mmseq_cors2)) / (1-mean(mmseq_cors2)),4)
	improve_rpkm2 <- 100 * round((mean(prebs_cors2) - mean(rpkm_cors2)) / (1-mean(rpkm_cors2)),4)

	improve_table <- data.frame(Improvement_MMSEQ=c(improve1, improve2), Improvement_RPKM=c(improve_rpkm1, improve_rpkm2))
	rownames(improve_table) <- c("Pearson cor.", "Spearman cor.")
	write.table(improve_table, file=paste(table_dir, "/", file_base, "_improve.csv", sep=""), sep=",", quote=FALSE)

	#data_table <- data.frame(RPKM=round(rpkm_cors1,2), MMSEQ=round(mmseq_cors1,2), PREBS=round(prebs_cors1,2))
	data_table <- data.frame(RPKM=rpkm_cors1, MMSEQ=mmseq_cors1, PREBS=prebs_cors1)
	write.table(data_table, file=paste(table_dir, "/", file_base, "_data.csv", sep=""), sep=",", quote=FALSE)
}

my_replace_ranks <- function(merged_filtered) {
	array_ranks <- data.frame(expr_val=merged_filtered$array_expr, expr_rank=rank(merged_filtered$array_expr, ties.method="random"))
	
	merged_filtered$expr_rank <- rank(merged_filtered$PREBS_RMA, ties.method="random")
	merged_filtered <- merge(merged_filtered, array_ranks)
	merged_filtered$PREBS_RMA <- merged_filtered$expr_val
	merged_filtered <- subset(merged_filtered, select=-c(expr_val,expr_rank))
	
	merged_filtered$expr_rank <- rank(merged_filtered$mmseq_expr, ties.method="random")
	merged_filtered <- merge(merged_filtered, array_ranks)
	merged_filtered$mmseq_expr <- merged_filtered$expr_val
	merged_filtered <- subset(merged_filtered, select=-c(expr_val,expr_rank))
	
	merged_filtered$expr_rank <- rank(merged_filtered$RPKM, ties.method="random")
	merged_filtered <- merge(merged_filtered, array_ranks)
	merged_filtered$RPKM <- merged_filtered$expr_val
	merged_filtered <- subset(merged_filtered, select=-c(expr_val,expr_rank))
	
	return(merged_filtered)
}

my_replace_ranks_new_diff <- function(merged_filtered) {
	array_ranks <- data.frame(expr_val=merged_filtered$array_expr1, expr_rank=rank(merged_filtered$array_expr1, ties.method="random"))
	
	merged_filtered$expr_rank <- rank(merged_filtered$PREBS_RMA2, ties.method="random")
	merged_filtered <- merge(merged_filtered, array_ranks)
	merged_filtered$PREBS_RMA2 <- merged_filtered$expr_val
	merged_filtered <- subset(merged_filtered, select=-c(expr_val,expr_rank))
	
	merged_filtered$expr_rank <- rank(merged_filtered$mmseq_expr2, ties.method="random")
	merged_filtered <- merge(merged_filtered, array_ranks)
	merged_filtered$mmseq_expr2 <- merged_filtered$expr_val
	merged_filtered <- subset(merged_filtered, select=-c(expr_val,expr_rank))
	
	merged_filtered$expr_rank <- rank(merged_filtered$RPKM2, ties.method="random")
	merged_filtered <- merge(merged_filtered, array_ranks)
	merged_filtered$RPKM2 <- merged_filtered$expr_val
	merged_filtered <- subset(merged_filtered, select=-c(expr_val,expr_rank))
	
	return(merged_filtered)
}

source("../general_scripts/my_plot.R")
cargs <- commandArgs(trailingOnly = TRUE)

output_dir <- cargs[1]
#collapse <- log2(as.numeric(cargs[2]))
#alpha <- log2(as.numeric(cargs[3]))
#my_quantile <- as.numeric(cargs[4])
#mode <- cargs[5]
mode2 <- cargs[2] # BASIC, REPLACE or NEW_DIFF
PERCENT_UPPER <- as.numeric(cargs[3])
PERCENT_LOWER <- as.numeric(cargs[4])
merged_files <- cargs[5:length(cargs)] # all merged_with_rma.RData files


prebs_cors1 <- NULL
mmseq_cors1 <- NULL
rpkm_cors1 <- NULL

prebs_cors2 <- NULL
mmseq_cors2 <- NULL
rpkm_cors2 <- NULL

sample_names <- NULL

#collapse <- log2(0.6)

index1 <- 1
index2 <- 2

for (i in 1:length(merged_files)) {
	load(merged_files[i])
	
	#sample_name <- strsplit(merged_files[i], "/")
	#sample_name <- tail(sample_name[[1]], 1)
	sample_name <- basename(merged_files[i])
	sample_name <- strsplit(sample_name, "_")
	sample_name <- sample_name[[1]][1]
	
	sample_names <- c(sample_names, sample_name)
	
	# save correlations
	merged_filtered <- my_filter(merged_with_rma, "PREBS_BEST", PERCENT_UPPER, PERCENT_LOWER)
	if (mode2 == "CROSS_DIFF") { merged_filtered <- my_replace_ranks(merged_filtered) }
	prebs_cors1 <- c(prebs_cors1, cor(merged_filtered$PREBS_RMA, merged_filtered$array_expr))
	prebs_cors2 <- c(prebs_cors2, cor(merged_filtered$PREBS_RMA, merged_filtered$array_expr, method="spearman"))
	my_plot(merged_filtered$PREBS_RMA, merged_filtered$array_expr, paste(output_dir,"/plots/",sample_name,"_PREBS_RMA_vs_array", sep=""), "PREBS_RMA value", "Microarray expression")
	#my_plot(rank(merged_filtered$PREBS_RMA), rank(merged_filtered$array_expr), paste(output_dir,"/plots/",sample_name,"_PREBS_RMA_vs_array_rank", sep=""), "PREBS_RMA value", "Microarray expression")

	merged_filtered <- my_filter(merged_with_rma, "MMSEQ_BEST", PERCENT_UPPER, PERCENT_LOWER)
	if (mode2 == "CROSS_DIFF") { merged_filtered <- my_replace_ranks(merged_filtered) }
	mmseq_cors1 <- c(mmseq_cors1, cor(merged_filtered$mmseq_expr, merged_filtered$array_expr))
	mmseq_cors2 <- c(mmseq_cors2, cor(merged_filtered$mmseq_expr, merged_filtered$array_expr, method="spearman"))
	my_plot(merged_filtered$mmseq_expr, merged_filtered$array_expr, paste(output_dir,"/plots/",sample_name,"_mmseq_vs_array", sep=""), "MMseq expression (log2 scale)", "Microarray expression")
	#my_plot(rank(merged_filtered$mmseq_expr), rank(merged_filtered$array_expr), paste(output_dir,"/plots/",sample_name,"_mmseq_vs_array_rank", sep=""), "MMseq expression (log2 scale)", "Microarray expression")

	merged_filtered <- my_filter(merged_with_rma, "RPKM_BEST", PERCENT_UPPER, PERCENT_LOWER)
	if (mode2 == "CROSS_DIFF") { merged_filtered <- my_replace_ranks(merged_filtered) }
	rpkm_cors1  <- c(rpkm_cors1, cor(merged_filtered$RPKM, merged_filtered$array_expr))
	rpkm_cors2  <- c(rpkm_cors2, cor(merged_filtered$RPKM, merged_filtered$array_expr, method="spearman"))
	my_plot(merged_filtered$RPKM, merged_filtered$array_expr, paste(output_dir,"/plots/",sample_name,"_RPKM_vs_array", sep=""), "RPKM (log2 scale)", "Microarray expression")	
	#my_plot(rank(merged_filtered$RPKM), rank(merged_filtered$array_expr), paste(output_dir,"/plots/",sample_name,"_RPKM_vs_array_rank", sep=""), "RPKM (log2 scale)", "Microarray expression")	
	
}

write_results("prebs")

############################ Differential expression calculation ########################################

N_SAMPLES <- length(merged_files)

#print("number of samples")
#print(N_SAMPLES)

prebs_cors1 <- NULL
mmseq_cors1 <- NULL
rpkm_cors1 <- NULL

prebs_cors2 <- NULL
mmseq_cors2 <- NULL
rpkm_cors2 <- NULL

for (i in 1:(N_SAMPLES-1)) {
	for (j in (i+1):N_SAMPLES) {
		#print("------i,j---")
		#print(i)
		#print(j)
		load(merged_files[i])
		merged1 <- merged_with_rma
		colnames(merged1) <- c("Gene_ID", "PREBS_mean1", "PREBS_median1", "array_expr1", "mmseq_expr1", "RPKM1", "Probes_mean_raw1", "PREBS_RMA1")
		load(merged_files[j])
		merged2 <- merged_with_rma
		colnames(merged2) <- c("Gene_ID", "PREBS_mean2", "PREBS_median2", "array_expr2", "mmseq_expr2", "RPKM2", "Probes_mean_raw2", "PREBS_RMA2")
		merged <- merge(merged1, merged2)

		merged$array_log2fc <- merged$array_expr2 - merged$array_expr1

		#quantile(abs(merged$array_log2fc), 0.95)

		merged$prebs_log2fc <- merged$PREBS_RMA2 - merged$PREBS_RMA1
		merged$mmseq_log2fc <- merged$mmseq_expr2 - merged$mmseq_expr1
		merged$rpkm_log2fc <- merged$RPKM2 - merged$RPKM1
		
		merged_filtered <- my_filter(merged, "MMSEQ_MEAN", PERCENT_UPPER, PERCENT_LOWER)
		if (mode2 == "CROSS_DIFF") {
			merged_filtered <- my_replace_ranks_new_diff(merged_filtered)
			merged_filtered$mmseq_log2fc <- merged_filtered$mmseq_expr2 - merged_filtered$array_expr1
		}
		mmseq_cors1 <- c(mmseq_cors1, cor(merged_filtered$mmseq_log2fc, merged_filtered$array_log2fc, method="pearson"))
		mmseq_cors2 <- c(mmseq_cors2, cor(merged_filtered$mmseq_log2fc, merged_filtered$array_log2fc, method="spearman"))
		if ((i == index1) && (j == index2)) {
			my_plot(merged_filtered$mmseq_log2fc, merged_filtered$array_log2fc, paste(output_dir, "/plots-diff/mmseq_vs_array_log2fc", sep=""), "MMseq Log2FC", "Microarray Log2FC")
		}

		merged_filtered <- my_filter(merged, "PREBS_MEAN", PERCENT_UPPER, PERCENT_LOWER)
		if (mode2 == "CROSS_DIFF") {
			merged_filtered <- my_replace_ranks_new_diff(merged_filtered)
			merged_filtered$prebs_log2fc <- merged_filtered$PREBS_RMA2 - merged_filtered$array_expr1
		}
		prebs_cors1 <- c(prebs_cors1, cor(merged_filtered$prebs_log2fc, merged_filtered$array_log2fc, method="pearson"))
		prebs_cors2 <- c(prebs_cors2, cor(merged_filtered$prebs_log2fc, merged_filtered$array_log2fc, method="spearman"))
		if ((i == index1) && (j == index2)) {
			my_plot(merged_filtered$prebs_log2fc, merged_filtered$array_log2fc, paste(output_dir, "/plots-diff/prebs_vs_array_log2fc", sep=""), "PREBS Log2FC", "Microarray Log2FC")
		}

		merged_filtered <- my_filter(merged, "RPKM_MEAN", PERCENT_UPPER, PERCENT_LOWER)
		if (mode2 == "CROSS_DIFF") {
			merged_filtered <- my_replace_ranks_new_diff(merged_filtered)
			merged_filtered$rpkm_log2fc <- merged_filtered$RPKM2 - merged_filtered$array_expr1
		}
		rpkm_cors1 <- c(rpkm_cors1, cor(merged_filtered$rpkm_log2fc, merged_filtered$array_log2fc, method="pearson"))
		rpkm_cors2 <- c(rpkm_cors2, cor(merged_filtered$rpkm_log2fc, merged_filtered$array_log2fc, method="spearman"))
		if ((i == index1) && (j == index2)) {
			my_plot(merged_filtered$rpkm_log2fc, merged_filtered$array_log2fc, paste(output_dir, "/plots-diff/rpkm_vs_array_log2fc", sep=""), "RPKM Log2FC", "Microarray Log2FC")
		}

		# Venn diagrams
		if ((i == index1) && (j == index2)) {
			merged <- merged[is.finite(merged$prebs_log2fc),]
			merged <- merged[is.finite(merged$rpkm_log2fc),]
			merged <- merged[is.finite(merged$mmseq_log2fc),]
			mmseq_diff <- (merged$mmseq_log2fc > log2(1.5)) | (merged$mmseq_log2fc < -log2(1.5))
			array_diff <- (merged$array_log2fc > log2(1.5)) | (merged$array_log2fc < -log2(1.5))
			prebs_diff <- (merged$prebs_log2fc > log2(1.5)) | (merged$prebs_log2fc < -log2(1.5))
			
			venn_input <- data.frame(MMSEQ=mmseq_diff, Microarray=array_diff, PREBS=prebs_diff)
			my_venn(venn_input, paste(output_dir, "/plots-diff/venn", sep=""))
		}
	}
}

write_results("prebs_log2fc")

#warnings()
