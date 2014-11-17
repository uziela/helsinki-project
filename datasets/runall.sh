#!/bin/sh

# 2012 (C) Karolis Uziela, karolis.uziela@cs.helsinki.fi
# Antti Honkela group
# University of Helsinki
# Helsinki, Finland

echo "runall.sh started with parameters: $*"

if [ $# != 5 ] ; then
	echo "
Usage: 

./runall.sh [Parameters]

Parameters:
<input-dir> - Input directory (dataset directory)
<mmseq-dir> - directory with mmseq files
<cdf-name>  - name of cdf
<mode>      - TOGETHER, SEPARATE or SUBSET. Do you want to normalize .CEL files together or separately? SUBSET is the same as TOGETHER, but does rma only on ENSG genes (not AFFX)
<array_dict> - file with mapping between sample names and .CEL file names

Commonly used CDFs:
HGU133Plus2_Hs_ENSG (Marioni, FIMM)
HGU133A2_Hs_ENSG	(Lungs_C)
HuEx10stv2_Hs_ENSG	(Lungs_S, brain)
HGFocus_Hs_ENSG		(Cheung)

"
	exit 1
fi

input_dir=$1
mmseq_dir=$2
cdf_name=$3
mode=$4
array_dict=$5

#./scripts/rna_expr_means.R $input_dir/rna_expr_means.RData $mmseq_dir/*/*.gene.mmseq
#./scripts/array_expr.R $input_dir/all-cel $cdf_name $input_dir/array_expr.RData $mode
#./scripts/array_expr_means.R $input_dir/array_expr.RData $array_dict $input_dir/array_expr_means.RData


./scripts/array_expr_rpa.R $input_dir/all-cel $cdf_name $input_dir/array_expr_rpa.RData
./scripts/array_expr_means.R $input_dir/array_expr_rpa.RData $array_dict $input_dir/array_expr_means_rpa.RData


echo "runall.sh done."
