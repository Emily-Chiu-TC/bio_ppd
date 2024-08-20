# Shiny web application (ref: https://shiny.posit.co/)
# to visualise collected data (favourite science subject, marble guess)

# packages----
library(shiny)
library(bslib)
library(tidyverse)
library(RColorBrewer)
library(colorBlindness)

# Define UI----
ui <- page_sidebar(
  title = "BIO PPD: Data Explorers (2024)",
  sidebar = sidebar(code(print("This is R, one of the programming languages used by biologists.")),
                    
                    card(card_header("Information"),
                         helpText("Note: Input a numerical guess for the number of marble,",
                                  "pick your favourite science subject,",
                                  "and adjust the colours and the features for the plots."),
                         
                         dateInput("date", label = "Select date", value = "2024-07-14")),
                    
                    card(card_header("Marble Guess"),
                         numericInput("marble", "Input number", value = 1), selected = 1),
                    
                    card(card_header("Favourite Science Subject"),
                         radioButtons("radio", label = "Select one subject",
                                      choices = list("Biology", "Chemistry", 
                                                     "Physics", "Mathematics")),
                         
                         helpText("Now select the colours for the graph"),
                         
                         radioButtons('bio', label = "Biology",
                                      choices = list("red", "orange", "yellow"))
                    
                    )),
                    
  value_box( #can this be smaller?
    title = "Engagement",
    value = 100,
    showcase = bsicons::bs_icon("bar-chart"), size = 1,
    theme = "teal"),
  
  card(card_header("Favourite Science Subject"),
       textOutput("selected_radio")),
  
  card(card_header("Your Marble Guess"),
       textOutput("selected_marble"))

)
  
# Define server logic----
server <- function(input, output) {
  output$selected_radio <- renderText({
    paste("You have selected: ", input$radio)
  })
  
  output$selected_marble <- renderText({
    paste("Your guess is:", input$marble)
  })
  
  output$value <- renderPrint({ input$date}) # date

}

# Run the application----
shinyApp(ui = ui, server = server)
