# Exploration-de-Donn-es-COVID-19

📊 Aperçu du Projet
Dans ce projet, je plonge dans les données réelles de la pandémie de COVID-19 (allant de début 2020 à début 2021). J'utilise des techniques SQL allant du niveau débutant 
à intermédiaire/avancé pour répondre à des questions clés sur les taux d'infection, la mortalité et l'impact de la population par pays et par continent.

Compétences SQL démontrées :
Jointures (Joins)

CTEs (Common Table Expressions)

Tables temporaires (Temp Tables)

Fonctions de fenêtrage (Window Functions)

Fonctions d'agrégation (Aggregate Functions)

Création de Vues (Creating Views)

Conversion de types de données (Casting/Converting)

💾 Sources des données et Préparation
Le jeu de données provient de Our World in Data.
Pour faciliter l'analyse technique et démontrer l'utilisation des jointures, le fichier source a été divisé en deux tables distinctes :

CovidDeaths : Contient les données relatives aux cas, aux décès et à la population.

CovidVaccinations : Contient les données relatives aux tests et aux vaccinations.

Processus d'importation :
Nettoyage initial et formatage sous Excel (conversion .csv vers .xlsx).

Importation dans SQL Server Management Studio (SSMS) via l'outil "SQL Server Import and Export Wizard (64-bit)".

🔍 Analyses effectuées
Voici quelques-unes des requêtes et analyses clés réalisées dans le script SQL :

Probabilité de décès : Calcul du ratio entre le nombre total de cas et le nombre total de décès (DeathPercentage) pour estimer le risque de mortalité par pays.

Taux d'infection par population : Analyse du pourcentage de la population ayant contracté le virus dans chaque pays.

Classement mondial de la mortalité : Identification des pays ayant le nombre de décès le plus élevé par rapport à leur population (nécessitant l'utilisation de CAST en INT pour la précision des calculs).

Analyse par continent : Décomposition des données pour identifier les zones géographiques les plus touchées.

Progression des vaccinations : Utilisation d'une Rolling Count (somme cumulative) pour suivre l'évolution des vaccinations par pays en utilisant des jointures.

🛠️ Comment utiliser ce dépôt
SQL Script : Téléchargez le fichier .sql présent dans ce dossier pour voir l'ensemble des requêtes.

Data : Les liens vers les données sources sont fournis dans la section ressources.



💡 Notes de l'auteur
Ce projet est conçu pour être "beginner-friendly" tout en montrant des compétences analytiques concrètes. Bien que le script soit reproductible, j'ai pris soin d'ajuster les requêtes pour gérer les valeurs nulles dans les colonnes continent afin d'assurer l'intégrité des données agrégées.
