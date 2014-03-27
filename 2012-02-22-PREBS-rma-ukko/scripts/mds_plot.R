#! /usr/bin/Rscript

plot_symb <- function(col_name, my_col) {
	col_len <- nchar(col_name)
	coord <- mat_scale[substr(rownames(mat_scale),1,col_len)==col_name,]
	points(coord[,1], coord[,2], pch=LETTERS[1:nrow(coord)], cex=0.6, col=my_col)
}

cargs <- commandArgs(trailingOnly = TRUE)

out_file <- cargs[1]
merged_files <- cargs[2:length(cargs)]

COR_METHOD <- "pearson"

FILTER_N <- 1000

N <- length(merged_files)

mat <- matrix(0,4*N,4*N)

colnames(mat) <- 1:(4*N)
rownames(mat) <- 1:(4*N)

METHODS <- c("array_expr", "mmseq_expr", "RPKM", "PREBS_RMA")

for (i in 1:N) {
	for (j in 1:4) {
		ch <- LETTERS[i]
		method <- METHODS[j]
		colnames(mat)[(i-1)*4+j] <- paste(method,ch,sep="+")
		rownames(mat)[(i-1)*4+j] <- paste(method,ch,sep="+")
	}
}

#print(mat)

for (i in 1:N) {
	ch1 <- LETTERS[i]
	load(merged_files[i])
	merged1 <- merged_with_rma[,c("Gene_ID","array_expr","mmseq_expr","RPKM","PREBS_RMA")]
	colnames(merged1)[2:5] <- paste(colnames(merged1)[2:5], ch1, sep="+")
	for (j in 1:N) {
		ch2 <- LETTERS[j]
		if (i != j) {
			load(merged_files[j])
			merged2 <- merged_with_rma[,c("Gene_ID","array_expr","mmseq_expr","RPKM","PREBS_RMA")]
			colnames(merged2)[2:5] <- paste(colnames(merged2)[2:5], ch2, sep="+")

			merged <- merge(merged1,merged2)
			#print(head(merged))
		} else {
			merged <- merged1
		}
		for (i2 in 1:4) {
			for (j2 in 1:4) {
				method1 <- paste(METHODS[i2], ch1, sep="+")
				method2 <- paste(METHODS[j2], ch2, sep="+")
				merged_filt <- merged
				#print("===========")
				#print(method1)
				#print(method2)
				#print(ch1)
				#print(ch2)
				#print(head(merged_filt[,method2]))
				#print("--------")
				merged_filt <- merged_filt[is.finite(merged_filt[,method1]),]
				merged_filt <- merged_filt[is.finite(merged_filt[,method2]),]
				merged_filt <- merged_filt[order(merged_filt[,method1]+merged_filt[,method2], decreasing=TRUE),]
				merged_filt <- merged_filt[1:FILTER_N,]
				#sim <- paste(as.character(i2), as.character(j2), sep="+")
				#mat[method1, method2] <- sim
				my_cor <- cor(merged_filt[,method1], merged_filt[,method2], method=COR_METHOD)
				if (is.na(my_cor)) {
					print(head(merged_filt))
				}
				if (my_cor < 0) {
					my_cor <- 0
				}
				mat[method1, method2] <- 1-my_cor
			}
		}
	}
}

#print(mat)
mat_dist <- as.dist(mat)
#print(mat_dist)
mat_scale <- cmdscale(mat_dist)
#print(mat_scale)

#unlist(strsplit(rownames(mat_scale), "\\+"))

pdf(out_file)
plot(mat_scale[,1], mat_scale[,2], type = "n", xlab = "", ylab = "", asp = 1, axes = FALSE, main = "cmdscale(1-correlation)")

plot_symb("array_expr", "red")
plot_symb("mmseq_expr", "blue")
plot_symb("RPKM", "orange")
plot_symb("PREBS_RMA", "green")

legend("bottomright",c("Microarray", "MMSEQ","RPKM", "PREBS"),pch=c("A","A","A","A"),col=c("red", "blue", "orange", "green"))
dev.off()

#x <- mat_scale[,1]
#y <- mat_scale[,2]

#plot(x, y, type = "n", xlab = "", ylab = "", asp = 1, axes = FALSE, main = "cmdscale(1-correlation)")
#text(x, y, rownames(mat_scale), cex = 0.6)

