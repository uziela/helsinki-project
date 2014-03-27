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
<input-file1> - Input file with rankings 1
<input-file2> - Input file with rankings 2
<input-file3> - Input file with rankings 3
<output-dir> - Output directory
"
	exit 1
fi

input_file1=$1;
input_file2=$2;
input_file3=$3;
out_dir=$4;

gsea_jar='./gsea2-2.07.jar'
#david_entrez='./gene2ensembl_clear.txt'
database='c2.cp.v3.0.ensembl.gmt'

# print parameters
echo "runall.sh has started with parameters: $*"

# Create output dir
if [ ! -d $out_dir ] ; then
	mkdir $out_dir
fi

for input_file in $input_file1 $input_file2 $input_file3 ; do
	
	#echo "Processing $input_file"
	name=`basename $input_file .rnk`

	# replace ensemble ids with entrez ids
	#if [ ! -f $out_dir/$name.entrez.rnk ] ; then
	#	./scripts/replace_ids.pl $input_file $david_entrez $out_dir/$name.entrez.rnk
	#fi

	# prepare script to run gsea with preranked list
	if [ ! -f $out_dir/$name.sh ] ; then
R --no-save <<EOP
source("gseaLda.R")
gsea.preranked.write.sh.script('$out_dir/$name.sh', '$gsea_jar', '$database', '$input_file', '$out_dir', '$name')
EOP
	fi

	# run gsea
	if [ ! -f $out_dir/"$name"_gsea.done ] ; then
		$out_dir/$name.sh
		touch $out_dir/"$name"_gsea.done
	fi

	# concatinate na_pos and na_neg
	if [ ! -f $out_dir/"$name"_na_all.txt ] ; then
		tail -n +2 $out_dir/"$name".GseaPreranked*/gsea_report_for_na_pos_*.xls > $out_dir/"$name"_na_pos.txt
		tail -n +2 $out_dir/"$name".GseaPreranked*/gsea_report_for_na_neg_*.xls > $out_dir/"$name"_na_neg.txt
		cat $out_dir/"$name"_na_pos.txt $out_dir/"$name"_na_neg.txt > $out_dir/"$name"_na_all.txt
	fi

done

# Calculate Spearman correlation
name1=`basename $input_file1 .rnk`
name2=`basename $input_file2 .rnk`
name3=`basename $input_file3 .rnk`

if [ ! -f $out_dir/"$name1"_vs_"$name2".corr ] ; then
	./scripts/prepare_spearman.pl $out_dir/"$name1"_na_all.txt $out_dir/"$name2"_na_all.txt $out_dir/"$name1"_vs_"$name2".stat
	./scripts/corrcoef $out_dir/"$name1"_vs_"$name2".stat 1 2 > $out_dir/"$name1"_vs_"$name2".corr
fi

if [ ! -f $out_dir/"$name1"_vs_"$name3".corr ] ; then
	./scripts/prepare_spearman.pl $out_dir/"$name1"_na_all.txt $out_dir/"$name3"_na_all.txt $out_dir/"$name1"_vs_"$name3".stat
	./scripts/corrcoef $out_dir/"$name1"_vs_"$name3".stat 1 2 > $out_dir/"$name1"_vs_"$name3".corr

	./scripts/prepare_spearman.pl $out_dir/"$name2"_na_all.txt $out_dir/"$name3"_na_all.txt $out_dir/"$name2"_vs_"$name3".stat
	./scripts/corrcoef $out_dir/"$name2"_vs_"$name3".stat 1 2 > $out_dir/"$name2"_vs_"$name3".corr	
fi

