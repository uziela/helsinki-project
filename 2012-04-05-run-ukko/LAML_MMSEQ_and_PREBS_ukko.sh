#!/bin/bash

input_dir="input-LAML-missed"
logs_dir="logs-missed"

MYHOST=`hostname`
MYDATE=`date --rfc-3339=date`
LOGSTEM="$HOME/2012-04-05-run-ukko/$logs_dir/LAML-MMSEQ.$MYDATE.$MYHOST.$$"

echo LAML_MMSEQ_ukko.sh $* > ${LOGSTEM}.log
echo LAML_MMSEQ_ukko.sh $* > ${LOGSTEM}.err
date >> ${LOGSTEM}.log
date >> ${LOGSTEM}.err

/cs/hiit/wfa/uziela/2012-02-09-mmseq/run_LAML_ukko.sh $1 $input_dir >>${LOGSTEM}.log 2>>${LOGSTEM}.err

date >> ${LOGSTEM}.log
date >> ${LOGSTEM}.err


MYDATE=`date --rfc-3339=date`
LOGSTEM="$HOME/2012-04-05-run-ukko/$logs_dir/LAML-PREBS.$MYDATE.$MYHOST.$$"

echo LAML_PREBS_ukko.sh $* > ${LOGSTEM}.log
echo LAML_PREBS_ukko.sh $* > ${LOGSTEM}.err

date >> ${LOGSTEM}.log
date >> ${LOGSTEM}.err

/cs/hiit/wfa/uziela/2012-02-10-PREBS/run_LAML_nogap_ukko.sh $1 $input_dir >>${LOGSTEM}.log 2>>${LOGSTEM}.err

date >> ${LOGSTEM}.log
date >> ${LOGSTEM}.err
