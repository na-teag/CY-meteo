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
cp meteo_filtered_data_v1.csv temp.csv
head -n2000000 $1 | tail  -n +2  > temp.csv 


arg_latitude1=$3
arg_latitude2=$4
arg_longitude1=$5
arg_longitude2=$6
lat_seul=0
long_seul=0
test=0
change=0



cut -d";" -f1,2,4,5,6,7,10,11,12,14 temp.csv | sed 's/,/ /g' | sed 's/;/ /g' | sed 's/  / £ /g' | sed 's/  / £ /g'  > temp2.csv #remplacer virgule par ; pour que lat et long soit séparé comme le reste


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
		arg_longitude2="-50"
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
		arg_latitude1="-45"
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
		awk -v arg_latitude1="$arg_latitude1" -v arg_latitude2="$arg_latitude2" ' arg_latitude1 <= $10 && $10 <= arg_latitude2  {print $0; }' temp2.csv > temp.csv
		#cut -d";" -f1,2,4,5,6,7,10,11,12,15 temp.csv | sed 's/;/ /g' | awk -v longitude1="$arg_longitude1" -v longitude2="$arg_longitude2" 'longitude1 <= $1 && $1 <= longitude2  {print $0; }'
		#cut -d";" -f1,2 temp.csv | sed 's/;/ /g'   | awk '  $1>=1 && $1 < 9 {print $0; }'

	elif [ $long_seul -eq 1 ]
	then
		awk -v arg_longitude1="$arg_longitude1" -v arg_longitude2="$arg_longitude2" ' arg_longitude1 <= $11 && $11 <= arg_longitude2   {print $0; }' temp2.csv > temp.csv
	else
		awk -v arg_latitude1="$arg_latitude1" -v arg_latitude2="$arg_latitude2" -v arg_longitude1="$arg_longitude1" -v arg_longitude2="$arg_longitude2" ' arg_latitude1<=$7 && $7<=arg_latitude2 && arg_longitude1<=$8 && $8<=arg_longitude2 {print $0} ' temp2.csv > temp.csv
	fi
	rm temp2.csv -f #boucle facultative, donc pas de changement de nom du dernier fichier mis a jour
	mv temp.csv temp2.csv
fi




