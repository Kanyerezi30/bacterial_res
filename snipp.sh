#!/usr/bin/env bash

# Perform variant calling with snippy

for i in $(ls *gz | cut -f1 -d"_" | sort -u)
do
	R1=$(ls *gz | grep $i | grep "_R1_")
	R2=$(ls *gz | grep $i | grep "_R2_")
	snippy --cpus 16 --outdir $i --ref ../vibref.gbk --R1 $R1 --R2 $R2
done
