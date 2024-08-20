# Shiny web application (ref: https://shiny.posit.co/)
# to visualise collected data (favourite science subject, marble guess)

# packages----
library(shiny)
library(bslib)
library(tidyverse)
library(RColorBrewer)
library(colorBlindness)

# scripts----
#source("scripts/marble.R")
#source("scripts/sci_fest_clean.R")

# Define UI----
## sidebar----
ui <- page_sidebar(
  title = "BIO PPD: Data Explorers (2024)",
  sidebar = sidebar(code(print("This is R, one of the programming languages used by biologists.")),
### text information----                    
                    card(card_header("Information"),
                         helpText("Note: Input a numerical guess for the number of marble,",
                                  "pick your favourite science subject,",
                                  "and adjust the colours and the features for the plots."),
### date input----                       
                         dateInput("date", label = "Select date", value = "2024-07-14")),
### marble input----                    
                    card(card_header("Marble Guess"),
                         numericInput("marble", "Input number", value = 1), selected = 1),
### subject input----                    
                    card(card_header("Favourite Science Subject"),
                         radioButtons("radio", label = "Select one subject",
                                      choices = list("Biology", "Chemistry", 
                                                     "Physics", "Mathematics")),
### graph colour input (tbc)----                         
                         helpText("Now select the colours for the graph"),
                         
                         radioButtons('bio', label = "Biology",
                                      choices = list("red", "orange", "yellow"))
                    
                    )),
## main page----
### number of visitors (tbc on number of input)----
  value_box( #can this be smaller?
    title = "Dashboard Visitors",
    value = 1,
    showcase = bsicons::bs_icon("bar-chart"), size = 1,
    theme = "teal"),

### subject----  
  card(card_header("Favourite Science Subject"),
       textOutput("selected_radio")),

### marble----  
  card(card_header("Your Marble Guess"),
       textOutput("selected_marble"))

)
  
# Define server logic----
server <- function(input, output) {
## subject output (tbc)----
  output$selected_radio <- renderText({
    paste("You have selected: ", input$radio)
  })

## marble output (tbc) ----
  output$selected_marble <- renderText({
    paste("Your guess is:", input$marble)
  })
  
  output$value <- renderPrint({ input$date}) # date

}

# Run the application----
shinyApp(ui = ui, server = server)
