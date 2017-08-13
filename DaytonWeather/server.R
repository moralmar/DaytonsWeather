#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#


pkgsName <- c("readr","magrittr","ggplot2","dplyr", "gridExtra", "shiny")
pkgs <- package(pkgsName)
lapply(pkgsName, require, character.only = TRUE)


# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
  output$distPlot <- renderPlot({
    
    # # generate bins based on input$bins from ui.R
    # x    <- faithful[, 2] 
    # bins <- seq(min(x), max(x), length.out = input$bins + 1)
    # 
    # # draw the histogram with the specified number of bins
    # hist(x, breaks = bins, col = 'darkgray', border = 'white')
          
    CountryABBR <- "EG"; City <- "CAIRO" #ensure: captial letters
    CityABBR <- paste0(CountryABBR, City)      
    
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
    p2
    
  })
  
  
  
  
  
})
