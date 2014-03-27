#!/bin/bash

MYHOST=`hostname`
MYDATE=`date --rfc-3339=date`
LOGSTEM="$HOME/2012-04-05-run-ukko/logs/test.$MYDATE.$MYHOST.$$"


echo $1 > ${LOGSTEM}.log


