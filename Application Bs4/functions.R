library(tidyverse)
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


