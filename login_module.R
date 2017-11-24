
library(shiny)

jscode <- '
$(function() {
var $els = $("[data-proxy-click]");
$.each(
$els,
function(idx, el) {
var $el = $(el);
var $proxy = $("#" + $el.data("proxyClick"));
$el.keydown(function (e) {
if (e.keyCode == 13) {
$proxy.click();
}
});
}
);
});
'

loginUI <- function(id){
  ns <- NS(id)
  tagList(
    actionButton(ns("btn"), "Click me to print the value in the text field"),
    div("Or press Enter when the text field is focused to \"press\" the button"),
    tagAppendAttributes(
      textInput(ns("text"), NULL, "foo"),
      `data-proxy-click` = ns("btn")
    )
  )
}

login <- function(input, output, session){
  observeEvent(input$btn, {
    cat(input$text, "\n")
  })
}


ui <- fluidPage(
  tags$head(tags$script(HTML(jscode))),
  loginUI("test")
)

server <- function(input, output, session) {
  callModule(login, "test")
}

shinyApp(ui, server)