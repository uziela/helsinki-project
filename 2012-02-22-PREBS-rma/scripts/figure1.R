#! /usr/bin/Rscript

# Written by Karolis Uziela in 2013

my_cor <- function(var1, var2, my_method) {
  cor_x <- cor(var1, var2, method=my_method)
  cor_x <- round(cor_x, 2)
  return(cor_x)
}

my_plot <- function(var1, var2, my_xlab, my_ylab, my_title) {
	
	smoothScatter(var1, var2, xlab=my_xlab, ylab=my_ylab, sub=my_title, font.sub=2)
  
  r <- my_cor(var1, var2, "pearson")
	n <- length(var1)
  r = paste("r =", r)
  n = paste("n =", n) 
  legend(x="topleft", legend=c(r, n), bg="white")
}

cargs <- commandArgs(trailingOnly = TRUE)

Marioni_dir <- cargs[1]
LAML_dir <- cargs[2]
Marioni_stock_dir <- cargs[3]
output_absolute <- cargs[4]
output_diff <- cargs[5]
output_venn <- cargs[6]
output_stock <- cargs[7]

kidney_files <- c("kidney_mmseq_vs_array.txt", "kidney_RPKM_vs_array.txt", "kidney_PREBS_RMA_vs_array.txt")
TCGA2803_files <- c("TCGA-AB-2803_mmseq_vs_array.txt", "TCGA-AB-2803_RPKM_vs_array.txt", "TCGA-AB-2803_PREBS_RMA_vs_array.txt")
diff_files <- c("mmseq_vs_array_log2fc.txt", "rpkm_vs_array_log2fc.txt", "prebs_vs_array_log2fc.txt")


# Absolute expression figure
pdf(output_absolute, height=7.5, width=11.25)
old.par <- par
par(mfrow=c(2,3))

my_table <- read.table(paste(Marioni_dir, "/", kidney_files[1], sep=""))
my_plot(my_table[,1], my_table[,2], "MMSEQ", "Microarray", "(a) MMSEQ, Marioni dataset")

my_table <- read.table(paste(Marioni_dir, "/", kidney_files[2], sep=""))
my_plot(my_table[,1], my_table[,2], "Read counting", "Microarray", "(b) Read counting, Marioni dataset")

my_table <- read.table(paste(Marioni_dir, "/", kidney_files[3], sep=""))
my_plot(my_table[,1], my_table[,2], "PREBS", "Microarray", "(c) PREBS, Marioni dataset")

my_table <- read.table(paste(LAML_dir, "/", TCGA2803_files[1], sep=""))
my_plot(my_table[,1], my_table[,2], "MMSEQ", "Microarray", "(d) MMSEQ, LAML dataset")

my_table <- read.table(paste(LAML_dir, "/", TCGA2803_files[2], sep=""))
my_plot(my_table[,1], my_table[,2], "Read counting", "Microarray", "(e) Read counting, LAML dataset")

my_table <- read.table(paste(LAML_dir, "/", TCGA2803_files[3], sep=""))
my_plot(my_table[,1], my_table[,2], "PREBS", "Microarray", "(f) PREBS, LAML dataset")

par(old.par)
dev.off()

# Differential expression figure

pdf(output_diff, height=7.5, width=11.25)
old.par <- par
par(mfrow=c(2,3))

my_table <- read.table(paste(Marioni_dir, "/", diff_files[1], sep=""))
my_plot(my_table[,1], my_table[,2], "MMSEQ", "Microarray", "(a) MMSEQ, Marioni dataset")

my_table <- read.table(paste(Marioni_dir, "/", diff_files[2], sep=""))
my_plot(my_table[,1], my_table[,2], "Read counting", "Microarray", "(b) Read counting, Marioni dataset")

my_table <- read.table(paste(Marioni_dir, "/", diff_files[3], sep=""))
my_plot(my_table[,1], my_table[,2], "PREBS", "Microarray", "(c) PREBS, Marioni dataset")

my_table <- read.table(paste(LAML_dir, "/", diff_files[1], sep=""))
my_plot(my_table[,1], my_table[,2], "MMSEQ", "Microarray", "(d) MMSEQ, LAML dataset")

my_table <- read.table(paste(LAML_dir, "/", diff_files[2], sep=""))
my_plot(my_table[,1], my_table[,2], "Read counting", "Microarray", "(e) Read counting, LAML dataset")

my_table <- read.table(paste(LAML_dir, "/", diff_files[3], sep=""))
my_plot(my_table[,1], my_table[,2], "PREBS", "Microarray", "(f) PREBS, LAML dataset")

par(old.par)
dev.off()

# Stock CDF figure

pdf(output_stock, height=5, width=10)
old.par <- par
par(mfrow=c(1,2))

my_table <- read.table(paste(Marioni_stock_dir, "/", kidney_files[3], sep=""))
my_plot(my_table[,1], my_table[,2], "PREBS", "Microarray", "(a) Absolute expression")

my_table <- read.table(paste(Marioni_stock_dir, "/", diff_files[3], sep=""))
my_plot(my_table[,1], my_table[,2], "PREBS", "Microarray", "(a) Differential expression")

par(old.par)
dev.off()



# Venn diagrams

library(VennDiagram)

pdf(output_venn)
old.par <- par
par(mfrow=c(1,2))

load(paste(Marioni_dir, "/venn.RData", sep=""))
venn.plot <- draw.triple.venn(area1, area2, area3, n12, n23, n13, n123, category = c("MMSEQ", "Microarray", "PREBS"), fill = c("green", "red", "blue"), lty = "blank", cex = 2, cat.cex = 2, cat.col = c("green", "red", "blue"), euler.d=TRUE, scaled=TRUE );


load(paste(LAML_dir, "/venn.RData", sep=""))
venn.plot <- draw.triple.venn(area1, area2, area3, n12, n23, n13, n123, category = c("MMSEQ", "Microarray", "PREBS"), fill = c("green", "red", "blue"), lty = "blank", cex = 2, cat.cex = 2, cat.col = c("green", "red", "blue"), euler.d=TRUE, scaled=TRUE );

par(old.par)
dev.off()


