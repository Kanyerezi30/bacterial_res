#!/usr/bin/env bash

for i in $(cat */allvf.csv | cut -f1)
do
	grep $i */allvf.csv > ctx.txt
	grep -i ctxa ctx.txt
	ctxa=$(echo $? | sed 's/0/pres/; s/1/abs/')
	grep -i ctxb ctx.txt
	ctxb=$(echo $? | sed 's/0/pres/; s/1/abs/')
	echo "$i,$ctxa,$ctxb" >> resctx.csv
done