if [ "${10}" != "_" ] # Temperatures
then
	#cut temp2.csv -d" " -f1,2,8 > temp3.csv
	#./tri -f temp3.csv -o tmp.dat $9 ${10}
	#echo 'plot "tmp.dat"' | gnuplot --persist
	if [ "${10}" == "-t1" ]
	then
		cut temp2.csv -d" " -f1,9 | awk '$1!="£" && $2!="£" {print $0}' > temp3.csv
		#cut temp2.csv -d" " -f1,9 > temp3.csv
		gcc -o tri tri.c -lm
		chmod u+x -f tri
		echo "test"
		./tri -f temp3.csv -o tmp.dat $9 ${10}
		echo -e '
		set grid nopolar
		set grid xtics mxtics ytics mytics noztics nomztics noztics nortics nomrtics nox2tics nomx2tics noy2tics nomy2tics nomcbtics
		set style data lines
		set title "Graphique des température par stations"
		set xlabel "Station"
		set ylabel "Température"
		Shadecolor = "#EECF83"
		set autoscale noextend
		set xtics rotated by 90 right
		set xrange [*:*]
		plot "tmp.dat" using 1:2:3 with filledcurves fc rgb Shadecolor notitle, "tmp.dat" using 1:4 with lines set linetype 2 lc rgb "sea-green" lw 2 pt 7' | gnuplot --persist 2>/dev/null
	elif [ "${10}" == "-t2" ]
	then
		cut temp2.csv -d" " -f2,9 | awk '$1!="£" && $2!="£" {print $0}' > temp3.csv
		gcc -o tri tri.c -lm
		chmod u+x -f tri
		./tri -f temp3.csv -o tmp.dat $9 ${10}
		#echo -e '
		#set grid nopolar
		#set grid xtics mxtics ytics mytics noztics nomztics noztics nortics nomrtics nox2tics nomx2tics noy2tics nomy2tics nomcbtics
		#set style data lines
		#set title "Graphique des température par heure"
		#set xlabel "Heure"
		#set ylabel "Température"
		#set autoscale noextend
		#set timefmt '%Y-%m-%d %H'
		#set xdata time
		#set format x '%Y-%m-%d %H'
		#set xrange [*:*]
		#set yrange [*:*]
		#set xtics rotate by 45 right
		#plot "tmp.dat" using (sprintf("%s-%s",substr(stringcolumn(1),1,10),substr(stringcolumn(1),12,14))):2 with lines notitle ' | gnuplot --persist 2>/dev/null
		echo -e '
		set grid nopolar
		set grid xtics mxtics ytics mytics noztics nomztics noztics nortics nomrtics nox2tics nomx2tics noy2tics nomy2tics nomcbtics
		set style data lines
		set title "Graphique des température par heure"
		set xlabel "Année.mois"
		set ylabel "Température"
		Shadecolor = "#EECF83"
		set autoscale noextend
		set xtics rotate by 45 right
		set xrange [*:*]
		plot "tmp.dat" using 1:2 with lines set linetype 2 lc rgb "sea-green" lw 2 pt 7 notitle' | gnuplot --persist 2>/dev/null
		# xlabel = Année.mois selon l'échelle. En cas de grande échelle, on ne voit pas les mois
	elif [ "${10}" == "-t3" ]
	then
		cut temp2.csv -d" " -f1,2,9 | awk '$1!="£" && $2!="£" && $3!="£" {print $0}' > temp3.csv
		#cut temp2.csv -d" " -f1,9 > temp3.csv
		gcc -o tri tri.c -lm
		chmod u+x -f tri
		#echo "test"
		#./tri -f temp3.csv -o tmp.dat $9 ${10}
		#echo -e '
		#set grid nopolar
		#set grid xtics mxtics ytics mytics noztics nomztics noztics nortics nomrtics nox2tics nomx2tics noy2tics nomy2tics nomcbtics
		#set style data lines
		#set title "Graphique des température selon les stations par horaire"
		#set xlabel "Heure"
		#set ylabel "Température"
		#Shadecolor = "#EECF83"
		#set autoscale noextend
		#set xtics rotated by 90 right
		#set xrange [*:*]
		#plot "tmp.dat" using 1:2:3 with filledcurves fc rgb Shadecolor notitle, "tmp.dat" using 1:4 with lines set linetype 2 lc rgb "sea-green" lw 2 pt 7' | gnuplot --persist 2>/dev/null
		#echo "l'option -t3 n'est pas disponible dans cette version"
	fi
fi

