#include <stdio.h>
#include <math.h>
#include <unistd.h>
#include <time.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>
#include <sys/time.h>
#include <math.h>



typedef struct stockage{
	int id;
	int donnee;
	int donnee2;
	int moyenne;
	float min;
	float max;
	float moyenne2;
	float latitude;
	float longitude;

}Stockage;

typedef struct arbre{
	Stockage stockage;
	int equilibre;
	struct arbre* filsG;
	struct arbre* filsD;
	struct arbre* autre;
}Arbre;

#define Parbre Arbre*

unsigned long getTimeMicroSec();
void affArbreGraphique(Parbre a, int info);
char* add(char tab[], char tab2[]);
int max(int a, int b);
int min(int a, int b);
float convertir(char* chaine);
void croissant(float *nbr1, float *nbr2);
int recherche(Stockage tab[], int droite, int gauche, int element);
Stockage* fscan(FILE* fichier, Stockage* stockage);
void triRapide(Stockage tab[], int taille, int colonne);
void rapideRec(Stockage tab[], int taille, int debut, int fin, int colonne);
int partition(Stockage tab[], int taille, int debut, int fin, int colonne);
void init(Stockage tab[]);
Parbre CreerArbre(Stockage stockage);
Parbre recherche_arbre(Parbre arbre, int nbr, int mode);
Parbre insertionAVL(Parbre arbre, Stockage stockage, int* h, int mode);
void suppr_arbre(Parbre arbre);
Parbre rotG(Parbre arbre);
Parbre rotD(Parbre arbre);
Parbre double_rotG(Parbre arbre);
Parbre double_rotD(Parbre arbre);
Parbre equilibrage(Parbre arbre);
void parcours(FILE* fichier, Parbre arbre, int mode);
void parcours_remplir(Parbre arbre, Parbre ancien, int *h);
Parbre insertionABR(Parbre arbre, Stockage stockage, int mode);