#!/bin/bash

# $arg_doc $arg_lieu $arg_latitude1 $arg_latitude2 $arg_longitude1 $arg_longitude2 $arg_date1 $arg_date2 $arg_tris $arg_t $arg_p $arg_w $arg_h $arg_m 
#   1          2             3              4            5                 6            7          8         9        10     11     12    13     14   


#-t1 : A             K   -- 1 11	| 2
#-t2 :   B           K   -- 2 11	| 2
#-t3 : A B           K   -- 1 2 11	|  3 
#-p1 : A         G       -- 1 7		| 2
#-p2 :   B       G       -- 2 7		| 2
#-p3 : A B       G       -- 1 2 7	|  3
#-w  : A   D E           -- 1 4 5	|  3
#-h  : A               N -- 1 14	| 2
#-m  : A       F         -- 1 6		| 2


#-MAJ:             J     -- 10		|
#-d  :   B               -- 2		|
#-g/a:             J     -- 10		|


################


compare(){
	#gcc -o compare compare.c
	#./compare $1 $2 #
	awk -v n1="$1" -v n2="$2" 'BEGIN {printf (n1<=n2?"1":"0") }' # est ce que $1 <= $2 ?
	#return $?
}



rm temp.csv
#cp meteo_filtered_data_v1.csv temp.csv
#head -n10 $1 | 
tail -n +2 $1 | cut -d\; -f1,2,4,5,6,7,10,11,14 > temp.csv


arg_latitude1=$3
arg_latitude2=$4
arg_longitude1=$5
arg_longitude2=$6
lat_seul=0
long_seul=0
test=0
change=0





if [ "$2" != "_" ]
then
	if [ "$2" = "-F" ]
	then
		arg_latitude1=41.3
		arg_latitude2=51.1
		arg_longitude1=-7.2
		arg_longitude2=9.6
	elif [ "$2" = "-G" ]
	then
		arg_latitude1=2
		arg_latitude2=5.8
		arg_longitude1=-54.6
		arg_longitude2=-51.5
	elif [ "$2" = "-S" ]
	then
		arg_latitude1=46
		arg_latitude2=48
		arg_longitude1=-57
		arg_longitude2=-56
	elif [ "$2" = "-A" ]
	then
		arg_latitude1=8
		arg_latitude2=28
		arg_longitude1=-85
		arg_longitude2=-53
	elif [ "$2" = "-O" ]
	then
		arg_latitude1=-35
		arg_latitude2=15
		arg_longitude1=42
		arg_longitude2=114
	elif [ "$2" = "-Q" ]
	then
		arg_latitude1=-100
		arg_latitude2=-58
		lat_seul=1
	elif [ "$2" = "-a" ]
	then
		lat_seul=1
		if [ ! `compare $arg_latitude1 $arg_latitude2` ]
		then
			change=$arg_latitude1
			arg_latitude1=$arg_latitude2
			arg_latitude2=$change
		fi
	elif [ "$2" = "-g" ]
	then
		long_seul=1
		if [ ! `compare $arg_longitude1 $arg_longitude2` ]
		then
			change=$arg_longitude1
			arg_longitude1=$arg_longitude2
			arg_longitude2=$change
		fi
	elif [ "$2" = "-g-a" ] || [ "$2" = "-a-g" ]
	then
		if [ ! `compare $arg_latitude1 $arg_latitude2` ]
		then
			change=$arg_latitude1
			arg_latitude1=$arg_latitude2
			arg_latitude2=$change
		fi
		if [ ! `compare $arg_longitude1 $arg_longitude2` ]
		then
			change=$arg_longitude1
			arg_longitude1=$arg_longitude2
			arg_longitude2=$change
			echo "test"
		fi
		#echo "$arg_longitude1 > $arg_longitude2 : `compare $arg_longitude1 $arg_longitude2`"
	fi

	nbr_ligne=`wc -l temp.csv | cut -d" " -f1`


	rm -f temp2.csv
	touch temp2.csv	

	for (( i=1 ; $i <= $nbr_ligne ; i++))
	do
		lat=`sed -n ${i}p temp.csv | cut -d";" -f7 | cut -d"," -f1`
		long=`sed -n ${i}p temp.csv | cut -d";" -f7 | cut -d"," -f2`
		if [ $lat_seul -eq 1 ]
		then
			if  [ `compare $arg_latitude1 $lat` -eq 1 ] && [ `compare $lat $arg_latitude2` -eq 1 ]
			then
				test=1
			else
				test=0
			fi
		elif [ $long_seul -eq 1 ]
		then
			if  [ `compare $arg_longitude1 $long` -eq 1 ] && [ `compare $long $arg_longitude2` -eq 1 ]
			then
				test=1
			else
				test=0
			fi
		else
			if  [ `compare $arg_longitude1 $long` -eq 1 ] && [ `compare $long $arg_longitude2` -eq 1 ] && [ `compare $arg_latitude1 $lat` -eq 1 ] && [ `compare $lat $arg_latitude2` -eq 1 ]
			then
				test=1
			else
				test=0
			fi
			#echo " `compare $arg_longitude1 $long` `compare $long $arg_longitude2` `compare $arg_latitude1 $lat` `compare $lat $arg_latitude2` "
		fi
		if [ $test -eq 1 ]
		then
			#cat temp.csv
			echo "oui($i)"
			head -n $i temp.csv | tail -n 1 >> temp2.csv
		fi
	done
fi



# sed -i -n 1d file

20h07























if [ "${10}" != "_" ]
then
	#cut temp.csv -d\; -f1,2,8 > temp2.csv
	#./tri -f temp2.csv -o tmp.dat $9 ${10}
	#echo 'plot "tmp.dat"' | gnuplot --persist
	test=1
fi

if [ "${11}" != "_" ]
then
	#cut temp.csv -d\; -f1,2,6 > temp2.csv
	#./tri -f temp2.csv -o tmp.dat $9 ${11}
	#echo 'plot "tmp.dat"' | gnuplot --persist
	test=1
fi

if [ "${12}" != "_" ]
then
	#cut temp.csv -d\; -f1,3,4 > temp2.csv
	#./tri -f temp2.csv -o tmp.dat $9 ${12}
	#echo 'plot "tmp.dat"' | gnuplot --persist
	test=1
fi

if [ "${13}" != "_" ]
then
	#cut temp.csv -d\; -f1,9 > temp2.csv
	#./tri -f temp2.csv -o tmp.dat $9 ${13} -r
	#echo 'plot "tmp.dat"' | gnuplot --persist
	test=1
fi

if [ "${14}" != "_" ]
then
	#cut temp.csv -d\; -f1,5 > temp2.csv
	#./tri -f temp2.csv -o tmp.dat $9 ${14} -r
	#echo 'plot "tmp.dat"' | gnuplot --persist
	test=1
fi




#echo 'plot "tmp.dat"' | gnuplot --persist






#       A FAIRE
#
# verifier les retour des programes c
# enlever la colonne des coordonées avant le tris avec les options obligatoires
#
#
#
#
#
#
#
#
#       A FAIRE SI Y'A LE TEMPS
#
# dans arguments.sh, regrouper les -t1/2/3 et -p1/2/ en une seule étape
# changer _ en NULL
#
#
#
#
#
#
#
#
#
