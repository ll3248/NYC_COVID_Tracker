### App folder

The App directory contains the app files for the Shiny App (i.e., ui.R, server.R and global.R).
 - ui.R and server.R are two key components for the Shiny App 
 - global.R is used to preprocess the data and define functions that used in server.R
 - output folder contains the data used for deployment and it will update daily

The output subfolder contains pre-processed data to be used in the Shiny app. See folder's README file for more details. 

The rsconnect subfolder contains a record of previously Shiny app deployments. 