#include <stdio.h>
#include <math.h>
#include <unistd.h>
#include <time.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>
#include <sys/time.h>
#include <math.h>



typedef struct station{ // structure pour l'option -t1
	float id;
	float somme_tot;
	int compteur;
	float temperature_min;
	float temperature_max;
	struct station* filsG;
	struct station* filsD;
}Station;

typedef struct stockage{
	int id;
	int donnee;
}Stockage;

typedef struct arbre{
	int id;
	int donnee;
	int equilibre;
	struct arbre* filsG;
	struct arbre* filsD;
}Arbre;

#define Parbre Arbre*

unsigned long getTimeMicroSec();
char* add(char tab[], char tab2[]);
int max(int a, int b);
int min(int a, int b);
float convertir(char* chaine);
void croissant(float *nbr1, float *nbr2);
Station* creerStation();
int recherche(Stockage tab[], int droite, int gauche, int element);
void triRapide(Stockage tab[], int taille, int colonne);
void rapideRec(Stockage tab[], int taille, int debut, int fin, int colonne);
int partition(Stockage tab[], int taille, int debut, int fin, int colonne);
void init(Stockage tab[]);
Parbre CreerArbre(int id, int donnee);
Parbre recherche_arbre(Parbre arbre, int id);
Parbre insertionAVL(Parbre arbre, int id, int donnee, int* h);
void suppr_arbre(Parbre arbre);
Parbre rotG(Parbre arbre);
Parbre rotD(Parbre arbre);
Parbre double_rotG(Parbre arbre);
Parbre double_rotD(Parbre arbre);
Parbre equilibrage(Parbre arbre);
