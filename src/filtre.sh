#!/bin/bash

# $arg_doc $arg_lieu $arg_latitude1 $arg_latitude2 $arg_longitude1 $arg_longitude2 $arg_date1 $arg_date2 $arg_tris $arg_t $arg_p $arg_w $arg_h $arg_m 
#   1          2             3              4            5                 6            7          8         9        10     11     12    13     14   


#-t1 : A             K   -- 1 11
#-t2 :   B           K   -- 2 11
#-t3 : A B           K   -- 1 2 11
#-p1 : A         G       -- 1 7
#-p2 :   B       G       -- 2 7
#-p3 : A B       G       -- 1 2 7
#-w  : A   D E           -- 1 4 5
#-h  : A               N -- 1 14
#-m  : A       F         -- 1 6


#-MAJ:             J     -- 10
#-d  :   B               -- 2
#-g/a:             J     -- 10


################

rm temp.csv
cp meteo_filtered_data_v1.csv temp.csv
head -n100 temp.csv | tail -n +2 | cut -d\; -f1,2,4,5,6,7,10,11,14 > temp2.csv
rm temp.csv
mv temp2.csv temp.csv

if [ "$2" != "_" ]
then
	./tri -f temp.csv -o temp2.csv -l $2 $3 $4 $5 $6
	echo "$a"
fi

if [ "${10}" != "_" ]
then
	cut temp.csv -d\; -f1,2,8 > temp2.csv
	#./tri -f temp2.csv -o tmp.dat $9 ${10}
	#echo 'plot "tmp.dat"' | gnuplot --persist
	test=1
fi

if [ "${11}" != "_" ]
then
	cut temp.csv -d\; -f1,2,6 > temp2.csv
	#./tri -f temp2.csv -o tmp.dat $9 ${11}
	#echo 'plot "tmp.dat"' | gnuplot --persist
	test=1
fi

if [ "${12}" != "_" ]
then
	cut temp.csv -d\; -f1,3,4 > temp2.csv
	#./tri -f temp2.csv -o tmp.dat $9 ${12}
	#echo 'plot "tmp.dat"' | gnuplot --persist
	test=1
fi

if [ "${13}" != "_" ]
then
	cut temp.csv -d\; -f1,9 > temp2.csv
	#./tri -f temp2.csv -o tmp.dat $9 ${13} -r
	#echo 'plot "tmp.dat"' | gnuplot --persist
	test=1
fi

if [ "${14}" != "_" ]
then
	cut temp.csv -d\; -f1,5 > temp2.csv
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
# 
#
#
#
#
#
#
#
#
#
