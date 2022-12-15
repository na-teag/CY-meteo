#!/bin/bash

echo "Utilisation : ls [OPTION]... [FICHIER]...
Afficher des renseignements sur les FICHIERs (du répertoire actuel par défaut).
Trier les entrées alphabétiquement si aucune des options -cftuvSUX ou --sort
ne sont utilisées.

Les arguments obligatoires pour les options longues le sont aussi pour les
options courtes.
  -a, --all                  ne pas ignorer les entrées débutant par .
  -A, --almost-all           ne pas inclure . ou .. dans la liste
      --author               avec -l, afficher l'auteur de chaque fichier
  -b, --escape               afficher les caractères non graphiques avec des
                               protections selon le style C
      --block-size=TAILLE    avec -l, dimensionner les tailles selon TAILLE avant
                               de les afficher. Par exemple, « --block-size=M ».
                               Consultez le format de TAILLE ci-dessous
  -B, --ignore-backups       ne pas inclure les entrées se terminant par ~ dans
                               la liste
  -c                         avec -lt : afficher et trier selon ctime (date de
                               dernière modification provenant des informations
                               d'état du fichier) ;
                               avec -l : afficher ctime et trier selon le nom ;
                               autrement : trier selon ctime, le plus récent en
                               premier
  -C                         afficher les noms en colonnes
  --color[=QUAND]            colorer la sortie ; QUAND peut être « always »
                               (toujours, valeur par défaut si omis), « auto »
                               (automatique) ou « never » (jamais) ; voir
                               ci-dessous pour plus d'informations
  

L'argument TAILLE est un entier suivi d'une unité facultative (10k pour 10*1024
par exemple). Les unités sont K, M, G, T, P, E, Z et Y (puissances de 1024) ou
KB, MB, etc. (puissances de 1000).
Les préfixes binaires peuvent être utilisés aussi: KiB=K, MiB=M, etc


État de sortie :
 0  en cas de succès,
 1  en cas de problème mineur (comme impossible d'accéder à un sous-répertoire),
 2  en cas de problème majeur (comme impossible d'accéder à un argument de ligne
                               de commande).

Aide en ligne de GNU coreutils : <https://www.gnu.org/software/coreutils/>
Signalez les problèmes de traduction de à : <traduc@traduc.org>
Documentation complète <https://www.gnu.org/software/coreutils/ls>
ou disponible localement via: info '(coreutils) ls invocation'
"