
library(shiny)
shinyApp(
  ui = fluidPage(DT::dataTableOutput('tbl')),
  server = function(input, output) {
    output$tbl = DT::renderDataTable(
      iris, 
      options = list(
        pageLength = 20,
        initComplete = JS('function(setting, json) {alert("done");}')
      ),
      # selection = 'single',
      selection = list(target = 'row', selected = c(1, 3))
    )
  }
)