# calculates bitseq vs mmseq transcript expression correlation and makes a plot

cargs <- commandArgs(trailingOnly = TRUE)

input_file1 <- cargs[1]
input_file2 <- cargs[2]
output_file <- cargs[3]

bitseq <- read.csv(input_file1, head=FALSE, sep=" ")
mmseq <- read.csv(input_file2, head=FALSE, sep="\t")

#ens <- read.csv("ensGene.tr", head=TRUE, sep=" ")
#colnames(ens) <- c("geneid","id","length")
#ens <- ens[,-1]
#head(ens)

colnames(bitseq) <- c("id","bitseq_expr")
bitseq$bitseq_expr <- log(bitseq$bitseq_expr)
colnames(mmseq) <- c("id","log_mu_em", "log_mu_gibbs", "mcse")

#head(bitseq)
#head(mmseq)

m <- merge(bitseq,mmseq)
#m <- merge(m1,ens)
#m <- m[m$length>7000 & m$length<8000,]

#head(m)

cor1 <- cor(m$bitseq_expr, m$log_mu_gibbs)
cor1 <- round(cor1, 2)
print(cor1)

png(output_file)
plot(m$bitseq_expr, m$log_mu_gibbs, xlab=input_file1, ylab=input_file2, sub=paste("Correlation: ", cor1, sep=""))
dev.off()
