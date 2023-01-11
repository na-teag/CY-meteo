#include "fonctions.c"



int main(int argc, char *argv[]){


	int arg_lieu=0;
	int arg_fich_in=0;
	int arg_fich_out=0;
	int arg_sens=0;
	int arg_tri=0;
	float c;
	int test=0;




// verification des arguments

	int suivant=0;
	for(int i=1; i<argc; i++){
		if(strcmp(argv[i], "-l") == 0){
			arg_lieu=i;
		}
		if(strcmp(argv[i], "-f") == 0){
			arg_fich_in=i;
		}
		if(strcmp(argv[i], "-o") == 0){
			arg_fich_out=i;
		}
		if(strcmp(argv[i], "-r") == 0){
			arg_sens=1;
		}
		if(strcmp(argv[i], "--avl") == 0){
			arg_tri=1;
		}
		if(strcmp(argv[i], "--abr") == 0){
			arg_tri=2;
		}
		if(strcmp(argv[i], "--tab") == 0){
			arg_tri=3;
		}
	}

	if(arg_fich_in == 0 || arg_fich_out == 0 || arg_tri == 0){
		exit(1);
	}
	if(arg_sens != 0){
		test=1;
	}
	if(arg_lieu != 0){
		if(test+12 != argc){
			exit(1);
		}
	}else{
		if(test+7 != argc){
			exit(1);
		}

	}
	test=0;
	



// partie fichier

	FILE* fichier = NULL;
	//char nom_fichier[] = argv[arg_fich_in+1];
	char chemin[] = {"../src/"};              
	char* chemin_fichier = add(chemin, argv[arg_fich_in+1]);
	fichier = fopen(chemin_fichier, "r");
	if(fichier == NULL){
		printf("\n%s dans %s, erreur %d : %s \n\n", argv[arg_fich_in+1], chemin_fichier, errno, strerror(errno));
		exit(2);
	}

	FILE* fichier2 = NULL;
	//char nom_fichier2[] = argv[arg_fich_out+1];
	char chemin2[] = {"../src/"};              
	char* chemin_fichier2 = add(chemin2, argv[arg_fich_out+1]);
	fichier2 = fopen(chemin_fichier2, "w");
	if(fichier2 == NULL){
		printf("\n%s dans %s, erreur %d : %s \n\n", argv[arg_fich_out+1], chemin_fichier2, errno, strerror(errno));
		exit(3);
	}

	
// partie de pré-tri en cas d'option de lieu


	#include "suppr_lignes.c"
	suppr_lignes(fichier, fichier2, argv[arg_lieu+1], argv[arg_lieu+2], argv[arg_lieu+3], argv[arg_lieu+4], argv[arg_lieu+5]);


	Station* debut = creerStation();
	Station* station = debut;
/*


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
	exit(14);
	return 14;
}