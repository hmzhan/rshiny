
# Example of exporting UI where a selectInput is dependent on another input from a different exported UI (this works)

library(shiny)

tabUI <- function(id) {
  ns <- NS(id)
  fluidRow(
    textOutput(ns("filter"))
  )
}

tabUI2 <- function(id) {
  ns <- NS(id)
  tagList(
    uiOutput(ns("ui")),
    uiOutput(ns("ui2"))
  )
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
  
  model <- reactive({
    req(!is.null(input$select2))
    unique(mpg$model[mpg$class == input$select2])
  })
  
  output$ui <- renderUI({
    withTags(
      div(
        div(
          selectizeInput(ns("select2"), "Class", choices = unique(mpg$class))
        )
      )
    )
  })
  
  output$ui2 <- renderUI({
    withTags(
      div(
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
