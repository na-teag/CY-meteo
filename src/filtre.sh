#!/bin/bash

echo "ok"

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






#echo "$variable"
 
 #head -n100 meteo_filtered_data_v1.csv | tail -n +2  |  cut -d\; -f$variable  > temp.csv
 #| sort -k1 -t\; -n
 #./tri


#echo 'plot "tmp.dat"' | gnuplot --persist
