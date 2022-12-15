#include "fonctions.c"



int main(int argc, char argv[]){

//partie fichier
    FILE* datafile = NULL;
    char filename[] = {"temp.csv"};
    char path[] = {"../src/"};              //the file's name and the path are separated to use the file's name if there is an error
    char* pathtofile = add(path, filename);
    datafile = fopen(pathtofile, "r");
    if(datafile == NULL){
        printf("\n%s in %s, error %d : %s \n\n", filename, pathtofile, errno, strerror(errno));
        exit(1);
    }
//fin de la partie fichier



    Station* debut = creerStation();
    Station* station = debut;

    float c;
    int test=0;


    fscanf(datafile, "%f", &c);
        
    while(!feof(datafile) || test != 0){ // si la fin du fichier n'est pas atteinte (à faire après chaque scanf)
        station->id  = c;
        fseek(datafile, 1, 1);
        fscanf(datafile, "%f", &c);
        if(feof(datafile)){
            break;
        }
        station->temperature_max = c;
        fscanf(datafile, "%f", &c);
        if(feof(datafile)){// même si apres c'est la fin de la boucle, on fait un test pour ne pas créer un chainon pour rien
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

    //free
    fclose(datafile);
    return 0;
}