# calcule de la proba de survie:
tPx <- function(age, annee,data) {
  # Charger la table de mortalité à partir du fichier Excel
  data = readxl::read_excel("TD-88-90.xlsx")

  # Trouver la ligne correspondant aux annee specifie
  ligne_age_debut <- which(data$age == age)
  ligne_age_arret <- which(data$age == age+annee)

  proba_survie = data[ligne_age_arret,2] / data[ligne_age_debut,2]

  return(proba_survie)
}
# tester la fonction:
tPx(0,10)

# calcule de la proba de deces:
tQx <- function(age, annee) {
  proba_deces = 1-proba_survie(age,annee)
  return(proba_deces)
}

# tester la fonction:
tQx(0,10)
























