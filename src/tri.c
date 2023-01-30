#include "fonctions.c"


int main(int argc, char *argv[]){


// partie paramètres


	int arg_tri=0;
	int test=0;
	int arg_ah=0; // altitude ou humidite
	char lettre;
	int i=0;
	int id, donnee, num;

	if(argc != 7){
		exit(1);
	}

	if(strcmp(argv[5],"--tab") == 0){
		arg_tri=1;
	}else if(strcmp(argv[5],"--abr") == 0){
		arg_tri=2;
	}else if(strcmp(argv[5],"--avl") == 0){
		arg_tri=3;
	}
	if(strcmp(argv[6],"-h") == 0){
		arg_ah=1;
	}else if(strcmp(argv[6],"-m") == 0){
		arg_ah=2;
	}

	if(arg_tri == 0){
		exit(1);
	}
	if(arg_ah == 0){
		exit(1);
	}
	printf("arg_tri=%d, %s", arg_tri, argv[5]);


// partie fichier
	
	FILE* fichier = NULL;
	char chemin[] = {"../src/"};
	char* chemin_fichier = add(chemin, argv[2]);
	fichier = fopen(chemin_fichier, "r");
	if(fichier == NULL){
		printf("\n%s dans %s, erreur %d : %s \n\n", argv[2], chemin_fichier, errno, strerror(errno));
		exit(2);
	}

	FILE* fichier2 = NULL;
	char chemin2[] = {"../src/"};
	char* chemin_fichier2 = add(chemin2, argv[4]);
	fichier2 = fopen(chemin_fichier2, "w");
	if(fichier2 == NULL){
		printf("\n%s dans %s, erreur %d : %s \n\n", argv[4], chemin_fichier2, errno, strerror(errno));
		exit(3);
	}


// TABLEAU

	if(arg_tri == 1){	
		Stockage tab[70];
		init(tab);
		
		for(i=0; !feof(fichier); i++){ // si la fin du fichier n'est pas atteinte (à faire après chaque scanf)
			//fscanf(fichier, "%d %d\n", &id, &donnee);
			do{
				test=0;
				fscanf(fichier, "%d", &id);
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
			fscanf(fichier, "%d\n", &donnee);
			num =recherche(tab, 0, 70, id);
			if(num == -1){
				if(tab[0].id != -1){
					printf("erreur, nbr de station dépasse 70\n");
				}
				tab[0].id = id;
				tab[0].donnee = donnee;
				triRapide(tab, 70, 1);
			}else{
				if(tab[num].donnee < donnee ){
					tab[num].donnee = donnee;
				}
			}
		}



		test=0;
		for(int j=0; j<70; j++){
			if(tab[j].id!=-1 && tab[j].id!=0){
				printf("%d\t%d\n", tab[j].id, tab[j].donnee);
			}else{
				test++;
			}
		}
		printf("\n\n\n\n\n\n\n");
		triRapide(tab, 70, 2);
		for(int j=69; j>=0; j--){
			if(tab[j].id!=-1 && tab[j].id!=0){
				printf("%d\t%d\n", tab[j].id, tab[j].donnee);
			}
		}
		printf("stations trouvées : %d", 70-test);
		if(test==0){
			printf(" ou plus\n");
		}else{
			printf("\n");
		}

		for(int j=69; j>=0; j--){
			if(tab[j].id!=-1 && tab[j].id!=0){
				fprintf(fichier2, "%d %d\n", tab[j].id, tab[j].donnee);
			}else{
				test++;
			}
		}
	}
	
// ABR

	if(arg_tri == 2){

	}
	

// AVL

	if(arg_tri == 3){
		
		Parbre arbre = NULL;
		int h =0;
		Parbre temp;
		for(i=0; !feof(fichier); i++){ // si la fin du fichier n'est pas atteinte (à faire après chaque scanf)
			do{
				test=0;
				fscanf(fichier, "%d", &id);
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
			fscanf(fichier, "%d\n", &donnee);
			temp = recherche_arbre(arbre, id);
			if(temp == NULL){
				arbre = insertionAVL(arbre, id, donnee, &h);
			}else{
				if(temp->donnee < donnee ){
					temp->donnee = donnee;
				}
			}
			affArbreGraphique(arbre, 1);
		}
		
		
		parcours_postfixe(fichier2 ,arbre);
	}

	//free
	fclose(fichier);
	fclose(fichier2);
	return 0;
}