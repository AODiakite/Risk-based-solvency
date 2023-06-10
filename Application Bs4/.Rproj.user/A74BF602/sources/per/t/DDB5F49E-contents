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

# Calculs vie -------
df_capitaux = Matrice_Capitaux(deces_deg_unique$`Année d'effet`,
                               deces_deg_unique$Dur_e_de_contrat,deces_deg_unique$Capital_d_c_s_initial)

Mat_Proj_Cap <- function(df_capitaux,Duree_contrat_rest,ages,choc = 0){
  mat_ages = Mat_Ages(Duree_contrat_rest,ages)
  mat_tqx =(1+choc) * Mat_tQx(mat_ages)
  mat_tpx = 1 -  mat_tqx
  mat_tpx = cbind(1,mat_tpx[,-ncol(mat_tpx)])

  mat_tpx_cumul = t(apply(mat_tpx,1,cumprod))

  # Matrice de projection des capitaux
  mat_tqx*df_capitaux*mat_tpx_cumul
}

proj_cap = Mat_Proj_Cap(df_capitaux,Duree_contrat_rest,ages,choc = 0)
proj_cap_choc_003 = Mat_Proj_Cap(df_capitaux,Duree_contrat_rest,ages,choc = 0.3)
proj_cap_choc_002 = Mat_Proj_Cap(df_capitaux,Duree_contrat_rest,ages,choc = 0.2)
#' Somme des capitaux projetés pour chaque année
#'
#' @param proj_cap Matrice de projection des capitaux
#'
#' @return Vector

projection_cap <- function(proj_cap){
  apply(proj_cap,2,sum)
}
proj_cap_vect = projection_cap(proj_cap)
proj_cap_vect_003 = projection_cap(proj_cap_choc_003)
proj_cap_vect_002 = projection_cap(proj_cap_choc_002)

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

BEGP = BEGP_vie(proj_cap_vect,ZC)
BEGP_Choc_003 = BEGP_vie(proj_cap_vect_003,ZC)
BEGP_Choc_002 = BEGP_vie(proj_cap_vect_002,ZC)

# Nombre de contrat
#' Parametre FG_moyen
#' Parametre Augmentation_X augmentation de X% des FG la premiere année
#' Parametre majoration de X% chaque année
FG_moyen = 100
Augmentation_X = 0.14
Majoration_X = 0.015

NB_contrat <- function(ages,Duree_contrat_rest,choc = 0){
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
NB_contrat = NBContrat(ages,Duree_contrat_rest,choc = 0.2)


FG_t = FG_moyen*NB_contrat # FG_t Avant Choque

## FG_t après choque
vect_choque_FG = 1+c(Augmentation_X,rep(Majoration_X,max_duree_rest-1))
FG_t_Choque = FG_moyen * cumprod(vect_choque_FG)
FG_t_Choque = FG_t_Choque * NB_contrat

# BEFG
BEFG = \(FG_t,ZC){
  n_max = length(FG_t)
  denom = (1 + ZC[1:n_max])^(1:n_max)
  sum(FG_t/denom)
}
BEFG_vie = BEFG(FG_t,ZC)
BEFG_vie_Choque = BEFG(FG_t_Choque,ZC)






