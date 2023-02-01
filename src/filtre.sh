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



rm temp.csv -f
#cp meteo_filtered_data_v1.csv temp.csv
 head -n100  $1| tail -n +2  > temp.csv #| cut -d\; -f1,2,4,5,6,7,10,11,14


arg_latitude1=$3
arg_latitude2=$4
arg_longitude1=$5
arg_longitude2=$6
lat_seul=0
long_seul=0
test=0
change=0



cut -d";" -f1,2,4,5,6,7,10,11,12,14 temp.csv | sed 's/,/ /g' | sed 's/;/ /g'  > temp2.csv #remplacer virgule par ; pour que lat et long soit séparé comme le reste


if [ "$2" != "_" ]
then
	if [ "$2" = "-F" ]
	then
		arg_latitude1="40"
		arg_latitude2="52"
		arg_longitude1="-8"
		arg_longitude2="10"
	elif [ "$2" = "-G" ]
	then
		arg_latitude1="2"
		arg_latitude2="6"
		arg_longitude1="-55"
		arg_longitude2="-51"
	elif [ "$2" = "-S" ]
	then
		arg_latitude1="46"
		arg_latitude2="48"
		arg_longitude1="-57"
		arg_longitude2="-56"
	elif [ "$2" = "-A" ]
	then
		arg_latitude1="8"
		arg_latitude2="28"
		arg_longitude1="-85"
		arg_longitude2="-53"
	elif [ "$2" = "-O" ]
	then
		arg_latitude1="-35"
		arg_latitude2="15"
		arg_longitude1="42"
		arg_longitude2="114"
	elif [ "$2" = "-Q" ]
	then
		arg_latitude1="-100"
		arg_latitude2="-58"
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

	
	if [ $lat_seul -eq 1 ]
	then
		awk temp2.csv -v arg_latitude1="$arg_latitude1" -v arg_latitude2="$arg_latitude2" ' arg_latitude1 <= $10 && $10 <= arg_latitude2  {print $0; }' > temp.csv
		#cut -d";" -f1,2,4,5,6,7,10,11,12,15 temp.csv | sed 's/;/ /g' | awk -v longitude1="$arg_longitude1" -v longitude2="$arg_longitude2" 'longitude1 <= $1 && $1 <= longitude2  {print $0; }'
		#cut -d";" -f1,2 temp.csv | sed 's/;/ /g'   | awk '  $1>=1 && $1 < 9 {print $0; }'

	elif [ $long_seul -eq 1 ]
	then
		awk temp2.csv -v arg_longitude1="$arg_longitude1" -v arg_longitude2="$arg_longitude2" ' arg_longitude1 <= $11 && $11 <= arg_longitude2   {print $0; }' > temp.csv
	else
		awk temp2.csv -v arg_latitude1="$arg_latitude1" -v arg_latitude2="$arg_latitude2" -v arg_longitude1="$arg_longitude1" -v arg_longitude2="$arg_longitude2" ' arg_latitude1 <= $7 && $7 <= arg_latitude2 && arg_longitude1 <= $8 && $8 <= arg_longitude2 {print $0; }' > temp.csv  
	fi
	rm temp2.csv -f #boucle facultative, donc pas de changement de nom du dernier fichier mis a jour
	mv temp.csv temp2.csv
fi




# rm temp2.csv -f
# mv temp.csv temp2.csv

if [ "${10}" != "_" ]
then
	#cut temp2.csv -d" " -f1,2,8 > temp3.csv
	#./tri -f temp3.csv -o tmp.dat $9 ${10}
	#echo 'plot "tmp.dat"' | gnuplot --persist
	test=1
fi

if [ "${11}" != "_" ]
then
	#cut temp2.csv -d" " -f1,2,6 > temp3.csv
	#./tri -f temp3.csv -o tmp.dat $9 ${11}
	#echo 'plot "tmp.dat"' | gnuplot --persist
	test=1
fi

if [ "${12}" != "_" ]
then
	cut temp2.csv -d" " -f1,3,4,7,8 > temp3.csv
	gcc -o tri2 tri2.c -lm
	chmod u+x -f tri2
	# ./tri2 -f temp3.csv -o tmp.dat $9 ${12}
	echo -e '
	set view map
	set dgrid3d 100,100,2
	unset key
	unset surface
	set pm3d at b
	splot "tmp.dat"' | gnuplot --persist 2>/dev/null
fi

if [ "${13}" != "_" ]
then
	cut temp2.csv -d" " -f1,7,8,11 | awk '$1!="" && $2!="" && $3!="" && $4!="" {print $0}' > temp3.csv
	gcc -o tri tri.c -lm
	chmod u+x -f tri
	./tri -f temp3.csv -o tmp.dat $9 ${13}
	# echo "ok"
	echo -e '
	set xlabel "longitude"
	set ylabel "latitude"
	set title "altitude des stations"
	set view map
	set dgrid3d 100,100,2
	unset key
	unset surface
	set pm3d at b
	splot "tmp.dat"' | gnuplot --persist 2>/dev/null
fi

if [ "${14}" != "_" ]
then
	awk '{print $1" "$2" "$3" "$4" "$6" "$7" "$8" "$9" "$10" "$5 }' temp2.csv > temp.csv
	cut -d" " -f1,6,7,10 temp.csv | awk '$1!="" && $2!="" && $3!="" && $4!="" {print $0}' > temp3.csv
	gcc -o tri tri.c -lm
	chmod u+x -f tri
	./tri -f temp3.csv -o tmp.dat $9 ${14}
	awk '$3 <= 100 {print $0}' tmp.dat > temp.csv
	cat temp.csv > tmp.dat
	echo -e '
	set xlabel "longitude"
	set ylabel "latitude"
	set title "humiditées maximales par station"
	set view map
	set dgrid3d 100,100,2
	unset key
	unset surface
	set pm3d at b
	splot "tmp.dat"' | gnuplot --persist 2>/dev/null
	# splot "tmp.dat" using 1:2:3 with pm3d title"X"' | gnuplot --persist
fi




#echo 'plot "tmp.dat"' | gnuplot --persist






#       A FAIRE
#
# enlever la colonne des coordonées avant le tris avec les options obligatoires
# enlever le head -n100
# vérifier le retour de toute les fonction en C (y compris les programmes de tri)
# préciser dans le redame et le help que pour le -m, si les stations ont différentes altitude, la + grande sera conservée
# mettre les titres sur les graphiques et le nom des axes
# faire un makefile
#
#
#
#       A FAIRE SI Y'A LE TEMPS
#
# dans arguments.sh, regrouper les -t1/2/3 et -p1/2/ en une seule étape
# changer ordre alphabetique readme en ordre thematique
# mettre que la date de début pour aller jusqu'au bout
# faire une option pour exporter le graphique
# option -m/h --tab : nombre le +grand ne semble pas apparaitre dans le fichier trié
# verifier boucle affichage tableau 70/69 et 0/1
#
#
#
#
