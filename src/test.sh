#!/bin/bash

compare(){
	gcc -o compare compare.c
	./compare $1 $2 #awk -v n1="$1" -v n2="$2" 'BEGIN {printf (n1<=n2?"1":"0") }' # est ce que $1 <= $2 ?
	return $?
}

if [ ! ` compare $1 $2 ` ]
then
    echo "oui"
else
    echo "non"
fi