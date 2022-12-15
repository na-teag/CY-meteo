#!/bin/bash

echo "ok"

# $arg_doc $arg_t $arg_p $arg_w $arg_h $arg_m $arg_lieu $arg_latitude1 $arg_latitude2 $arg_longitude1 $arg_longitude2 $arg_date1 $arg_date2 $arg_tris



#-t1 : A K -- 1 11
#-t2 : B K -- 2 11
#-t3 : A B K -- 1 2 11
#-p1 : A

 
 #head -n100 meteo_filtered_data_v1.csv | tail -n +2  | sed -e 's/,/;/g' | cut -d\; -f1,11 | sort -k1 -t\; -n > temp.csv
 #gnuplot temp.csv 