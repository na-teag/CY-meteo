#include <stdio.h>
#include <math.h>
#include <unistd.h>
#include <time.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>
#include <sys/time.h>

typedef struct station{ // structure pour l'option -t1
    float id;
    float somme_tot;
    int compteur;
    float temperature_min;
    float temperature_max;
    struct station* filsG;
    struct station* filsD;
}Station;



unsigned long getTimeMicroSec();
char* add(char tab[], char tab2[]);
Station* creerStation();