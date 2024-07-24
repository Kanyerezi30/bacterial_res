#!/usr/bin/env bash

mkdir plasmid
for i in $(ls *fa)
do
	output=$(echo $i | cut -f1 -d".")
	mkdir -p plasmid/${output}
	plasmidfinder.py --infile $i -o plasmid/${output}
done
