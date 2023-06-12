#' Ce fichier R contient tous les packages requis pour fair rourner l'application.
#' Au cas où vous n'avez pas un des packages requis installer,
#' l'installation se fera automatiquement.
#' Ainsi nul besoin de toucher à ce fichier.


if (!requireNamespace("tidyverse", quietly = TRUE)) {
  # Installer le package s'il n'est pas déjà installé
  install.packages("tidyverse")
}
library(tidyverse)

if (!requireNamespace("bslib", quietly = TRUE)) {
  install.packages("bslib")
}
library(bslib)

if (!requireNamespace("readxl", quietly = TRUE)) {
  install.packages("readxl")
}
library(readxl)

if (!requireNamespace("bsicons", quietly = TRUE)) {
  install.packages("bsicons")
}
library(bsicons)

if (!requireNamespace("glue", quietly = TRUE)) {
  install.packages("glue")
}
library(glue)

if (!requireNamespace("rvest", quietly = TRUE)) {
  install.packages("rvest")
}
library(rvest)

if (!requireNamespace("scales", quietly = TRUE)) {
  install.packages("scales")
}
library(scales)
options(warn = -1)

if (!requireNamespace("bs4Dash", quietly = TRUE)) {
  install.packages("bs4Dash")
}
library(bs4Dash)

if (!requireNamespace("shiny", quietly = TRUE)) {
  install.packages("shiny")
}
library(shiny)

if (!requireNamespace("shinybusy", quietly = TRUE)) {
  install.packages("shinybusy")
}
library(shinybusy)

if (!requireNamespace("shinyalert", quietly = TRUE)) {
  install.packages("shinyalert")
}
library(shinyalert)

if (!requireNamespace("argonDash", quietly = TRUE)) {
  install.packages("argonDash")
}
library(argonDash)

if (!requireNamespace("argonR", quietly = TRUE)) {
  install.packages("argonR")
}
library(argonR)

if (!requireNamespace("thematic", quietly = TRUE)) {
  install.packages("thematic")
}
library(thematic)

if (!requireNamespace("plotly", quietly = TRUE)) {
  install.packages("plotly")
}
library(plotly)

if (!requireNamespace("thematic", quietly = TRUE)) {
  install.packages("thematic")
}
library(thematic)
