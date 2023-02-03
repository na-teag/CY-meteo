#include "fonctions.c"


int main(int argc, char *argv[]){


// partie paramètres


	int arg_tri=0;
	int test=0;
	int arg_w=0; // vent
	int arg_ah=0; // altitude ou humidite
	int arg_tp=0; // temperature ou pression
	char lettre;
	char date[13];
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
	}else if(strcmp(argv[6],"-w") == 0){
		arg_w=1;
	}else if(strcmp(argv[6],"-t1") == 0){
		arg_tp=1;
	}else if(strcmp(argv[6],"-t2") == 0){
		arg_tp=2;
	}else if(strcmp(argv[6],"-t3") == 0){
		arg_tp=3;
	}else if(strcmp(argv[6],"-p1") == 0){
		arg_tp=1;
	}else if(strcmp(argv[6],"-p2") == 0){
		arg_tp=2;
	}else if(strcmp(argv[6],"-p3") == 0){
		arg_tp=3;
	}
	if(arg_tri == 0){
		exit(1);
	}
	if(arg_ah == 0 && arg_w == 0 && arg_tp == 0){
		exit(1);
	}
	//printf("arg_tri=%d, %s, arg_ah=%d, arg_w=%d, arg_tp=%d", arg_tri, argv[5], arg_ah, arg_w, arg_tp);


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



//-------------------- HUMIDITE ET ALTITUDE -------------------


