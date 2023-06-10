options(warn = -1)
source("installation packages.R")
TD_88_90 <- read_excel("Data/TD-88-90.xlsx")

# Proba de survie -----
tPx <- function(x,TD = TD_88_90){
  tryCatch(
    ifelse(x+2 > 111 | TD[[2]][x+1] == 0,
           0,
           TD[[2]][x+2]/TD[[2]][x+1]),
    error = function(e){
      return(0)
    }
  )

}

# Proba de Deces -----
tQx <- function(x,TD = TD_88_90){
  1 - tPx(x,TD)
}


#' Mat ages
#'
#' @param Duree_contrat_rest Vecteur de durée des contrats restantes
#' @param ages Vecteur d'age
#' @param TD TD-88-90
#'
#' @return

Mat_Ages <- function(Duree_contrat_rest,ages,TD = TD_88_90){
  ncolMatrix = max(Duree_contrat_rest)
  nrowMatrix = length(Duree_contrat_rest)
  mat_tqx = matrix(rep(0:(ncolMatrix-1),nrowMatrix),ncol = ncolMatrix,byrow = TRUE)
  mat_ages = rep(ages,each = ncolMatrix)
  mat_ages = matrix(mat_ages,ncol = ncolMatrix,byrow = TRUE)
  mat_ages = mat_ages+mat_tqx
  mat_ages
}

Mat_tPx <- function(mat_ages){
  tPx(mat_ages)
}

Mat_tQx <- function(mat_ages){
  tQx(mat_ages)
}

tableau_amort = function(Annee,maturite,cap_initial,tx_interet = 0.04 ,annee_max_proj = 2042){
  annuite = (cap_initial*tx_interet)*(1/(1-(1+tx_interet)^(-maturite)))
  df = data.frame(Annee = Annee + 0:(maturite-1), CRP = 0,
                  Interest = 0, Ammortissement = 0,
                  Annuite = annuite)
  df$CRP[1] = cap_initial
  df$Interest[1] = cap_initial*tx_interet
  df$Ammortissement[1] = annuite - df$Interest[1]
  for (i in 2:maturite) {
    df$CRP[i] = df$CRP[i-1] - df$Ammortissement[i-1]
    df$Interest[i] = df$CRP[i]*tx_interet
    df$Ammortissement[i] = annuite - df$Interest[i]
  }
  max_annee = max(df$Annee)
  if(max_annee < annee_max_proj){
    df0 = data.frame(Annee = (max_annee+1):annee_max_proj, CRP = 0,
                     Interest = 0, Ammortissement = 0,
                     Annuite = 0)
    df = rbind(df,df0)
  }
  df
}

#' Title
#'
#' @param Annee vecteur des annees
#' @param maturite vecteur
#' @param cap_initial vecteur
#' @param max_duree_rest vecteur
#'

Matrice_Capitaux <- function(Annee,maturite,cap_initial,
                             max_duree_rest = max(Duree_contrat_rest),annee_max_proj = 2042){
  result = Map(
    function(x, y, z) {
      T_AMORT = tableau_amort(x,y,z,annee_max_proj)
      T_AMORT = tail(T_AMORT,max_duree_rest)
      T_AMORT$CRP
    },
    x = Annee,
    y= maturite,
    z = cap_initial
  )
  df_result = as.data.frame(result)
  df_result = t(df_result)
  rownames(df_res) = NULL
  df_res
}

Mat_Proj_Cap <- function(df_capitaux,Duree_contrat_rest,ages,choc = 0){
  mat_ages = Mat_Ages(Duree_contrat_rest,ages)
  mat_tqx =(1+choc) * Mat_tQx(mat_ages)
  mat_tpx = 1 -  mat_tqx
  mat_tpx = cbind(1,mat_tpx[,-ncol(mat_tpx)])

  mat_tpx_cumul = t(apply(mat_tpx,1,cumprod))

  # Matrice de projection des capitaux
  mat_tqx*df_capitaux*mat_tpx_cumul
}

#' Somme des capitaux projetés pour chaque année
#'
#' @param proj_cap Matrice de projection des capitaux
#'
#' @return Vector

projection_cap <- function(proj_cap){
  apply(proj_cap,2,sum)
}

#' BE des garanties probabilisées
#'
#' @param proj_cap_vect vecteur de capitaux projetés
#' @param ZC vecteur de taux ZC
#'
#' @return BEGP

BEGP_vie <- function(proj_cap_vect, ZC){
  nn = length(proj_cap_vect)
  denom = (1+ZC[1:nn])^(1:nn)
  sum(proj_cap_vect/denom)
}

# NB contrat

