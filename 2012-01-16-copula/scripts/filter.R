load("marioni_detail.RData")
marioni_detail_filt <- marioni_detail
marioni_detail_filt <- marioni_detail_filt[marioni_detail_filt$array_expr1_real > quantile(marioni_detail$array_expr1_real, 0.1),]
marioni_detail_filt <- marioni_detail_filt[marioni_detail_filt$rna_expr1_real > quantile(marioni_detail$rna_expr1_real, 0.1),]
marioni_detail <- marioni_detail_filt
save(marioni_detail, file="marioni_detail_filt.RData")
