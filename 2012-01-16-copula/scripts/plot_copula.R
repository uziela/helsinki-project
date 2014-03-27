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

#if (FALSE) {
if (FALSE) {
###### candidate features ######
my_plot(marioni_detail$gc, marioni_detail$log2FC_diff, "output/gc_vs_log2fc_diff.png", "%GC in sequence", "log2FC difference" )
my_plot(marioni_ranks$gc, marioni_ranks$log2FC_diff, "output/gc_vs_log2fc_diff_copula.png", "%GC in sequence", "log2FC difference" )

my_plot(marioni_detail$gc_probes, marioni_detail$log2FC_diff, "output/gc_probes_vs_log2fc_diff.png", "%GC in probes", "log2FC difference" )
my_plot(marioni_ranks$gc_probes, marioni_ranks$log2FC_diff, "output/gc_probes_vs_log2fc_diff_copula.png", "%GC in probes", "log2FC difference" )

my_plot(marioni_detail$GeneLengthKB, marioni_detail$log2FC_diff, "output/gene_length_vs_log2fc_diff.png", "Gene length in KB", "log2FC difference" )
my_plot(marioni_ranks$GeneLengthKB, marioni_ranks$log2FC_diff, "output/gene_length_vs_log2fc_diff_copula.png", "Gene length in KB", "log2FC difference" )

my_plot(marioni_detail$probe_count, marioni_detail$log2FC_diff, "output/probe_count_vs_log2fc_diff.png", "Probe count for a gene", "log2FC difference" )
my_plot(marioni_ranks$probe_count, marioni_ranks$log2FC_diff, "output/probe_count_vs_log2fc_diff_copula.png", "Probe count for a gene", "log2FC difference" )

my_plot(marioni_detail$transcript_count, marioni_detail$log2FC_diff, "output/transcript_count_vs_log2fc_diff.png", "Transcript count", "log2FC difference" )
my_plot(marioni_ranks$transcript_count, marioni_ranks$log2FC_diff, "output/transcript_count_vs_log2fc_diff_copula.png", "Transcript count", "log2FC difference" )
}
##### other ######

my_plot(marioni_detail$array_log2FC, marioni_detail$rna_log2FC, "output/array_log2fc_vs_rna_log2fc.png", "Microarray Log2FC", "RNA-seq Log2FC" )
my_plot(marioni_ranks$array_log2FC, marioni_ranks$rna_log2FC, "output/array_log2fc_vs_rna_log2fc_copula.png", "Microarray Log2FC", "RNA-seq Log2FC" )

my_plot(marioni_detail$rna_log2FC_abs, marioni_detail$log2FC_diff, "output/rna_log2fc_vs_log2fc_diff.png", "Absolute RNA-seq Log2FC", "log2FC difference" )
my_plot(marioni_ranks$rna_log2FC_abs, marioni_ranks$log2FC_diff, "output/rna_log2fc_vs_log2fc_diff_copula.png", "Absolute RNA-seq Log2FC", "log2FC difference" )

my_plot(marioni_detail$array_log2FC_abs, marioni_detail$log2FC_diff, "output/array_log2fc_vs_log2fc_diff.png", "Absolute microarray Log2FC", "log2FC difference" )
my_plot(marioni_ranks$array_log2FC_abs, marioni_ranks$log2FC_diff, "output/array_log2fc_vs_log2fc_diff_copula.png", "Absolute microarray Log2FC", "log2FC difference" )

my_plot(marioni_detail$array_exp, marioni_detail$rna_exp, "output/array_exp_vs_rna_exp.png", "Microarray avg. expression", "RNA-seq avg. expression" )
my_plot(marioni_ranks$array_exp, marioni_ranks$rna_exp, "output/array_exp_vs_rna_exp_copula.png", "Microarray avg. expression", "RNA-seq avg. expression" )


my_plot(marioni_detail$rna_exp, marioni_detail$log2FC_diff, "output/rna_exp_vs_log2fc_diff.png", "RNA-seq avg. expression", "log2FC difference" )
my_plot(marioni_ranks$rna_exp, marioni_ranks$log2FC_diff, "output/rna_exp_vs_log2fc_diff_copula.png", "RNA-seq avg. expression", "log2FC difference" )

my_plot(marioni_detail$array_exp, marioni_detail$log2FC_diff, "output/array_exp_vs_log2fc_diff.png", "Microarray avg. expression", "log2FC difference" )
my_plot(marioni_ranks$array_exp, marioni_ranks$log2FC_diff, "output/array_exp_vs_log2fc_diff_copula.png", "Microarray avg. expression", "log2FC difference" )



