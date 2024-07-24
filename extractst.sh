#!/usr/bin/env bash

for i in $(cat uganda.ids)
do
	scheme=$(grep -w $i all.st | cut -f2)
	st=$(grep -w $i all.st | cut -f3)
	echo "$i,$scheme,$st"
done
