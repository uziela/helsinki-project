#!/bin/bash

input_dir="input-LAML-22-80"

MYHOST=`hostname`
MYDATE=`date --rfc-3339=date`
LOGSTEM="$HOME/2012-04-05-run-ukko/logs/LAML-MMSEQ.$MYDATE.$MYHOST.$$"

echo LAML_MMSEQ_ukko.sh $* > ${LOGSTEM}.log
date >> ${LOGSTEM}.log

/cs/hiit/wfa/uziela/2012-02-09-mmseq/run_LAML_ukko.sh $1 $input_dir >>${LOGSTEM}.log 2>${LOGSTEM}.err

date >> ${LOGSTEM}.log
