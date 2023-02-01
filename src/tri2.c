#include "fonctions.c"


int main(int argc, char *argv[]){


// partie paramètres


	int arg_tri=0;
	int test=0;
	int arg_ah=0; // altitude ou humidite
	char lettre;
	int i=0;
	int id, donnee, num, doublon;
	Stockage stockage;

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
	//printf("arg_tri=%d, %s", arg_tri, argv[5]);


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
		init(tab);//on initialise toutes les cases du tableau à -1
		
		for(i=0; !feof(fichier); i++){ // si la fin du fichier n'est pas atteinte (à faire après chaque scanf)
			fscan(fichier, &stockage);
			//printf("%f\t%f\t%d\n", stockage.longitude, stockage.latitude, stockage.donnee);
			num =recherche(tab, 0, 70, stockage.id);
			if(num == -1){
				if(tab[0].id != -1){
					printf("erreur, nbr de station dépasse 70\n");
				}
				tab[0].id = stockage.id;
				tab[0].donnee = stockage.donnee;
				tab[0].latitude = stockage.latitude;
				tab[0].longitude = stockage.longitude;
				triRapide(tab, 70, 1);
			}else{
				if(tab[num].donnee < donnee ){
					tab[num].donnee = donnee;
				}
			}
		}


		//affichtab(tab);exit(1);
		test=0;
		triRapide(tab, 70, 2);
		for(int j=70; j>=0; j--){
			if(tab[j].id!=-1 && tab[j].id!=0 && tab[j].longitude<=200){
				fprintf(fichier2, "%f\t%f\t%d\n", tab[j].longitude, tab[j].latitude, tab[j].donnee);
				//printf("%f\t%f\t%d\n", tab[j].longitude, tab[j].latitude, tab[j].donnee);
			}else{
				test++;
			}
		}//for(int j=0; j<70;j++){if(tab[j].donnee==194){printf("ppppp%dpppppp",j);}}
		printf("stations trouvées : %d", 70-test);
		if(test==0){
			printf(" ou plus\n");
		}else{
			printf("\n");
		}
	}
	
// ABR

	if(arg_tri == 2){
		
		Parbre arbre = NULL;
		Parbre temp;
		for(i=0; !feof(fichier); i++){ // si la fin du fichier n'est pas atteinte (à faire après chaque scanf)
			fscan(fichier, &stockage);
			temp = recherche_arbre(arbre, stockage.id, 1);
			if(temp == NULL){
				arbre = insertionABR(arbre, stockage, 1);
			}else{
				if(temp->stockage.donnee < stockage.donnee ){
					temp->stockage.donnee = stockage.donnee;
				}
			}
		}
		//affArbreGraphique(arbre, 1);
		parcours(fichier2, arbre);
		fclose(fichier2);
		suppr_arbre(arbre);
		fichier2 = fopen(chemin_fichier2, "r");
		if(fichier2 == NULL){
			printf("\n%s dans %s, erreur %d : %s \n\n", argv[4], chemin_fichier2, errno, strerror(errno));
			exit(3);
		}
		arbre = NULL;
		while(!feof(fichier2)){
			fscanf(fichier2, "%f\t%f\t%d\n", &stockage.longitude, &stockage.latitude, &stockage.donnee);
			temp = recherche_arbre(arbre, stockage.donnee, 2);
			if(temp == NULL){
				arbre = insertionABR(arbre, stockage, 2);
			}else{//deux donnée iddentiques mais pas de la même station
				Parbre temp2 = autre(temp);
				temp2->autre=CreerArbre(stockage);
			}
		}
			//affArbreGraphique(arbre, 1);
		fclose(fichier2);
		fichier2 = fopen(chemin_fichier2, "w");
		if(fichier2 == NULL){
			printf("\n%s dans %s, erreur %d : %s \n\n", argv[4], chemin_fichier2, errno, strerror(errno));
			exit(3);
		}
		parcours(fichier2, arbre);
	}

// AVL

	if(arg_tri == 3){
		
		Parbre arbre = NULL;
		int h =0;
		Parbre temp;
		for(i=0; !feof(fichier); i++){ // si la fin du fichier n'est pas atteinte (à faire après chaque scanf)
			fscan(fichier, &stockage);
			temp = recherche_arbre(arbre, stockage.id, 1);
			if(temp == NULL){
				arbre = insertionAVL(arbre, stockage, &h, 1);
			}else{
				if(temp->stockage.donnee < stockage.donnee ){
					temp->stockage.donnee = stockage.donnee;
				}
			}
		}
		//affArbreGraphique(arbre, 1);
		parcours(fichier2, arbre);
		fclose(fichier2);
		suppr_arbre(arbre);
		fichier2 = fopen(chemin_fichier2, "r");
		if(fichier2 == NULL){
			printf("\n%s dans %s, erreur %d : %s \n\n", argv[4], chemin_fichier2, errno, strerror(errno));
			exit(3);
		}
		arbre = NULL;
		h=0;
		while(!feof(fichier2)){
			fscanf(fichier2, "%f\t%f\t%d\n", &stockage.longitude, &stockage.latitude, &stockage.donnee);
			
				temp = recherche_arbre(arbre, stockage.donnee, 2);
				if(temp == NULL){
					arbre = insertionAVL(arbre, stockage, &h, 2);
				}else{//deux donnée iddentiques mais pas de la même station
					Parbre temp2 = autre(temp);
					temp2->autre=CreerArbre(stockage);
				}
			
		}
		fclose(fichier2);affArbreGraphique(arbre, 1);
		fichier2 = fopen(chemin_fichier2, "w");
		if(fichier2 == NULL){
			printf("\n%s dans %s, erreur %d : %s \n\n", argv[4], chemin_fichier2, errno, strerror(errno));
			exit(3);
		}
		parcours(fichier2, arbre);
		
	}

	fclose(fichier);
	fclose(fichier2);
	return 0;
}