#include "fonctions.c"



int main(int argc, char *argv[]){


	int arg_lieu=0;
	int arg_fich_in=0;
	int arg_fich_out=0;
	int arg_sens=0;
	int arg_tri=0;
	float c;
	int test=0;

// partie paramètres

	if(argc != 4){
		exit(1);
	}

// partie fichier

	FILE* fichier = NULL;
	char chemin[] = {"../src/"};              
	char* chemin_fichier = add(chemin, argv[1]);
	fichier = fopen(chemin_fichier, "r");
	if(fichier == NULL){
		printf("\n%s dans %s, erreur %d : %s \n\n", argv[1], chemin_fichier, errno, strerror(errno));
		exit(2);
	}

	FILE* fichier2 = NULL;
	char chemin2[] = {"../src/"};              
	char* chemin_fichier2 = add(chemin2, argv[2]);
	fichier2 = fopen(chemin_fichier2, "w");
	if(fichier2 == NULL){
		printf("\n%s dans %s, erreur %d : %s \n\n", argv[2], chemin_fichier2, errno, strerror(errno));
		exit(3);
	}
// TABLEAU

int tab[70][2];


	
// ARBRE

	fscanf(fichier, "%f", &c);
		
	while(!feof(fichier) || test != 0){ // si la fin du fichier n'est pas atteinte (à faire après chaque scanf)
		station->id  = c;
		fseek(fichier, 1, 1);
		fscanf(fichier, "%f", &c);
		if(feof(fichier)){
			break;
		}
		station->temperature_max = c;
		fscanf(fichier, "%f", &c);
		if(feof(fichier)){// même si apres c'est la fin de la boucle, on fait un test pour ne pas créer un chainon pour rien
			break;
		}
		station->filsG = creerStation();
		station = station->filsG;
	}

	station = debut;
	while(station != NULL){
		printf("%.0f;%f\n", station->id, station->temperature_max);
		station = station->filsG;
	}
*/
	//free
	fclose(fichier);
	fclose(fichier2);
	return 0;
}