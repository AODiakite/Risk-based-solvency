# calcule de la proba de survie:
proba_survie <- function(age, annee) {
  # Charger la table de mortalité à partir du fichier Excel
  data = readxl::read_excel("TD-88-90.xlsx")
  
  # Trouver la ligne correspondant aux annee specifie
  ligne_age_debut <- which(data$age == age)
  ligne_age_arret <- which(data$age == age+annee)
  
  proba_survie = data[ligne_age_arret,2] / data[ligne_age_debut,2]
  
  return(proba_survie)
}
# tester la fonction:
proba_survie(0,10)

# calcule de la proba de deces:
proba_deces <- function(age, annee) {
  proba_deces = 1-proba_survie(age,annee)
  return(proba_deces)
}

# tester la fonction:
proba_deces(0,10)
























