#!/usr/bin/env bash

rm allamr.csv
for i in $(ls *amr)
do
	id=$(echo $i | cut -f1 -d".")
	amr=$(awk -F"\t" '$10 >= 90 && $11 >= 90 {print $6}' $i | sort -u | sed -z 's/\n/,/g; s/,$/\n/')
	echo -e "$id\t$amr" >> allamr.csv
done
