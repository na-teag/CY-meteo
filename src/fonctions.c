#include "header.h"

unsigned long getTimeMicroSec(){
	struct timeval tv;
	gettimeofday(&tv, NULL);
	return (1000000 * tv.tv_sec) + tv.tv_usec;
}

char* add(char tab[], char tab2[]){
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

int max(int a, int b){
	if(a<b){
		return b;
	}
	return a;
}

int min(int a, int b){
	if(a<b){
		return a;
	}
	return b;
}


float convertir(char* chaine){
	char* ptr;
	float val=strtof(chaine, &ptr);
	if(strcmp(chaine, ptr) == 0){
		exit(10);
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

Stockage* fscan(FILE* fichier, Stockage* stockage){
	int test, lettre;
	do{
		test=0;
		fscanf(fichier, "%d %f %f", &stockage->id, &stockage->latitude, &stockage->longitude);
		fgetc(fichier);
		lettre = fgetc(fichier); // dans le fichier, certain relevé d'humidité n'ont aucunes valeurs, dans ce cas il faut passer à la ligne suivante
		fseek(fichier, -1, 1);
		while(!('0' <= lettre && lettre <= '9')){
			lettre = fgetc(fichier);
			test=1;
		}
		if(test==1){
			fseek(fichier, -1, 1);
		}
	}while(test!=0);
	fscanf(fichier, "%d\n", &stockage->donnee);
}


int partition(Stockage tab[], int taille, int debut, int fin, int colonne){
    int pivot;
    int i=debut-1;
    Stockage temp;
	if(colonne == 1){
		pivot=tab[fin].id;
		for(int j=debut; j<= fin-1; j++){
			if(tab[j].id <= pivot){
				i++;
				temp=tab[i];
				tab[i]=tab[j];
				tab[j]=temp;
			}
		}
	}else{
		pivot=tab[fin].donnee;
		for(int j=debut; j<= fin-1; j++){
			if(tab[j].donnee <= pivot){
				i++;
				temp=tab[i];
				tab[i]=tab[j];
				tab[j]=temp;
			}
		}
	}
	temp=tab[i+1];
	tab[i+1]=tab[fin];
	tab[fin]=temp;
	return i+1;
}

void rapideRec(Stockage tab[], int taille, int debut, int fin, int colonne){
    int pivot;
    if(debut < fin ){
        pivot = partition(tab, taille, debut, fin, colonne);
        rapideRec(tab, taille, debut, pivot-1, colonne);
        rapideRec(tab, taille, pivot+1, fin, colonne);
    }
}


void triRapide(Stockage tab[], int taille, int colonne){
    rapideRec(tab, taille, 0, taille, colonne);
}

//int taille_tab(void tab){
//	return sizeof(tab)/sizeof(tab[0]);
//}

int recherche(Stockage tab[], int droite, int gauche, int element){
	if(gauche >= droite){
		int millieu = droite+(gauche-droite)/2;
		if(tab[millieu].id == element){
			//printf("test\n");
			return millieu;
		}
		if(tab[millieu].id > element){
			return recherche(tab, droite, millieu-1, element);
		}
		return recherche(tab, millieu+1, gauche, element);
	}
	return -1;
}

void init(Stockage tab[]){
	for(int i=0; i < 70; i++){
		tab[i].id = -1;
		tab[i].donnee = -1;
		tab[i].latitude = -1;
		tab[i].longitude = -1;
	}
}





Parbre CreerArbre(Stockage stockage){
	Parbre arbre =  malloc(sizeof(Arbre));
	arbre->stockage.id = stockage.id;
	arbre->stockage.donnee = stockage.donnee;
	arbre->stockage.longitude = stockage.longitude;
	arbre->stockage.latitude = stockage.latitude;
	arbre->filsD = NULL;
	arbre->filsG = NULL;
	arbre->equilibre = 0;
	return arbre;
}


Parbre recherche_arbre(Parbre arbre, int nbr, int mode){
	if(mode==1){
		if(arbre == NULL){
			return NULL;
		}else if(arbre->stockage.id == nbr){
			return arbre;
		}else if(nbr < arbre->stockage.id){
			return recherche_arbre(arbre->filsG, nbr, mode);
		}else{
			return recherche_arbre(arbre->filsD, nbr, mode);
		}
	}else{
		if(arbre == NULL){
			return NULL;
		}else if(arbre->stockage.donnee == nbr){
			return arbre;
		}else if(nbr < arbre->stockage.donnee){
			return recherche_arbre(arbre->filsG, nbr, mode);
		}else{
			return recherche_arbre(arbre->filsD, nbr, mode);
		}
	}
}
	


Parbre insertionAVL(Parbre arbre, Stockage stockage, int* h, int mode){
	if(mode == 1){
		if(arbre == NULL){
			*h=1;
			return CreerArbre(stockage);
		}else if(stockage.id < arbre->stockage.id){
			arbre->filsG = insertionAVL(arbre->filsG, stockage, h, mode);
			*h = -*h;
		}else if(stockage.id > arbre->stockage.id){
			arbre->filsD = insertionAVL(arbre->filsD, stockage, h, mode);
		}else{
			*h=0;
			return arbre;
		}
	}else if(mode == 2){
		if(arbre == NULL){
			*h=1;
			return CreerArbre(stockage);
		}else if(stockage.donnee < arbre->stockage.donnee){
			arbre->filsG = insertionAVL(arbre->filsG, stockage, h, mode);
			*h = -*h;
		}else if(stockage.donnee > arbre->stockage.donnee){
			arbre->filsD = insertionAVL(arbre->filsD, stockage, h, mode);
		}else{
			*h=0;
			return arbre;
		}
	}
	if(*h != 0){
		arbre->equilibre = arbre->equilibre + *h;
		arbre = equilibrage(arbre);
		if(arbre->equilibre == 0){
			*h = 0;
		}else{
			*h=1;
		}
	}
	return arbre;
}
/*
void suppr_arbre_autre(Parbre arbre){
	if(arbre->autre!=NULL){
		suppr_arbre_autre(arbre->autre);
	}
	free(arbre);
}*/

void suppr_arbre(Parbre arbre){
	if(arbre==NULL){
		return;
	}
	if(arbre->filsD != NULL){
		suppr_arbre(arbre->filsD);
	}
	if(arbre->filsG != NULL){
		suppr_arbre(arbre->filsG);
	}
	if(arbre->autre != NULL){
		suppr_arbre(arbre->autre);
	}
	free(arbre);
}


Parbre rotG(Parbre arbre){
	int eq_a, eq_p;
	Parbre pivot = arbre->filsD;
	arbre->filsD = pivot->filsG;
	pivot->filsG = arbre;
	eq_a = arbre->equilibre;
	eq_p = pivot->equilibre;
	arbre->equilibre = eq_a - max(eq_p, 0) -1;
	pivot->equilibre = min(eq_a-2, min(eq_a+eq_p-2, eq_p-1));
	arbre = pivot;
	return arbre;
}

Parbre rotD(Parbre arbre){
	int eq_a, eq_p;
	Parbre pivot = arbre->filsG;
	arbre->filsG = pivot->filsD ;
	pivot->filsD= arbre;
	eq_a = arbre->equilibre;
	eq_p = pivot->equilibre;
	arbre->equilibre = eq_a-min(eq_p, 0)+1;
	pivot->equilibre = max(eq_a+2, max(eq_a+eq_p+2, eq_p+1));
	arbre = pivot;
	return arbre;
}

Parbre double_rotG(Parbre arbre){
	arbre->filsD = rotD(arbre->filsD);
	return rotG(arbre);
}

Parbre double_rotD(Parbre arbre){
	arbre->filsG = rotG(arbre->filsG);
	return rotD(arbre);
}

Parbre equilibrage(Parbre arbre){
	if(arbre->equilibre >= 2){
		if(arbre->filsD->equilibre >= 0){
			return rotG(arbre);
		}else{
			return double_rotG(arbre);
		}
	}else if(arbre->equilibre <= -2){
		if(arbre->filsG->equilibre <= 0){
			return rotD(arbre);
		}else{
			return double_rotD(arbre);
		}
	}
	return arbre;
}


void parcours(FILE* fichier, Parbre arbre){
	if(arbre != NULL){
		parcours(fichier, arbre->filsD);
		fprintf(fichier, "%f\t%f\t%d\n", arbre->stockage.longitude, arbre->stockage.latitude, arbre->stockage.donnee);
		parcours(fichier, arbre->autre);
		parcours(fichier, arbre->filsG);
	}
}

Parbre autre(Parbre arbre){
	if(arbre->autre!=NULL){
		return autre(arbre->autre);
	}
	return arbre;
}



Parbre insertionABR(Parbre arbre, Stockage stockage, int mode){
	if(mode == 1){
		if(arbre == NULL){
			return CreerArbre(stockage);
		}else if(stockage.id < arbre->stockage.id){
			arbre->filsG = insertionABR(arbre->filsG, stockage, mode);
		}else if(stockage.id > arbre->stockage.id){
			arbre->filsD = insertionABR(arbre->filsD, stockage, mode);
		}
		return arbre;
	}else{
		if(arbre == NULL){
			return CreerArbre(stockage);
		}else if(stockage.donnee < arbre->stockage.donnee){
			arbre->filsG = insertionABR(arbre->filsG, stockage, mode);
		}else if(stockage.donnee > arbre->stockage.donnee){
			arbre->filsD = insertionABR(arbre->filsD, stockage, mode);
		}else if(stockage.donnee = arbre->stockage.donnee && stockage.id != arbre->stockage.id){
			arbre->autre = insertionABR(arbre->autre, stockage, mode);
		}
		return arbre;
	}
}






































































































































































typedef struct {
int elmt;
int info;
} TArbBin;

int hauteur(Parbre a){
if (a==NULL) return -1;return 1 + max(hauteur(a->filsG), hauteur(a->filsD));
}

void ABVersTabRec(Parbre a, int pos, TArbBin *T, int info){
if (a!=NULL){
T[pos].elmt = a->stockage.donnee;
T[pos].info = (info ? a->equilibre : hauteur(a));
ABVersTabRec(a->filsG, 2 * pos + 1, T, info);
ABVersTabRec(a->filsD, 2 * pos + 2, T, info);
}}

TArbBin* ABVersTab(Parbre a, int info){
TArbBin *T;
if (a==NULL) return NULL;
if ((T = (TArbBin *) calloc((int) pow(2, hauteur(a) + 1) - 1, sizeof(TArbBin))) ==
NULL){
puts("Erreur allocation Arbre vers Tableau");
exit(1);
}
ABVersTabRec(a, 0, T, info);
return T;
}

void affArbreGraphique(Parbre a, int info){
TArbBin *Tarb;
int iTarb;
int tailleAff = 7; // noeud=" xx,xx "
int largeur; // largeur d'affichage maximum
int h;
int nbNoeuds;
int p, i, j;
int ecart;puts("");
if (a==NULL){
puts("Arbre vide");
return;
}
h = hauteur(a);
largeur = tailleAff * ((int) pow(2, h)); // taille element * nbFeuillesMax;
Tarb = ABVersTab(a, info);
iTarb = 0;
for (p = 0, nbNoeuds = 1; p <= h; p++, nbNoeuds *= 2){
// p = profondeur, nbNoeuds par niveau
ecart = (largeur / (nbNoeuds * 2));
for (j = 1; j <= nbNoeuds; j++){
for (i = 0; i < ecart - 3; i++) putchar(' '); // -3 car 3 caracteres, avant milieu
if (Tarb[iTarb].elmt == 0)
printf(" ..... ");
else
printf(" %2d,%+1d ", Tarb[iTarb].elmt, Tarb[iTarb].info);//printf(" %2d    ", Tarb[iTarb].elmt);
iTarb++;
if (j < nbNoeuds && p < h) // entre 2 noeuds sauf au dernier niveau
for (i = 0; i < ecart - 4; i++) putchar(' '); // -4 car 4 caracteres apres milieu
}
puts("");
}
free(Tarb);
puts("");
}