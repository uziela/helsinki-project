#! /cs/fs2/home/uziela/software/R-3.1.0/bin/Rscript

my_filter <- function(merged_filtered, mode, percentage_upper, percentage_lower) {
  GENES_N <- nrow(merged_filtered)
  #FILTER_N <- floor(percentage / 100 * GENES_N)
  upper <- floor(percentage_upper / 100 * GENES_N)
  lower <- floor(percentage_lower / 100 * GENES_N)

  if (mode == "PREBS_KIDNEY") {
    merged_filtered <- merged_filtered[order(merged_filtered$kidney_prebs, decreasing=TRUE),]
  }

  if (mode == "PREBS_LIVER") {
    merged_filtered <- merged_filtered[order(merged_filtered$liver_prebs, decreasing=TRUE),]
  }

  if (mode == "PREBS_INTER") {
    merged_filtered <- merged_filtered[is.finite(merged_filtered$log2fc_prebs),]
    merged1 <- merged_filtered[order(merged_filtered$kidney_prebs, decreasing=TRUE),]
    merged2 <- merged_filtered[order(merged_filtered$liver_prebs, decreasing=TRUE),]
    merged1 <- merged1[upper:lower,]
    merged2 <- merged2[upper:lower,]
    merged1 <- merged1[is.element(merged1$ID, merged2$ID),]
    merged_filtered <- merged1
  }

  if ((mode == "PREBS_KIDNEY") || (mode == "PREBS_LIVER")) {
    merged_filtered <- merged_filtered[upper:lower,]
  }
  return(merged_filtered)
}

cargs <- commandArgs(trailingOnly = TRUE)
input_prebs_file <- cargs[1]
input_array_expr_means_file <- cargs[2]
output_dir <- cargs[3]

prebs_table <- read.table(input_prebs_file, head=TRUE)
load(input_array_expr_means_file)

array_expr_means <- as.data.frame(array_expr_means)
array_expr_means$ID <- rownames(array_expr_means)

colnames(array_expr_means) <- c("kidney_array", "liver_array", "ID")
colnames(prebs_table) <- c("kidney_prebs", "liver_prebs", "ID")

#head(prebs_table)
#head(array_expr_means)

merged <- merge(prebs_table, array_expr_means)
#head(merged)

#nrow(merged)
kidney_prebs_filtered <- my_filter(merged, "PREBS_KIDNEY", 60, 0)
kidney_table <- kidney_prebs_filtered[,c("kidney_prebs", "kidney_array")]
write.table(kidney_table, file=paste(output_dir, "/kidney_PREBS_RMA_vs_array.txt", sep=""), quote=F, row.names=F, col.names=F)

liver_prebs_filtered <- my_filter(merged, "PREBS_LIVER", 60, 0)
liver_table <- liver_prebs_filtered[,c("liver_prebs", "liver_array")]
write.table(liver_table, file=paste(output_dir, "/liver_PREBS_RMA_vs_array.txt", sep=""), quote=F, row.names=F, col.names=F)

merged$log2fc_prebs <- merged$liver_prebs - merged$kidney_prebs
merged$log2fc_array <- merged$liver_array - merged$kidney_array
log2fc_filtered <- my_filter(merged, "PREBS_INTER", 60, 0)
log2fc_table <- log2fc_filtered[,c("log2fc_prebs", "log2fc_array")]
write.table(log2fc_table, file=paste(output_dir, "/prebs_vs_array_log2fc.txt", sep=""), quote=F, row.names=F, col.names=F)
#head(kidney_table)

#nrow(kidney_prebs_filtered)
