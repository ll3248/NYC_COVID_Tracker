#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
# Define UI for application that draws a histogram


dashboardPage(
  skin = "yellow",
  dashboardHeader(title = "NYC COVID 19 Tracker"),
  dashboardSidebar(sidebarMenu(
    menuItem("ZipCodeTracker", tabName = "ZipCodeTracker", icon = icon("fas fa-map-signs")), 
    menuItem("Averages", tabName = "Averages", icon = icon("fas fa-table")),
    menuItem("About", tabName = "About", icon = icon("fas fa-asterisk"))
  )
  ),
  
  dashboardBody(fill = FALSE,tabItems(
    # Tab panel 1 MAP-------------------------------------------------------------------
    #sub1 ------------------------------------------------------------------------------
    tabItem(tabName = "ZipCodeTracker",
            titlePanel("Local NYC COVID-19 Cases"),

            # Sidebar with a slider input for number of bins
            sidebarLayout(
              sidebarPanel(
                helpText("Locate an area zip code on the map using the dropdown menu below.", br(), 
                         "Select up to two zip codes at a time.", br()), 
                selectInput("ZipCode", 
                            label = "Zip Code:",
                            choices = covid_zip_code$GEOID10, selected = 10001, multiple = TRUE),
                helpText("To see cases near popular tourist attractions, use the following guide.", br(), 
                         "Central Park: 10019", br(),
                         "Chinatown: 10002 & 10038", br(),
                         "Columbia University: 10027", br(),
                         "Coney Island: 11224", br(),
                         "Empire State Building: 10001", br(),
                         "Madison Square Garden: 10010", br(),
                         "Statue of Liberty: 10004", br(),
                         "Times Square: 10036", br(), 
                         "", br()), 

                helpText("Select what information that should be displayed on the legend.", 
                         "Colors and scale will adjust according to user selection."), 
                
                radioButtons("radio", label = "Legend Information:",
                             choices = list("COVID Case Count" = "COVID Case Count", 
                                            "COVID Death Count" = "COVID Death Count", 
                                            "Total COVID Tests" = "Total COVID Tests", 
                                            "Positive COVID Tests" = "Positive COVID Tests", 
                                            "Percent Positive COVID Tests" = "Percent Positive COVID Tests"), 
                             selected = "COVID Case Count"), 
                
                helpText("", br(), 
                         "Check the box below to display only the most recent COVID-19 cases from the past four weeks.", 
                         "Most recent 4 week data available: June 21st, 2020 to July 18th, 2020", 
                         "", br()), 
                
                checkboxInput("checkbox", label = "Recent 4 Week Data?", value = FALSE), 
                
                helpText("", br(), 
                         "Note: NYCHealth Open Data Last Updated September 30th, 2020.", 
                         "", br())
              ), # end sidebar panel 
              mainPanel(leafletOutput("myMap", height = 800))
            ) # end side bar layout     
    ),
    # Tab panel 2  Averages----------------------------------------------------------------
    tabItem(tabName = "Averages",
            
            titlePanel("NYC Cumulative Average"), 
            fluidRow(column(12, tableOutput("myTable1"))),
            titlePanel("Borough Cumulative Averages"), 
            fluidRow(column(12, tableOutput("myTable3"))),
            titlePanel("NYC Recent Four Week Average"), 
            fluidRow(column(12, tableOutput("myTable2"))),
            titlePanel("Borough Recent Four Week Averages"), 
            fluidRow(column(12, tableOutput("myTable4"))),
            
            HTML("NYCHealth Open Data Last Updated September 30th, 2020."), 
    ), 
    
    # Tab panel 3  Data Source-------------------------------------------------------------
    tabItem(tabName = "About", 
            HTML(
              "<h2> Data Source : </h2>
                              <h4><p><li><a href='https://coronavirus.jhu.edu/map.html'>Coronavirus COVID-19 Global Cases map Johns Hopkins University</a></li></h4>
                              <h4><li>COVID-19 Cases : <a href='https://github.com/CSSEGISandData/COVID-19' target='_blank'>Github Johns Hopkins University</a></li></h4>
                              <h4><li>NYC COVID-19 Data : <a href='https://github.com/nychealth/coronavirus-data' target='_blank'>Github NYC Health</a></li></h4>
                              <h4><li>Spatial Polygons : <a href='https://www.naturalearthdata.com/downloads/' target='_blank'> Natural Earth</a></li></h4>"
              
            ),
            
            titlePanel("Disclaimers : "),
            HTML(
              "<b>COVID-19 Guideslines : </b> <br>
                              <li>Our goal is to provide general guidelines for the public to consider as they navigate NYC and to inform the public of openly available data. </li>
                              <li>This is no way constitutes as professional medical advice. </li>
                              <li>Please talk to your doctor or healthcare provider if you have any questions or concerns about COVID-19.</li>" 
            ),
            
            HTML(
              "<b>NYC Health OpenData : </b> <br>
                              <li>The COVID-19 data is an observational study and any inferences drawn from this map should be treated with caution. </li>
                              <li>The data shown here only reflects the currently situation in NYC, and thus, is not representative of the entire United States as a whole.</li>
                              <li>Data about COVID-19 is always continuously updated but the data here is only a snapshot of something that is continuously changing.</li>" 
            ), 
            
            titlePanel("Credits : "),
            HTML(
              " <p>This website was built using RShiny.</p>",
              "<p>The following R packages were used in to build this RShiny application:</p>
              <p>
              <code>base</code><code>dplyr</code><code>tibble</code>
              <code>leaflet</code><code>tidyverse</code><code>shinythemes</code>
              <code>padr</code><code>plotly</code><code>ggplot2</code>
              <code>tigris</code><code>shiny</code><code>shinydashboard</code><code>sp</code><code>stringr</code>
              <code>tidyr</code>
              </p>
              <p>This website was originally a part of a course project at Columbia University.</p>",
              "<p>For more information, please contact Levi Lee | email: ll3248[at]columbia[dot]edu </p>"
            )
    )
  )
 )
)
  
  