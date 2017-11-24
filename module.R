
library(shiny)

sliderTextUI <- function(id){
  ns <- NS(id)
  tagList(
    sliderInput(
      inputId = ns("slider"), 
      label = "Slide me",
      min = 0,
      max = 100,
      value = 5
    ),
    textOutput(ns("number"))
  )
}

sliderText <- function(input, output, session, show){
  output$number <- renderText({
    if(show()){
      input$slider
    } else{
      NULL
    }
  })
  reactive({input$slider + 5})
}

ui <- fluidPage(
  checkboxInput("display", "Show Value"),
  sliderTextUI("module"),
  h2(textOutput("value"))
)
server <- function(input, output, session){
  display <- reactive({input$display})
  num <- callModule(sliderText, "module", display)
  output$value <- renderText({
    paste0("slider1+5: ", num())
  })
}

shinyApp(ui, server)


