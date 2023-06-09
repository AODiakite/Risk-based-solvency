# Part des cessionnaire

# Opeération d'assurance vie
#' Title
#'
#' @param BEGP
#' @param ZC
#' @param taux_cession
#' @param PD Proba de Defaut
#'
BEGPi = proj_cap_vect
Ajustement_DC <- \(BEGPi,ZC,taux_cession,PD){
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

