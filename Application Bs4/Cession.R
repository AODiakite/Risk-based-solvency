# Part des cessionnaire

# Opeération d'assurance vie
#' Title
#'
#' @param BEGP
#' @param ZC
#' @param taux_cession
#' @param PD Proba de Defaut
#'

Ajustement_DC <- \(BEGP,ZC,taux_cession,PD){
  BEGP_cede = BEGP*taux_cession
  Adj_i = Map(\(x){
    0.5*max(x,0)
  })
}
