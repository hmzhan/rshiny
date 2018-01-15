# https://rstudio.github.io/DT/010-style.html
# 1. selection
# 2. highlights
# 3. row height

library(shiny)
shinyApp(
  ui <- fluidPage(DT::dataTableOutput('tbl')),
  server <- function(input, output) {
    output$tbl <- DT::renderDataTable({
      dat <- datatable(
        iris, 
        options = list(
          pageLength = 5,
          initComplete = JS('function(setting, json) {alert("done");}')
        ),
        # selection = 'single',
        selection = list(target = 'row', selected = c(1, 3))
      ) %>% 
        formatStyle(
          'Species', 
          backgroundColor = styleEqual('setosa', 'red'),
          lineHeight='30%')
      return(dat)
    })
  }
)