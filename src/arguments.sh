#!/bin/bash

#allowed_arg="-t1 -t2 -t3 -p1 -p2 -p3 -w -h -m -F -G -S -A -O -Q -d --tab --abr --avl -f --help -a -g"

liste_arg=""
erreur_txt=""
erreur_arg=0
next_arg=0
arg_date1=""
arg_date2=""
arg_latitude1=""
arg_latitude2=""
arg_longitude1=""
arg_longitude2=""
arg_t="0"
arg_p="0"
arg_w="0"
arg_h="0"
arg_m="0"
arg_d="0"
arg_f="0"
arg_g="0"
arg_a="0"
arg_lieu="0"
arg_tris="0"
arg_help=0
num0_9='^[0-9]'


test_erreur () { #next_arg erreur_txt
    if [ "$next_arg" != "0" ]
    then
        erreur_arg=1
        if [ "$next_arg" = "fichier" ]
        then
            erreur_txt="$erreur_txt\nerreur : un argument de type $next_arg est attendu après l'option -f"
        elif [ "$next_arg" = "date_de_début_de_relevé" ]
        then
            erreur_txt="$erreur_txt\nerreur : un argument de type $next_arg est attendu après l'option -d"
        elif [ "$next_arg" = "date_de_fin_de_relevé" ]
        then
            erreur_txt="$erreur_txt\nerreur : un argument de type $next_arg est attendu après l'option -d"
        elif [ "$next_arg" = "latitude1" ]
        then
            erreur_txt="$erreur_txt\nerreur : un argument de type $next_arg est attendu après l'option -a"
        elif [ "$next_arg" = "latitude2" ]
        then
            erreur_txt="$erreur_txt\nerreur : un argument de type $next_arg est attendu après l'option -a"
        elif [ "$next_arg" = "longitude1" ]
        then
            erreur_txt="$erreur_txt\nerreur : un argument de type $next_arg est attendu après l'option -g"
        elif [ "$next_arg" = "longitude2" ]
        then
            erreur_txt="$erreur_txt\nerreur : un argument de type $next_arg est attendu après l'option -g"
        fi
    fi
}

nest_pas () {
    for (( i=$2 ; i<=$3 ; i++ ))
    do
        if [ "$i" = "$1" ]
        then
            return 1
        fi
    done
    return 0
}



