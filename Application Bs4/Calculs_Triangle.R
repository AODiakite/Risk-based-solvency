# Importation du triangle de reglement A.T
TriangleRgleAT <- read_excel("Data/TriangleRgle.xlsx")
names(TriangleRgleAT)[1] <- "Annee"
TriangleRgleAT = TriangleRgleAT[,-1]
TriangleRgleAT = as.matrix(TriangleRgleAT)

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
  cumul = triangle
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
  cumul = triangle
  n = nrow(cumul)
  # Calculer les facteurs de développement individuels par année de développement
  for (j in 1:(n-1)) {
    numerateur = sum(cumul[1:(n-j),j+1])
    denominateur = sum(cumul[1:(n-j),j])
    fdc[j] = numerateur/denominateur
  }
  # Renvoyer la matrice des facteurs de développement individuels
  return(fdc)
}
fdc = calculer_fdc(triangle)
#  Les règlements cumulés futurs estimés
C_hat <- function(triangle,fdc){
  # Vérifier que le triangle est une matrice carrée
  if (!is.matrix(triangle) || nrow(triangle) != ncol(triangle)) {
    stop("Le triangle doit être une matrice carrée")
  }
  # Initialiser la matrice de sortie
  n = nrow(triangle)
  # Calculer les montants cumulés des sinistres réglés par année de développement
  cumul = triangle
  fdc = c(fdc,1)
  # Construction du prod des fdc
  resultat = Map(\(x) cumprod(fdc[x:n]), x =n:1)
  resultat = Map(\(x) append(x[-length(x)],NA,0), x= resultat)
  # On prend les elements de la diagonale secondaire
  Diag = diag(apply(cumul,1,rev))
  # On applique la formule
  resultat = Map(\(x,y) x*y, x =resultat, y = Diag)
  resultat = Map(\(x,y) c(rep(NA,x-1),y), x = n:1, y = resultat)
  resultat = matrix(unlist(resultat), nrow = n, byrow = TRUE)
  resultat

}

Diag = diag(apply(triangle,1,rev))
c_hat <- C_hat(triangle = triangle,fdc = fdc)
PSAP = sum(c_hat[,n] - Diag,na.rm = TRUE)



# Constitution du triangle des règlements décumulés futurs par année de survenance :

# Triangle decumulé
decumul_tri <- function(triangle, c_hat){
  n = nrow(triangle)
  cumul = triangle
  triangleGLobal = matrix(nrow = n, ncol = n)
  decumul = matrix(nrow = n, ncol = n)
  for (i in 1:n) {
    for (j in 1:n) {
      triangleGLobal[i,j] = sum(c(cumul[i,j], c_hat[i,j]),na.rm = TRUE)
    }
  }

  decumul = triangleGLobal
  for (i in 1:n) {
    decumul[i,2:n] = triangleGLobal[i,2:n] - triangleGLobal[i,1:(n-1)]
  }
  decumul
}

decumul = decumul_tri(triangle,c_hat)

R_hat <- function(decumul){
  # On renverse la matrice decumuler pour faciliter l'obtention des diags secondaires
  rev_decumul =  apply(decumul,1,rev)
  n = nrow(decumul)
  r_hat = c()
  for (i in 1:(n-1)) {
    r_hat[i] = sum(diag(rev_decumul[1:(n-i+1),i:n]))
  }
  r_hat[n] = rev_decumul[1,n]
  r_hat[-1]
}

r_hat = R_hat(decumul)

# La meilleure estimation des engagements pour sinistres nets -----
BE_Sinistre = sum(r_hat/((1+TZC$`Taux zéro coupon`[1:length(r_hat)])^(1:length(r_hat))))


