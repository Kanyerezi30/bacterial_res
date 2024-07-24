#!/usr/bin/env bash

for i in $(ls *fa)
do
	output=$(echo $i | cut -f1 -d".")
	abricate --db vfdb $i > ${output}.vf
done
