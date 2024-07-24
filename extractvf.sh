#!/usr/bin/env bash

rm allvf.csv
for i in $(ls *vf)
do
	id=$(echo $i | cut -f1 -d".")
	amr=$(awk -F"\t" '$10 >= 90 && $11 >= 90 {print $6}' $i | sort -u | sed -z 's/\n/,/g; s/,$/\n/')
	echo -e "$id\t$amr" >> allvf.csv
done
