# filters out genes which were low-expressed
# first argument - input file (without .table extension)
# second argument - input file with variances (including .stat extension)

cargs <- commandArgs(trailingOnly = TRUE)

input_file <- cargs[1]
var_file <- cargs[2]

data <- read.csv(file=paste(input_file, ".table", sep=""), header=TRUE, sep=" ")
var_data <- read.csv(file=var_file, header=TRUE, sep=" ")

rna_id05 <- var_data[ var_data$rna_log_var < quantile(var_data$rna_log_var,0.95) , ]
rna_id10 <- var_data[ var_data$rna_log_var < quantile(var_data$rna_log_var,0.90) , ]
rna_id20 <- var_data[ var_data$rna_log_var < quantile(var_data$rna_log_var,0.80) , ]
rna_id30 <- var_data[ var_data$rna_log_var < quantile(var_data$rna_log_var,0.70) , ]
rna_id40 <- var_data[ var_data$rna_log_var < quantile(var_data$rna_log_var,0.60) , ]
rna_id50 <- var_data[ var_data$rna_log_var < quantile(var_data$rna_log_var,0.50) , ]

array_id05 <- var_data[ var_data$array_log_var < quantile(var_data$array_log_var,0.95) , ]
array_id10 <- var_data[ var_data$array_log_var < quantile(var_data$array_log_var,0.90) , ]
array_id20 <- var_data[ var_data$array_log_var < quantile(var_data$array_log_var,0.80) , ]
array_id30 <- var_data[ var_data$array_log_var < quantile(var_data$array_log_var,0.70) , ]
array_id40 <- var_data[ var_data$array_log_var < quantile(var_data$array_log_var,0.60) , ]
array_id50 <- var_data[ var_data$array_log_var < quantile(var_data$array_log_var,0.50) , ]

rna05 <- data[ is.element(data$Gene_ID, rna_id05$Gene_ID), ]
rna10 <- data[ is.element(data$Gene_ID, rna_id10$Gene_ID), ]
rna20 <- data[ is.element(data$Gene_ID, rna_id20$Gene_ID), ]
rna30 <- data[ is.element(data$Gene_ID, rna_id30$Gene_ID), ]
rna40 <- data[ is.element(data$Gene_ID, rna_id40$Gene_ID), ]
rna50 <- data[ is.element(data$Gene_ID, rna_id50$Gene_ID), ]

array05 <- data[ is.element(data$Gene_ID, array_id05$Gene_ID), ]
array10 <- data[ is.element(data$Gene_ID, array_id10$Gene_ID), ]
array20 <- data[ is.element(data$Gene_ID, array_id20$Gene_ID), ]
array30 <- data[ is.element(data$Gene_ID, array_id30$Gene_ID), ]
array40 <- data[ is.element(data$Gene_ID, array_id40$Gene_ID), ]
array50 <- data[ is.element(data$Gene_ID, array_id50$Gene_ID), ]

both05 <- rna05[ is.element(rna05$Gene_ID, array05$Gene_ID), ]
both10 <- rna10[ is.element(rna10$Gene_ID, array10$Gene_ID), ]
both20 <- rna20[ is.element(rna20$Gene_ID, array20$Gene_ID), ]
both30 <- rna20[ is.element(rna30$Gene_ID, array30$Gene_ID), ]
both40 <- rna20[ is.element(rna40$Gene_ID, array40$Gene_ID), ]
both50 <- rna20[ is.element(rna50$Gene_ID, array50$Gene_ID), ]

write.table(rna05, file=paste(input_file, ".rna05.table", sep=""), quote = FALSE, sep = " ")
write.table(rna10, file=paste(input_file, ".rna10.table", sep=""), quote = FALSE, sep = " ")
write.table(rna20, file=paste(input_file, ".rna20.table", sep=""), quote = FALSE, sep = " ")
write.table(rna30, file=paste(input_file, ".rna30.table", sep=""), quote = FALSE, sep = " ")
write.table(rna40, file=paste(input_file, ".rna40.table", sep=""), quote = FALSE, sep = " ")
write.table(rna50, file=paste(input_file, ".rna50.table", sep=""), quote = FALSE, sep = " ")

write.table(array05, file=paste(input_file, ".array05.table", sep=""), quote = FALSE, sep = " ")
write.table(array10, file=paste(input_file, ".array10.table", sep=""), quote = FALSE, sep = " ")
write.table(array20, file=paste(input_file, ".array20.table", sep=""), quote = FALSE, sep = " ")
write.table(array30, file=paste(input_file, ".array30.table", sep=""), quote = FALSE, sep = " ")
write.table(array40, file=paste(input_file, ".array40.table", sep=""), quote = FALSE, sep = " ")
write.table(array50, file=paste(input_file, ".array50.table", sep=""), quote = FALSE, sep = " ")

write.table(both05, file=paste(input_file, ".both05.table", sep=""), quote = FALSE, sep = " ")
write.table(both10, file=paste(input_file, ".both10.table", sep=""), quote = FALSE, sep = " ")
write.table(both20, file=paste(input_file, ".both20.table", sep=""), quote = FALSE, sep = " ")
write.table(both30, file=paste(input_file, ".both30.table", sep=""), quote = FALSE, sep = " ")
write.table(both40, file=paste(input_file, ".both40.table", sep=""), quote = FALSE, sep = " ")
write.table(both50, file=paste(input_file, ".both50.table", sep=""), quote = FALSE, sep = " ")
