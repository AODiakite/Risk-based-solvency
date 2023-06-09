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



