#!/bin/sh

# 2011 (C) Karolis Uziela, karolis.uziela@cs.helsinki.fi
# Antti Honkela group
# University of Helsinki
# Helsinki, Finland

if [ $# != 4 ] ; then
	echo "
Usage: 

./runall.sh [Parameters]

Parameters:
<table.rand file> - .table.rand file which was used in the run (HAS TO BE .rand !!!)
<out-dir> - output directory which was used in the run
<run-name> - name which was used in the run
<target> - target features which was used in the run. If the target feature is P-value (more exactly log(P-value)) then absolute value is taken and the sign is taken from logFC.

"
	exit 1
fi

table_file=$1
out_dir=$2
runname=$3
target=$4


tail -n +2 $table_file | cut -d ' ' -f 2 >$out_dir/$runname.genes

if [ "$target" = 'logFC' ] || [ "$target" = 'log2FoldChange' ] ; then
	paste $out_dir/$runname.genes $out_dir/$runname.pred > $out_dir/$runname.rnk
fi

if [ "$target" = 'adj.P.Val' ] || [ "$target" = 'padj' ] ; then
	
	# format prediction rankings
	perl -ne 'print abs($_)."\n"' $out_dir/$runname.pred > $out_dir/$runname.pred.abs
	
	tail -n +2 $table_file | cut -d ' ' -f 3 >$out_dir/$runname.arraylogfc
	tail -n +2 $table_file | cut -d ' ' -f 13 >$out_dir/$runname.rnalogfc
	
	perl -ne 'print "-\n" if ($_ < 0); print "\n" if ($_ >= 0);' $out_dir/$runname.arraylogfc >$out_dir/$runname.arraylogfc.sign
	perl -ne 'print "-\n" if ($_ < 0); print "\n" if ($_ >= 0);' $out_dir/$runname.rnalogfc >$out_dir/$runname.rnalogfc.sign
	
	if [ "$target" = 'adj.P.Val' ] ; then
		paste -d '' $out_dir/$runname.rnalogfc.sign $out_dir/$runname.pred.abs > $out_dir/$runname.pred.abs2	# if target is microarray adj pval then take rna logfc
	else
		paste -d '' $out_dir/$runname.arraylogfc.sign $out_dir/$runname.pred.abs > $out_dir/$runname.pred.abs2	# if target is rna adj pval then take microarray logfc
	fi
	paste $out_dir/$runname.genes $out_dir/$runname.pred.abs2 > $out_dir/$runname.rnk
	
	# format rankings by original Microarray and RNA-seq p-values
	tail -n +2 $table_file | cut -d ' ' -f 7 >$out_dir/arrayp
	tail -n +2 $table_file | cut -d ' ' -f 15 >$out_dir/rnap
	
	perl -ne 'print log($_)/log(10) if ($_ > 1e-7); print -7 if ($_ <= 1e-7) ; print "\n";' $out_dir/arrayp > $out_dir/arrayp2
	perl -ne 'print log($_)/log(10) if ($_ > 1e-22); print -22 if ($_ <= 1e-22) ; print "\n";' $out_dir/rnap > $out_dir/rnap2
	
	perl -ne 'print abs($_)."\n"' $out_dir/arrayp2 > $out_dir/arrayp.abs
	perl -ne 'print abs($_)."\n"' $out_dir/rnap2 > $out_dir/rnap.abs
	
	paste -d '' $out_dir/$runname.arraylogfc.sign $out_dir/arrayp.abs > $out_dir/arrayp.abs2
	paste -d '' $out_dir/$runname.rnalogfc.sign $out_dir/rnap.abs > $out_dir/rnap.abs2
	
	paste $out_dir/$runname.genes $out_dir/arrayp.abs2 > $out_dir/array_p.rnk
	paste $out_dir/$runname.genes $out_dir/rnap.abs2 > $out_dir/rna_p.rnk
	
	# delete unnecessary files
	rm $out_dir/$runname.pred.abs
	rm $out_dir/$runname.arraylogfc $out_dir/$runname.rnalogfc
	rm $out_dir/$runname.arraylogfc.sign $out_dir/$runname.rnalogfc.sign
	rm $out_dir/$runname.pred.abs2
	
	rm $out_dir/arrayp $out_dir/arrayp2 $out_dir/rnap $out_dir/rnap2
	rm $out_dir/arrayp.abs $out_dir/rnap.abs
	rm $out_dir/arrayp.abs2 $out_dir/rnap.abs2
fi
