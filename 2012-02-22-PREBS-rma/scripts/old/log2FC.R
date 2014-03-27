#! /usr/bin/Rscript 

source("/triton/ics/scratch/uzielak1/general_scripts/my_plot.R")

cargs <- commandArgs(trailingOnly = TRUE)

array_means_file <- cargs[1] 
rna_means_file <- cargs[2]
prebs_rma_file <- cargs[3]
rpkm_table_file <- cargs[4]

output_dir <- cargs[5]

collapse <- log2(as.numeric(cargs[6]))
alpha <- log2(as.numeric(cargs[7]))
my_quantile <- as.numeric(cargs[8])

mode <- cargs[9]

#collapse <- log2(0.3)

#index1=37
#index2=20

index1=1
index2=2

load(array_means_file)
if (mode == "FILTER_ARR") {
	array_expr_means <- array_expr_means[array_expr_means[,index1] > quantile(array_expr_means[,index1], my_quantile) - 0.001,]
	array_expr_means <- array_expr_means[array_expr_means[,index2] > quantile(array_expr_means[,index2], my_quantile) - 0.001,]
}

if ((mode == "SEPARATE_Q") || (mode == "SEPARATE_Q_FILTER")) {
	q1_down <- quantile(array_expr_means[,index1], my_quantile) - 0.001
	q1_up <- quantile(array_expr_means[,index1], my_quantile + 0.2) + 0.001
	q2_down <- quantile(array_expr_means[,index2], my_quantile) - 0.001
	q2_up <- quantile(array_expr_means[,index2], my_quantile + 0.2) + 0.001
	array_expr_means <- array_expr_means[(array_expr_means[,index1] > q1_down) & (array_expr_means[,index1] < q1_up),]
	array_expr_means <- array_expr_means[(array_expr_means[,index2] > q2_down) & (array_expr_means[,index2] < q2_up),]
}

array_log2fc <- data.frame(Gene_ID=rownames(array_expr_means), array_log2fc=array_expr_means[,index1]-array_expr_means[,index2])
#head(array_log2fc)

load(rna_means_file)

if ((mode == "COLLAPSE") || (mode == "FILTER_ARR") || (mode == "FILTER_SEQ") || (mode == "SEPARATE_Q")) {
	rna_expr_means[rna_expr_means < collapse] <- collapse
	rna_expr_means[is.na(rna_expr_means)] <- collapse
}

if ((mode == "FILTER") || (mode == "SEPARATE_Q_FILTER")) {
	rna_expr_means <- rna_expr_means[rna_expr_means[,index1]>collapse,]
	rna_expr_means <- rna_expr_means[rna_expr_means[,index2]>collapse,]
	rna_expr_means <- rna_expr_means[!is.na(rna_expr_means[,index1]),]
	rna_expr_means <- rna_expr_means[!is.na(rna_expr_means[,index2]),]	
}

if (mode == "FILTER_SEQ") {
	rna_expr_means <- rna_expr_means[rna_expr_means[,index1] >= quantile(rna_expr_means[,index1], my_quantile) - 0.001,]
	rna_expr_means <- rna_expr_means[rna_expr_means[,index2] >= quantile(rna_expr_means[,index2], my_quantile) - 0.001,]
}

mmseq_log2fc <- data.frame(Gene_ID=rownames(rna_expr_means), mmseq_log2fc=rna_expr_means[,index1]-rna_expr_means[,index2])
#head(mmseq_log2fc)



load(prebs_rma_file)
if ((mode == "FILTER") || (mode == "SEPARATE_Q_FILTER")) {
	prebs_rma <- prebs_rma[prebs_rma[,index1]>alpha,]
	prebs_rma <- prebs_rma[prebs_rma[,index2]>alpha,]
}

if (mode == "FILTER_SEQ") {
	prebs_rma <- prebs_rma[prebs_rma[,index1] >= quantile(prebs_rma[,index1], my_quantile) - 0.001,]
	prebs_rma <- prebs_rma[prebs_rma[,index2] >= quantile(prebs_rma[,index2], my_quantile) - 0.001,]
}

