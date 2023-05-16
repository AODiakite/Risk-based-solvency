# Importation du triangle de reglement A.T
TriangleRgleAT <- read_excel("Data/TriangleRgle.xlsx")
names(TriangleRgleAT)[1] <- "Annee"
TriangleRgleAT = TriangleRgleAT[,-1]
TriangleRgleAT = as.matrix(TriangleRgleAT)
cumul <- t(apply(TriangleRgleAT, 1, cumsum))

# Calcul des facteurs de développement individuels ----

# Définir une fonction qui calcule les facteurs de développement individuels à partir d'un triangle de règlement
# Le triangle de règlement doit être une matrice carrée avec les années de survenance en lignes et les années de développement en colonnes
# La fonction renvoie une matrice de même dimension que le triangle de règlement, avec les facteurs de développement individuels en diagonale et des NA ailleurs

calculer_fdi <- function(triangle){
  # Vérifier que le triangle est une matrice carrée
  if (!is.matrix(triangle) || nrow(triangle) != ncol(triangle)) {
    stop("Le triangle doit être une matrice carrée")
  }
  # Initialiser la matrice de sortie
  fdi <- matrix(NA, nrow = nrow(triangle), ncol = ncol(triangle)-1)
  # Calculer les montants cumulés des sinistres réglés par année de développement
  cumul = t(apply(triangle, 1, cumsum))
  # Calculer les facteurs de développement individuels par année de développement
  for (i in 1:nrow(cumul)) {
    fdi[i, ] <- cumul[i, -1] / cumul[i, -ncol(cumul)]
  }
  # Renvoyer la matrice des facteurs de développement individuels
  return(fdi)
}

# Calcul des facteurs de développement communs ------

calculer_fdc <- function(triangle){
  # Vérifier que le triangle est une matrice carrée
  if (!is.matrix(triangle) || nrow(triangle) != ncol(triangle)) {
    stop("Le triangle doit être une matrice carrée")
  }
  # Initialiser le vecteur de sortie
  fdc <- c()
  # Calculer les montants cumulés des sinistres réglés par année de développement
  cumul = t(apply(triangle, 1, cumsum))
  n = nrow(cumul)
  # Calculer les facteurs de développement individuels par année de développement
  for (j in 1:(n-1)) {
    numerateur = sum(cumul[1:(n-j),j+1])
    denominateur = sum(cumul[1:(n-j+1),j])
    fdc[j] = numerateur/denominateur
  }
  # Renvoyer la matrice des facteurs de développement individuels
  return(fdc)
}

#  Les règlements cumulés futurs estimés
C_hat <- function(triangle,fdc){
  # Vérifier que le triangle est une matrice carrée
  if (!is.matrix(triangle) || nrow(triangle) != ncol(triangle)) {
    stop("Le triangle doit être une matrice carrée")
  }
  # Initialiser la matrice de sortie
  n = nrow(triangle)
  c_hat <- matrix(nrow = n,ncol = n)
  # Calculer les montants cumulés des sinistres réglés par année de développement
  cumul = t(apply(triangle, 1, cumsum))
  fdc = c(1,fdc)
  for (i in 1:n) {

      c_hat[i,(n-i+1):n] = cumul[i,n-i+1]*cumprod(fdc[(n-i+1):n])


  }
  c_hat

}
c_hat <- C_hat(triangle = triangle,fdc = fdc)



