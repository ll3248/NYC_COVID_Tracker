#--------------------------------------------------------------------
###############################Install Related Packages #######################

if (!require("dplyr")) {
  install.packages("dplyr")
  library(dplyr)
}
if (!require("tibble")) {
  install.packages("tibble")
  library(tibble)
}
if (!require("tidyverse")) {
  install.packages("tidyverse")
  library(tidyverse)
}
if (!require("shinythemes")) {
  install.packages("shinythemes")
  library(shinythemes)
}

if (!require("sf")) {
  install.packages("sf")
  library(sf)
}
if (!require("RCurl")) {
  install.packages("RCurl")
  library(RCurl)
}
if (!require("tmap")) {
  install.packages("tmap")
  library(tmap)
}
if (!require("rgdal")) {
  install.packages("rgdal")
  library(rgdal)
}
if (!require("leaflet")) {
  install.packages("leaflet")
  library(leaflet)
}
if (!require("shiny")) {
  install.packages("shiny")
  library(shiny)
}
if (!require("shinythemes")) {
  install.packages("shinythemes")
  library(shinythemes)
}
if (!require("plotly")) {
  install.packages("plotly")
  library(plotly)
}
if (!require("ggplot2")) {
  install.packages("ggplot2")
  library(ggplot2)
}
if (!require("viridis")) {
  install.packages("viridis")
  library(viridis)
}
if (!require("shinydashboard")) {
  install.packages("shinydashboard")
  library(shinydashboard)
}
if (!require("readr")) {
  install.packages("readr")
  library(readr)
}
if (!require("leaflet")) {
  install.packages("leaflet")
  library(leaflet)
}

if (!require("tigris")) {
  install.packages("tigris")
  library(tigris)
}
if (!require("emojifont")) {
  install.packages("emojifont")
  library(emojifont)
}

if (!require("shinyWidgets")) {
  install.packages("shinyWidgets")
  library(shinyWidgets)
}

#=======================================================================

load('./output/covid_zip_code.RData')
#load('./output/collected_preprocessed_data.RData')

#=======================================================================




