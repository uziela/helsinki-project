#!/bin/sh

# 2011 (C) Karolis Uziela, karolis.uziela@cs.helsinki.fi
# Antti Honkela group
# University of Helsinki
# Helsinki, Finland

if [ $# != 5 ] ; then
	echo "
Usage: 

./runall.sh [Parameters]

Parameters:
<input-dir> - Input directory. It should have microarray and rna-seq subdirectories. Each subdirectory should have subdirectories phen1 and phen2 (for phenotype1 and phenotype2)
<mode>		- 0 or 1 (0 - use Limma to calculate microarray logFC and P-values, 1 - manually calculate logFC, don't calculate P-values at all.)
<CDF-name1> - name of CDF which you want to use for phen1
<CDF-name2> - name of CDF which you want to use for phen2 (works only in 'manual' mode)
<run-name> - run name (it will be used to name some output files)

Note:
You have to install CDF before you use. Download it from http://brainarray.mbni.med.umich.edu/Brainarray/Database/CustomCDF/CDF_download.asp and use
R CMD INSTALL ?.tar.gz

Commonly used CDFs:
HGU133Plus2_Hs_ENSG (Marioni, FIMM)
HGU133A2_Hs_ENSG	(Lungs_C)
HuEx10stv2_Hs_ENSG	(Lungs_S, brain)
HGFocus_Hs_ENSG		(Cheung)

"
	exit 1
fi

input_dir=$1;
mode=$2;
cdfname1=$3;
cdfname2=$4;
run_name=$5;

rna_dir="$input_dir/rna-seq";
array_dir="$input_dir/microarray";

##################### Process RNA-seq #####################

# create simbolic links for .sra files from phenotype directories to rna-seq directory
if [ ! -f $rna_dir/rna_links.done ] ; then
	current=`pwd`
	
	for i in $current/$rna_dir/phen1/* ; do
		base=`basename $i`
		ln -s $i $rna_dir/phen1_$base
	done

	for i in $current/$rna_dir/phen2/* ; do
		base=`basename $i`
		ln -s $i $rna_dir/phen2_$base
	done
	touch $rna_dir/rna_links.done
fi

#rna_phen1=`ls $input_dir/rna-seq/phen1_*.sra | wc -l`
#rna_phen2=`ls $input_dir/rna-seq/phen2_*.sra | wc -l`

# run bowtie and matti scripts for each sra
if [ ! -f $rna_dir/matti.done ] ; then
	fa_count=`ls -1 $current/$rna_dir/*.fa 2>/dev/null | wc -l`
	sra_count=`ls -1 $current/$rna_dir/*.sra 2>/dev/null | wc -l`
	
	if [ $fa_count != "0" ] ; then
		for i in $rna_dir/*.fa ; do
			echo "foo $i"
			base=`basename $i .fa`
			./run-single.sh $base $rna_dir 
		done
	fi
	
	if [ $sra_count != "0" ] ; then
		for i in $rna_dir/*.sra ; do
			base=`basename $i .sra`
			./run-single.sh $base $rna_dir 
		done
	fi
	touch $rna_dir/matti.done
fi

# create count table for DESeq
if [ ! -f $rna_dir/count_table.RData ] ; then
	Rscript scripts/countTable.R $rna_dir/count_table.RData $rna_dir/*counts.RData
fi

# run DESeq
if [ ! -f $input_dir/rna_table.RData ] ; then
	Rscript scripts/runDESeq.R $rna_dir/count_table.RData $input_dir/rna_table.RData
fi

##################### Process Microarray #####################

if [ $mode = "0" ] ; then
	# create simbolic links for .CEL files from phenotype directories to microarray directory
	if [ ! -f $array_dir/array_links.done ] ; then
		current=`pwd`
		for i in $current/$array_dir/phen1/* ; do
			base=`basename $i`
			ln -s $i $array_dir/phen1_$base
		done

		for i in $current/$array_dir/phen2/* ; do
			base=`basename $i`
			ln -s $i $array_dir/phen2_$base
		done
		touch $array_dir/array_links.done
	fi

	array_phen1=`ls $input_dir/microarray/phen1_*.CEL | wc -l`
	array_phen2=`ls $input_dir/microarray/phen2_*.CEL | wc -l`

	if [ ! -f $input_dir/array_table.RData ] ; then
		current=`pwd`
		cd $array_dir
		Rscript $current/scripts/runAffyLimmaCDF.R $array_phen1 $array_phen2 $cdfname1 $current/$input_dir/array_table.RData
		cd $current
	fi
elif [ $mode = "1" ] ; then
	if [ ! -f $input_dir/array_table.RData ] ; then
		current=`pwd`
		cd $array_dir
		Rscript $current/scripts/runAffyCDFManual.R $cdfname1 $cdfname2 $current/$input_dir/array_table.RData
		cd $current
	fi
fi

##################### Join data from both platforms #####################

# Join RNA-seq and Microarray tables. The script excludes genes which are found only by one of the platforms. It also excludes genes with undefined or infinite log2 fold changes
if [ ! -f $input_dir/$run_name.table ] ; then
	Rscript scripts/fixTables.R $input_dir/array_table.RData $input_dir/rna_table.RData $input_dir/$run_name.RData $input_dir/$run_name.table
	#Rscript scripts/remove_extremely_significant.R $input_dir/$run_name.RData $input_dir/"$run_name"_no_signif.RData $input_dir/"$run_name"_no_signif.table		# create a separate table without very significant values
fi


if [ ! -d $input_dir/plots ] ; then
	mkdir $input_dir/plots
	Rscript scripts/plotGraph.R $input_dir/$run_name.RData $input_dir/plots
fi

if [ ! -d $input_dir/histograms ] ; then
	mkdir $input_dir/histograms
	Rscript scripts/histograms.R $input_dir/$run_name.RData $input_dir/histograms
fi

if [ ! -d $input_dir/more-plots ] ; then
	mkdir $input_dir/more-plots
	./more-plots.sh $input_dir/$run_name.table $input_dir/more-plots
fi

