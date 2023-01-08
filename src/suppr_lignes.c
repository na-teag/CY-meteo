

int suppr_lignes(FILE* fichier, FILE* fichier2, char* type_lieu, char* lat1_char, char* lat2_char, char* long1_char, char* long2_char){
	float lat1;
	float lat2;
	float long1;
	float long2;
	int filtre=0;
	char a=' ';
	int i=0;

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
	}
	if(strcmp(type_lieu, "-g") == 0){
		filtre=2;
		long1=convertir(long1_char);
		long2=convertir(long2_char);
		croissant(&long1, &long2);
	}
	if(strcmp(type_lieu, "-a-g") == 0 || strcmp(type_lieu, "-g-a") == 0){
		filtre=3;
		lat1=convertir(lat1_char);
		lat2=convertir(lat2_char);
		long1=convertir(long1_char);
		long2=convertir(long2_char);
		croissant(&lat1, &lat2);
		croissant(&long1, &long2);
	}
	

	rewind(fichier);
	//while(!feof(fichier)){
		while(a!=','){
			a=fgetc(fichier);
			i++;
		}
		fprintf(fichier3, "\n%d", i);
		fprintf(fichier3,"test");
	//}
	fclose(fichier3);

	return 0;
}