
library(shiny)

checkboxGroupUI <- function(id){
  ns <- NS(id)
  tagList(
    checkboxInput(
      inputId = ns("check"),
      label = "Flip checks 1",
      FALSE
    ),
    checkboxInput(
      inputId = ns("check2"),
      label = "Flip checks 2",
      FALSE
    ),
    checkboxInput(
      inputId = ns("check3"),
      label = "Flip checks 3",
      FALSE
    ),
    uiOutput(ns("check_one")),
    uiOutput(ns("check_group"))
  )
}

checkboxGroup <- function(input, output, session){
  ns <- session$ns
  output$check_group <- renderUI({
    checkboxGroupInput(
      ns("nkgp"),
      "Check group",
      choices = 1:5,
      inline = TRUE
    )
  })
  output$check_one <- renderUI({
    checkboxInput(
      ns("ck1"),
      "Check one",
      FALSE
    )
  })
  observe({
    check <- req(input$check)
    if(check){
      updateCheckboxInput(
        session,
        "check",
        value = FALSE
      )
    }
  })
  observeEvent(input$ckgp, {
    browser()
    select <- input$ckgp
    not_select <- (1:5)[-select]
    choice <- c(select, not_select)
    updateCheckboxGroupInput(
      session,
      "ckgp",
      selected = select,
      choices = choice,
      inline = TRUE
    )
  })
  observe({
    check2 <- req(input$check2)
    if(check2){
      updateCheckboxInput(
        session,
        "check2",
        value = FALSE
      )
      updateCheckboxGroupInput(
        session,
        "ckgp",
        selected = 1:2,
        choices = 1:5,
        inline = TRUE
      )
      updateCheckboxInput(
        session,
        "ck1",
        value = !input$ck1
      )
    }
  })
  observe({
    check3 <- req(input$check3)
    if(check3){
      updateCheckboxGroupInput(
        session,
        "ckgp",
        selected = 1:2,
        choices = 1:5,
        inline = TRUE
      )
      updateCheckboxInput(
        session,
        "check3",
        value = FALSE
      )
      updateCheckboxInput(
        session,
        "ck1",
        value = !input$ck1
      )
    }
  })
}

ui <- fluidPage(
  checkboxGroupUI("module")
)

server <- function(input, output, session){
  callModule(checkboxGroup, "module")
}

shinyApp(ui, server)








