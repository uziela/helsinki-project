load("marioni_detail.RData")
load("count_table.RData")
colnames(count_table) <- paste("name",colnames(count_table), sep="")
count_table <- as.data.frame(count_table)
count_table$rna_expr1_real <- count_table$name1 + count_table$name2
count_table$rna_expr2_real <- count_table$name3 + count_table$name4
count_table <- count_table[,-c(1,2,3,4)]


millionsMapped <- sum(count_table)/1e+06

library(DESeq)
conds <- c("a", "b")
cds <- newCountDataSet( count_table, conds )
cds <- estimateSizeFactors(cds)
factors <- sizeFactors(cds)

#head(factors)

for(i in 1:2) {
	count_table[i] <- count_table[i]/factors[i]
}

count_table$Gene_ID <- rownames(count_table)

marioni_detail <- merge(marioni_detail, count_table)

#marioni_detail$rna_expr1_real <- log2(marioni_detail$rna_expr1_real / marioni_detail$GeneLengthKB / millionsMapped)
#marioni_detail$rna_expr2_real <- log2(marioni_detail$rna_expr2_real / marioni_detail$GeneLengthKB / millionsMapped)

marioni_detail$rna_expr1_real <- log2(marioni_detail$rna_expr1_real / marioni_detail$GeneLengthKB )
marioni_detail$rna_expr2_real <- log2(marioni_detail$rna_expr2_real / marioni_detail$GeneLengthKB )

mean_diff1 <- mean(marioni_detail$rna_expr1_real) - mean(marioni_detail$array_expr1)
mean_diff2 <- mean(marioni_detail$rna_expr2_real) - mean(marioni_detail$array_expr2)

marioni_detail$array_expr1_real <- marioni_detail$array_expr1 + mean_diff1 
marioni_detail$array_expr2_real <- marioni_detail$array_expr2 + mean_diff2

marioni_detail$expr_diff1_real <- marioni_detail$rna_expr1_real - marioni_detail$array_expr1_real
marioni_detail$expr_diff2_real <- marioni_detail$rna_expr2_real - marioni_detail$array_expr2_real

marioni_detail$expr_diff1_real_abs <- abs(marioni_detail$expr_diff1_real)
marioni_detail$expr_diff2_real_abs <- abs(marioni_detail$expr_diff2_real)

save(marioni_detail, file="marioni_detail.RData")
