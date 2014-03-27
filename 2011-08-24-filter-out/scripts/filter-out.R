# filters out genes which were low-expressed
# first argument - input file (without .table extension)

cargs <- commandArgs(trailingOnly = TRUE)

input_file <- cargs[1]


data <- read.csv(file=paste(input_file, ".table", sep=""), header=TRUE, sep=" ")

rna05 <- data[ data$baseMean > quantile(data$baseMean,0.05) , ]
rna10 <- data[ data$baseMean > quantile(data$baseMean,0.10) , ]
rna20 <- data[ data$baseMean > quantile(data$baseMean,0.20) , ]
rna30 <- data[ data$baseMean > quantile(data$baseMean,0.30) , ]
rna40 <- data[ data$baseMean > quantile(data$baseMean,0.40) , ]
rna50 <- data[ data$baseMean > quantile(data$baseMean,0.50) , ]


array05 <- data[ data$AveExpr > quantile(data$AveExpr,0.05) , ]
array10 <- data[ data$AveExpr > quantile(data$AveExpr,0.10) , ]
array20 <- data[ data$AveExpr > quantile(data$AveExpr,0.20) , ]
array30 <- data[ data$AveExpr > quantile(data$AveExpr,0.30) , ]
array40 <- data[ data$AveExpr > quantile(data$AveExpr,0.40) , ]
array50 <- data[ data$AveExpr > quantile(data$AveExpr,0.50) , ]

both05 <- rna05[ is.element(rna05$Gene_ID, array05$Gene_ID), ]
both10 <- rna10[ is.element(rna10$Gene_ID, array10$Gene_ID), ]
both20 <- rna20[ is.element(rna20$Gene_ID, array20$Gene_ID), ]
both30 <- rna30[ is.element(rna30$Gene_ID, array30$Gene_ID), ]
both40 <- rna40[ is.element(rna40$Gene_ID, array40$Gene_ID), ]
both50 <- rna50[ is.element(rna50$Gene_ID, array50$Gene_ID), ]

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
