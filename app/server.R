#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
#-------------------------------------------------App Server----------------------------------

#can run RData directly to get the necessary date for the app
#global.r will enable us to get new data everyday
#update data with automated script

source("global.R")

shinyServer(function(input, output) {

    #----------------------------------------
    #tab panel 1 - Maps
    
    output$myMap <- renderLeaflet({
        
        # this determines the chosen parameter the user has selected 
        # did the user want recent or cumulative data?
        # what information did the user want to see in the legend?
        # see "add a legend" and 'create color palette' comment below to see chosen_parameter variable in use
        chosen_parameter <- if (input$radio == "COVID Case Count") {
            if(input$checkbox == TRUE){covid_zip_code$COVID_CASE_COUNT_4WEEK} else{covid_zip_code$COVID_CASE_COUNT}
        } else if (input$radio == "COVID Death Count") {
            if(input$checkbox == TRUE){covid_zip_code$COVID_DEATH_COUNT_4WEEK} else{covid_zip_code$COVID_DEATH_COUNT}
        } else if (input$radio == "Total COVID Tests") {
            if(input$checkbox == TRUE){covid_zip_code$NUM_PEOP_TEST_4WEEK} else{covid_zip_code$TOTAL_COVID_TESTS}
        } else if (input$radio == "Positive COVID Tests") {
            if(input$checkbox == TRUE){covid_zip_code$TOTAL_POSITIVE_TESTS_4WEEK} else{covid_zip_code$TOTAL_POSITIVE_TESTS}
        } else if (input$radio == "Percent Positive COVID Tests") {
            if(input$checkbox == TRUE){covid_zip_code$PERCENT_POSITIVE_4WEEK} else{covid_zip_code$PERCENT_POSITIVE}
        }
        
        
        
        # create color palette 
        pal <- colorNumeric(
            palette = "Greens",
            domain = chosen_parameter)
        
        # create labels for zipcodes
        labels <-  paste0(
            "Zip Code: ", covid_zip_code$GEOID10, "<br/>",
            "Neighborhood: ", covid_zip_code$NEIGHBORHOOD_NAME, "<br/>",
            "Borough: ", covid_zip_code$BOROUGH_GROUP, "<br/>",
            "Population: ", floor(covid_zip_code$POP_DENOMINATOR), "<br/>",
            
            # this number change depending on the options the user has selected
            # did the user want recent or cumulative data?
            # seperate check from the chosen_parameter variable above 
            "COVID Case Count: ", if(input$checkbox == TRUE){covid_zip_code$COVID_CASE_COUNT_4WEEK} else{covid_zip_code$COVID_CASE_COUNT}, "<br/>",
            "COVID Death Count: ", if(input$checkbox == TRUE){covid_zip_code$COVID_DEATH_COUNT_4WEEK} else{covid_zip_code$COVID_DEATH_COUNT}, "<br/>",
            "Total COVID Tests: ", if(input$checkbox == TRUE){covid_zip_code$NUM_PEOP_TEST_4WEEK} else{covid_zip_code$TOTAL_COVID_TESTS}, "<br/>",
            "Positive COVID Tests: ", if(input$checkbox == TRUE){covid_zip_code$TOTAL_POSITIVE_TESTS_4WEEK} else{covid_zip_code$TOTAL_POSITIVE_TESTS}, "<br/>",
            "Percent Positive COVID Tests: ", if(input$checkbox == TRUE){covid_zip_code$PERCENT_POSITIVE_4WEEK} else{covid_zip_code$PERCENT_POSITIVE}
        ) %>%
            
            lapply(htmltools::HTML)
        
        covid_zip_code %>%
            leaflet %>% 
            # add base map
            addProviderTiles("CartoDB") %>% 
            # mark selected zip code
            
            # add zip codes
            addPolygons(fillColor = ~pal(chosen_parameter),
                        weight = 2,
                        opacity = 1,
                        color = "white",
                        dashArray = "3",
                        fillOpacity = 0.7,
                        highlight = highlightOptions(weight = 2,
                                                     color = "#666",
                                                     dashArray = "",
                                                     fillOpacity = 0.7,
                                                     bringToFront = TRUE),
                        label = labels) %>%
            
            addPolygons(data = covid_zip_code[covid_zip_code$GEOID10 == input$ZipCode, ], 
                        color = "blue", weight = 5, fill = FALSE) %>%
            
            # add legend
            addLegend(pal = pal, 
                      values = ~chosen_parameter,
                      opacity = 0.7, 
                      title = htmltools::HTML(input$radio),
                      position = "bottomright")
        
    }) 
    

    #----------------------------------------
    #tab panel 2 - Averages 
    
    averages_cumulative <- as.data.frame(covid_zip_code) %>%
      select(COVID_CASE_COUNT, COVID_DEATH_COUNT, TOTAL_COVID_TESTS, TOTAL_POSITIVE_TESTS, PERCENT_POSITIVE) %>%
      summarise_all(mean)
    
    averages_recent <- as.data.frame(covid_zip_code) %>%
      select(COVID_CASE_COUNT_4WEEK, COVID_DEATH_COUNT_4WEEK, NUM_PEOP_TEST_4WEEK, TOTAL_POSITIVE_TESTS_4WEEK, PERCENT_POSITIVE_4WEEK) %>%
      summarise_all(mean)
    
    averages_borough_cumulative <- as.data.frame(covid_zip_code) %>% group_by(BOROUGH_GROUP) %>% 
      select(COVID_CASE_COUNT, COVID_DEATH_COUNT, TOTAL_COVID_TESTS, TOTAL_POSITIVE_TESTS, PERCENT_POSITIVE) %>%
      summarise_all(mean)
    
    averages_borough_recent <- as.data.frame(covid_zip_code) %>% group_by(BOROUGH_GROUP) %>% 
      select(COVID_CASE_COUNT_4WEEK, COVID_DEATH_COUNT_4WEEK, NUM_PEOP_TEST_4WEEK, TOTAL_POSITIVE_TESTS_4WEEK, PERCENT_POSITIVE_4WEEK) %>%
      summarise_all(mean)
    
    output$myTable1 <- renderTable(averages_cumulative)
    output$myTable3 <- renderTable(averages_borough_cumulative)
    
    
    output$myTable2 <- renderTable(averages_recent)
    output$myTable4 <- renderTable(averages_borough_recent)
    
    #----------------------------------------
    #tab panel 3 - Data Source
    
    
})