NBContrat <- function(ages,Duree_contrat_rest,choc = 0){
  mat_ages = Mat_Ages(Duree_contrat_rest,ages)
  mat_tqx =(1+choc) * Mat_tQx(mat_ages)
  NB_contrat = 1-mat_tqx
  NB_contrat = t(apply(NB_contrat,1,cumprod))
  max_duree_rest = max(Duree_contrat_rest)
  mat_duree = Map(\(x){
    c(rep(1,x),rep(0,max_duree_rest-x))
  }, x = Duree_contrat_rest)
  mat_duree = as.data.frame(mat_duree)
  mat_duree = t(mat_duree)
  rownames(mat_duree) = NULL

  NB_contrat = NB_contrat*mat_duree
  NB_contrat = apply(NB_contrat,2,sum)
  NB_contrat
}

# BEFG
BEFG = \(FG_t,ZC){
  n_max = length(FG_t)
  denom = (1 + ZC[1:n_max])^(1:n_max)
  sum(FG_t/denom)
}

# Cession ------

Ajustement_DC_Vie <- \(BEGPi,ZC,taux_cession,PD){
  BEGPi_actualised = BEGPi/((1+ZC[1:length(BEGPi)])^(1:length(BEGPi)))
  BEGP_cede = cumsum(rev(BEGPi_actualised))
  BEGP_cede = rev(BEGP_cede)
  BEGP_cede = BEGP_cede*taux_cession
  Adj_i = Map(\(x,y){
    0.5*max(x,0)*PD*(1-PD)^(y-1)
  }, x = as.list(BEGP_cede), y = as.list(1:length(BEGP_cede)))
  Adj_i = unlist(Adj_i)
  Adj_act_i = Adj_i/((1+ZC[1:length(Adj_i)])^(1:length(Adj_i)))

  sum(Adj_act_i)
}

# Opeération d'assurance vie

Ajustement_DC_NVie <- \(r_hat,cad_liq,ZC,RS,PPNA,PFP,taux_acquistion,PD,tc_prime = 0.05 , tc_sinistre = 0.03){
  cad_liq0 = cad_liq[-1]
  cad_actualiser = cad_liq0/((1+ZC[1:length(cad_liq0)])^(1:length(cad_liq0)))
  cad_actualiser_cumule = rev(cumsum(rev(cad_actualiser)))
  PFP_Vect = c(PFP,rep(0,length(cad_liq0)-1))
  PFPA = (1-taux_acquistion)*PFP_Vect
  BEPrimes = RS*(PPNA+PFP_Vect)*cad_actualiser_cumule-PFPA
  BEPrimes_Cede = tc_prime*BEPrimes

  BESinistre = r_hat/((1+ZC[1:length(r_hat)])^(1:length(r_hat)))
  BESinistre = rev(cumsum(rev(BESinistre)))
  BESinistre_Cede = tc_sinistre*BESinistre

  BE_ENG_Cede = BESinistre_Cede+BEPrimes_Cede

  Adj_i = Map(\(x,y){
    0.5*max(x,0)*PD*(1-PD)^(y-1)
  }, x = as.list(BE_ENG_Cede), y = as.list(1:length(BE_ENG_Cede)))
  Adj_i = unlist(Adj_i)
  Adj_act_i = Adj_i/((1+ZC[1:length(Adj_i)])^(1:length(Adj_i)))
  sum(Adj_act_i)
}


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
      Message = c("OK !", "Téléchargement effectuer avec succès !","success")
      shinyalert(Message[1], Message[2] , type = Message[3],timer = 2500)

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

# Cash flows : -------
#' Fonction de calcul les flux de règlements futurs probabilisés nets de recours relatifs aux sinistres survenus
#'
#' @param decumul triangle de réglement décumulé
#'
#' @return vecteur des Cash flows

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
#'
#' @param cad_liq Cadence de liquidation
#' @param RS Ratio de sinistralite
#' @param PPNA Provision pour primes non acquises
#' @param PFP Le montant des primes futures probabilisé.
#' @param ZC Vecteur de taux ZC
#' @param taux_acquistion


BE_Prime_nv <- function(cad_liq,RS,PPNA,PFP,ZC, taux_acquistion){
  cad_actualiser = cad_liq[-1]/((1+ZC[1:length(cad_liq[-1])])^(1:length(cad_liq[-1])))

  (RS*(PPNA+PFP)*sum(cad_actualiser)) - (1-taux_acquistion)*PFP

}

# La meilleure estimation des engagements pour sinistres nets -----
#' Title
#'
#' @param r_hat les flux de règlements futurs probabilisés nets de
#'              recours relatifs aux sinistres survenus
#' @param ZC Vecteur de taux ZC
#'
#' @return BE Sinistre non vie

BE_Sinistre_nv = function(r_hat, ZC ){
  sum(r_hat/((1+ZC[1:length(r_hat)])^(1:length(r_hat))))
}










