load("marioni_detail.RData")
load("marioni_ranks.RData")

my_cor <- function(var1, var2) {
	cor_x <- cor(var1, var2)
	cor_x <- round(cor_x, 2)
	print(cor_x)
	return(cor_x)
}

my_plot <- function(var1, var2, my_file, my_xlab, my_ylab) {
	cor1 <- my_cor(var1, var2)
	png(my_file)
	plot(var1, var2, xlab=my_xlab, ylab=my_ylab, sub=paste("Correlation: ",cor1, sep=""))
	dev.off()
}



###### candidate features ######
if (FALSE) {
my_plot(marioni_detail$gc, marioni_detail$expr_diff1, "output/gc_vs_expr_diff1.png", "%GC in sequence", "Absolute expression difference" )
my_plot(marioni_ranks$gc, marioni_ranks$expr_diff1, "output/gc_vs_expr_diff1_copula.png", "%GC in sequence", "Absolute expression difference" )

my_plot(marioni_detail$gc_probes, marioni_detail$expr_diff1, "output/gc_probes_vs_expr_diff1.png", "%GC in probes", "Absolute expression difference" )
my_plot(marioni_ranks$gc_probes, marioni_ranks$expr_diff1, "output/gc_probes_vs_expr_diff1_copula.png", "%GC in probes", "Absolute expression difference" )

my_plot(marioni_detail$GeneLengthKB, marioni_detail$expr_diff1, "output/gene_length_vs_expr_diff1.png", "Gene length in KB", "Absolute expression difference" )
my_plot(marioni_ranks$GeneLengthKB, marioni_ranks$expr_diff1, "output/gene_length_vs_expr_diff1_copula.png", "Gene length in KB", "Absolute expression difference" )

my_plot(marioni_detail$probe_count, marioni_detail$expr_diff1, "output/probe_count_vs_expr_diff1.png", "Probe count for a gene", "Absolute expression difference" )
my_plot(marioni_ranks$probe_count, marioni_ranks$expr_diff1, "output/probe_count_vs_expr_diff1_copula.png", "Probe count for a gene", "Absolute expression difference" )

my_plot(marioni_detail$transcript_count, marioni_detail$expr_diff1, "output/transcript_count_vs_expr_diff1.png", "Transcript count", "Absolute expression difference" )
my_plot(marioni_ranks$transcript_count, marioni_ranks$expr_diff1, "output/transcript_count_vs_expr_diff1_copula.png", "Transcript count", "Absolute expression difference" )
}
##### other ######
if (FALSE) {
my_plot(marioni_detail$puma_expr1, marioni_detail$rna_expr1, "output/puma_expr1_vs_rna_expr1.png", "Microarray expression", "RNA-seq expression" )
my_plot(marioni_ranks$puma_expr1, marioni_ranks$rna_expr1, "output/puma_expr1_vs_rna_expr1_copula.png", "Microarray expression", "RNA-seq expression" )

my_plot(marioni_detail$puma_expr2, marioni_detail$rna_expr2, "output/puma_expr2_vs_rna_expr2.png", "Microarray expression", "RNA-seq expression" )
my_plot(marioni_ranks$puma_expr2, marioni_ranks$rna_expr2, "output/puma_expr2_vs_rna_expr2_copula.png", "Microarray expression", "RNA-seq expression" )

my_plot(marioni_detail$puma_logFC, marioni_detail$rna_log2FC, "output/puma_logFC_vs_rna_log2fc.png", "Microarray Log2FC", "RNA-seq Log2FC" )
my_plot(marioni_ranks$puma_logFC, marioni_ranks$rna_log2FC, "output/puma_logFC_vs_rna_log2fc_copula.png", "Microarray Log2FC", "RNA-seq Log2FC" )
}

my_plot(marioni_detail$array_expr1, marioni_detail$rna_expr1, "output/array_expr1_vs_rna_expr1.png", "Microarray expression", "RNA-seq expression" )
my_plot(marioni_ranks$array_expr1, marioni_ranks$rna_expr1, "output/array_expr1_vs_rna_expr1_copula.png", "Microarray expression", "RNA-seq expression" )

my_plot(marioni_detail$array_expr2, marioni_detail$rna_expr2, "output/array_expr2_vs_rna_expr2.png", "Microarray expression", "RNA-seq expression" )
my_plot(marioni_ranks$array_expr2, marioni_ranks$rna_expr2, "output/array_expr2_vs_rna_expr2_copula.png", "Microarray expression", "RNA-seq expression" )

my_plot(marioni_detail$array_log2FC, marioni_detail$rna_log2FC, "output/array_log2FC_vs_rna_log2fc.png", "Microarray Log2FC", "RNA-seq Log2FC" )
my_plot(marioni_ranks$array_log2FC, marioni_ranks$rna_log2FC, "output/array_log2FC_vs_rna_log2fc_copula.png", "Microarray Log2FC", "RNA-seq Log2FC" )