for k in $@
do
    case $k in
    -t)
        erreur_arg=1
        erreur_txt="$erreur_txt\nerreur : veuillez spécifier le mode associé à l'option -t. Exemple : -t1";;
    -t1)
        test_erreur $next_arg $erreur_txt
        next_arg=0
        if [ "$arg_t" = "0" ] || [ "$arg_t" = "$k" ]
        then
            arg_t="$k"
        else
            erreur_arg=1
            erreur_txt="$erreur_txt\nerreur : l'option -t a déjà été utilisée, impossible d'en ajouter une autre"
        fi;;
    -t2)
        test_erreur $next_arg $erreur_txt
        next_arg=0
        if [ "$arg_t" = "0" ] || [ "$arg_t" = "$k" ]
        then
            arg_t="$k"
        else
            erreur_arg=1
            erreur_txt="$erreur_txt\nerreur : l'option -t a déjà été utilisée, impossible d'en ajouter une autre"
        fi;;
    -t3)
        test_erreur $next_arg $erreur_txt
        next_arg=0
        if [ "$arg_t" = "0" ] || [ "$arg_t" = "$k" ]
        then
            arg_t="$k"
        else
            erreur_arg=1
            erreur_txt="$erreur_txt\nerreur : l'option -t a déjà été utilisée, impossible d'en ajouter une autre"
        fi;;
    -p)
        erreur_arg=1
        erreur_txt="$erreur_txt\nerreur : veuillez spécifier le mode associé à l'option -p. Exemple : -p1";;
    -p1)
        test_erreur $next_arg $erreur_txt
        next_arg=0
        if [ "$arg_p" = "0" ] || [ "$arg_p" = "$k" ]
        then
            arg_p="$k"
        else
            erreur_arg=1
            erreur_txt="$erreur_txt\nerreur : l'option -p a déjà été utilisée, impossible d'en ajouter une autre"
        fi;;
    -p2)
        test_erreur $next_arg $erreur_txt
        next_arg=0
        if [ "$arg_p" = "0" ] || [ "$arg_p" = "$k" ]
        then
            arg_p="$k"
        else
            erreur_arg=1
            erreur_txt="$erreur_txt\nerreur : l'option -p a déjà été utilisée, impossible d'en ajouter une autre"
        fi;;
    -p3)
        test_erreur $next_arg $erreur_txt
        next_arg=0
        if [ "$arg_p" = "0" ] || [ "$arg_p" = "$k" ]
        then
            arg_p="$k"
        else
            erreur_arg=1
            erreur_txt="$erreur_txt\nerreur : l'option -p a déjà été utilisée, impossible d'en ajouter une autre"
        fi;;
    -d)
        test_erreur $next_arg $erreur_txt
        if [ "$arg_d" = "0" ]
        then
            arg_d="$k"
            next_arg=date_de_début_de_relevé
        else
            erreur_arg=1
            erreur_txt="$erreur_txt\nerreur : l'option -d a déjà été utilisée"
        fi;;
    --tab)
        test_erreur $next_arg $erreur_txt
        next_arg=0
        if [ "$arg_tris" = "0" ] || [ "$arg_tris" = "$k" ]
        then
            arg_tris="$k"
        else
            erreur_arg=1
            erreur_txt="$erreur_txt\nerreur : l'option de tri $arg_tris a déjà été utilisée, impossible d'en ajouter une autre"
        fi;;
    --abr)
        test_erreur $next_arg $erreur_txt
        next_arg=0
        if [ "$arg_tris" = "0" ] || [ "$arg_tris" = "$k" ]
        then
            arg_tris="$k"
        else
            erreur_arg=1
            erreur_txt="$erreur_txt\nerreur : l'option de tri $arg_tris a déjà été utilisée, impossible d'en ajouter une autre"
        fi;;
    --avl)
        test_erreur $next_arg $erreur_txt
        next_arg=0
        if [ "$arg_tris" = "0" ] || [ "$arg_tris" = "$k" ]
        then
            arg_tris="$k"
        else
            erreur_arg=1
            erreur_txt="$erreur_txt\nerreur : l'option de tri $arg_tris a déjà été utilisée, impossible d'en ajouter une autre"
        fi;;
    -w)
        test_erreur $next_arg $erreur_txt
        next_arg=0
        arg_w="$k";;
    -h)
        test_erreur $next_arg $erreur_txt
        next_arg=0
        arg_h="$k";;
    -m)
        test_erreur $next_arg $erreur_txt
        next_arg=0
        arg_m="$k";;
    -f)
        test_erreur $next_arg $erreur_txt
        if [ "$arg_f" = "0" ]
        then
            arg_f="$k"
            next_arg=fichier
        else
            erreur_arg="$k"
            erreur_txt="$erreur_txt\nerreur : l'option -f a déjà été utilisée, impossible d'utiliser plusieurs fichiers"
        fi;;
    -F)
        test_erreur $next_arg $erreur_txt
        next_arg=0
        if [ "$arg_lieu" = "0" ] || [ "$arg_lieu" = "$k" ]
        then
            arg_lieu="$k"
        else
            erreur_arg=1
            erreur_txt="$erreur_txt\nerreur : l'option de lieu $arg_lieu a déjà été utilisée, impossible d'ajouter l'option $k"
        fi;;
    -G)
        test_erreur $next_arg $erreur_txt
        if [ "$arg_lieu" = "0" ] || [ "$arg_lieu" = "$k" ]
        then
            arg_lieu="$k"
        else
            erreur_arg=1
            erreur_txt="$erreur_txt\nerreur : l'option de lieu $arg_lieu a déjà été utilisée, impossible d'ajouter l'option $k"
        fi;;
    -S)
        test_erreur $next_arg $erreur_txt
        if [ "$arg_lieu" = "0" ] || [ "$arg_lieu" = "$k" ]
        then
            arg_lieu="$k"
        else
            erreur_arg=1
            erreur_txt="$erreur_txt\nerreur : l'option de lieu $arg_lieu a déjà été utilisée, impossible d'ajouter l'option $k"
        fi;;
    -A)
        test_erreur $next_arg $erreur_txt
        if [ "$arg_lieu" = "0" ] || [ "$arg_lieu" = "$k" ]
        then
            arg_lieu="$k"
        else
            erreur_arg=1
            erreur_txt="$erreur_txt\nerreur : l'option de lieu $arg_lieu a déjà été utilisée, impossible d'ajouter l'option $k"
        fi;;
    -O)
        test_erreur $next_arg $erreur_txt
        if [ "$arg_lieu" = "0" ] || [ "$arg_lieu" = "$k" ]
        then
            arg_lieu="$k"
        else
            erreur_arg=1
            erreur_txt="$erreur_txt\nerreur : l'option de lieu $arg_lieu a déjà été utilisée, impossible d'ajouter l'option $k"
        fi;;
    -Q)
        test_erreur $next_arg $erreur_txt
        if [ "$arg_lieu" = "0" ] || [ "$arg_lieu" = "$k" ]
        then
            arg_lieu="$k"
        else
            erreur_arg=1
            erreur_txt="$erreur_txt\nerreur : l'option de lieu $arg_lieu a déjà été utilisée, impossible d'ajouter l'option $k"
        fi;;
    -a)
        test_erreur $next_arg $erreur_txt
        if [ "$arg_lieu" = "0" ]
        then
            arg_lieu="$k"
            next_arg="latitude1"
        elif [ "$arg_lieu" = "-g" ]
        then
            arg_lieu="$arg_lieu$k"
            next_arg="latitude1"
        else
            erreur_arg=1
            erreur_txt="$erreur_txt\nerreur : l'option de lieu $arg_lieu a déjà été utilisée, impossible d'ajouter l'option $k"
        fi;;
    -g)
        test_erreur $next_arg $erreur_txt
        if [ "$arg_lieu" = "0" ]
        then
            arg_lieu="$k"
            next_arg="longitude1"
        elif [ "$arg_lieu" = "-a" ]
        then
            arg_lieu="$arg_lieu$k"
            next_arg="longitude1"
        else
            erreur_arg=1
            erreur_txt="$erreur_txt\nerreur : l'option de lieu $arg_lieu a déjà été utilisée, impossible d'ajouter l'option $k"
        fi;;
    --help)
        test_erreur $next_arg $erreur_txt
        next_arg=0
        arg_help=1;;
    *)
        if [ "$next_arg" = "date_de_début_de_relevé" ]
        then
            arg_date1="$k"
            next_arg=date_de_fin_de_relevé
        elif [ "$next_arg" = "date_de_fin_de_relevé" ]
        then
            arg_date2="$k"
            next_arg=0
        elif [ "$next_arg" = "fichier" ]
        then
            if [ -e $k ] && [ -f $k ]
            then
                test_ext=`echo "$k" | tail -c5`
                if [ "$test_ext" = ".csv" ]
                then
                    arg_doc="$k"
                    next_arg=0
                else
                    erreur_arg="1"
                    next_arg=0
                    erreur_txt="$erreur_txt\nerreur : le fichier \"$k\" n'est pas compatible. Le fichier attendu porte l'extention .csv"
                fi
            else
                erreur_arg="1"
                next_arg=0
                erreur_txt="$erreur_txt\nerreur : aucun fichier nommé \"$k\" n'a été trouvé"
            fi
        elif [ "$next_arg" = "latitude1" ]
        then
            arg_latitude1="$k"
            next_arg="latitude2"
        elif [ "$next_arg" = "latitude2" ]
        then
            arg_latitude2="$k"
            next_arg=0
        elif [ "$next_arg" = "longitude1" ]
        then
            arg_longitude1="$k"
            next_arg="longitude2"
        elif [ "$next_arg" = "longitude2" ]
        then
            arg_longitude2="$k"
            next_arg=0
        else
            erreur_arg="1"
            erreur_txt="$erreur_txt\nerreur : l'option $k n'est pas reconnue"
            next_arg=0
        fi
    esac

    #echo "$k"
    
