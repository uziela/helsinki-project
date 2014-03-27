#!/bin/sh

# 2011 (C) Karolis Uziela, karolis.uziela@cs.helsinki.fi
# Antti Honkela group
# University of Helsinki
# Helsinki, Finland

if [ $# != 3 ] ; then
	echo "
Usage: 

./runall.sh [Parameters]

Parameters:
<input-dir>  - input directory with merged tables (.table)
<output-dir> - output directory
<mode>       - (1, 2, 3, 4, 5) do you want to filter out low expression genes (1) or high log2 fold change genes (2) or log2FC variances (3) or expr variances (4) or low log2 fold change genes (5)

"
	exit 1
fi

input_dir=$1;
output_dir=$2;
mode=$3;

if [ ! -d $output_dir ] ; then
	mkdir $output_dir
	cp $input_dir/*.table $output_dir
	mkdir $output_dir/corr
	mkdir $output_dir/tables
	mkdir $output_dir/plots
	mkdir $output_dir/plots-png
fi

# filter out
if [ ! -f $output_dir/filter.done ] ; then
	echo "filter out"
	for i in $output_dir/*.table ; do
		dirname=`dirname $i`
		basename=`basename $i .table`
		if [ $mode = "1" ] ; then
			Rscript scripts/filter-out.R $dirname/$basename
		elif [ $mode = "2" ] ; then
			Rscript scripts/filter-out2.R $dirname/$basename
		elif [ $mode = "3" ] ; then
			Rscript scripts/filter-out3.R $dirname/$basename $input_dir/variances.stat
			mv $dirname/$basename.nofilter $i
		elif [ $mode = "4" ] ; then
			Rscript scripts/filter-out4.R $dirname/$basename $input_dir/variances.stat
			mv $dirname/$basename.nofilter $i
		elif [ $mode = "5" ] ; then
			Rscript scripts/filter-out5.R $dirname/$basename
		fi
	done
	touch $output_dir/filter.done
fi

# remove index
if [ ! -f $output_dir/index.txt ] ; then
	echo "remove index"
	for i in $output_dir/*.table ; do
		tail -n +2 $i > $i.noindex
		if [ ! -f $output_dir/index.txt ] ; then
			head -n 1 $i > $output_dir/index.txt
		fi
	done
fi

# calculate correlations
if [ ! -f $output_dir/corr/noindex.corr ] ; then
	echo "calculate correlations"
	for i in $output_dir/*.rna05.table.noindex ; do
		base=`basename $i .rna05.table.noindex`
		./scripts/corrcoef $output_dir/$base.table.noindex 3 13 | grep "Correlation" | perl -pe 's/Correlation: //' >> $output_dir/corr/noindex.corr

		./scripts/corrcoef $output_dir/$base.rna05.table.noindex 3 13 | grep "Correlation" | perl -pe 's/Correlation: //' >> $output_dir/corr/rna05.corr
		./scripts/corrcoef $output_dir/$base.rna10.table.noindex 3 13 | grep "Correlation" | perl -pe 's/Correlation: //' >> $output_dir/corr/rna10.corr
		./scripts/corrcoef $output_dir/$base.rna20.table.noindex 3 13 | grep "Correlation" | perl -pe 's/Correlation: //' >> $output_dir/corr/rna20.corr
		./scripts/corrcoef $output_dir/$base.rna30.table.noindex 3 13 | grep "Correlation" | perl -pe 's/Correlation: //' >> $output_dir/corr/rna30.corr
		./scripts/corrcoef $output_dir/$base.rna40.table.noindex 3 13 | grep "Correlation" | perl -pe 's/Correlation: //' >> $output_dir/corr/rna40.corr
		./scripts/corrcoef $output_dir/$base.rna50.table.noindex 3 13 | grep "Correlation" | perl -pe 's/Correlation: //' >> $output_dir/corr/rna50.corr

		./scripts/corrcoef $output_dir/$base.array05.table.noindex 3 13 | grep "Correlation" | perl -pe 's/Correlation: //' >> $output_dir/corr/array05.corr
		./scripts/corrcoef $output_dir/$base.array10.table.noindex 3 13 | grep "Correlation" | perl -pe 's/Correlation: //' >> $output_dir/corr/array10.corr
		./scripts/corrcoef $output_dir/$base.array20.table.noindex 3 13 | grep "Correlation" | perl -pe 's/Correlation: //' >> $output_dir/corr/array20.corr
		./scripts/corrcoef $output_dir/$base.array30.table.noindex 3 13 | grep "Correlation" | perl -pe 's/Correlation: //' >> $output_dir/corr/array30.corr
		./scripts/corrcoef $output_dir/$base.array40.table.noindex 3 13 | grep "Correlation" | perl -pe 's/Correlation: //' >> $output_dir/corr/array40.corr
		./scripts/corrcoef $output_dir/$base.array50.table.noindex 3 13 | grep "Correlation" | perl -pe 's/Correlation: //' >> $output_dir/corr/array50.corr

		./scripts/corrcoef $output_dir/$base.both05.table.noindex 3 13 | grep "Correlation" | perl -pe 's/Correlation: //' >> $output_dir/corr/both05.corr
		./scripts/corrcoef $output_dir/$base.both10.table.noindex 3 13 | grep "Correlation" | perl -pe 's/Correlation: //' >> $output_dir/corr/both10.corr
		./scripts/corrcoef $output_dir/$base.both20.table.noindex 3 13 | grep "Correlation" | perl -pe 's/Correlation: //' >> $output_dir/corr/both20.corr
		./scripts/corrcoef $output_dir/$base.both30.table.noindex 3 13 | grep "Correlation" | perl -pe 's/Correlation: //' >> $output_dir/corr/both30.corr
		./scripts/corrcoef $output_dir/$base.both40.table.noindex 3 13 | grep "Correlation" | perl -pe 's/Correlation: //' >> $output_dir/corr/both40.corr
		./scripts/corrcoef $output_dir/$base.both50.table.noindex 3 13 | grep "Correlation" | perl -pe 's/Correlation: //' >> $output_dir/corr/both50.corr

		echo $base >> $output_dir/corr/names.txt
	done
fi 

if [ ! -f $output_dir/tables/rna-table.html ] ; then
	./scripts/create-table-corr.py $output_dir/corr/noindex.corr $output_dir/corr/rna*.corr $output_dir/corr/names.txt $output_dir/tables/rna-table.html
	./scripts/create-table-corr.py $output_dir/corr/noindex.corr $output_dir/corr/array*.corr $output_dir/corr/names.txt $output_dir/tables/array-table.html
	./scripts/create-table-corr.py $output_dir/corr/noindex.corr $output_dir/corr/both*.corr $output_dir/corr/names.txt $output_dir/tables/both-table.html
fi

if [ ! -f $output_dir/plots/plot.done ] ; then
	for i in $output_dir/*.rna05.table.noindex ; do
		base=`basename $i .rna05.table.noindex`
		./scripts/plot-corr-col.sh $output_dir/$base.table.noindex $output_dir/$base.rna10.table.noindex $output_dir/$base.rna20.table.noindex $output_dir/$base.rna30.table.noindex $output_dir/$base.rna40.table.noindex $output_dir/$base.rna50.table.noindex $output_dir/plots/$base-rna.ps "3:13" "Microarray Log2 fold change" "RNA-seq Log2 fold change"
		./scripts/plot-corr-col.sh $output_dir/$base.table.noindex $output_dir/$base.array10.table.noindex $output_dir/$base.array20.table.noindex $output_dir/$base.array30.table.noindex $output_dir/$base.array40.table.noindex $output_dir/$base.array50.table.noindex $output_dir/plots/$base-array.ps "3:13" "Microarray Log2 fold change" "RNA-seq Log2 fold change"
		./scripts/plot-corr-col.sh $output_dir/$base.table.noindex $output_dir/$base.both10.table.noindex $output_dir/$base.both20.table.noindex $output_dir/$base.both30.table.noindex $output_dir/$base.both40.table.noindex $output_dir/$base.both50.table.noindex $output_dir/plots/$base-both.ps "3:13" "Microarray Log2 fold change" "RNA-seq Log2 fold change"
	done
	for i in $output_dir/plots/*.ps ; do
		convert $i $output_dir/plots-png/`basename $i`.png
	done
	touch $output_dir/plots/plot.done
fi

: << 'EOC'
if [ ! -f $output_dir/plots/plot.done ] ; then
	for i in $output_dir/*.noindex ; do
		./scripts/plot-corr-gen.sh $i $output_dir/plots/`basename $i`.ps "3:13" "Microarray Log2 fold change" "RNA-seq Log2 fold change"
	done
	for i in $output_dir/plots/*.ps ; do
		convert $i $output_dir/plots-png/`basename $i`.png
	done
	touch $output_dir/plots/plot.done
fi
EOC