if [ "${11}" != "_" ] # pression
then
	#cut temp2.csv -d" " -f1,2,6 > temp3.csv
	#./tri -f temp3.csv -o tmp.dat $9 ${11}
	#echo 'plot "tmp.dat"' | gnuplot --persist
	if [ "${11}" == "-p1" ]
	then
		cut temp2.csv -d" " -f1,6 | awk '$1!="£" && $2!="£" {print $0}' > temp3.csv
		#cut temp2.csv -d" " -f1,6 > temp3.csv
		gcc -o tri tri.c -lm
		chmod u+x -f tri
		echo "test"
		./tri -f temp3.csv -o tmp.dat $9 ${11}
		echo "test"
		echo -e '
		set grid nopolar
		set grid xtics mxtics ytics mytics noztics nomztics noztics nortics nomrtics nox2tics nomx2tics noy2tics nomy2tics nomcbtics
		set style data lines
		set title "Graphique des pressions par stations"
		set xlabel "Station"
		set ylabel "Pression"
		Shadecolor = "#EECF83"

		set autoscale noextend
		set xrange [*:*]
		set xtics rotated by 90
		plot "tmp.dat" using 1:2:3 with filledcurves fc rgb Shadecolor notitle, "tmp.dat" using 1:4 with lines set linetype 2 lc rgb "sea-green" lw 2 pt 7' | gnuplot --persist 2>/dev/null
	elif [ "${11}" == "-p2" ]
	then
		cut temp2.csv -d" " -f2,6 | awk '$1!="£" && $2!="£" {print $0}' > temp3.csv
		#cut temp2.csv -d" " -f1,6 > temp3.csv
		gcc -o tri tri.c -lm
		chmod u+x -f tri
		./tri -f temp3.csv -o tmp.dat $9 ${11}
		echo -e '
		set grid nopolar
		set grid xtics mxtics ytics mytics noztics nomztics noztics nortics nomrtics nox2tics nomx2tics noy2tics nomy2tics nomcbtics
		set style data lines
		set title "Graphique des pressions par heure"
		set xlabel "Année.mois"
		set ylabel "Pression"
		Shadecolor = "#EECF83"
		set autoscale noextend
		set xtics rotate by 45 right
		set xrange [*:*]
		plot "tmp.dat" using 1:2 with lines set linetype 2 lc rgb "sea-green" lw 2 pt 7 notitle' | gnuplot --persist 2>/dev/null
	elif [ "${11}" == "-p3" ]
	then
		cut temp2.csv -d" " -f1,2,6 | awk '$1!="£" && $2!="£" && $3!="£" {print $0}' > temp3.csv
		#cut temp2.csv -d" " -f1,2,6 > temp3.csv
		gcc -o tri tri.c -lm
		chmod u+x -f tri
		#./tri -f temp3.csv -o tmp.dat $9 ${11}
		#echo -e '
		#set grid nopolar
		#set grid xtics mxtics ytics mytics noztics nomztics noztics nortics nomrtics nox2tics nomx2tics noy2tics nomy2tics nomcbtics
		#set style data lines
		#set title "Graphique des température selon les stations par horaire"
		#set xlabel "Heure"
		#set ylabel "Pression"
		#Shadecolor = "#EECF83"
		#set autoscale noextend
		#set xtics rotated by 90 right
		#set xrange [*:*]
		#plot "tmp.dat" using 1:2:3 with filledcurves fc rgb Shadecolor notitle, "tmp.dat" using 1:4 with lines set linetype 2 lc rgb "sea-green" lw 2 pt 7' | gnuplot --persist 2>/dev/null
		#echo "l'option -p3 n'est pas disponible dans cette version"
	fi
fi

if [ "${12}" != "_" ] # vent
then
	cut temp2.csv -d" " -f1,3,4,7,8 | awk '$1!="£" && $2!="£" && $3!="£" && $4!="£" {print $0}' > temp3.csv
	gcc -o tri tri.c -lm
	chmod u+x -f tri
	./tri -f temp3.csv -o tmp.dat $9 ${12}
	echo -e '
	set xlabel "longitude"
	set ylabel "latitude"
	set title "graphique vectoriel des vents"
	set xtics rotated by 90
	set ytics
	set xrange [*:*]
	set yrange [*:*]
	set autoscale noextend
	plot "tmp.dat" using 2:3:4:5 with vectors arrowstyle 3 notitle' | gnuplot --persist 2>/dev/null
fi

if [ "${13}" != "_" ] # altitude
then
	cut temp2.csv -d" " -f1,7,8,11 | awk '$1!="£" && $2!="£" && $3!="£" && $4!="£" {print $0}' > temp3.csv
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

if [ "${14}" != "_" ] # humidité
then
	# less temp2.csv
	awk -F" " '$1!="£" && $7!="£" && $8!="£" && $5!="£" {print $0} ' temp2.csv  > temp.csv
	awk -F" " '{print $1" "$7" "$8" "$5 }' temp.csv > temp3.csv
	# exit 1
	gcc -o tri tri.c -lm
	chmod u+x -f tri
	./tri -f temp3.csv -o tmp.dat $9 ${14}
	echo -e '
	set xlabel "longitude"
	set ylabel "latitude"
	set title "humiditées maximales par station"
	set view map
	set dgrid3d 100,100,2
	set palette rgbformulae 7,5,15
	unset key
	unset surface
	set pm3d at b
	splot "tmp.dat"' | gnuplot --persist 2>/dev/null
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
# faire un doc pour les limitations
# faire des fonctions dans des .c à part
# faire les images des graphiques
#
#
#
#       A FAIRE SI Y'A LE TEMPS
#
#
# changer ordre alphabetique readme en ordre thematique
# mettre que la date de début pour aller jusqu'au bout
# verifier boucle affichage tableau 70/69 et 0/1
#
#
#
#
