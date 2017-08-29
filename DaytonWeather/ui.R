#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#


# interesting regarding Shiny Inputs:
#  https://shiny.rstudio.com/gallery/option-groups-for-selectize-input.html


# interesting regarding buttons:
# https://shiny.rstudio.com/articles/action-buttons.html

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Old Faithful Geyser Data"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
            
            # a select input
            selectInput('x4', 'X4', choices = list(
                    Egypt = c("Cairo" = "EGCAIRO", `New Jersey` = 'NJ'),
                    Japan = c("Osaka" = "JPOSAKA", `Washington` = 'WA')
            ), selectize = FALSE),
            
            sliderInput("bins",
                   "Number of bins:",
                   min = as.integer(min(PastData$Year)),#1995,
                   max = as.integer(max(DataYearX$Year)),#2014,
                   value = 2014L,
                   step = 1),
            
            actionButton("goButton", "Go!"),
            actionButton("reset", "Clear"), 
            hr()
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
       plotOutput("distPlot"),
       verbatimTextOutput('values')
    )
  )
))
