#!/bin/bash

input_dir="input-LAML-22-80"
logs_dir="logs4_PREBS_22-80_arraycomp"

MYHOST=`hostname`
MYDATE=`date --rfc-3339=date`
LOGSTEM="$HOME/2012-04-05-run-ukko/$logs_dir/LAML-PREBS.$MYDATE.$MYHOST.$$"

echo LAML_PREBS_ukko.sh $* > ${LOGSTEM}.log
date >> ${LOGSTEM}.log
date >> ${LOGSTEM}.err

/cs/hiit/wfa/uziela/2012-02-10-PREBS/run_LAML_nogap_ukko.sh $1 $input_dir >>${LOGSTEM}.log 2>>${LOGSTEM}.err

date >> ${LOGSTEM}.log
date >> ${LOGSTEM}.err