done


###################### vérification de fin deboucle ########################################


#### erreur fichier

test_erreur $next_arg $erreur_txt

if [ "$arg_f" = "0" ]
then
    erreur_txt="$erreur_txt\nerreur : aucun fichier spécifié, l'argument -f est nécéssaire"
    erreur_arg=1
fi


#### erreur argument manquant

if [ "$arg_t" = "0" ] && [ "$arg_p" = "0" ] && [ "$arg_m" = "0" ] && [ "$arg_h" = "0" ] && [ "$arg_w" = "0" ]
then
    erreur_txt="$erreur_txt\nerreur : aucun type de donné à analyser spécifié, vous devez utiliser au moins une des options suivantes : -t -p -m -h -w"
    erreur_arg=1
fi


#### erreur format de date

if [ "$arg_d" != "0" ]
then
    if  [ ${#arg_date1} -ne 10 ]
    then
        erreur_txt="$erreur_txt\nerreur : la date de début n'a pas le bon format"
        erreur_arg=1
    elif nest_pas ${arg_date1:0:1} 0 2  || nest_pas ${arg_date1:1:1} 0 9 || nest_pas ${arg_date1:2:1} 0 9 || nest_pas ${arg_date1:3:1} 0 9 || [ "${arg_date1:4:1}" != "-" ] || nest_pas ${arg_date1:5:1} 0 1 || nest_pas ${arg_date1:6:1} 0 9 || [ "${arg_date1:7:1}" != "-" ] || nest_pas ${arg_date1:8:1} 0 3 || nest_pas ${arg_date1:9:1} 0 9
    then
        erreur_txt="$erreur_txt\nerreur : la date de début n'a pas le bon format"
        erreur_arg=1
    elif [ "${arg_date1:8:1}" = "3" ] && ! nest_pas ${arg_date1:9:1} 2 9
    then
        erreur_txt="$erreur_txt\nerreur : la date de début n'a pas le bon format"
        erreur_arg=1
    elif [ "${arg_date1:5:1}" = "1" ] && ! nest_pas ${arg_date1:6:1} 3 9
    then
        erreur_txt="$erreur_txt\nerreur : la date de début n'a pas le bon format"
        erreur_arg=1
    fi

    if  [ ${#arg_date2} -ne 10 ]
    then
        erreur_txt="$erreur_txt\nerreur : la date de fin n'a pas le bon format"
        erreur_arg=1
    elif nest_pas ${arg_date2:0:1} 0 2  || nest_pas ${arg_date2:1:1} 0 9 || nest_pas ${arg_date2:2:1} 0 9 || nest_pas ${arg_date2:3:1} 0 9 || [ "${arg_date2:4:1}" != "-" ] || nest_pas ${arg_date2:5:1} 0 1 || nest_pas ${arg_date2:6:1} 0 9 || [ "${arg_date2:7:1}" != "-" ] || nest_pas ${arg_date2:8:1} 0 3 || nest_pas ${arg_date2:9:1} 0 9
    then
        erreur_txt="$erreur_txt\nerreur : la date de fin n'a pas le bon format"
        erreur_arg=1
    elif [ "${arg_date2:8:1}" = "3" ] && ! nest_pas ${arg_date2:9:1} 2 9
    then
        erreur_txt="$erreur_txt\nerreur : la date de fin n'a pas le bon format"
        erreur_arg=1
    elif [ "${arg_date2:5:1}" = "1" ] && ! nest_pas ${arg_date2:6:1} 3 9
    then
        erreur_txt="$erreur_txt\nerreur : la date de fin n'a pas le bon format"
        erreur_arg=1
    fi
fi

#### erreur format de latitude et longitude


reel='^[-]?[0-9]+([.][0-9]+)?$'

if [ "$arg_lieu" = "-a" ]
then
    if ! [[ $arg_latitude1 =~ $reel ]]
    then
        erreur_txt="$erreur_txt\nerreur : la première latitude n'a pas le bon format"
        erreur_arg=1
    fi

    if ! [[ $arg_latitude2 =~ $reel ]]
    then
        erreur_txt="$erreur_txt\nerreur : la deuxième latitude n'a pas le bon format"
        erreur_arg=1
    fi
fi
if [ "$arg_lieu" = "-g" ]
then
    if ! [[ $arg_longitude1 =~ $reel ]]
    then
        erreur_txt="$erreur_txt\nerreur : la première longitude n'a pas le bon format"
        erreur_arg=1
    fi

    if ! [[ $arg_longitude2 =~ $reel ]]
    then
        erreur_txt="$erreur_txt\nerreur : la deuxième longitude n'a pas le bon format"
        erreur_arg=1
    fi
fi
if [ "$arg_lieu" = "-a-g" ] || [ "$arg_lieu" = "-g-a" ]
then
    if ! [[ $arg_longitude1 =~ $reel ]]
    then
        erreur_txt="$erreur_txt\nerreur : la première longitude n'a pas le bon format"
        erreur_arg=1
    fi
    if ! [[ $arg_longitude2 =~ $reel ]]
    then
        erreur_txt="$erreur_txt\nerreur : la deuxième longitude n'a pas le bon format"
        erreur_arg=1
    fi

    if ! [[ $arg_latitude1 =~ $reel ]]
    then
        erreur_txt="$erreur_txt\nerreur : la première latitude n'a pas le bon format"
        erreur_arg=1
    fi
    if ! [[ $arg_latitude2 =~ $reel ]]
    then
        erreur_txt="$erreur_txt\nerreur : la deuxième latitude n'a pas le bon format"
        erreur_arg=1
    fi
fi



# peut on utiliser en même temps -t1 -t2 et -t3 ?



########################### appel des fichiers appropriés ###################################################


if [ $erreur_arg -eq 1 ] && [ $arg_help -eq 0 ]
then
    #echo "pas ok"
    echo -e "\033[31m$erreur_txt"
    echo -e "\x1B[0m\nPour afficher l'aide, utilisez l'option --help, ou consultez le readme : \033[34mhttps://github.com/na-teag/CY-meteo/blob/main/README.md \x1B[0m"
    exit 1
elif [ $arg_help -eq 1 ]
then
    less help.txt
else
    bash filtre.sh $arg_doc $arg_lieu $arg_latitude1 $arg_latitude2 $arg_longitude1 $arg_longitude2 $arg_date1 $arg_date2 $arg_tris $arg_t $arg_p $arg_w $arg_h $arg_m 
fi