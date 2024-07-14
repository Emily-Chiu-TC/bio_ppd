# Shiny web application (ref: https://shiny.posit.co/)
# to visualise collected data (favourite science subject, marble guess)

# packages----
library(shiny)
library(bslib)
library(tidyverse)

# Define UI----
ui <- page_sidebar(
  title = "title panel",
  sidebar = sidebar("Sidebar",
                    code(print("Hello"))),
  value_box(
    title = "Value box",
    value = 100,
    showcase = bsicons::bs_icon("bar-chart"),
    theme = "teal"),
  
  
  card(card_header("Card header"),
       # card_image("www/shiny.svg", height = "300px"),
       card_footer("Shiny is a product of Posit."),
       "Card body"),
  
  
  card("Card 2")
)

# Define server logic----
server <- function(input, output) {
}

# Run the application----
shinyApp(ui = ui, server = server)
