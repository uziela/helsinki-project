#!/bin/bash

input_dir="input-LAML-all"
logs_dir="logs_ratios"
output_dir="LAML_all-ratios"

MYHOST=`hostname`
MYDATE=`date --rfc-3339=date`
LOGSTEM="$HOME/2012-04-05-run-ukko/$logs_dir/ratios.$MYDATE.$MYHOST.$$"

mkdir -p $logs_dir

echo run_ratios_ukko.sh $* > ${LOGSTEM}.log
date >> ${LOGSTEM}.log
date >> ${LOGSTEM}.err

/cs/hiit/wfa/uziela/2012-02-10-PREBS/run_ratios_ukko.sh $1 $input_dir $output_dir >>${LOGSTEM}.log 2>>${LOGSTEM}.err

date >> ${LOGSTEM}.log
date >> ${LOGSTEM}.err
