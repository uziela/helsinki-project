# Removes extremely significant instances (removes 10% quantile sorted by adj. P-val)
cargs <- commandArgs(trailingOnly = TRUE)

input_file=cargs[1]
output_file=cargs[2]
output_table=cargs[3]

load(input_file)

merged_no_extreme <- merged_fixed

array_quant = quantile(merged_no_extreme$adj.P.Val, 0.1)
rna_quant = quantile(merged_no_extreme$padj, 0.1)

#merged_no_extreme <- merged_no_extreme[merged_no_extreme$adj.P.Val < array_quant,]
merged_no_extreme <- merged_no_extreme[merged_no_extreme$adj.P.Val > array_quant,]

#merged_no_extreme <- merged_no_extreme[merged_no_extreme$padj < rna_quant,]
merged_no_extreme <- merged_no_extreme[merged_no_extreme$padj > rna_quant,]

array_no_extreme <- array_fixed[is.element(array_fixed$Gene_ID, merged_no_extreme$Gene_ID),]
rna_no_extreme <- rna_fixed[is.element(rna_fixed$Gene_ID, merged_no_extreme$Gene_ID),]

write.table(merged_no_extreme, quote = FALSE, sep = " ", file=output_table)
save(merged_no_extreme, array_no_extreme, rna_no_extreme, file=output_file)
