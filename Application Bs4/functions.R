library(tidyverse)
library(bslib)
library(readxl)
library(bsicons)
library(glue)
library(rvest)
library(scales)
options(warn = -1)
library(bs4Dash)
library(shiny)
library(shinybusy)
library(shinyalert)
library(argonDash)
library(argonR)
library(thematic)
library(plotly)
library(thematic)
# Taux de référence des bons de trésor -------

get_taux_BAM <- function(DATE = "2021-12-30"){
  tryCatch(
    {
      DATE = ymd(DATE)
      d = day(DATE)
      m = month(DATE)
      y = year(DATE)
      link = glue("https://www.bkam.ma/Marches/Principaux-indicateurs/Marche-obligataire/Marche-des-bons-de-tresor/Marche-secondaire/Taux-de-reference-des-bons-du-tresor?date={d}%2F{m}%2F{y}&block=e1d6b9bbf87f86f8ba53e8518e882982#address-c3367fcefc5f524397748201aee5dab8-e1d6b9bbf87f86f8ba53e8518e882982")
      TRBT = read_html(link) %>%
        html_element("table") %>%
        html_table()
      TRBT = TRBT %>%
        mutate(Maturité = as.integer(dmy(`Date d'échéance`)-dmy(`Date de la valeur`)),
               Maturité = round(Maturité/360,3),
               `Taux moyen pondéré (%)` = `Taux moyen pondéré`,
               `Taux moyen pondéré` = parse_number(`Taux moyen pondéré`,
                                                   locale = locale(decimal_mark = ",")),
               `Taux moyen pondéré` = `Taux moyen pondéré`/100
        ) %>%
        relocate(`Taux moyen pondéré (%)`,.after = `Taux moyen pondéré`) %>%
        na.omit()
      Message = c("Ok !", "Téléchargement effectuer avec succès !","success")
      shinyalert(Message[1], Message[2] , type = Message[3])

    TRBT
    },
    error = function(e){
      Message = c("Oops !", "Le télécharment a échoué. Des données ne sont pas disponibles pour cette date ou vous n'avez pas accès à internet","error")
      shinyalert(Message[1], Message[2] , type = Message[3])
      return(0)
    }
  )
}

# Conversion du taux monétaire en taux actuariel ----
#' taux_BAM : Représente la table de taux obtenu grace à la fonction get_taux_BAM
#' Valeurs retournées : Data frame
#' Contenue du DF retournée : Maturité, Taux actuariel, Taux actuariel en pourcentage
get_taux_act <- function(taux_BAM){
  m = taux_BAM$Maturité # Maturité en annee
  tm = taux_BAM$`Taux moyen pondéré` # Taux monetaire
  TA = ifelse((tm*m/tm) <= 1, (1+tm*m)^(365/(360*m))-1, tm)
  tibble(Maturité = m,
         `Taux actuariel` = round(TA,5),
         `Taux actuariel (%)` = gsub("\\.",",",paste0(round(TA*100,3),"%"))
  )
}

# Interpolation des taux actuariels pour avoir des taux de Maturité pleine ----
#' TA : La table de taux actuariel obtenue grace à la fonction get_taux_act
#' Valeurs retournées : Data frame
#' Contenue du DF retournée : Maturité, Taux actuariel, Taux actuariel en pourcentage
interpolation <- function(TA){
  taux_plein = 0
  m = TA$Maturité
  ta = TA$`Taux actuariel`
  mat_pleine = 1:trunc(max(m)) # Maturités pleines
  for (j in mat_pleine) {
    i = which( m >= j)[1]-1
    taux_plein[j] = ta[i]+((ta[i+1]-ta[i])/(m[i+1]-m[i]))*(j-m[i])
  }
  tibble(
    "Maturité" = mat_pleine,
    `Taux actuariel` = round(taux_plein,5),
    `Taux actuariel (%)` = gsub("\\.",",",paste0(round(taux_plein*100,3),"%"))
  )

}

# Transformation du taux actuariel en taux ZC avec la méthode boostrap ------------
#' T_INTER: resultat de la fonction interpolation
#' Valeurs retournées : Data frame
#' Contenue du DF retournée : Maturité, Taux actuariel, Taux zéro coupon,
#'  Taux actuariel en pourcentage, Taux ZC en pourcentage
boostrapping <- function(T_INTER){
  ti = T_INTER$`Taux actuariel` # taux actuariel de Maturité pleine
  taux_ZC = ti[1]
  m = range(T_INTER$Maturité)[2] # Maturité maximale
  for (i in 2:m) {
    numerateur = (1+ti[i])
    sommation = ti[i]*sum(1/((1+taux_ZC)^(1:(i-1))))
    taux_ZC[i] = -1 + (numerateur/(1-sommation))^(1/i)
  }
  tibble(
    Maturité = 1:m,
    "Taux zéro coupon" = round(taux_ZC,5),
    `Taux zéro coupon (%)` = gsub("\\.",",",paste0(round(taux_ZC*100,3),"%"))
  )
}

# Triangle superieur -----
Triangulariser <- function(TriangleRgleAT){
  triangle0 = matrix(nrow = nrow(TriangleRgleAT), ncol = ncol(TriangleRgleAT))
  n = nrow(TriangleRgleAT)
  for (i in 1:n) {
    for (j in 1:(n-i+1)) {
      triangle0[i,j] = TriangleRgleAT[i,j]
    }

  }
  triangle0
}

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
#  Les règlements cumulés futurs estimés
C_hat <- function(triangle,fdc){
  # Vérifier que le triangle est une matrice carrée
  if (!is.matrix(triangle) || nrow(triangle) != ncol(triangle)) {
    stop("Le triangle doit être une matrice carrée")
  }
  n = nrow(triangle)
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

# Cash flows
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
# BE Prime Non Vie-hors rente -----
#'La somme actualisée des flux de règlements futurs probabilisés nets
#' de recours relatifs aux sinistres non encore survenus


BE_Prime_nv <- function(cad_liq,RS,PPNA,PFP,ZC, taux_acquistion){
  cad_actualiser = cad_liq[-1]/((1+ZC[1:length(cad_liq[-1])])^(1:length(cad_liq[-1])))
  (RS*(PPNA+PFP)*sum(cad_actualiser)) - (1-taux_acquistion)*PFP

}

# La meilleure estimation des engagements pour sinistres nets -----
BE_Sinistre_nv = function(r_hat, ZC ){
  sum(r_hat/((1+ZC[1:length(r_hat)])^(1:length(r_hat))))
}










