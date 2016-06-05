library(shiny)
library(shinydashboard)

server <- function(input, output) {
  lm_line = reactive({
  input$yes
  fit = lm(dist ~ speed, data = cars)
  lines(cars$speed, predict(fit, cars), lwd = 2)
})

output$foo = renderPlot({
  col = input$color
  if (length(col) == 0 || !(col %in% colors())) col = 'gray'
  plot(cars, main = input$title, col = col, cex = input$bigger, pch = 19)
  lm_line()
})

output$distPlot <- renderPlot({
    col = input$color
    if (length(col) == 0 || !(col %in% colors())) col = 'darkgray'
    hist(rnorm(input$col), col = col, border = 'white')
  })
}
# includeScript('js/voice.min.js'),
ui <- fluidPage(
  includeScript('js/voice.min.js'),
  sidebarLayout(
    sidebarPanel(
      sliderInput("col", "Number of observations:", min = 10, max = 500, value = 100)
    ),
    mainPanel(plotOutput("distPlot"),
              plotOutput("foo")
    )
  ),
  HTML("<script>runVoice(true, Shiny);</script>")
)

shinyApp(ui = ui, server = server)
# textInput("color", "Number of observations:", 'red')
