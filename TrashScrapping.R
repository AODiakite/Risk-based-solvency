library(rvest)
library(lubridate)

# Définir les dates de début et de fin
end_date <- Sys.Date()
start_date <- end_date %m-% months(6)

# Convertir les dates en format pour le site web
start_date_str <- format(start_date, "%d/%m/%Y")
end_date_str <- format(end_date, "%d/%m/%Y")

# Définir l'URL de base
url_base <- "https://www.casablanca-bourse.com/bourseweb/Negociation-Historique.aspx?Cat=24&IdLink=302"

# Créer une session pour conserver les cookies
session <- html_session(url_base)

# Remplir le formulaire avec les informations souhaitées
form <-html_form(read_html(url_base))[[1]]
form_filled <- html_form_set(form,
                             `HistoriqueNegociation1$HistValeur1$DDValeur` = "AFMA",
                             `HistoriqueNegociation1$HistValeur1$DateTimeControl1$TBCalendar` = start_date_str,
                             `HistoriqueNegociation1$HistValeur1$DateTimeControl2$TBCalendar` = end_date_str)

# Soumettre le formulaire
session <- html_form_submit( form_filled)
session <- html_form_submit(form_filled, submit = "HistoriqueNegociation1$HistValeur1$ImageButton1")

# Extraire les données de la table
data <- html_table(html_nodes(session, "table"), fill = TRUE)[[1]]

# Afficher les données
data








library(rvest)

# Définir l'URL de la page
url <- "https://www.casablanca-bourse.com/bourseweb/Negociation-Historique.aspx?Cat=24&IdLink=302"

# Lire la page
page <- read_html(url)

# Sélectionner tous les boutons d'envoi
submit_buttons <- html_nodes(page, 'input[type="submit"], input[type="image"]')

# Extraire les noms des boutons d'envoi
submit_button_names <- html_attr(submit_buttons, "name")

# Afficher les noms des boutons d'envoi
submit_button_names






