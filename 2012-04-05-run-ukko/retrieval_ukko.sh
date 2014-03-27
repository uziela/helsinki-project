#!/bin/bash

MYHOST=`hostname`
MYDATE=`date --rfc-3339=date`
LOGSTEM="$HOME/2012-04-05-run-ukko/logs/retrieval.$MYDATE.$MYHOST.$$"

echo run_retrieval.sh $* > ${LOGSTEM}.log
date >> ${LOGSTEM}.log

/cs/hiit/wfa/uziela/2012-02-22-PREBS-rma/run_retrieval.sh $1 >>${LOGSTEM}.log 2>${LOGSTEM}.err

date >> ${LOGSTEM}.log
