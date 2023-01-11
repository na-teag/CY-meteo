

int suppr_lignes(FILE* fichier, FILE* fichier2, char* type_lieu, char* lat1_char, char* lat2_char, char* long1_char, char* long2_char){
	float lat1;
	float lat2;
	float long1;
	float long2;
	int test_lat=0;
	int test_long=0;
	int filtre=0;
	char lettre=' ';
	int i=0;
	char ligne[150];
	float nbr1
	float nbr2
	int test = 1;

	FILE* fichier3 = NULL;
	fichier3 = fopen("test.txt", "w");
	if(fichier3 == NULL){
		exit(2);
	}


	if(strcmp(type_lieu, "-a") == 0){
		filtre=1;
		lat1=convertir(lat1_char);
		lat2=convertir(lat2_char);
		croissant(&lat1, &lat2);
		test_lat=1;
	}
	if(strcmp(type_lieu, "-g") == 0){
		filtre=2;
		long1=convertir(long1_char);
		long2=convertir(long2_char);
		croissant(&long1, &long2);
		test_long=1;
	}
	if(strcmp(type_lieu, "-a-g") == 0 || strcmp(type_lieu, "-g-a") == 0){
		filtre=3;
		lat1=convertir(lat1_char);
		lat2=convertir(lat2_char);
		long1=convertir(long1_char);
		long2=convertir(long2_char);
		croissant(&lat1, &lat2);
		croissant(&long1, &long2);
		test_lat=1;
		test_long=1;
	}
	
		int j=0;

	rewind(fichier);
	//while(!feof(fichier)){
		while(!(lettre==';' && j==6)){
			lettre=fgetc(fichier);
			ligne[i]=lettre;
			i++;
			if(lettre==';'){
				j++;
			}
		}
		lettre=' ';
		fscanf(fichier, "%f", &nbr1);
		
		
		lettre=' ';
		while(lettre!=';'){
			lettre=fgetc(fichier);
			ligne[i]=lettre;
			i++;
		}
		// arriver à inclure la fin de la ligne ou il n'y a pas de ;
		j=0;
		i=0;
		
		
		
		if(test_lat == 1){
			if(!(lat1 <= nbr1 && nbr1 <= lat2)){
				test=0;
				printf("non");
			}
		}
		if(test_long == 1){
			if(!(long1 <= nbr2 && nbr2 <= long2)){
				test=0;
				printf("non");
			}
		}

		//fprintf(fichier3, "%f", nbr1);
		//fprintf(fichier3, "%f", nbr2);

		if(test == 1){
			fprintf(fichier3, "%s\n", ligne);
		}
		printf("%d", test);


	//}
	fclose(fichier3);

	return 0;
}