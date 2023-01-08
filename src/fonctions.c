#include "header.h"

unsigned long getTimeMicroSec(){// get the time
	struct timeval tv;
	gettimeofday(&tv, NULL);
	return (1000000 * tv.tv_sec) + tv.tv_usec;
}

char* add(char tab[], char tab2[]){ // put two character strings together
	char* tab3 = NULL;
	tab3 = malloc(strlen(tab)*sizeof(char)+strlen(tab2)*sizeof(char)+1);
	if(tab3 == NULL){
		printf("erreur d'allocution");
		exit(1);
	}
	for(int i=0; i<strlen(tab); i++){
		tab3[i] = tab[i];
	}
	for(int i=0; i<strlen(tab2); i++){
		tab3[i+strlen(tab)] = tab2[i];
	}
	tab3[strlen(tab)+strlen(tab2)+1] = '\0';
	return tab3;
}

Station* creerStation(){
	Station *station = malloc(sizeof(Station));
	if(station == NULL){
		printf("erreur d'allocution");
		exit(1);
	}
	station->filsG = NULL;
	station->filsD = NULL;
	return station;
}

float convertir(char* chaine){
	char* ptr;
	float val=strtof(chaine, &ptr);
	if(strcmp(chaine, ptr) == 0){
		exit(1);
	}
	return val;
}

void croissant(float *nbr1, float *nbr2){
	if(*nbr2 < *nbr1){
		int nbr3=*nbr1;
		*nbr1 = *nbr2;
		*nbr2 = nbr3;
	}
}