prebs_log2fc <- data.frame(Gene_ID=prebs_rma$Gene_ID, prebs_log2fc=prebs_rma[,index1]-prebs_rma[,index2])
#head(prebs_log2fc)

load(rpkm_table_file)
if ((mode == "COLLAPSE") || (mode == "FILTER_ARR") || (mode == "FILTER_SEQ") || (mode == "SEPARATE_Q")) {
	RPKM_table[RPKM_table < collapse] <- collapse
	RPKM_table[is.na(RPKM_table)] <- collapse
}

if ((mode == "FILTER") || (mode == "SEPARATE_Q_FILTER")) {
	RPKM_table <- RPKM_table[!is.na(RPKM_table[,index1]),]
	RPKM_table <- RPKM_table[!is.na(RPKM_table[,index2]),]
	RPKM_table <- RPKM_table[RPKM_table[,index1]>collapse,]
	RPKM_table <- RPKM_table[RPKM_table[,index2]>collapse,]
}

if (mode == "FILTER_SEQ") {
	RPKM_table <- RPKM_table[RPKM_table[,index1] >= quantile(RPKM_table[,index1], my_quantile) - 0.001,]
	RPKM_table <- RPKM_table[RPKM_table[,index2] >= quantile(RPKM_table[,index2], my_quantile) - 0.001,]
}

rpkm_log2fc <- data.frame(Gene_ID=rownames(RPKM_table), rpkm_log2fc=RPKM_table[,index1]-RPKM_table[,index2])


merged <- merge(array_log2fc, mmseq_log2fc)

merged <- merge(merged, prebs_log2fc)

merged <- merge(merged, rpkm_log2fc)

my_plot(merged$mmseq_log2fc, merged$array_log2fc, paste(output_dir, "/plots-diff/mmseq_vs_array_log2fc.png", sep=""), "MMseq Log2FC", "Microarray Log2FC")

my_plot(merged$prebs_log2fc, merged$array_log2fc, paste(output_dir, "/plots-diff/prebs_vs_array_log2fc.png", sep=""), "PREBS Log2FC", "Microarray Log2FC")

my_plot(merged$rpkm_log2fc, merged$array_log2fc, paste(output_dir, "/plots-diff/rpkm_vs_array_log2fc.png", sep=""), "RPKM Log2FC", "Microarray Log2FC")

my_plot(merged$prebs_log2fc, merged$mmseq_log2fc, paste(output_dir, "/plots-diff/prebs_vs_mmseq_log2fc.png", sep=""), "PREBS Log2FC", "MMseq Log2FC")

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

output_table <- data.frame(RPKM=rpkm_cors, MMSEQ=mmseq_cors, PREBS=prebs_cors)
rownames(output_table) <- c("Pearson cor.", "Spearman cor.")
write.table(output_table, file=paste(table_dir, "/prebs_log2fc_stats.csv", sep=""), sep=",", quote=FALSE)

improve1 <- 100 * round((prebs_cor1 - mmseq_cor1) / (1-mmseq_cor1),4)
improve_rpkm1 <- 100 * round((prebs_cor1 - rpkm_cor1) / (1-rpkm_cor1),4)

improve2 <- 100 * round((prebs_cor2 - mmseq_cor2) / (1-mmseq_cor2),4)
improve_rpkm2 <- 100 * round((prebs_cor2 - rpkm_cor2) / (1-rpkm_cor2),4)

improve_table <- data.frame(Improvement_RPKM=c(improve_rpkm1, improve_rpkm2), Improvement_MMSEQ=c(improve1, improve2))
rownames(improve_table) <- c("Pearson cor.", "Spearman cor.")
write.table(improve_table, file=paste(table_dir, "/prebs_log2fc_improve.csv", sep=""), sep=",", quote=FALSE)
	

