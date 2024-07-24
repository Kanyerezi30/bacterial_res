#!/usr/bin/env bash

for i in $(ls *amr)
do
	id=$(echo $i | cut -f1 -d".")
	echo "{" > ${id}.json
	echo "\"Identified Species\":\"Vibrio Cholerae\"," >> ${id}.json
	st=$(cat ${id}.st | cut -f3)
	echo "\"Sequence Type (ST)\":\"$st\"," >> ${id}.json
	plasmid=$(grep  -o '"plasmid": "[^"]*"' plasmid/${id}/data.json | sed 's/"plasmid": "\(.*\)"/\1/')
	echo "\"Plasmid Replicon Type\":\"$plasmid\"," >> ${id}.json
	echo "\"data\":[" >> ${id}.json
	
	cat database.txt | cut -f2 > words.txt
	while IFS= read -r drug
	do
                echo "   {" >> ${id}.json
                class=$(cat database.txt | grep -P "\t$drug$" | cut -f1 | sort -u)
                echo "    \"Drug.Class\":\"$class\"," >> ${id}.json
                echo "    \"Drug.Name\":\"$drug\"," >> ${id}.json
                grep -w $drug ${id}.amr
                res_p=$(echo $?)
                if [ $res_p -eq 0 ]
                then
                        pheno="Resistant"
                        gen_bac=$(cat ${id}.amr | cut -f6 | sort -u | sed -z 's/\n/,/g; s/,$/\n/')
                elif [ $res_p -eq 1 ]
                then
                        pheno="No resistance"
                        gen_bac=""
                fi
                echo "    \"WGS-predicted phenotype\":\"$pheno\"," >> ${id}.json
                echo "    \"Genetic background\":\"$gen_bac\"" >> ${id}.json
                echo "   }," >> ${id}.json
    		# Add your processing logic here
	done < words.txt
#        for drug in $(cat database.txt | cut -f2)
#        do
#                echo "   {" >> ${id}.json
#		class=$(cat database.txt | grep -P "\t$drug$" | cut -f1 | sort -u)
#                echo "    \"Drug.Class\":\"$class\"," >> ${id}.json
#                echo "    \"Drug.Name\":\"$drug\"," >> ${id}.json
#		grep -w $drug ${id}.amr
#		res_p=$(echo $?)
#		if [ $res_p -eq 0 ]
#		then
#			pheno="Resistant"
#			gen_bac=$(cat ${id}.amr | cut -f6 | sort -u | sed -z 's/\n/,/g; s/,$/\n/')
#		elif [ $res_p -eq 1 ]
#		then
#			pheno="No resistance"
#			gen_bac=""
#		fi
#                echo "    \"WGS-predicted phenotype\":\"$pheno\"," >> ${id}.json
#                echo "    \"Genetic background\":\"$gen_bac\"" >> ${id}.json
#                echo "   }," >> ${id}.json
#        done
	echo " ]," >> ${id}.json
	vf=$(awk -F"\t" '{print $6}' ${id}.vf | grep -v GENE | sed -z 's/\n/,/g; s/,$/\n/')

	echo "\"virulence factors\":\"$vf\"," >> ${id}.json
	echo "  \"runDetails\":{" >> ${id}.json
	echo "    \"testDate\":\"$(date +%F" "%T)\"" >> ${id}.json
	echo -e "  }\n}" >> ${id}.json
	cat ${id}.json > test.json
	cat test.json | sed -z 's/,\n ]/\n ]/' > ${id}.json
done
