
## Introduction

Suite aux crises multiples qui ont secoué le monde de la finance et de l'assurance notamment celle de 2008, les autorités se sont rendu compte de l'insuffisance de la supervision prudentielle. Cette dernière s'est montrée très chétive lors de la crise d'où la nécessité de mettre en place de nouvelles dispositions prudentielles plus robustes.

C'est dans ce contexte, à l'image de *Bâle 2* pour la finance, que la *Solvabilité 2* voit le jour dans le milieu de l'assurance. Cette réforme réglementaire européenne vient renforcer la précédente en adaptant au mieux les exigences de fonds propres des compagnies d'assurances et de réassurances aux risques qu'elles encourent.

Les insuffisances évoquées n'ont pas épargné le cadre prudentiel marocain. C'est ainsi que l'Autorité de Contrôle des Assurances et de la Prévoyance Sociale (ACAPS[^1]) a adopter la norme de Solvabilité Basé sur les Risques (SBR) afin de tenir compte de la diversités des risques encourues par les compagnies d'assurances et de réassurances marocaines. La SBR s'articule autour de trois piliers :

[^1]: <https://www.acaps.ma/fr/l-acaps/missions>

-   *Le pilier I* regroupe les *exigences quantitatives*, à savoir les règles de valorisation des actifs et des passifs ainsi que les exigences de capital et leur mode de calcul;
-   *Le pilier II* porte sur les *exigences qualitatives* et définit les règles de gouvernance et de gestion des risques, en l'occurrence l'évaluation interne des risques de la solvabilité;
-   *Le pilier III* concerne, quant à lui, les *obligations de reporting* à l'Autorité et de diffusion de l'information au public.

## Modèle LSTM appliqué au cours de l'indice MASI

Ce code est utilisé pour créer et entraîner un modèle de réseaux de neurones récurrents (RNN) appelé Long Short-Term Memory (LSTM) pour prédire le dernier cours de l'indice MASI à partir des données historiques.

Voici une explication étape par étape du code :

1.  Les bibliothèques nécessaires sont importées, notamment pandas pour la manipulation des données, matplotlib pour la visualisation des résultats, et TensorFlow pour la création et l'entraînement du modèle LSTM.

2.  Le fichier CSV contenant les données historiques est lu à l'aide de la fonction `pd.read_csv()`, et les données sont stockées dans un DataFrame appelé `df`.

3.  Deux fonctions, `convert_num()` et `pct_to_num()`, sont définies pour convertir les valeurs des colonnes en nombres. La première fonction est utilisée pour enlever les espaces, les points et les virgules et convertir les valeurs en nombres décimaux. La deuxième fonction est utilisée pour enlever les espaces, les virgules et les signes de pourcentage, puis convertir les valeurs en nombres décimaux.

4.  Les fonctions de conversion sont appliquées aux colonnes appropriées du DataFrame à l'aide de la méthode `applymap()`.

5.  Les données sont préparées pour l'entraînement du modèle. Les colonnes pertinentes du DataFrame (`Dernier`, `Ouv.`, `Plus Haut`, `Plus Bas`) sont extraites et converties en tableaux NumPy. Les données sont ensuite normalisées à l'aide de la classe `MinMaxScaler` de scikit-learn, ce qui les met à l'échelle entre 0 et 1.

6.  Des séquences de données sont créées pour l'entraînement du modèle. Chaque séquence contient les 5 observations précédentes en tant qu'entrée et la valeur du cours "Dernier" à la prochaine observation en tant que sortie. Cela permet d'entraîner le modèle à prédire le cours futur en fonction des observations passées.

7.  Les données sont divisées en ensembles d'entraînement et de test. 95% des données sont utilisées pour l'entraînement et 5% sont réservées pour les tests.

8.  Le modèle LSTM est défini à l'aide de la classe `Sequential` de Keras. Il est composé de trois couches LSTM avec une couche de dropout entre chaque couche pour éviter le surapprentissage. La dernière couche est une couche dense avec une seule unité qui prédit la valeur du cours "Dernier".

9.  Le modèle est compilé avec l'optimiseur Adam et la fonction de perte "mean_squared_error" pour mesurer l'erreur de prédiction.

10. Le modèle est entraîné sur les données d'entraînement à l'aide de la méthode `fit()`. Le nombre d'époques est défini à 100 et la taille du lot est définie à 30.

11. Le modèle est utilisé pour faire des prédictions sur les données de test à l'aide de la méthode `predict()`. Les prédictions sont inversées à l'échelle originale à l'aide de la méthode `inverse_transform()` de l'objet `scaler`.

12. L'erreur de prédiction est évaluée en calculant la racine carrée de l'erreur quadratique moyenne (RMSE) entre les valeurs de test réelles et les valeurs prédites.

13. Les valeurs réelles et prédites sont tracées à l'aide de la bibliothèque matplotlib pour visualiser les performances du modèle.

En résumé, ce code utilise un modèle LSTM pour prédire le dernier cours du MASI à partir des données historiques, puis évalue les performances du modèle en calculant l'erreur de prédiction et en traçant les résultats.


