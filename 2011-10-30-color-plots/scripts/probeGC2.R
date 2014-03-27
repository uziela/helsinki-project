load("probes_gc.RData")

probes$gc_content <- as.numeric(probes$gc_content)

counts <- table(as.factor(probes$Gene_ID))
counts <- as.data.frame(counts)
names(counts) <- c("Gene_ID", "probe_count")
counts$Gene_ID <- as.character(counts$Gene_ID)

print(length(counts$Gene_ID))
gc_means <- numeric(0)
for (i in 1:length(counts$Gene_ID)) {
	print(i)
	id <- counts[i,]$Gene_ID
	gc_mean <- mean(probes[probes$Gene_ID==id,]$gc_content)
	gc_means <- c(gc_means, gc_mean)
}
counts$gc_mean <- gc_means

probes_gc <- counts

save(probes_gc, file="probes_gc2.RData")
