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
arg_t=0
arg_p=0
arg_w=0
arg_h=0
arg_m=0
arg_d=0
arg_f=0
arg_g=0
arg_a=0
arg_lieu=0
arg_tris=0
arg_help=0


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
        if [ $arg_d -eq 0 ]
        then
            arg_d=1
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
        arg_w=1;;
    -h)
        test_erreur $next_arg $erreur_txt
        next_arg=0
        arg_h=1;;
    -m)
        test_erreur $next_arg $erreur_txt
        next_arg=0
        arg_m=1;;
    -f)
        test_erreur $next_arg $erreur_txt
        if [ $arg_f -eq 0 ]
        then
            arg_f=1
            next_arg=fichier
        else
            erreur_arg=1
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

test_erreur $next_arg $erreur_txt

if [ "$arg_f" = "0" ]
then
    erreur_txt="$erreur_txt\nerreur : aucun fichier spécifié, l'argument -f est nécéssaire"
    erreur_arg=1
fi

if [ "$arg_t" = "0" ] && [ "$arg_p" = "0" ] && [ $arg_m -eq 0 ] && [ $arg_h -eq 0 ] && [ $arg_w -eq 0 ]
then
    erreur_txt="$erreur_txt\nerreur : aucun type de donné à analyser spécifié, vous devez utiliser au moins une des options suivantes : -t -p -m -h -w"
    erreur_arg=1
fi


# la date est elle au bon format ?

# latitudes et longitudes sont elle ok ?

# fcommentaire et nom de variable en anglais = plus de points ?



########################### appel des fichiers appropriés ###################################################


if [ $erreur_arg -eq 1 ] && [ $arg_help -eq 0 ]
then
    #echo "pas ok"
    echo -e "\033[31m$erreur_txt"
    echo -e "\033[30m \nPour afficher l'aide, utilisez l'option --help, ou consultez le readme : \033[34mhttps://github.com/na-teag/"
    exit 1
elif [ $arg_help -eq 1 ]
then
    bash help.sh
else
    bash filtre.sh $arg_doc $arg_t $arg_p $arg_w $arg_h $arg_m $arg_lieu $arg_latitude1 $arg_latitude2 $arg_longitude1 $arg_longitude2 $arg_date1 $arg_date2 $arg_tris
fi