```python
import pandas as pd
import matplotlib.pyplot as plt
import tensorflow as tf
from tensorflow.keras.models import Sequential
from tensorflow.keras.layers import Dense, LSTM, Dropout
import numpy as np

#Lecture du fichier csv
df = pd.read_csv('Moroccan All Shares - Données Historiques.csv')

# Conversion en nombres
def convert_num(x):
    x = x.replace(" ", "")
    x = x.replace(".", "")
    x = x.replace(",", ".")
    return float(x)

# Conversion des pourcentages en nombres
def pct_to_num(x):
    x = x.replace(" ", "")
    x = x.replace(",", ".")
    x = x.replace("%", "")
    return float(x)

# Appliquer les fonctions de conversion aux colonnes appropriées
df_temp = df.loc[:, ~df.columns.isin(["Date", "Variation %","Vol."])].applymap(convert_num)
df.loc[:, ~df.columns.isin(["Date", "Variation %","Vol."])] = df_temp
df["Variation %"] = df["Variation %"].apply(pct_to_num)


# Préparer les données
# Supposons que df est un dataframe contenant les données historiques
# avec les colonnes suivantes: Date, Dernier, Ouv., Plus Haut, Plus Bas, Vol., Variation %
# On va utiliser les 5 dernières observations comme entrées du modèle
# et prédire le cours Dernier à la prochaine date

# Convertir les données en numpy arrays
X = df[['Dernier','Ouv.',' Plus Haut', 'Plus Bas']].to_numpy()
y = df["Dernier"].to_numpy()

# Normaliser les données
from sklearn.preprocessing import MinMaxScaler
scaler = MinMaxScaler()
X = scaler.fit_transform(X)
y = scaler.fit_transform(y.reshape(-1, 1))

# Créer des séquences de données
# Chaque séquence contient 5 observations consécutives (timesteps) comme entrée
# et le cours Dernier à la prochaine observation comme sortie
X_seq = []
y_seq = []
timesteps = 5
for i in range(timesteps, len(X)):
  X_seq.append(X[i-timesteps:i])
  y_seq.append(y[i])
X_seq = np.array(X_seq)
y_seq = np.array(y_seq)

# Diviser les données en train et test sets
train_size = int(len(X_seq) * 0.95)
X_train, X_test = X_seq[:train_size], X_seq[train_size:]
y_train, y_test = y_seq[:train_size], y_seq[train_size:]

# Définir le modèle RNN
model = Sequential()
model.add(LSTM(units=50, return_sequences=True, 
               input_shape=(X_train.shape[1], X_train.shape[2])))
model.add(Dropout(0.2))
model.add(LSTM(units=50, return_sequences=True))
model.add(Dropout(0.2))
model.add(LSTM(units=50))
model.add(Dropout(0.2))
model.add(Dense(units=1))

# Compiler le modèle
model.compile(optimizer='adam', loss='mean_squared_error')

# Entraîner le modèle
model.fit(X_train, y_train, epochs=100, batch_size=30)

# Faire des prédictions
y_pred = model.predict(X_test)
y_pred = scaler.inverse_transform(y_pred) # Revenir à l'échelle originale

# Évaluer le modèle
from sklearn.metrics import mean_squared_error
rmse = np.sqrt(mean_squared_error(scaler.inverse_transform(y_test), y_pred))
print('RMSE: ', rmse)

# Tracer les valeurs observées et prédites

plt.plot(scaler.inverse_transform(y_test), label='Dernier cours observé')
plt.plot(y_pred, label='Dernier cours prédite')
plt.legend()
plt.xlabel('Jours')
plt.ylabel('Dernier cours')
plt.title('Prédiction du dernier cours avec un modèle LSTM')
plt.show()
```

