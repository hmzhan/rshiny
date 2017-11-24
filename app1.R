
# Simple example of exporting UI to another function (this works)

library(shiny)

tabUI <- function(id) {
  ns <- NS(id)
  fluidRow(
    textOutput(ns("filter"))
  )
}
tabUI2 <- function(id) {
  ns <- NS(id)
  uiOutput(ns("ui"))
}
filtersUI <- function(id, ...) {
  ns <- NS(id)
  
  fluidRow(
    ...
  )
}

filters <- function(input, output, session) {
}

tab <- function(input, output, session) {
  
  ns <- session$ns
  
  output$ui <- renderUI({
    selectizeInput(ns("select"), "Model", choices = unique(mpg$model))
  })
  
  output$filter <- renderText(input$select)
  invisible()
}



ui <- fixedPage(
  wellPanel(
    tabUI("tab")
  ),
  wellPanel(
    filtersUI("filters", tabUI2("tab"))
  )
  
)

server <- function(input, output, session) {
  tab <- callModule(tab, "tab")
  
  callModule(filters, "filters")
}


shinyApp(ui, server)