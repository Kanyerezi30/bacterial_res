#!/usr/bin/env bash

## Perform assembly using skesa
for i in $(ls *gz | cut -f1 -d"_" | sort -u)
do
        R1=$(ls *gz | grep $i | grep "_R1_")
        R2=$(ls *gz | grep $i | grep "_R2_")
	skesa --reads $R1,$R2 --cores 16 --memory 32 > ${i}.skesa.fa
done
