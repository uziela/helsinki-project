#!/bin/sh

# 2012 (C) Karolis Uziela, karolis.uziela@cs.helsinki.fi
# Antti Honkela group
# University of Helsinki
# Helsinki, Finland

echo "build_reference.sh started with parameters: $*"

if [ $# != 2 ] ; then
        echo "
Usage: 

./build_reference.sh [Parameters]

Parameters:
<cdna-file> - cdna file (.fa, unzipped)
<ncrna-file> - ncRNA file (enter 'FALSE' if you don't want to use ncRNA)
"
        exit 1
fi

current=`pwd`

cdna_file=$1
ncrna_file=$2

base=`basename $cdna_file .cdna.all.fa`

dirn=`dirname $cdna_file`

if [ $ncrna_file = 'FALSE' ] ; then
	fastagrep.sh -v 'supercontig|GRCh37:[^1-9XMY]' $cdna_file > $dirn/$base.ref_transcripts.fa
else
	fastagrep.sh -v 'supercontig|GRCh37:[^1-9XMY]' $cdna_file > $dirn/$base.ref_transcripts.fa
	fastagrep.sh -v 'supercontig|GRCh37:[^1-9XMY]' $ncrna_file >> $dirn/$base.ref_transcripts.fa
fi

cd $dirn
bowtie-build --offrate 3 $base.ref_transcripts.fa $base.ref_transcripts
cd $current

echo "build_reference.sh done."
