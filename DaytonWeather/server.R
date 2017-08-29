#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

remove(list = ls(all.names = TRUE))
cat("\014")

pkgsName <- c("readr","magrittr","ggplot2","dplyr", "gridExtra", "shiny")
pkgs <- package(pkgsName)
lapply(pkgsName, require, character.only = TRUE)


shinyServer(function(input, output) {
        
        output$values <- renderPrint({
                list(x4 = input$x4)
        })
        

        calc_when_go <- eventReactive(input$go, {

                # CountryABBR <- "EG"; City <- "CAIRO" #ensure: captial letters
                # CityABBR <- paste0(CountryABBR, City)      
                CityABBR <- x4
                # make file name
                name <- make_filename(CityABBR)
                
                # read
                testfile <- read_and_load(name)
                (get_FileInfo(testfile, CountryABBR, City))
                
                # wrangling
                YearToday <- input$bins #2014L
                YearPastMin <- min(testfile$Year)
                YearPastMax <- YearToday - 1
                
                PastData <- get_YearData(testfile, YearPastMin:YearPastMax)
                DataYearX <- get_YearData(testfile, YearToday)
                
                PastExtremes <- get_YearPastExtremes(PastData)
                head(PastExtremes); tail(PastExtremes)
                
                YearXExtremes <- get_ExtremesForYearX(PastExtremes, DataYearX)
                
                
                p2 <- create_base_plot(PastExtremes, 
                                       DataYearX, 
                                       YearXExtremes, 
                                       YearPastMin, 
                                       YearPastMax, 
                                       YearToday) + 
                        theme_dayton()
        })

        
        output$distPlot <- renderPlot({
          
        p2
    
  })
})
