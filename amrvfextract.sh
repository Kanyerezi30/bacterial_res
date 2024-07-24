#!/usr/bin/env bash

for i in $(cat uganda.ids)
do
        amr=$(grep -w $i allamr.csv | cut -f2)
        vf=$(grep -w $i allvf.csv | cut -f2)
        echo -e "$i\t$amr\t$vf"
done
