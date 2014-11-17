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

MY_WIDTH=7
MY_WIDTH2=5
MY_HEIGHT=4.7
MY_HEIGHT2=2.5
MY_CEX=0.68


kidney_files <- c("kidney_mmseq_vs_array.txt", "kidney_RPKM_vs_array.txt", "kidney_PREBS_RMA_vs_array.txt")
TCGA2803_files <- c("TCGA-AB-2803_mmseq_vs_array.txt", "TCGA-AB-2803_RPKM_vs_array.txt", "TCGA-AB-2803_PREBS_RMA_vs_array.txt")
diff_files <- c("mmseq_vs_array_log2fc.txt", "rpkm_vs_array_log2fc.txt", "prebs_vs_array_log2fc.txt")


# Absolute expression figure
setEPS()
postscript(output_absolute, height=MY_HEIGHT, width=MY_WIDTH)
old.par <- par
par(mfrow=c(2,3), mar=c(5, 4, 1, 1) + 0.1)

my_table <- read.table(paste(Marioni_dir, "/", kidney_files[1], sep=""))
my_plot(my_table[,1], my_table[,2], "MMSEQ", "Microarray", "(a) MMSEQ, Marioni data set")

my_table <- read.table(paste(Marioni_dir, "/", kidney_files[2], sep=""))
my_plot(my_table[,1], my_table[,2], "Read counting", "Microarray", "(b) Read counting, Marioni data set")

my_table <- read.table(paste(Marioni_dir, "/", kidney_files[3], sep=""))
my_plot(my_table[,1], my_table[,2], "PREBS", "Microarray", "(c) PREBS, Marioni data set")

my_table <- read.table(paste(LAML_dir, "/", TCGA2803_files[1], sep=""))
my_plot(my_table[,1], my_table[,2], "MMSEQ", "Microarray", "(d) MMSEQ, LAML data set")

my_table <- read.table(paste(LAML_dir, "/", TCGA2803_files[2], sep=""))
my_plot(my_table[,1], my_table[,2], "Read counting", "Microarray", "(e) Read counting, LAML data set")

my_table <- read.table(paste(LAML_dir, "/", TCGA2803_files[3], sep=""))
my_plot(my_table[,1], my_table[,2], "PREBS", "Microarray", "(f) PREBS, LAML data set")

par(old.par)
dev.off()

# Differential expression figure

postscript(output_diff, height=MY_HEIGHT, width=MY_WIDTH)
old.par <- par
par(mfrow=c(2,3), mar=c(5, 4, 1, 1) + 0.1)

my_table <- read.table(paste(Marioni_dir, "/", diff_files[1], sep=""))
my_plot(my_table[,1], my_table[,2], "MMSEQ", "Microarray", "(a) MMSEQ, Marioni data set")

my_table <- read.table(paste(Marioni_dir, "/", diff_files[2], sep=""))
my_plot(my_table[,1], my_table[,2], "Read counting", "Microarray", "(b) Read counting, Marioni data set")

my_table <- read.table(paste(Marioni_dir, "/", diff_files[3], sep=""))
my_plot(my_table[,1], my_table[,2], "PREBS", "Microarray", "(c) PREBS, Marioni data set")

my_table <- read.table(paste(LAML_dir, "/", diff_files[1], sep=""))
my_plot(my_table[,1], my_table[,2], "MMSEQ", "Microarray", "(d) MMSEQ, LAML data set")

my_table <- read.table(paste(LAML_dir, "/", diff_files[2], sep=""))
my_plot(my_table[,1], my_table[,2], "Read counting", "Microarray", "(e) Read counting, LAML data set")

my_table <- read.table(paste(LAML_dir, "/", diff_files[3], sep=""))
my_plot(my_table[,1], my_table[,2], "PREBS", "Microarray", "(f) PREBS, LAML data set")

par(old.par)
dev.off()

# Stock CDF figure

postscript(output_stock, height=MY_HEIGHT2, width=MY_WIDTH2)
old.par <- par
par(mfrow=c(1,2), mar=c(5, 4, 1, 1) + 0.1, cex=MY_CEX)

my_table <- read.table(paste(Marioni_stock_dir, "/", kidney_files[3], sep=""))
my_plot(my_table[,1], my_table[,2], "PREBS", "Microarray", "(a) Absolute expression")

my_table <- read.table(paste(Marioni_stock_dir, "/", diff_files[3], sep=""))
my_plot(my_table[,1], my_table[,2], "PREBS", "Microarray", "(b) Differential expression")

par(old.par)
dev.off()



# Venn diagrams

library(VennDiagram)

postscript(output_venn, width=5.5, height=2.75, fonts=c('serif'))

pushViewport(viewport(layout = grid.layout(1, 2)))

pushViewport(viewport(layout.pos.col = 1, layout.pos.row = 1))
load(paste(Marioni_dir, "/venn.RData", sep=""))
venn.plot1 <- draw.triple.venn(area1, area2, area3, n12, n23, n13, n123, category = c("MMSEQ", "Microarray", "PREBS"), cex = 0.6, cat.cex = 0.6, euler.d=TRUE, scaled=TRUE, margin=0.05)
grid.draw(venn.plot1)
grid.text("(a) Marioni data set", y=0.02, just=c("centre", "bottom"),
          gp=gpar(fontsize=8, fontface='bold'))
popViewport()

pushViewport(viewport(layout.pos.col = 2, layout.pos.row = 1))
load(paste(LAML_dir, "/venn.RData", sep=""))
venn.plot2 <- draw.triple.venn(area1, area2, area3, n12, n23, n13, n123, category = c("MMSEQ", "Microarray", "PREBS"),  cex = 0.6, cat.cex = 0.6, euler.d=TRUE, scaled=TRUE, margin=0.05, title="LAML data" )
grid.draw(venn.plot2)
grid.text("(b) LAML data set", y=0.02, just=c("centre", "bottom"),
          gp=gpar(fontsize=8, fontface='bold'))
popViewport()
popViewport()

dev.off()


