#!/bin/sh

# 2011 (C) Karolis Uziela, karolis.uziela@cs.helsinki.fi
# Antti Honkela group
# University of Helsinki
# Helsinki, Finland

if [ $# != 2 ] ; then
	echo "
Usage: 

./more-plots.sh <input-file> 

<input-file> - Input file has to be merged table with rna-seq and microarray data (output from R)
<out-dir> - output directory


Example runs:
./more-plots.sh ./input/merged_fixed.table ./more-plots
"
	exit 1
fi

input_file=$1;
out_dir=$2;



# print parameters
echo "more-plots.sh has started with parameters: $*"

# Create output dir
if [ ! -d $out_dir ] ; then
	mkdir $out_dir
fi

# Remove first line from the input file
if [ ! -f $out_dir/input.table ] ; then
	tail -n +2 $input_file > $out_dir/input.table
fi

: << 'EOC'
# Make a plot "Microarray adj.P.Val vs RNA-seq padj" and calculate correlation
if [ ! -f $out_dir/p-values.ps ] ; then
	cut -d ' ' -f 7 $out_dir/input.table > $out_dir/p-values-array.stat
	cut -d ' ' -f 15 $out_dir/input.table > $out_dir/p-values-rna.stat
	
	perl -ni -e 'print ($_ > 1e-10 ? log($_)/log(10)."\n" : "-10\n"); ' $out_dir/p-values-array.stat $out_dir/p-values-rna.stat
	#perl -ni -e 'chomp $_; if ($_ > 1e-10) { print log($_)/log(10)."\n" } else { print "-10\n" } ' $out_dir/p-values-array.stat $out_dir/p-values-rna.stat
	
	paste $out_dir/p-values-array.stat $out_dir/p-values-rna.stat > $out_dir/p-values.stat
	./scripts/plot-corr.sh $out_dir/p-values.stat $out_dir/p-values.ps "Microarray adj. P-value" "RNA-seq adj. P-value"
	
	./scripts/corrcoef $out_dir/p-values.stat 1 2 > $out_dir/p-values.corr
fi
EOC

# Make a plot "Microarray logFC vs RNA-seq log2FoldChange" and calculate correlation
if [ ! -f $out_dir/logfc.ps ] ; then
	cut -d ' ' -f 3 $out_dir/input.table > $out_dir/logfc-array.stat
	cut -d ' ' -f 13 $out_dir/input.table > $out_dir/logfc-rna.stat
	
	paste $out_dir/logfc-array.stat $out_dir/logfc-rna.stat > $out_dir/logfc.stat
	./scripts/plot-corr2.sh $out_dir/logfc.stat $out_dir/logfc.ps "Microarray Log2FoldChange" "RNA-seq Log2FoldChange"
	
	./scripts/corrcoef $out_dir/logfc.stat 1 2 > $out_dir/logfc.corr
fi

: << 'EOC'
# Make a plot "RNA-seq padj vs Gene length" and calculate correlation
if [ ! -f $out_dir/length-rnap.ps ] ; then
	cut -d ' ' -f 18 $out_dir/input.table > $out_dir/length.stat
	
	paste $out_dir/length.stat $out_dir/p-values-rna.stat > $out_dir/length-rnap.stat
	./scripts/plot-corr3.sh $out_dir/length-rnap.stat $out_dir/length-rnap.ps "Gene length" "RNA-seq adj. P-value"
	
	./scripts/corrcoef $out_dir/length-rnap.stat 1 2 > $out_dir/length-rnap.corr
fi

# Make a plot "RNA-seq baseMean vs RNA-seq padj" and calculate correlation
if [ ! -f $out_dir/rnaexp-rnap.ps ] ; then
	cut -d ' ' -f 9 $out_dir/input.table > $out_dir/rnaexp.stat
	
	perl -ni -e 'print log($_)/log(10)."\n"; ' $out_dir/rnaexp.stat
	
	paste $out_dir/rnaexp.stat $out_dir/p-values-rna.stat > $out_dir/rnaexp-rnap.stat
	./scripts/plot-corr3.sh $out_dir/rnaexp-rnap.stat $out_dir/rnaexp-rnap.ps "RNA Mean expression" "RNA-seq adj. P-value"
	
	./scripts/corrcoef $out_dir/rnaexp-rnap.stat 1 2 > $out_dir/rnaexp-rnap.corr
fi

# Make a plot "Microarray AveExpr vs RNA-seq padj" and calculate correlation
if [ ! -f $out_dir/arrayexp-rnap.ps ] ; then
	cut -d ' ' -f 4 $out_dir/input.table > $out_dir/arrayexp.stat
	
	#perl -ni -e 'print log($_)/log(10)."\n"; ' $out_dir/arrayexp.stat
	
	paste $out_dir/arrayexp.stat $out_dir/p-values-rna.stat > $out_dir/arrayexp-rnap.stat
	./scripts/plot-corr3.sh $out_dir/arrayexp-rnap.stat $out_dir/arrayexp-rnap.ps "Microarray Mean expression" "RNA-seq adj. P-value"
	
	./scripts/corrcoef $out_dir/arrayexp-rnap.stat 1 2 > $out_dir/arrayexp-rnap.corr
fi
EOC

: << 'ENDC'
# Make a plot "pval_difference vs RNA-seq padj"
if [ ! -f $out_dir/pval_diff-rnap.ps ] ; then
	
	paste $input_file.diff $out_dir/p-values-rna.stat > $out_dir/pval_diff-rnap.stat
	./scripts/plot-corr3.sh $out_dir/pval_diff-rnap.stat $out_dir/pval_diff-rnap.ps "P-value difference" "RNA-seq adj. P-value"
	
	./scripts/corrcoef $out_dir/pval_diff-rnap.stat 1 2 > $out_dir/pval_diff-rnap.corr
fi
ENDC
