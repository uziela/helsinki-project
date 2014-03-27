source("~/general_scripts/my_plot.R")

load("input/kidney/probe_counts.RData")

library(affy)

Data <- ReadAffy(cdfname = "HGU133Plus2_Hs_ENSG",celfile.path="input/kidney")

affy_probes <- exprs(Data)[,c(1,2,3)]

affy_probes <- as.data.frame(affy_probes)

affy_probes$expr <- rowMeans(affy_probes, na.rm=TRUE)

indexes <- indices2xy(as.numeric(rownames(affy_probes)),cdf="hgu133plus2hsensgcdf")

affy_probes$Probe.X <- indexes[,1]
affy_probes$Probe.Y <- indexes[,2]

merged <- merge(affy_probes, probe_counts)

my_plot(log2(merged$expr+1), log2(merged$counts+1), "kidney_probes_log.png", "Affy probe expression (log2 scale)", "PREBS count (log2 scale)")

merged <- merged[merged$expr!=0,]
merged <- merged[merged$counts!=0,]

my_plot(log2(merged$expr), log2(merged$counts), "kidney_probes_log_zero_removed.png", "Affy probe expression (log2 scale)", "PREBS count (log2 scale)")
