# EDC base de données  Johan Petrikovsky

Veuillez trouver ici le résultat de mon étude de cas
## Commentaires général 
Concernant la modélisation j'ai fais le choix de sortir les tables *thèmes, activites, types* dans l'éventualités ou ces données pouvaient être importantes et pouvaient devenir critère de tri. A l'inverse cela ne m'a pas semblé pertinent pour la localité.
La création des fonctions et déclencheurs avant l'insertion des données permet de voir par exemple que le trigramme se génère bien.
Concernant le trigramme j'ai fais le choix d'un champ avec contrainte UNIQUE et d'insérer 500 salariés pour vérifier la robustesse.

## Présentation des dossiers

### Dossier 00 - Modélisation
Contient les **fichiers OpenModel Sphere** dans le sous dossier correspondant ainsi que **deux fichiers JPG du MCD et MLD**

### Dossier 01 - Création
Contient dans l'ordre les fichiers à exécuter pour créer la base de données
1. Création de l'utilsateur
2. Création de la base de données
3. Création des tables
4. Création des fonctions et déclencheurs

### Dossier 02 - Insertion des données
Les données minimum à la réalisation des requêts/fonctions/déclencheurs sont fournis séparés en plusieurs fichiers numérotés à insérer dans l'ordre.
Le fichier 07-create-hierarchie permet de définir les chefs de chaque salarié. Le chef suprême (id1) n'en a pas.
1. Divisions
2. Clients
3. Salaries
4. Création de la hierarchie
5. Projets
6. Tâches
7. Association salariés/tâches

### Dossier 03 -  SELECT
Un seul fichier contenant les requêtes SELECT numérotées dans l'ordre


