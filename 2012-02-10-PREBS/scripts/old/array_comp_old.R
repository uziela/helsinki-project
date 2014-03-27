# Arguments:
# 1. CDF name
# 2. Input directory (must contain .CEL files)
# 3. Path to PREBS expression file (*runname*_PREBS.RData)
# 4. MMseq file
# 5. Run name
# Output:
# *runname*_PREBS_mean_vs_array.png, *runname*_PREBS_median_vs_array.png, *runname*_mmseq_vs_array.png and *runname*_RPKM_vs_array.png files in the input directory

source("~/general_scripts/my_plot.R")

library(affy)

cargs <- commandArgs(trailingOnly = TRUE)
mycdf <- cargs[1]
input_path <- cargs[2]
prebsFile <- cargs[3]
mmseqFile <- cargs[4]
rpkmFile <- cargs[5]
run_name <- cargs[6]
cel_indexes <- cargs[7]


Data <- ReadAffy(cdfname = mycdf,celfile.path=input_path)
eset <- rma(Data)
my_expr <- exprs(eset)

if (cel_indexes != "all") {
	cel_indexes <- as.numeric(unlist(strsplit(cel_indexes,",")))
	if (length(cel_indexes) < 2) {
		print("ERROR: incorrect .CEL indexes. You must provide at least 2 indexes separated by commas")
		quit()
	}
	my_expr <- my_expr[,cel_indexes]
}

means <- rowMeans(my_expr, na.rm=TRUE)

names(means) <- substr(names(means), 1, nchar(names(means))-3)

array_expr <- data.frame(Gene_ID=names(means), array_expr=means)

load(prebsFile)

# Load PREBS

merged <- merge(gene_expr, array_expr)

merged <- merged[is.finite(merged$PREBS_mean),]

merged <- merged[is.finite(merged$PREBS_median),]



# Load mmseq
mmseq <- read.csv(mmseqFile, sep = "\t", comment.char = "#")

mmseq_clean <- data.frame(Gene_ID=mmseq$gene_id, mmseq_expr=mmseq$log_mu_gibbs)

mmseq_clean <- mmseq_clean[!is.na(mmseq_clean$mmseq_expr),]

mmseq_clean$mmseq_expr <- mmseq_clean$mmseq_expr / log(2)	# convert to log2 base (from natural base)

merged <- merge(merged, mmseq_clean) 


# Load RPKM

load(rpkmFile)

rpkm_table <- data.frame(Gene_ID=names(rpkm), RPKM=rpkm)

rpkm_table <- rpkm_table[rpkm_table$RPKM != 0,]

rpkm_table$RPKM <- log2(rpkm_table$RPKM)

merged <- merge(merged, rpkm_table) 

# Filter

merged <- merged[merged$mmseq_expr >= 0,]
#merged <- merged[merged$RPKM > 0,]

# Plot

plot_path <- paste(input_path,"/plots", sep="")

my_plot(merged$PREBS_mean, merged$array_expr, paste(plot_path,"/",run_name,"_PREBS_mean_vs_array.png", sep=""), "PREBS_mean value", "Microarray expression")

my_plot(merged$PREBS_median, merged$array_expr, paste(plot_path,"/",run_name,"_PREBS_median_vs_array.png", sep=""), "PREBS_median value", "Microarray expression")

my_plot(merged$mmseq_expr, merged$array_expr, paste(plot_path,"/",run_name,"_mmseq_vs_array.png", sep=""), "MMseq expression (log2 scale)", "Microarray expression")

my_plot(merged$RPKM, merged$array_expr, paste(plot_path,"/",run_name,"_RPKM_vs_array.png", sep=""), "RPKM (log2 scale)", "Microarray expression")

# Plot copulas

plot_path <- paste(input_path,"/plots-copula", sep="")

my_plot(rank(merged$PREBS_mean), rank(merged$array_expr), paste(plot_path,"/",run_name,"_copula_PREBS_mean_vs_array.png", sep=""), "PREBS_mean value", "Microarray expression")

my_plot(rank(merged$PREBS_median), rank(merged$array_expr), paste(plot_path,"/",run_name,"_copula_PREBS_median_vs_array.png", sep=""), "PREBS_median value", "Microarray expression")

my_plot(rank(merged$mmseq_expr), rank(merged$array_expr), paste(plot_path,"/",run_name,"_copula_mmseq_vs_array.png", sep=""), "MMseq expression (log2 scale)", "Microarray expression")

my_plot(rank(merged$RPKM), rank(merged$array_expr), paste(plot_path,"/",run_name,"_copula_RPKM_vs_array.png", sep=""), "RPKM (log2 scale)", "Microarray expression")
