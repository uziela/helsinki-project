#! /usr/bin/Rscript 

my_filter <- function(merged_filtered, mode) {
	if ((mode == "FILTER") || (mode == "SEPARATE_Q_FILTER")) {
		merged_filtered <- merged_filtered[!is.na(merged_filtered$mmseq_expr),]
		merged_filtered <- merged_filtered[!is.na(merged_filtered$RPKM),]
		merged_filtered <- merged_filtered[merged_filtered$mmseq_expr > collapse,]
		merged_filtered <- merged_filtered[merged_filtered$RPKM > collapse,]
		merged_filtered <- merged_filtered[merged_filtered$PREBS_RMA > alpha,]
	}
	
	if ((mode == "FILTER_MMSEQ") || (mode == "SEPARATE_Q")) {
		merged_filtered <- merged_filtered[!is.na(merged_filtered$mmseq_expr),]
		merged_filtered <- merged_filtered[!is.na(merged_filtered$RPKM),]
		merged_filtered <- merged_filtered[merged_filtered$mmseq_expr > collapse,]
	}	
		
	if ((mode == "COLLAPSE") || (mode == "FILTER_ARR") || (mode == "FILTER_SEQ")) {
		merged_filtered$mmseq_expr[is.na(merged_filtered$mmseq_expr)] <- collapse
		merged_filtered$RPKM[is.na(merged_filtered$RPKM)] <- collapse
		merged_filtered$mmseq_expr[merged_filtered$mmseq_expr < collapse] <- collapse
		merged_filtered$RPKM[merged_filtered$RPKM < collapse] <- collapse
	}
	
	if (mode == "FILTER_ARR") {
		merged_filtered <- merged_filtered[merged_filtered$array_expr >= quantile(merged_filtered$array_expr, my_quantile) - 0.001,]
	}
	
	if (mode == "FILTER_SEQ") {
		q1 <- quantile(merged_filtered$RPKM, my_quantile) - 0.001
		q2 <- quantile(merged_filtered$mmseq_expr, my_quantile) - 0.001
		q3 <- quantile(merged_filtered$PREBS_RMA, my_quantile) - 0.001
		
		merged_filtered <- merged_filtered[merged_filtered$RPKM > q1,]
		merged_filtered <- merged_filtered[merged_filtered$mmseq_expr > q2,]
		merged_filtered <- merged_filtered[merged_filtered$PREBS_RMA > q3,]
	}
	
	if ((mode == "SEPARATE_Q") || (mode == "SEPARATE_Q_FILTER")) {
		q1 <- quantile(merged_filtered$array_expr, my_quantile) - 0.001
		q2 <- quantile(merged_filtered$array_expr, my_quantile + 0.2) + 0.001
		merged_filtered <- merged_filtered[(merged_filtered$array_expr > q1) & (merged_filtered$array_expr < q2),]
	}
	return(merged_filtered)
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
collapse <- log2(as.numeric(cargs[2]))
alpha <- log2(as.numeric(cargs[3]))
my_quantile <- as.numeric(cargs[4])
mode <- cargs[5]
mode2 <- cargs[6] # BASIC, REPLACE or NEW_DIFF
merged_files <- cargs # all merged_with_rma.RData files

prebs_cors1 <- NULL
mmseq_cors1 <- NULL
rpkm_cors1 <- NULL

prebs_cors2 <- NULL
mmseq_cors2 <- NULL
rpkm_cors2 <- NULL

prebs_raw_cors <- NULL
mmseq_raw_cors <- NULL

sample_names <- NULL

merged1 <- NULL
merged2 <- NULL

#collapse <- log2(0.6)

start_arg <- 7

index1 <- 1
index2 <- 2

for (i in start_arg:length(merged_files)) {
	load(merged_files[i])
	
	#sample_name <- strsplit(merged_files[i], "/")
	#sample_name <- tail(sample_name[[1]], 1)
	sample_name <- basename(merged_files[i])
	sample_name <- strsplit(sample_name, "_")
	sample_name <- sample_name[[1]][1]
	
	sample_names <- c(sample_names, sample_name)
	
	merged_filtered <- my_filter(merged_with_rma, mode)
	if (mode2 == "REPLACE") {
		merged_filtered <- my_replace_ranks(merged_filtered)
	}
	
	# save correlations
	prebs_cors1 <- c(prebs_cors1, cor(merged_filtered$PREBS_RMA, merged_filtered$array_expr))
	prebs_cors2 <- c(prebs_cors2, cor(merged_filtered$PREBS_RMA, merged_filtered$array_expr, method="spearman"))
	my_plot(merged_filtered$PREBS_RMA, merged_filtered$array_expr, paste(output_dir,"/plots/",sample_name,"_PREBS_RMA_vs_array.png", sep=""), "PREBS_RMA value", "Microarray expression")

	mmseq_cors1 <- c(mmseq_cors1, cor(merged_filtered$mmseq_expr, merged_filtered$array_expr))
	mmseq_cors2 <- c(mmseq_cors2, cor(merged_filtered$mmseq_expr, merged_filtered$array_expr, method="spearman"))
	mmseq_raw_cors <- c(mmseq_raw_cors, cor(merged_filtered$mmseq_expr, merged_filtered$Probes_mean_raw))
	my_plot(merged_filtered$mmseq_expr, merged_filtered$array_expr, paste(output_dir,"/plots/",sample_name,"_mmseq_vs_array.png", sep=""), "MMseq expression (log2 scale)", "Microarray expression")

	rpkm_cors1  <- c(rpkm_cors1, cor(merged_filtered$RPKM, merged_filtered$array_expr))
	rpkm_cors2  <- c(rpkm_cors2, cor(merged_filtered$RPKM, merged_filtered$array_expr, method="spearman"))
	my_plot(merged_filtered$RPKM, merged_filtered$array_expr, paste(output_dir,"/plots/",sample_name,"_RPKM_vs_array.png", sep=""), "RPKM (log2 scale)", "Microarray expression")	
	
	if (start_arg + index1 - 1 == i) {
		merged1 <- merged_filtered
		colnames(merged1) <- c("Gene_ID", "PREBS_mean1", "PREBS_median1", "array_expr1", "mmseq_expr1", "RPKM1", "Probes_mean_raw1", "PREBS_RMA1")
	}
	if (start_arg + index2 - 1 == i) {
		merged2 <- merged_filtered
		colnames(merged2) <- c("Gene_ID", "PREBS_mean2", "PREBS_median2", "array_expr2", "mmseq_expr2", "RPKM2", "Probes_mean_raw2", "PREBS_RMA2")
	}
}

table_dir <- paste(output_dir, "/tables", sep="")

rpkm_cors  <- c(round(mean(rpkm_cors1),2), round(mean(rpkm_cors2), 2))
mmseq_cors <- c(round(mean(mmseq_cors1),2), round(mean(mmseq_cors2),2))
prebs_cors <- c(round(mean(prebs_cors1),2), round(mean(prebs_cors2),2))

output_table <- data.frame(MMSEQ=mmseq_cors, RPKM=rpkm_cors, PREBS=prebs_cors)
rownames(output_table) <- c("Pearson cor.", "Spearman cor.")
write.table(output_table, file=paste(table_dir, "/prebs_stats.csv", sep=""), sep=",", quote=FALSE)

# Round correlations before calculating improvement (can be commented)
#rpkm_cors1 <- round(mean(rpkm_cors1), 2)
#mmseq_cors1 <- round(mean(mmseq_cors1), 2)
#prebs_cors1 <- round(mean(prebs_cors1), 2)
#rpkm_cors2 <- round(mean(rpkm_cors2), 2)
#mmseq_cors2 <- round(mean(mmseq_cors2), 2)
#prebs_cors2 <- round(mean(prebs_cors2), 2)

improve1 <- 100 * round((mean(prebs_cors1) - mean(mmseq_cors1)) / (1-mean(mmseq_cors1)),4)
improve_rpkm1 <- 100 * round((mean(prebs_cors1) - mean(rpkm_cors1)) / (1-mean(rpkm_cors1)),4)

improve2 <- 100 * round((mean(prebs_cors2) - mean(mmseq_cors2)) / (1-mean(mmseq_cors2)),4)
improve_rpkm2 <- 100 * round((mean(prebs_cors2) - mean(rpkm_cors2)) / (1-mean(rpkm_cors2)),4)

improve_table <- data.frame(Improvement_MMSEQ=c(improve1, improve2), Improvement_RPKM=c(improve_rpkm1, improve_rpkm2))
rownames(improve_table) <- c("Pearson cor.", "Spearman cor.")
write.table(improve_table, file=paste(table_dir, "/prebs_improve.csv", sep=""), sep=",", quote=FALSE)

#print(sample_names)
#print(sort(prebs_cors1, index.return=TRUE)$ix)
#print(sort(mmseq_cors1, index.return=TRUE)$ix)

############################ Differential expression calculation ########################################

merged <- merge(merged1, merged2)

merged$array_log2fc <- merged$array_expr2 - merged$array_expr1

quantile(abs(merged$array_log2fc), 0.95)

if ((mode2 == "BASIC") || (mode2 == "REPLACE")) {
	merged$prebs_log2fc <- merged$PREBS_RMA2 - merged$PREBS_RMA1
	merged$mmseq_log2fc <- merged$mmseq_expr2 - merged$mmseq_expr1
	merged$rpkm_log2fc <- merged$RPKM2 - merged$RPKM1
	print(quantile(abs(merged$mmseq_log2fc), 0.95))
	print(quantile(abs(merged$rpkm_log2fc), 0.95))
	print(quantile(abs(merged$prebs_log2fc), 0.95))
	
	my_plot(merged$mmseq_log2fc, merged$array_log2fc, paste(output_dir, "/plots-diff/mmseq_vs_array_log2fc.png", sep=""), "MMseq Log2FC", "Microarray Log2FC")
	my_plot(merged$prebs_log2fc, merged$array_log2fc, paste(output_dir, "/plots-diff/prebs_vs_array_log2fc.png", sep=""), "PREBS Log2FC", "Microarray Log2FC")
	my_plot(merged$rpkm_log2fc, merged$array_log2fc, paste(output_dir, "/plots-diff/rpkm_vs_array_log2fc.png", sep=""), "RPKM Log2FC", "Microarray Log2FC")
	#my_plot(merged$prebs_log2fc, merged$mmseq_log2fc, paste(output_dir, "/plots-diff/prebs_vs_mmseq_log2fc.png", sep=""), "PREBS Log2FC", "MMseq Log2FC")
}

if (mode2 == "NEW_DIFF") {
	merged <- my_replace_ranks_new_diff(merged)
	merged$prebs_log2fc <- merged$PREBS_RMA2 - merged$array_expr1
	merged$mmseq_log2fc <- merged$mmseq_expr2 - merged$array_expr1
	merged$rpkm_log2fc <- merged$RPKM2 - merged$array_expr1
	my_plot(merged$mmseq_log2fc, merged$array_log2fc, paste(output_dir, "/plots-diff/mmseq_vs_array_log2fc.png", sep=""), "MMseq-Microarray Log2FC", "Microarray Log2FC")
	my_plot(merged$prebs_log2fc, merged$array_log2fc, paste(output_dir, "/plots-diff/prebs_vs_array_log2fc.png", sep=""), "PREBS-Microarray Log2FC", "Microarray Log2FC")
	my_plot(merged$rpkm_log2fc, merged$array_log2fc, paste(output_dir, "/plots-diff/rpkm_vs_array_log2fc.png", sep=""), "RPKM-Microarray Log2FC", "Microarray Log2FC")
	#my_plot(merged$prebs_log2fc, merged$mmseq_log2fc, paste(output_dir, "/plots-diff/prebs_vs_mmseq_log2fc.png", sep=""), "PREBS Log2FC", "MMseq Log2FC")
}



# Venn diagrams
mmseq_diff <- (merged$mmseq_log2fc > log2(1.5)) | (merged$mmseq_log2fc < -log2(1.5))
array_diff <- (merged$array_log2fc > log2(1.5)) | (merged$array_log2fc < -log2(1.5))
prebs_diff <- (merged$prebs_log2fc > log2(1.5)) | (merged$prebs_log2fc < -log2(1.5))

venn_input <- data.frame(MMSEQ=mmseq_diff, Microarray=array_diff, PREBS=prebs_diff)
my_venn(venn_input, paste(output_dir, "/plots-diff/venn.pdf", sep=""))

# Correlation table

table_dir <- paste(output_dir, "/tables", sep="")

rpkm_cor1 <- cor(merged$rpkm_log2fc, merged$array_log2fc, method="pearson")
rpkm_cor2 <- cor(merged$rpkm_log2fc, merged$array_log2fc, method="spearman")

mmseq_cor1 <- cor(merged$mmseq_log2fc, merged$array_log2fc, method="pearson")
mmseq_cor2 <- cor(merged$mmseq_log2fc, merged$array_log2fc, method="spearman")

prebs_cor1 <- cor(merged$prebs_log2fc, merged$array_log2fc, method="pearson")
prebs_cor2 <- cor(merged$prebs_log2fc, merged$array_log2fc, method="spearman")

rpkm_cors  <- c(round(rpkm_cor1, 2), round(rpkm_cor2, 2))
mmseq_cors <- c(round(mmseq_cor1, 2), round(mmseq_cor2, 2))
prebs_cors <- c(round(prebs_cor1, 2), round(prebs_cor2, 2))

output_table <- data.frame(MMSEQ=mmseq_cors, RPKM=rpkm_cors, PREBS=prebs_cors)
rownames(output_table) <- c("Pearson cor.", "Spearman cor.")
write.table(output_table, file=paste(table_dir, "/prebs_log2fc_stats.csv", sep=""), sep=",", quote=FALSE)

# Round correlations before calculating improvement (can be commented)
#rpkm_cor1 <- round(rpkm_cor1, 2)
#mmseq_cor1 <- round(mmseq_cor1, 2)
#prebs_cor1 <- round(prebs_cor1, 2)
#rpkm_cor2 <- round(rpkm_cor2, 2)
#mmseq_cor2 <- round(mmseq_cor2, 2)
#prebs_cor2 <- round(prebs_cor2, 2)

improve1 <- 100 * round((prebs_cor1 - mmseq_cor1) / (1-mmseq_cor1),4)
improve_rpkm1 <- 100 * round((prebs_cor1 - rpkm_cor1) / (1-rpkm_cor1),4)

improve2 <- 100 * round((prebs_cor2 - mmseq_cor2) / (1-mmseq_cor2),4)
improve_rpkm2 <- 100 * round((prebs_cor2 - rpkm_cor2) / (1-rpkm_cor2),4)

improve_table <- data.frame(Improvement_MMSEQ=c(improve1, improve2), Improvement_RPKM=c(improve_rpkm1, improve_rpkm2))
rownames(improve_table) <- c("Pearson cor.", "Spearman cor.")
write.table(improve_table, file=paste(table_dir, "/prebs_log2fc_improve.csv", sep=""), sep=",", quote=FALSE)


