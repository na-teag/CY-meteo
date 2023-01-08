#include <stdio.h>
#include <math.h>
#include <unistd.h>
#include <time.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>
#include <sys/time.h>
#define NBR_COLONNE 9

typedef struct station{ // structure pour l'option -t1
	float id;
	float somme_tot;
	int compteur;
	float temperature_min;
	float temperature_max;
	struct station* filsG;
	struct station* filsD;
}Station;



unsigned long getTimeMicroSec();
char* add(char tab[], char tab2[]);
int suppr_lignes(FILE* fichier, FILE* fichier2, char* type_lieu, char* lat1_char, char* lat2_char, char* long1_char, char* long2_char);
float convertir(char* chaine);
void croissant(float *nbr1, float *nbr2);
Station* creerStation();