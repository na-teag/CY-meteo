if [ "${10}" = "-t1" ] || [ "${10}" = "-t3" ] || [ "${11}" = "-p1" ] || [ "${11}" = "-p3" ] || [ "${12}" != "_" ] || [ "${13}" = "_" ] || [ "${14}" = "_" ]
then
	if [ "$variable" = "" ]
	then
		variable="1"
	else
		variable="1,$variable"
	fi
	nbr_colonne=$((nbr_colonne+1))
fi

if [ "${10}" = "-t2" ] || [ "${10}" = "-t3" ] || [ "${11}" = "-p2" ] || [ "${11}" = "-p3" ] || [ "$7" != "_" ]
then
	if [ "$variable" = "" ]
	then
		variable="2"
	else
		variable="2,$variable"
	fi
	nbr_colonne=$((nbr_colonne+1))
fi

if [ "${12}" = "-w" ]
then
	if [ "$variable" = "" ]
	then
		variable="4,5"
	else
		variable="4,5,$variable"
	fi
	nbr_colonne=$((nbr_colonne+2))
fi

if [ "${14}" = "-m" ]
then
	if [ "$variable" = "" ]
	then
		variable="6"
	else
		variable="6,$variable"
	fi
	nbr_colonne=$((nbr_colonne+1))
fi

if [ "${11}" != "_" ]
then
	if [ "$variable" = "" ]
	then
		variable="7"
	else
		variable="7,$variable"
	fi
	nbr_colonne=$((nbr_colonne+1))
fi

if [ "$2" != "_" ]
then
	if [ "$variable" = "" ]
	then
		variable="10"
	else
		variable="10,$variable"
	fi
	nbr_colonne=$((nbr_colonne+1))
fi

if [ "${10}" != "_" ]
then
	if [ "$variable" = "" ]
	then
		variable="11"
	else
		variable="11,$variable"
	fi
	nbr_colonne=$((nbr_colonne+1))
fi

if [ "${13}" != "_" ]
then
	if [ "$variable" = "" ]
	then
		variable="14"
	else
		variable="14,$variable"
	fi
	nbr_colonne=$((nbr_colonne+1))
fi