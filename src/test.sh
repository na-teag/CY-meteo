
arg_lieu="-a"
arg_latitude1=$1
arg_latitude2=$2
erreur_txt=""



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

if [ $erreur_arg -eq 1 ]
then
    #echo "pas ok"
    echo -e "\033[31m$erreur_txt"
    echo -e "\x1B[0m\nPour afficher l'aide, utilisez l'option --help, ou consultez le readme : \033[34mhttps://github.com/na-teag/CY-meteo/blob/main/README.md \x1B[0m"
    exit 1
fi