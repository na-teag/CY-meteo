
	#remplacer virgule par ; pour que lat et long soit séparé comme le reste
	#$arg_latitude1<'"-50"'
	sed 's/,/;/g' temp.csv > temp2.csv
	if [ $lat_seul -eq 1 ]
	then
		cut -d";" -f1,2,4,5,6,7,10,11,12,15 temp2.csv | sed 's/;/ /g' | awk -v arg_latitude1="$arg_latitude1" -v arg_latitude2="$arg_latitude2" ' arg_latitude1 <= $10 && $10 <= arg_latitude2  {print $0; }' > temp.csv
		#cut -d";" -f1,2,4,5,6,7,10,11,12,15 temp.csv | sed 's/;/ /g' | awk -v longitude1="$arg_longitude1" -v longitude2="$arg_longitude2" 'longitude1 <= $1 && $1 <= longitude2  {print $0; }'
		#cut -d";" -f1,2 temp.csv | sed 's/;/ /g'   | awk '  $1>=1 && $1 < 9 {print $0; }'

	elif [ $long_seul -eq 1 ]
	then
		cut -d";" -f1,2,4,5,6,7,10,11,12,15 temp2.csv | sed 's/;/ /g' | awk -v arg_longitude1="$arg_longitude1" -v arg_longitude2="$arg_longitude2" ' arg_longitude1 <= $11 && $11 <= arg_longitude2   {print $0; }' > temp.csv
	else
		cut -d";" -f1,2,4,5,6,7,10,11,12,15 temp2.csv | sed 's/;/ /g' | awk -v arg_latitude1="$arg_latitude1" -v arg_latitude2="$arg_latitude2" -v arg_longitude1="$arg_longitude1" -v arg_longitude2="$arg_longitude2" ' arg_latitude1 <= $7 && $7 <= arg_latitude2 && arg_longitude1 <= $8 && $8 <= arg_longitude2 {print $0; }' > temp.csv  
	fi

fi

