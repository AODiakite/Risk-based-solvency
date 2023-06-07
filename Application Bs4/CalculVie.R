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


#' Title
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
                             max_duree_rest = max(Duree_contrat_rest)){
  result = Map(
    function(x, y, z) {
      T_AMORT = tableau_amort(x,y,z)
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

df_capitaux = Matrice_Capitaux(deces_deg_unique$`Année d'effet`,
                               deces_deg_unique$Dur_e_de_contrat,deces_deg_unique$Capital_d_c_s_initial)

mat_ages = Mat_Ages(Duree_contrat_rest,ages)
mat_tqx = Mat_tQx(mat_ages)
mat_tpx = Mat_tPx(mat_ages)
mat_tpx = cbind(1,mat_tpx[,-ncol(mat_tpx)])

mat_tpx_cumul = t(apply(mat_tpx,1,cumprod))

# Matrice de projection des capitaux
proj_cap = mat_tqx*df_capitaux*mat_tpx_cumul

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


NB_contrat = Mat_tPx(mat_ages)
NB_contrat = t(apply(NB_contrat,1,cumprod))