// TABLEAU

	if(arg_ah != 0){
		if(arg_tri == 1){	
			Stockage tab[70];
			init(tab, 70);//on initialise toutes les cases du tableau à -1

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
			parcours(fichier2, arbre, 1);
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
			parcours(fichier2, arbre, 1);
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
			parcours(fichier2, arbre, 1);
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
			fclose(fichier2);//affArbreGraphique(arbre, 1);
			fichier2 = fopen(chemin_fichier2, "w");
			if(fichier2 == NULL){
				printf("\n%s dans %s, erreur %d : %s \n\n", argv[4], chemin_fichier2, errno, strerror(errno));
				exit(3);
			}
			parcours(fichier2, arbre, 1);

		}




//----------- VENT ----------------








	}else if(arg_w == 1){

		if(arg_tri == 1){	
		Stockage tab[70];
		init(tab, 70);//on initialise toutes les cases du tableau à -1
		
		for(i=0; !feof(fichier); i++){ // si la fin du fichier n'est pas atteinte (à faire après chaque scanf)
			fscanf(fichier, "%d %d %f %f %f",&stockage.id, &stockage.moyenne, &stockage.moyenne2, &stockage.latitude, &stockage.longitude);
			//printf("%f\t%f\t%d\n", stockage.longitude, stockage.latitude, stockage.donnee);
			num =recherche(tab, 0, 70, stockage.id);
			if(num == -1){
				if(tab[0].id != -1){
					printf("erreur, nbr de station dépasse 70\n");
				}
				tab[0].id = stockage.id;
				tab[0].donnee = 1;
				tab[0].moyenne = stockage.moyenne;
				tab[0].moyenne2 = stockage.moyenne2;
				tab[0].latitude = stockage.latitude;
				tab[0].longitude = stockage.longitude;
				triRapide(tab, 70, 1);
			}else{
				tab[num].moyenne2 += stockage.moyenne2;
				tab[num].moyenne += stockage.moyenne;
				tab[num].donnee ++;
			}
			//printf("%d\t%f\t%d\n", tab[70].id, tab[70].moyenne2, tab[70].donnee);
		}
		tab[num].moyenne -= stockage.moyenne; // la derniere ligne semble être traitée deux fois
		tab[num].moyenne2 -= stockage.moyenne2;
		tab[num].donnee --;

		//affichtab(tab);exit(1);
		test=0;
		for(int j=0; j<=70; j++){
			if(tab[j].id!=-1 && tab[j].id!=0 && tab[j].longitude<=200){
				fprintf(fichier2, "%d\t%f\t%f\t%f\t%f\n",tab[j].id ,tab[j].longitude, tab[j].latitude, ((tab[j].moyenne/tab[j].donnee)*3.14159)/180, tab[j].moyenne2/tab[j].donnee);
				//printf("%f\t%f\t%d\n", tab[j].longitude, tab[j].latitude, tab[j].donnee);
			}else{
				test++;
			}
		}//for(int j=0; j<70;j++){if(tab[j].donnee==194){printf("ppppp%dpppppp",j);}}
		printf("stations trouvées : %d", 70-test+1);
		if(test==0){
			printf(" ou plus\n");
		}else{
			printf("\n");
		}
		}else if(arg_tri == 2){

	// ABR
		
		Parbre arbre = NULL;
		Parbre temp;
		for(i=0; !feof(fichier); i++){ // si la fin du fichier n'est pas atteinte (à faire après chaque scanf)
			fscanf(fichier, "%d %d %f %f %f\n",&stockage.id, &stockage.moyenne, &stockage.moyenne2, &stockage.latitude, &stockage.longitude);
			temp = recherche_arbre(arbre, stockage.id, 1);
			stockage.donnee2=1;
			if(temp == NULL){
				arbre = insertionABR(arbre, stockage, 1);
			}else{
				temp->stockage.donnee++;
				temp->stockage.moyenne2 += stockage.moyenne2;
				temp->stockage.moyenne += stockage.moyenne;
			}
		}
		parcours(fichier2, arbre, 2);
		//affArbreGraphique(arbre, 1);
		
		}else if(arg_tri == 3){


	//AVL
	
		Parbre arbre = NULL;
		Parbre temp;
		int h =0;
		for(i=0; !feof(fichier); i++){ // si la fin du fichier n'est pas atteinte (à faire après chaque scanf)
			fscanf(fichier, "%d %d %f %f %f\n",&stockage.id, &stockage.moyenne, &stockage.moyenne2, &stockage.latitude, &stockage.longitude);
			temp = recherche_arbre(arbre, stockage.id, 1);
			stockage.donnee2=1;
			if(temp == NULL){
				arbre = insertionAVL(arbre, stockage, &h, 1);
			}else{
				temp->stockage.donnee++;
				temp->stockage.moyenne2 += stockage.moyenne2;
				temp->stockage.moyenne += stockage.moyenne;
			}
			//printf("%d", temp->stockage.id);
		}
		parcours(fichier2, arbre, 2);
		//affArbreGraphique(arbre, 1);
		
		}
	}else if(arg_tp == 1){



//------------------TEMPERATURE/PRESSION 1 ---------------




		//printf("test");
		if(arg_tri == 1){	
		Stockage tab[70];
		init(tab, 70);//on initialise toutes les cases du tableau à -1
		
		for(i=0; !feof(fichier); i++){ // si la fin du fichier n'est pas atteinte (à faire après chaque scanf)
			fscanf(fichier, "%d %f\n",&stockage.id, &stockage.min);
			//printf("%f\t%f\t%d\n", stockage.longitude, stockage.latitude, stockage.donnee);
			num =recherche(tab, 0, 70, stockage.id);
			if(num == -1){
				if(tab[0].id != -1){
					printf("erreur, nbr de station dépasse 70\n");
				}
				tab[0].id = stockage.id;
				tab[0].donnee = 1;
				tab[0].min = stockage.min;
				tab[0].max = stockage.min;
				tab[0].moyenne2 = stockage.min;
				triRapide(tab, 70, 1);
			}else{
				tab[num].moyenne2 += stockage.min;
				tab[num].donnee ++;
				if(stockage.min < tab[num].min){
					tab[num].min = stockage.min;
				}
				if(stockage.min > tab[num].max){
					tab[num].max = stockage.min;
				}
			}
			//printf("%d\t%f\t%d\n", tab[70].id, tab[70].moyenne2, tab[70].donnee);
		}
		tab[num].moyenne2 -= stockage.moyenne2; // la derniere ligne semble être traitée deux fois
		tab[num].donnee --;
		//printf("%d\t%f\t%d\n\n", tab[70].id, tab[70].moyenne2, tab[70].donnee);

		//affichtab(tab);exit(1);
		test=0;
		for(int j=0; j<=70; j++){
			if(tab[j].id!=-1 && tab[j].id!=0 && tab[j].longitude<=200){
				fprintf(fichier2, "%d\t%f\t%f\t%f\n",tab[j].id ,tab[j].min, tab[j].max, tab[j].moyenne2/tab[j].donnee);
				//printf("%d\t%f\t%f\t%f\n",tab[j].id ,tab[j].min, tab[j].max, tab[j].moyenne2/tab[j].donnee);
			}else{
				test++;
			}
		}//for(int j=0; j<70;j++){if(tab[j].donnee==194){printf("ppppp%dpppppp",j);}}
		printf("stations trouvées : %d", 70-test+1);
		if(test==0){
			printf(" ou plus\n");
		}else{
			printf("\n");
		}
		}else if(arg_tri == 2){

	// ABR
		
		Parbre arbre = NULL;
		Parbre temp;
		for(i=0; !feof(fichier); i++){ // si la fin du fichier n'est pas atteinte (à faire après chaque scanf)
			fscanf(fichier, "%d %f\n",&stockage.id, &stockage.moyenne2);
			temp = recherche_arbre(arbre, stockage.id, 1);
			stockage.donnee=1;
			if(temp == NULL){
				arbre = insertionABR(arbre, stockage, 1);
			}else{
				temp->stockage.donnee++;
				temp->stockage.moyenne2 += stockage.moyenne2;
				if(stockage.moyenne2 < temp->stockage.min){
					temp->stockage.min = stockage.moyenne2;
				}
				if(stockage.moyenne2 > temp->stockage.max){
					temp->stockage.max = stockage.moyenne2;
				}
			}
			//printf("%f\n", stockage.moyenne2);
		//affArbreGraphique(arbre, 1);
		}
		parcours(fichier2, arbre, 3);

				
		
		}else if(arg_tri == 3){


	//AVL
	
		Parbre arbre = NULL;
		Parbre temp;
		int h=0;
		for(i=0; !feof(fichier); i++){ // si la fin du fichier n'est pas atteinte (à faire après chaque scanf)
			fscanf(fichier, "%d %f\n",&stockage.id, &stockage.moyenne2);
			temp = recherche_arbre(arbre, stockage.id, 1);
			stockage.donnee=1;
			if(temp == NULL){
				arbre = insertionAVL(arbre, stockage, &h, 1);
			}else{
				temp->stockage.donnee++;
				temp->stockage.moyenne2 += stockage.moyenne2;
				if(stockage.moyenne2 < temp->stockage.min){
					temp->stockage.min = stockage.moyenne2;
				}
				if(stockage.moyenne2 > temp->stockage.max){
					temp->stockage.max = stockage.moyenne2;
				}
			}
			//printf("%f\n", stockage.moyenne2);
		//affArbreGraphique(arbre, 1);
		}
		parcours(fichier2, arbre, 3);
		
		}
	}else if(arg_tp == 2){



//------------------TEMPERATURE/PRESSION 2 ---------------




		
		if(arg_tri == 1){

		Stockage tab[10000];
		init(tab, 10000);//on initialise toutes les cases du tableau à -1
		
		for(i=0; !feof(fichier); i++){ // si la fin du fichier n'est pas atteinte (à faire après chaque scanf)
			fscanf(fichier, "%s %f\n", &stockage.date, &stockage.moyenne2);
			//printf("%f\t%f\t%d\n", stockage.longitude, stockage.latitude, stockage.donnee);
			stockage.date[25]='\0';
			stockage.id = numero_date(stockage.date);
			stockage.date[25]='\0';
			//printf("%s=%d\n", stockage.date, stockage.id);
			num =recherche(tab, 0, 10000, stockage.id);
			if(num == -1){
				if(tab[0].id != -1){
					printf("erreur\n");
				}
				for(int i=0; i<24; i++){
					tab[0].date[i] = stockage.date[i];
				}
				tab[0].date[25] = '\0';
				//printf("%s\t%s\n", tab[0].date, stockage.date);
				tab[0].id = stockage.id;
				tab[0].donnee = 1;
				tab[0].moyenne2 = stockage.moyenne2;
				triRapide(tab, 10000, 1);
			}else{
				tab[num].moyenne2 += stockage.moyenne2;
				tab[num].donnee ++;
			}
			//printf("%d\t%f\t%d\n", tab[70].id, tab[70].moyenne2, tab[70].donnee);
		}
		tab[num].moyenne2 -= stockage.moyenne2; // la derniere ligne semble être traitée deux fois
		tab[num].donnee --;
		//printf("%d\t%f\t%d\n\n", tab[70].id, tab[70].moyenne2, tab[70].donnee);
		
		//affichtab(tab);exit(1);
		test=0;
		for(int j=0; j<10000; j++){
			if(tab[j].id!=-1 && tab[j].id!=0){
				fprintf(fichier2, "%.2f\t%f\n", (floor(((float) tab[j].id)/100000))/100 ,tab[j].moyenne2/tab[j].donnee);
			}else{
				test++;
			}
		}//for(int j=0; j<70;j++){if(tab[j].donnee==194){printf("ppppp%dpppppp",j);}}
		printf("stations trouvées : %d", 10000-test+1);
		if(test==0){
			printf(" ou plus\n");
		}else{
			printf("\n");
		}
		}else if(arg_tri == 2){

	// ABR
		
		Parbre arbre = NULL;
		Parbre temp;
		for(i=0; !feof(fichier); i++){ // si la fin du fichier n'est pas atteinte (à faire après chaque scanf)
			fscanf(fichier, "%s %f\n", &stockage.date, &stockage.moyenne2);
			stockage.date[25]='\0';
			stockage.id = numero_date(stockage.date);
			stockage.date[25]='\0';
			temp = recherche_arbre(arbre, stockage.id, 1);
			stockage.donnee=1;
			if(temp == NULL){
				stockage.donnee=1;
				arbre = insertionABR(arbre, stockage, 1);
			}else{
				temp->stockage.moyenne2 += stockage.moyenne2;
				temp->stockage.donnee ++;
			}
			//printf("%f\n", stockage.moyenne2);
		//affArbreGraphique(arbre, 1);
		}
		parcours(fichier2, arbre, 4);

	}else if(arg_tri == 3){

	//AVL
	
		Parbre arbre = NULL;
		Parbre temp;
		int h;
		for(i=0; !feof(fichier); i++){ // si la fin du fichier n'est pas atteinte (à faire après chaque scanf)
			fscanf(fichier, "%s %f\n", &stockage.date, &stockage.moyenne2);
			stockage.date[25]='\0';
			stockage.id = numero_date(stockage.date);
			stockage.date[25]='\0';
			temp = recherche_arbre(arbre, stockage.id, 1);
			stockage.donnee=1;
			if(temp == NULL){
				stockage.donnee=1;
				arbre = insertionAVL(arbre, stockage, &h, 1);
			}else{
				temp->stockage.moyenne2 += stockage.moyenne2;
				temp->stockage.donnee ++;
			}
			//printf("%f\n", stockage.moyenne2);
		//affArbreGraphique(arbre, 1);
		}
		parcours(fichier2, arbre, 4);
		
	}
	}






















	fclose(fichier);
	fclose(fichier2);
	return 0;
}