![Courbe de cours prédit et de cours observé](Documents/Rapport-PFE_files/figure-html/Prediction.png){#fig-Prediction_masi2}

## Application de calcul des CSR

Dans le cadre de ce projet, nous avons développé une application permettant de calculer les capitaux de solvabilité requis. Ce calcul passe par plusieurs étapes c'est pourquoi l'application contient plusieurs onglets :

-   **Paramètres** : les paramètres généraux de l'application; \_ **Courbe des taux** : construction de la courbe des taux zéro coupon; \_ **Non-vie hors rentes** : calcul des meilleures estimations pour une apération d'assurance non vie hors rente (exemple de l'accident de travail AT);
-   **Assurance vie** : calcul des meilleures estimations pour une apération d'assurance vie (exemple d'un capital garanti dégressif en cas de décès).

![Onglets de l'application](Documents/Rapport-PFE_files/figure-html/Onglets_App.png){#fig-onglets}

Cette application a été développée grâce a [Shiny](https://shiny.posit.co/) et une de ses extensions [bs4dash](https://rinterface.github.io/bs4Dash/index.html). En guise d'information, Shiny est un package R qui facilite la création d'applications Web interactives directement à partir de R. Vous pouvez héberger des applications autonomes sur une page Web ou les intégrer dans des documents *R Markdown* ou créer des tableaux de bord. Vous pouvez également étendre vos applications Shiny avec des thèmes *CSS*, des widgets *html* et des actions *JavaScript*, d'où l'intervention de {bs4Dash} dans ce projet. Il permet quant à lui de créer des tableaux de bord *Shiny* avec la technologie *Bootstrap 4*. Le choix du langage R pour développer cette application est motivé par la simplicité du package shiny et de plus ce langage nous est déjà familier puisque c'est l'un des plus utilisés en sciences de données.

L'application est une agglomération de codes et de calculs, son utilisation nécessite alors de claires indications.

### Navigation dans le code source

Le dossier de l'application contient trois fichiers principaux d'extention ".R". Le premier nommé *app.R* contient la partie ui (user interface) et server de l'application. Le socond, *functions.R* détient l'ensemble des fonctions que nous avons programmé et qui sont requis dans le fichier *app.R*. Le dernier fichier sert à automatiser l'installation de tous les packages nécessaire pour faire tourner l'applciation et nous l'avons nommé *installation packages.R*.

Les commentaires ont été faits de sorte à faciliter la navigation. Peut importe le fichier, vous pouvez commencer par contracter votre code comme indiqué dans la @fig-app_R. Cette dernière est celle du code contracté du fichier *app.R*. Comme vous pouvez le constater, les titres sont assez significatifs. Vous pouvez donc étendre la partie qui vous intéresse pour avoir accès au code. Cette astuce, simple qu'elle puisse paraître, est très utile pour naviguer dans le code source sachant que le nombre de lignes est pléthoriques.

![Fichier app.R](Documents/Rapport-PFE_files/figure-html/codes_app_R.png){#fig-app_R}

### Paramètres

Cet onglet est dédié à la spécification de certains paramètres de la normes *SBR*. Nous avons donné des valeurs par défaut puisque l'ACAPS n'a toujours pas quantifié de manière officielle ces paramètres. Dans cet onglet on trouve :

-   **Choc de mortalité** : représente le taux de choc de mortalité que nous avons fixé à $30\%$ selon les informations disponibles.

-   **Choc de catastrophe** : taux de hausse de la mortalité due à une catastrophe naturelle. Ce taux est fixé par défaut à $0,2\%$ puisque l'ACAPS ne l'a pas encore communiqué. Par catastrophe naturelle, on sous entend une circonstance particulière telle qu'une épidémie, un tremblement de terre etc,

-   **Probabilité de défaut** : représente la probabilité de défaut des cessionnaires. Nous avons pris la valeur de $1,2\%$ qui est la praba de défaut moyenne des réassureurs sur le marché,

-   **Cession vie** : est le taux de cession des engagements dans le cadre de l'opération d'assurance vie. Ce paramètre dépend du traité de réassurance, autrement dit c'est une entrée définie par l'utilsateur de l'application et non par l'ACAPS. pour les données dont nous disposons, ce taux est de $1\%$,

-   **Cession primes non-vie** : taux de cession des primes dans l'opération d'assurance non vie qui vaut $5\%$,

-   **Cession sinistres non-vie** : taux de cession des sinistres dans l'opération d'assurance non vie qui vaut $3\%$,

-   \*\*Augmentation des FG\* : taux d'augmentation des frais de gestions valant par défaut dans notre application $14\%$;

-   **Majoration des FG** : taux de majoration des frais de gestions qui correspond au taux d'augmentation annuelle pour les années de projection. Il vaut $1,5\%$;

![Apperçu de l'onglet paramètre](Documents/Rapport-PFE_files/figure-html/parametres.png){#fig-parametres}

### Courbe des taux

La construction de la courbe des taux zéro coupon est une étape cruciale du calcul de CSR. Nous avons inclus ce processus décrit dans le mémoire de fin d'étude. L'application donne la main à l'utilisateur de saisir une date de valeur, le 30 décembre 2022 pour notre étude. Cette date n'est rien d'autre que la date d'inventaire.

![Selection de la date de valeur](Documents/Rapport-PFE_files/figure-html/Date_zc.png){#fig-Date_zc}

En suite, l'application se charge de télécharger automatiquement la table des taux des bons de références disponibles sur le site de la Banque Centrale BAM. Cette table est alors utilisée pour faire une interpolation afin de trouver les taux correspondant aux maturités pleines. On utilise ces derniers pour calculer d'abord les taux actuariels et par ricochet les taux zéro coupon. Dans cet onglet, on peut trouver les différentes étapes suivies pour la construction de la courbe des taux zéro coupon, du téléchargement des données au boostraping. De plus, toutes les tables sont exportables sous format pdf, excel, ou csv.

![Apperçu de la courbe des taux zéro-coupon dans l'application](Documents/Rapport-PFE_files/figure-html/TauxZC2.png){#fig-tzc_app}

![Zoom sur la courbe de taux zéro coupon (En bleue)](Documents/Rapport-PFE_files/figure-html/tauxZC.png){#fig-tzc}

Une fois la courbe construite, nous allons l'utiliser dans la suite de notre application pour le calcul des tous les flux futurs actualisés dont nous aurons besoin.

### Opérations d'assurance non-vie hors rente

Pour cette opération, l'entreprise d'accueil a mis à notre disposition une base de données sur l'assurance Accident de Travail (AT). Il s'agit d'un triangle de règlements cumulés d'une assurance AT.

<table class=" lightable-material lightable-striped" style='font-family: "Source Sans Pro", helvetica, sans-serif; margin-left: auto; margin-right: auto;'>
 <thead>
  <tr>
   <th style="text-align:right;"> ...1 </th>
   <th style="text-align:right;"> 0 </th>
   <th style="text-align:right;"> 1 </th>
   <th style="text-align:right;"> 2 </th>
   <th style="text-align:right;"> 3 </th>
   <th style="text-align:right;"> 4 </th>
   <th style="text-align:right;"> 5 </th>
   <th style="text-align:right;"> 6 </th>
   <th style="text-align:right;"> 7 </th>
   <th style="text-align:right;"> 8 </th>
   <th style="text-align:right;"> 9 </th>
   <th style="text-align:right;"> 10 </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> 2012 </td>
   <td style="text-align:right;"> 3504.000 </td>
   <td style="text-align:right;"> 17838.65 </td>
   <td style="text-align:right;"> 29762.13 </td>
   <td style="text-align:right;"> 37354.13 </td>
   <td style="text-align:right;"> 48113.13 </td>
   <td style="text-align:right;"> 54288.92 </td>
   <td style="text-align:right;"> 60990.92 </td>
   <td style="text-align:right;"> 64953.92 </td>
   <td style="text-align:right;"> 67075.06 </td>
   <td style="text-align:right;"> 67961.14 </td>
   <td style="text-align:right;"> 69073.14 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2013 </td>
   <td style="text-align:right;"> 4774.242 </td>
   <td style="text-align:right;"> 14225.85 </td>
   <td style="text-align:right;"> 24891.85 </td>
   <td style="text-align:right;"> 38451.85 </td>
   <td style="text-align:right;"> 45605.98 </td>
   <td style="text-align:right;"> 54219.98 </td>
   <td style="text-align:right;"> 57611.98 </td>
   <td style="text-align:right;"> 61752.56 </td>
   <td style="text-align:right;"> 62906.74 </td>
   <td style="text-align:right;"> 64306.33 </td>
   <td style="text-align:right;"> 0.00 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2014 </td>
   <td style="text-align:right;"> 3821.918 </td>
   <td style="text-align:right;"> 12489.92 </td>
   <td style="text-align:right;"> 28284.92 </td>
   <td style="text-align:right;"> 39782.63 </td>
   <td style="text-align:right;"> 46485.63 </td>
   <td style="text-align:right;"> 51429.63 </td>
   <td style="text-align:right;"> 53462.05 </td>
   <td style="text-align:right;"> 54797.99 </td>
   <td style="text-align:right;"> 55771.01 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.00 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2015 </td>
   <td style="text-align:right;"> 4074.000 </td>
   <td style="text-align:right;"> 19021.00 </td>
   <td style="text-align:right;"> 35729.00 </td>
   <td style="text-align:right;"> 50865.00 </td>
   <td style="text-align:right;"> 58417.00 </td>
   <td style="text-align:right;"> 62138.27 </td>
   <td style="text-align:right;"> 63510.56 </td>
   <td style="text-align:right;"> 64673.57 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.00 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2016 </td>
   <td style="text-align:right;"> 5070.000 </td>
   <td style="text-align:right;"> 19512.00 </td>
   <td style="text-align:right;"> 41560.00 </td>
   <td style="text-align:right;"> 51917.00 </td>
   <td style="text-align:right;"> 59168.44 </td>
   <td style="text-align:right;"> 66278.59 </td>
   <td style="text-align:right;"> 69647.56 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.00 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2017 </td>
   <td style="text-align:right;"> 3817.000 </td>
   <td style="text-align:right;"> 17940.00 </td>
   <td style="text-align:right;"> 27339.00 </td>
   <td style="text-align:right;"> 33666.67 </td>
   <td style="text-align:right;"> 37893.96 </td>
   <td style="text-align:right;"> 41649.41 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.00 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2018 </td>
   <td style="text-align:right;"> 7838.000 </td>
   <td style="text-align:right;"> 23756.00 </td>
   <td style="text-align:right;"> 34489.85 </td>
   <td style="text-align:right;"> 42665.27 </td>
   <td style="text-align:right;"> 51181.77 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.00 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2019 </td>
   <td style="text-align:right;"> 7690.000 </td>
   <td style="text-align:right;"> 29440.55 </td>
   <td style="text-align:right;"> 43027.97 </td>
   <td style="text-align:right;"> 56870.69 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.00 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2020 </td>
   <td style="text-align:right;"> 8935.000 </td>
   <td style="text-align:right;"> 27985.56 </td>
   <td style="text-align:right;"> 42675.50 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.00 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2021 </td>
   <td style="text-align:right;"> 4979.975 </td>
   <td style="text-align:right;"> 21154.81 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.00 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2022 </td>
   <td style="text-align:right;"> 5818.641 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.00 </td>
   <td style="text-align:right;"> 0.00 </td>
  </tr>
</tbody>
</table>

Notre application donne à l'utilsateur l'option de selectionner manuellement le triangle, au cas où ce dernier n'est pas cumulé, l'utilsateur peut cocher sur la case *Voulez vous cumuler le triangle ?* avant de confirmer la lecture (voir @fig-import). Les autres paramètres de cette fenêtre sont des paramètres généraux d'importation de données commun à tous les langages de programmation.

![Importation du triangle](Documents/Rapport-PFE_files/figure-html/importTrgle.png){#fig-import}

En plus du triangle, cet onglet de l'application a besoin des donnèes d'entrée telles que :

-   **Primes Acquises (PA)** : nécessaire pour le calcul du ratio de sinistralité qui pour rappel vaut $RS = \frac{\sum\limits_{i=n-2}^{n}CU_i}{\sum\limits_{i=n-2}^{n}PA_i}$ où CU représente les charges ultimes,

-   **PPNA** : provision pour primes non acquises à la date d'inventaire,

-   **Primes futurs** : le montant unique des primes futurs,

-   **Taux de frais d'acquisition** : Le taux de frais d'acquisition en assurance est le pourcentage de frais prélevé par l'assureur sur chaque versement effectué par l'assuré

-   **Taux de frais gestion moyens**

La @fig-parametrage donne un aperçu de l'endroit où ces paramètres sont requis et le @tbl-parametrage représente les données historiques de PA et PPNA dont nous avons besoin.

![Aperçu du paramétrage dans l'application](Documents/Rapport-PFE_files/figure-html/parametrage.png){#fig-parametrage}

<table class=" lightable-material lightable-striped" style='font-family: "Source Sans Pro", helvetica, sans-serif; margin-left: auto; margin-right: auto;'>
 <thead>
  <tr>
   <th style="text-align:right;"> Année </th>
   <th style="text-align:right;"> PA </th>
   <th style="text-align:right;"> PPNA </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> 2020 </td>
   <td style="text-align:right;"> 86292 </td>
   <td style="text-align:right;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2021 </td>
   <td style="text-align:right;"> 133944 </td>
   <td style="text-align:right;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2022 </td>
   <td style="text-align:right;"> 115787 </td>
   <td style="text-align:right;"> 25000 </td>
  </tr>
</tbody>
</table>

L'application supporte le calcul des meilleures estimations des engagements une fois tous les paramètres de cet onglet sont renseignés.

##### Meilleure estimation des engagements pour sinistres avec Chain Ladder {.unnumbered}

En suivant les étapes mentionnées à la méthode de Chain Ladder, on a obtenu les facteurs de développements présenté dans le tableau @tbl-fdev.

<table class=" lightable-material lightable-striped" style='font-family: "Source Sans Pro", helvetica, sans-serif; margin-left: auto; margin-right: auto;'>
 <thead>
  <tr>
   <th style="text-align:right;"> fdc1 </th>
   <th style="text-align:right;"> fdc2 </th>
   <th style="text-align:right;"> fdc3 </th>
   <th style="text-align:right;"> fdc4 </th>
   <th style="text-align:right;"> fdc5 </th>
   <th style="text-align:right;"> fdc6 </th>
   <th style="text-align:right;"> fdc7 </th>
   <th style="text-align:right;"> fdc8 </th>
   <th style="text-align:right;"> fdc9 </th>
   <th style="text-align:right;"> fdc10 </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> 3.7312 </td>
   <td style="text-align:right;"> 1.689 </td>
   <td style="text-align:right;"> 1.3263 </td>
   <td style="text-align:right;"> 1.177 </td>
   <td style="text-align:right;"> 1.1161 </td>
   <td style="text-align:right;"> 1.0585 </td>
   <td style="text-align:right;"> 1.045 </td>
   <td style="text-align:right;"> 1.0234 </td>
   <td style="text-align:right;"> 1.0176 </td>
   <td style="text-align:right;"> 1.0164 </td>
  </tr>
</tbody>
</table>

Ces facteurs sont ensuite utilisé pour remplir le triangle inférieur par la méthode de Chaine Ladder pour obtenir les règlements futurs (table ci-après @tbl-regF) cumulés dont la dernières colonnes représente les charges ultimes.

<table class=" lightable-material lightable-striped" style='font-family: "Source Sans Pro", helvetica, sans-serif; margin-left: auto; margin-right: auto;'>
 <thead>
  <tr>
   <th style="text-align:right;"> A\D </th>
   <th style="text-align:left;"> 0 </th>
   <th style="text-align:right;"> 1 </th>
   <th style="text-align:right;"> 2 </th>
   <th style="text-align:right;"> 3 </th>
   <th style="text-align:right;"> 4 </th>
   <th style="text-align:right;"> 5 </th>
   <th style="text-align:right;"> 6 </th>
   <th style="text-align:right;"> 7 </th>
   <th style="text-align:right;"> 8 </th>
   <th style="text-align:right;"> 9 </th>
   <th style="text-align:right;"> 10 </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> 2012 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2013 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 65358.53 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2014 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 56751.72 </td>
   <td style="text-align:right;"> 57680.30 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2015 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 66187.34 </td>
   <td style="text-align:right;"> 67351.21 </td>
   <td style="text-align:right;"> 68453.23 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2016 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 72782.18 </td>
   <td style="text-align:right;"> 74485.74 </td>
   <td style="text-align:right;"> 75795.54 </td>
   <td style="text-align:right;"> 77035.73 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2017 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 44085.75 </td>
   <td style="text-align:right;"> 46069.91 </td>
   <td style="text-align:right;"> 47148.24 </td>
   <td style="text-align:right;"> 47977.31 </td>
   <td style="text-align:right;"> 48762.33 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2018 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 57122.55 </td>
   <td style="text-align:right;"> 60464.00 </td>
   <td style="text-align:right;"> 63185.29 </td>
   <td style="text-align:right;"> 64664.23 </td>
   <td style="text-align:right;"> 65801.32 </td>
   <td style="text-align:right;"> 66877.98 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2019 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 66936.99 </td>
   <td style="text-align:right;"> 74706.50 </td>
   <td style="text-align:right;"> 79076.55 </td>
   <td style="text-align:right;"> 82635.54 </td>
   <td style="text-align:right;"> 84569.73 </td>
   <td style="text-align:right;"> 86056.85 </td>
   <td style="text-align:right;"> 87464.94 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2020 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 56599.12 </td>
   <td style="text-align:right;"> 66617.36 </td>
   <td style="text-align:right;"> 74349.77 </td>
   <td style="text-align:right;"> 78698.95 </td>
   <td style="text-align:right;"> 82240.95 </td>
   <td style="text-align:right;"> 84165.90 </td>
   <td style="text-align:right;"> 85645.92 </td>
   <td style="text-align:right;"> 87047.28 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2021 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 35731.44 </td>
   <td style="text-align:right;"> 47389.45 </td>
   <td style="text-align:right;"> 55777.54 </td>
   <td style="text-align:right;"> 62251.75 </td>
   <td style="text-align:right;"> 65893.24 </td>
   <td style="text-align:right;"> 68858.89 </td>
   <td style="text-align:right;"> 70470.62 </td>
   <td style="text-align:right;"> 71709.81 </td>
   <td style="text-align:right;"> 72883.15 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2022 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> 21710.35 </td>
   <td style="text-align:right;"> 36669.78 </td>
   <td style="text-align:right;"> 48633.93 </td>
   <td style="text-align:right;"> 57242.31 </td>
   <td style="text-align:right;"> 63886.54 </td>
   <td style="text-align:right;"> 67623.65 </td>
   <td style="text-align:right;"> 70667.19 </td>
   <td style="text-align:right;"> 72321.24 </td>
   <td style="text-align:right;"> 73592.98 </td>
   <td style="text-align:right;"> 74797.13 </td>
  </tr>
</tbody>
</table>

On en déduit facilement les flux de règlements futurs en faisant la sommes des élments du triangle inférieur décumulé. Par suite, on obtient les cashflows pour les 10 années de projections suivants :

<table class=" lightable-material lightable-striped" style='font-family: "Source Sans Pro", helvetica, sans-serif; margin-left: auto; margin-right: auto;'>
 <thead>
  <tr>
   <th style="text-align:right;"> Année </th>
   <th style="text-align:right;"> Flux de règlements futurs nets de recours </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> 2023 </td>
   <td style="text-align:right;"> 69516.673 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2024 </td>
   <td style="text-align:right;"> 53526.816 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2025 </td>
   <td style="text-align:right;"> 38666.143 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2026 </td>
   <td style="text-align:right;"> 26538.953 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2027 </td>
   <td style="text-align:right;"> 17684.015 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2028 </td>
   <td style="text-align:right;"> 11191.502 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2029 </td>
   <td style="text-align:right;"> 7543.367 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2030 </td>
   <td style="text-align:right;"> 4294.611 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2031 </td>
   <td style="text-align:right;"> 2445.069 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2032 </td>
   <td style="text-align:right;"> 1204.150 </td>
  </tr>
</tbody>
</table>

Une actualisation des cash flows de la @tbl-cash par la courbe des taux zéro coupon s'opère automatiquement par l'application pour effectuer le calcul de la meilleure estimation des engagements pour sinistres :

$$
BES = 213\;799\; \text{MAD}
$$

##### Meilleure estimation des engagements pour prime ($BEP$) {.unnumbered}

Pour le calcul de la $BEP$, nous avons besoin du ration de sinitralité ($RS = \frac{\sum\limits_{i=n-2}^{n}CU_i}{\sum\limits_{i=n-2}^{n}PA_i}$). Notre application calcule ce ratio à partir des PA données en input puisque nous disposons déjà des charges ultimes, qui, nous le rappelons, correspondent aux éléments de la dernière colonne de la @tbl-regF. Ainsi nous obtenons les paramètres suivants :

<table class=" lightable-material lightable-striped" style='font-family: "Source Sans Pro", helvetica, sans-serif; margin-left: auto; margin-right: auto;'>
 <thead>
  <tr>
   <th style="text-align:left;"> Parametre </th>
   <th style="text-align:left;"> Valeur </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> RS </td>
   <td style="text-align:left;"> 0,698546111 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> PPNA </td>
   <td style="text-align:left;"> 25000 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Primes futurs </td>
   <td style="text-align:left;"> 100000 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Taux de frais d'acquisition </td>
   <td style="text-align:left;"> 0,1 </td>
  </tr>
</tbody>
</table>

Après détermination des cadences de liquidation, nous trouve comme meilleure estimation des engagements pour prime :

$$
BEP = -16\;907\; \text{MAD}
$$

Ce résultat négatif s'explique par le montant des primes primes futurs. En effet, du fait que cette prime soit unique et importante, au moment de l'inventaire, l'asssureur a encaissé plus qu'il ne doit décaisser d'ici 10 ans pour les engagements correspondants. Par conséquent, puis que la meilleure estimation correspond à la différence entre les décaiseement et les encaissements, alors c'est pourquoi la $BEP$ est négative.

<table class=" lightable-material lightable-striped" style='font-family: "Source Sans Pro", helvetica, sans-serif; margin-left: auto; margin-right: auto;'>
 <thead>
  <tr>
   <th style="text-align:left;"> Cad.0 </th>
   <th style="text-align:left;"> Cad.1 </th>
   <th style="text-align:left;"> Cad.2 </th>
   <th style="text-align:left;"> Cad.3 </th>
   <th style="text-align:left;"> Cad.4 </th>
   <th style="text-align:left;"> Cad.5 </th>
   <th style="text-align:left;"> Cad.6 </th>
   <th style="text-align:left;"> Cad.7 </th>
   <th style="text-align:left;"> Cad.8 </th>
   <th style="text-align:left;"> Cad.9 </th>
   <th style="text-align:left;"> Cad.10 </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 7,78% </td>
   <td style="text-align:left;"> 21,25% </td>
   <td style="text-align:left;"> 20,00% </td>
   <td style="text-align:left;"> 16,00% </td>
   <td style="text-align:left;"> 11,51% </td>
   <td style="text-align:left;"> 8,88% </td>
   <td style="text-align:left;"> 5,00% </td>
   <td style="text-align:left;"> 4,07% </td>
   <td style="text-align:left;"> 2,21% </td>
   <td style="text-align:left;"> 1,70% </td>
   <td style="text-align:left;"> 1,61% </td>
  </tr>
</tbody>
</table>

![Output des cadences de liquidations dans l'application](Documents/Rapport-PFE_files/figure-html/cad.png)

##### Meilleure estimation des frais de gestions ($BEFG$) {.unnumbered}

Le taux moyen des trois dernières années des frais de gestions étant de $3\%$, on aboutit au résultat :

$$
 BEFG = 59\;067\;\text{MAD}
 $$

![Affichages des BE dans l'application](Documents/Rapport-PFE_files/figure-html/BENV.png)

### Opérations d'assurance vie

Dans ce projet nous avons étudié le cas d'un capital décès dégressif. Ce dernier est un type de capital versé aux bénéficiaires d'une assurance décès qui diminue progressivement avec le temps, jusqu'à atteindre un capital nul. Ce type de capital est utile pour couvrir un besoin financier important lors des premières années de l'assurance (hypothèque, crédit, enfants à charge, etc.) et qui diminue au fil du temps. Comme dans le cas du triangle, l'utilisateur de notre application peut parcourir son ordinateur afin de sélectionner la table de données qui doit contenir au moins les colonnes suivantes :

-   **Age de l'assuré**,
-   **Année d'effet du contrat**,
-   **Durée du contrat**,
-   **Durée restante du contrat**,
-   **Le capital initial**.

L'utilisateur doit sélectionner les colonnes mentionner sous-dessus puis renseigné les frais de gestions unitaire moyen qui est de $100$ pour notre étude.

![Importation des données (Capital Décès Dégressif)](Documents/Rapport-PFE_files/figure-html/dec_import.png){#fig-dec_import}

<table class=" lightable-material lightable-striped" style='font-family: "Source Sans Pro", helvetica, sans-serif; margin-left: auto; margin-right: auto;'>
 <thead>
  <tr>
   <th style="text-align:right;"> ID </th>
   <th style="text-align:right;"> Age </th>
   <th style="text-align:right;"> Année.d'effet </th>
   <th style="text-align:right;"> Ann_e_d_expiration </th>
   <th style="text-align:right;"> Dur_e_de_contrat </th>
   <th style="text-align:right;"> Durre.contrat.restante </th>
   <th style="text-align:right;"> Prime </th>
   <th style="text-align:right;"> Capital_d_c_s_initial </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> 1400001 </td>
   <td style="text-align:right;"> 46 </td>
   <td style="text-align:right;"> 2017 </td>
   <td style="text-align:right;"> 2037 </td>
   <td style="text-align:right;"> 20 </td>
   <td style="text-align:right;"> 15 </td>
   <td style="text-align:right;"> 55624 </td>
   <td style="text-align:right;"> 2625000 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 1400002 </td>
   <td style="text-align:right;"> 43 </td>
   <td style="text-align:right;"> 2017 </td>
   <td style="text-align:right;"> 2042 </td>
   <td style="text-align:right;"> 25 </td>
   <td style="text-align:right;"> 20 </td>
   <td style="text-align:right;"> 94684 </td>
   <td style="text-align:right;"> 1785000 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 1400003 </td>
   <td style="text-align:right;"> 35 </td>
   <td style="text-align:right;"> 2014 </td>
   <td style="text-align:right;"> 2039 </td>
   <td style="text-align:right;"> 25 </td>
   <td style="text-align:right;"> 17 </td>
   <td style="text-align:right;"> 4113 </td>
   <td style="text-align:right;"> 262500 </td>
  </tr>
</tbody>
</table>

#### Tableau d'amortissement {.unnumbered}

Le capital étant dégressif, il est primordial de voir comment se capital est amorti tout au long de la durée du contrat. Voici un exemple d'ammortissemnt d'un contrat de durée $25\;ans$, de date d'effet 2017, de capital initial $1\;785\;000\;\text{MAD}$. Le montant des annuités vaut $114\;261\;\text{MAD}$ sachant que le taux d'intérêt est de $4\%$.

<table class=" lightable-material lightable-striped" style='font-family: "Source Sans Pro", helvetica, sans-serif; margin-left: auto; margin-right: auto;'>
 <thead>
  <tr>
   <th style="text-align:right;"> Annee </th>
   <th style="text-align:right;"> CRP </th>
   <th style="text-align:right;"> Intérêts </th>
   <th style="text-align:right;"> Amortissement </th>
   <th style="text-align:right;"> Annuité </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> 2017 </td>
   <td style="text-align:right;"> 1785000 </td>
   <td style="text-align:right;"> 71400 </td>
   <td style="text-align:right;"> 42861 </td>
   <td style="text-align:right;"> 114261 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2018 </td>
   <td style="text-align:right;"> 1742139 </td>
   <td style="text-align:right;"> 69686 </td>
   <td style="text-align:right;"> 44576 </td>
   <td style="text-align:right;"> 114261 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2019 </td>
   <td style="text-align:right;"> 1697563 </td>
   <td style="text-align:right;"> 67903 </td>
   <td style="text-align:right;"> 46359 </td>
   <td style="text-align:right;"> 114261 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2020 </td>
   <td style="text-align:right;"> 1651204 </td>
   <td style="text-align:right;"> 66048 </td>
   <td style="text-align:right;"> 48213 </td>
   <td style="text-align:right;"> 114261 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2021 </td>
   <td style="text-align:right;"> 1602991 </td>
   <td style="text-align:right;"> 64120 </td>
   <td style="text-align:right;"> 50142 </td>
   <td style="text-align:right;"> 114261 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2022 </td>
   <td style="text-align:right;"> 1552849 </td>
   <td style="text-align:right;"> 62114 </td>
   <td style="text-align:right;"> 52147 </td>
   <td style="text-align:right;"> 114261 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2023 </td>
   <td style="text-align:right;"> 1500702 </td>
   <td style="text-align:right;"> 60028 </td>
   <td style="text-align:right;"> 54233 </td>
   <td style="text-align:right;"> 114261 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2024 </td>
   <td style="text-align:right;"> 1446468 </td>
   <td style="text-align:right;"> 57859 </td>
   <td style="text-align:right;"> 56403 </td>
   <td style="text-align:right;"> 114261 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2025 </td>
   <td style="text-align:right;"> 1390066 </td>
   <td style="text-align:right;"> 55603 </td>
   <td style="text-align:right;"> 58659 </td>
   <td style="text-align:right;"> 114261 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2026 </td>
   <td style="text-align:right;"> 1331407 </td>
   <td style="text-align:right;"> 53256 </td>
   <td style="text-align:right;"> 61005 </td>
   <td style="text-align:right;"> 114261 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2027 </td>
   <td style="text-align:right;"> 1270402 </td>
   <td style="text-align:right;"> 50816 </td>
   <td style="text-align:right;"> 63445 </td>
   <td style="text-align:right;"> 114261 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2028 </td>
   <td style="text-align:right;"> 1206957 </td>
   <td style="text-align:right;"> 48278 </td>
   <td style="text-align:right;"> 65983 </td>
   <td style="text-align:right;"> 114261 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2029 </td>
   <td style="text-align:right;"> 1140974 </td>
   <td style="text-align:right;"> 45639 </td>
   <td style="text-align:right;"> 68622 </td>
   <td style="text-align:right;"> 114261 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2030 </td>
   <td style="text-align:right;"> 1072351 </td>
   <td style="text-align:right;"> 42894 </td>
   <td style="text-align:right;"> 71367 </td>
   <td style="text-align:right;"> 114261 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2031 </td>
   <td style="text-align:right;"> 1000984 </td>
   <td style="text-align:right;"> 40039 </td>
   <td style="text-align:right;"> 74222 </td>
   <td style="text-align:right;"> 114261 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2032 </td>
   <td style="text-align:right;"> 926762 </td>
   <td style="text-align:right;"> 37070 </td>
   <td style="text-align:right;"> 77191 </td>
   <td style="text-align:right;"> 114261 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2033 </td>
   <td style="text-align:right;"> 849571 </td>
   <td style="text-align:right;"> 33983 </td>
   <td style="text-align:right;"> 80279 </td>
   <td style="text-align:right;"> 114261 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2034 </td>
   <td style="text-align:right;"> 769293 </td>
   <td style="text-align:right;"> 30772 </td>
   <td style="text-align:right;"> 83490 </td>
   <td style="text-align:right;"> 114261 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2035 </td>
   <td style="text-align:right;"> 685803 </td>
   <td style="text-align:right;"> 27432 </td>
   <td style="text-align:right;"> 86829 </td>
   <td style="text-align:right;"> 114261 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2036 </td>
   <td style="text-align:right;"> 598974 </td>
   <td style="text-align:right;"> 23959 </td>
   <td style="text-align:right;"> 90302 </td>
   <td style="text-align:right;"> 114261 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2037 </td>
   <td style="text-align:right;"> 508671 </td>
   <td style="text-align:right;"> 20347 </td>
   <td style="text-align:right;"> 93915 </td>
   <td style="text-align:right;"> 114261 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2038 </td>
   <td style="text-align:right;"> 414757 </td>
   <td style="text-align:right;"> 16590 </td>
   <td style="text-align:right;"> 97671 </td>
   <td style="text-align:right;"> 114261 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2039 </td>
   <td style="text-align:right;"> 317086 </td>
   <td style="text-align:right;"> 12683 </td>
   <td style="text-align:right;"> 101578 </td>
   <td style="text-align:right;"> 114261 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2040 </td>
   <td style="text-align:right;"> 215508 </td>
   <td style="text-align:right;"> 8620 </td>
   <td style="text-align:right;"> 105641 </td>
   <td style="text-align:right;"> 114261 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2041 </td>
   <td style="text-align:right;"> 109867 </td>
   <td style="text-align:right;"> 4395 </td>
   <td style="text-align:right;"> 109867 </td>
   <td style="text-align:right;"> 114261 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2042 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0 </td>
  </tr>
</tbody>
</table>

Ce calcul se fait automatiquement par l'application à partir de la table de données.

#### Projection du capital ammorti {.unnumbered}

Maintenant que nous disposant du capital amorti pour la durée du contrat, l'étape qui s'en suit est de déterminer la valeur probable de ce capital. On sait que ce capital sera versé qu'en cas de décès de l'assuré. Alors, pour une année $j$ de projection de donnée, le capital restant ($VPC$) est versé que si l'assuré d'âge $x$ survit jusqu'à l'année $j-1$ et décède à l'année $j$. En terme mathématiques :

$$
VPC = _{j-1}p_x \times q_{x+j}*CRP_i
$$

#### Résultats et interprétations {.unnumbered}

L'onglet dédié à cette opération d'assurance de capital décès dégressif, après tout calcul, fournit les résultat suivants :

<table class=" lightable-material lightable-striped" style='font-family: "Source Sans Pro", helvetica, sans-serif; margin-left: auto; margin-right: auto;'>
 <thead>
  <tr>
   <th style="text-align:left;"> Meilleure estimation des garanties probabilisées </th>
   <th style="text-align:left;"> Meilleure estimation des frais de gestions </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 183 895 103 </td>
   <td style="text-align:left;"> 3 725 418 </td>
  </tr>
</tbody>
</table>

![Apperçu des résultat dans l'application](Documents/Rapport-PFE_files/figure-html/BE_VIE.png)

### Part des cessionnaires

La part des cessionnaires est déterminées conformément aux spécification techniques de l'ACAPS. Les taux de cession sont fournis dans l'onglet paramètres et peuvent être modifiés en fonction du traité de réassurance correspondant à l'étude :

-   **Taux de cession des engagements vie** : $1\%$,

-   **Taux de cession primes non-vie** : $5\%$,

-   **Taux de cession sinistres non-vie** : $3\%$.

La meilleure estimations des engagements pour primes non-vie étant négative, on s'attend aussi à une cession négative des primes.

![Part des cessionnaires](Documents/Rapport-PFE_files/figure-html/cession.png){#fig-cession}

### Capital de solvabilité requis

En tenant compte des paramètres renseigné dans le premier onglet ainsi que de tous les calculs effectués dans les autres onglets, il en ressort les capitaux de solvabilité requis pour les risque de souscription vie et non vie indiqué à la figure suivante :

<table class=" lightable-material lightable-striped" style='font-family: "Source Sans Pro", helvetica, sans-serif; margin-left: auto; margin-right: auto;'>
<tbody>
  <tr>
   <td style="text-align:left;"> CSR Souscription vie </td>
   <td style="text-align:left;"> CSR Souscription non-vie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 52 496 918 </td>
   <td style="text-align:left;"> 197 616 </td>
  </tr>
</tbody>
</table>

<table class=" lightable-material lightable-striped" style='font-family: "Source Sans Pro", helvetica, sans-serif; margin-left: auto; margin-right: auto;'>
<tbody>
  <tr>
   <td style="text-align:left;"> CSR mortalité </td>
   <td style="text-align:left;"> CSR catastrophe </td>
   <td style="text-align:left;"> CSR frais </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 52 485 959 </td>
   <td style="text-align:left;"> 353 884 </td>
   <td style="text-align:left;"> 1 012 563 </td>
  </tr>
</tbody>
</table>

<table class=" lightable-material lightable-striped" style='font-family: "Source Sans Pro", helvetica, sans-serif; margin-left: auto; margin-right: auto;'>
<tbody>
  <tr>
   <td style="text-align:left;"> Marge de risque non-vie </td>
   <td style="text-align:left;"> Marge de risque vie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 9 338 125 </td>
   <td style="text-align:left;"> 19 965 000 </td>
  </tr>
</tbody>
</table>

![les CSR calculés](Documents/Rapport-PFE_files/figure-html/CSR.png){#fig-csr}

Nous avons supposé que les sous risques sont indépendants entendant la publication de la matrice de corrélation entre ces sous-risques.
