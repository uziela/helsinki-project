
cargs <- commandArgs(trailingOnly = TRUE)

array_expr_file <- cargs[1]
input_path <- cargs[2]
run_name <- cargs[3]
cel_indexes <- cargs[4]
cdf_package_name <- cargs[5] # hgu133plus2hsensgcdf or hgfocushsensgcdf

probes_counts_file <- paste(input_path, "/probe_counts.RData", sep="")
merged_file <- paste(input_path, "/merged.RData", sep="")

source("~/general_scripts/my_plot.R")

load(probes_counts_file)

library(affy)

load(array_expr_file)

if (cel_indexes == "all") {
	means <- rowMeans(probe_expr, na.rm=TRUE)
	names(means) <- substr(names(means), 1, nchar(names(means))-3)
	probe_expr <- data.frame(Gene_ID=names(means), probe_expr=means)
} else {
	cel_indexes <- as.numeric(unlist(strsplit(cel_indexes,",")))
	probe_expr <- probe_expr[,cel_indexes]
	
	#print(length(cel_indexes))
	if (length(cel_indexes) == 1) {
		means <- probe_expr
	} else {
		means <- rowMeans(probe_expr, na.rm=TRUE)
	}
	names(means) <- substr(names(means), 1, nchar(names(means))-3)
	probe_expr <- data.frame(Gene_ID=names(means), probe_expr=means)
}

probe_expr <- as.data.frame(probe_expr)

tail(probe_expr)

indexes <- indices2xy(as.numeric(rownames(probe_expr)),cdf=cdf_package_name)

probe_expr$Probe.X <- indexes[,1]
probe_expr$Probe.Y <- indexes[,2]

merged <- merge(probe_expr, probe_counts)

# filter

#merged <- merged[merged$probe_expr!=0,]
#merged <- merged[merged$counts!=0,]

#merged <- merged[merged$probe_expr>20,]
#merged <- merged[merged$counts>4,]


# plot

plot_path <- paste(input_path,"/plots", sep="")

my_plot(log2(merged$counts+1), log2(merged$probe_expr+1), paste(plot_path,"/",run_name,"_probes.png", sep=""), "PREBS count (log2 scale)", "Affy probe expression (log2 scale)")

# plot means
library(plyr)

affy_gene_expr <- ddply(merged, "Probe.Set.Name", function(df)mean(df$probe_expr))
names(affy_gene_expr) <- c("Gene_ID", "Probes_mean_raw")

affy_gene_expr$Gene_ID <- as.character(affy_gene_expr$Gene_ID)
affy_gene_expr$Gene_ID <- substr(affy_gene_expr$Gene_ID, 1, nchar(affy_gene_expr$Gene_ID)-3)

affy_gene_expr$Probes_mean_raw <- log2(affy_gene_expr$Probes_mean_raw)

# to make sure we plot the same plots we load the output file from previous plot script (array_comp.R)
load(merged_file)	# take care: merged variable is now overwritten

merged_with_probes <- merge(merged, affy_gene_expr)

my_plot(merged_with_probes$PREBS_mean, merged_with_probes$Probes_mean_raw, paste(plot_path,"/",run_name,"_PREBS_mean_vs_probes_mean.png", sep=""), "PREBS_mean value", "Affy probe expression mean for genes (log2 scale)")

save(merged_with_probes, file=paste(input_path,"/","merged_with_probes.RData",sep=""))

