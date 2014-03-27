load("marioni_detail.RData")
load("marioni_ranks.RData")

#my_cor <- function(var1, var2) {
#	cor_x <- cor(var1, var2)
#	cor_x <- round(cor_x, 2)
#	print(cor_x)
#	return(cor_x)
#}

#my_plot <- function(var1, var2, my_file, my_xlab, my_ylab) {
#	cor1 <- my_cor(var1, var2)
#	png(my_file)
#	plot(var1, var2, xlab=my_xlab, ylab=my_ylab, sub=paste("Correlation: ",cor1, sep=""))
#	dev.off()
#}

source("../general_scripts/my_plot.R")


###### candidate features ######

my_plot(marioni_detail$gc, marioni_detail$expr_diff1_real_abs, "output/gc_vs_expr_diff1.png", "%GC in sequence", "Expression difference" )
my_plot(marioni_ranks$gc, marioni_ranks$expr_diff1_real_abs, "output/gc_vs_expr_diff1_copula.png", "%GC in sequence", "Expression difference" )

my_plot(marioni_detail$gc_probes, marioni_detail$expr_diff1_real_abs, "output/gc_probes_vs_expr_diff1.png", "%GC in probes", "Expression difference" )
my_plot(marioni_ranks$gc_probes, marioni_ranks$expr_diff1_real_abs, "output/gc_probes_vs_expr_diff1_copula.png", "%GC in probes", "Expression difference" )

my_plot(marioni_detail$GeneLengthKB, marioni_detail$expr_diff1_real_abs, "output/gene_length_vs_expr_diff1.png", "Gene length in KB", "Expression difference" )
my_plot(marioni_ranks$GeneLengthKB, marioni_ranks$expr_diff1_real_abs, "output/gene_length_vs_expr_diff1_copula.png", "Gene length in KB", "Expression difference" )

my_plot(marioni_detail$probe_count, marioni_detail$expr_diff1_real_abs, "output/probe_count_vs_expr_diff1.png", "Probe count for a gene", "Expression difference" )
my_plot(marioni_ranks$probe_count, marioni_ranks$expr_diff1_real_abs, "output/probe_count_vs_expr_diff1_copula.png", "Probe count for a gene", "Expression difference" )

my_plot(marioni_detail$transcript_count, marioni_detail$expr_diff1_real_abs, "output/transcript_count_vs_expr_diff1.png", "Transcript count for a gene", "Expression difference" )
my_plot(marioni_ranks$transcript_count, marioni_ranks$expr_diff1_real_abs, "output/transcript_count_vs_expr_diff1_copula.png", "Transcript count", "Expression difference" )

##### other ######
if (FALSE) {
my_plot(marioni_detail$array_expr1_real, marioni_detail$rna_expr1_real, "output/array_expr1_vs_rna_expr1.png", "Microarray expression", "RNA-seq expression" )
my_plot(marioni_ranks$array_expr1_real, marioni_ranks$rna_expr1_real, "output/array_expr1_vs_rna_expr1_copula.png", "Microarray expression", "RNA-seq expression" )

my_plot(marioni_detail$rna_expr1_real, marioni_detail$expr_diff1_real_abs, "output/rna_expr1_vs_expr_diff1.png", "RNA-seq expression", "Expression difference" )
my_plot(marioni_ranks$rna_expr1_real, marioni_ranks$expr_diff1_real_abs, "output/rna_expr1_vs_expr_diff1_copula.png", "RNA-seq expression", "Expression difference" )

my_plot(marioni_detail$array_expr1_real, marioni_detail$expr_diff1_real_abs, "output/array_expr1_vs_expr_diff1.png", "Microarray expression", "Expression difference" )
my_plot(marioni_ranks$array_expr1_real, marioni_ranks$expr_diff1_real_abs, "output/array_expr1_vs_expr_diff1_copula.png", "Microarray expression", "Expression difference" )
}



