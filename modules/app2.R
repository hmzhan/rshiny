

# Example of exporting UI where a selectInput is dependent on another input from the same exported UI (this doesn't work)

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

filters <- function(input, output, session, ui) {
}

tab <- function(input, output, session) {
  
  ns <- session$ns
  
  model <- reactive({
    req(!is.null(input$select2))
    unique(mpg$model[mpg$class == input$select2])
  })
  
  output$ui <- renderUI({
    withTags(
      div(
        div(
          selectizeInput(ns("select2"), "Class", choices = unique(mpg$class))
        ),
        div(
          selectizeInput(ns("select"), "Model", choices = model())
        )
      )
    )
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
  callModule(tab, "tab")
  callModule(filters, "filters")
}


shinyApp(ui, server)