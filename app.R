library(shiny)
library(shinydashboard)
library(highcharter)
library(forecast)

library(dplyr)
library(viridisLite)
library(treemap)

# output$test <- renderText({
#   "股票板块推荐"
# })
#
# output$diqu <- renderText({
#   "股票地区推荐"
# })
# library(shinyjs)
# library(quantmod)
#      includeScript('js/voice.min.js')
#  HTML("<script>runVoice(true, Shiny);</script>")



# forecast <- reactive({return(input$forecast)})

# if(input$forecast==FALSE){
#   AirPassengers %>%
#     hchart()
# }else{
#   AirPassengers %>%
#     forecast(level = 90) %>%
#     hchart() %>%
#     hc_add_theme(thm)
# }
# div(id='forecast',class='forecast',highchartOutput("forecastPlot", width = "100%", height=270)),
# textOutput("test"),textOutput("diqu")
shinyApp(
  ui = fluidPage(
    singleton(tags$head(
      tags$script(src="//cdnjs.cloudflare.com/ajax/libs/annyang/1.4.0/annyang.min.js"),
      tags$script(src="//cdnjs.cloudflare.com/ajax/libs/SpeechKITT/0.3.0/speechkitt.min.js"),
      includeScript('init.js')

    )),

    mainPanel(div(id='table', class='table mchart',tableOutput("table")),
            div(id='chart',class='chart mchart',highchartOutput("phonePlot", width = "100%", height=270)),
            div(id='forecast',class='forecast mchart',highchartOutput("forecastPlot", width = "100%", height=270)),
            highchartOutput("treemap", width = "100%", height=270)),
            highchartOutput("map",width = "100%", height=270)



  ),
  server = function(input, output) {

    lm_line = reactive({
      input$yes
      fit = lm(dist ~ speed, data = cars)
      lines(cars$speed, predict(fit, cars), lwd = 2)
    })


    output$foo = renderPlot({
      col = input$color
      colors = c("#434348", "#90ed7d","blue", "red")
      if (length(col) == 0 || !(col %in% colors())) col = 'gray'
      plot(cars, main = input$title, col = col, cex = input$bigger, pch = 19)
      lm_line()
    })


    output$table <- renderTable({
      AirPassengers
        })



    output$phonePlot <- renderHighchart({
      col = input$color
      if (length(col) == 0) col = 'gray'

      thm <- hc_theme(
    colors = c(col, "#434348", "#90ed7d"),
    chart = list(
      backgroundColor = "transparent",
      style = list(fontFamily = "Source Sans Pro")
        ),
        xAxis = list(
        gridLineWidth = 1
        )
      )

      AirPassengers %>% hchart() %>% hc_add_theme(thm)

    })

    output$forecastPlot <- renderHighchart({
      col = input$color
      if (length(col) == 0) col = 'gray'
      thm <- hc_theme(
        colors = c(col, "#434348", "#90ed7d"),
        chart = list(
          backgroundColor = "transparent",
          style = list(fontFamily = "Source Sans Pro")
        ),
        xAxis = list(
          gridLineWidth = 1
        )
      )

      AirPassengers %>% forecast(level=90) %>% hchart() %>% hc_add_theme(thm)

    })





    output$treemap <- renderHighchart({
        data("Groceries", package = "arules")
dfitems <- tbl_df(Groceries@itemInfo)

set.seed(10)

dfitemsg <- dfitems %>%
  mutate(category = gsub(" ", "-", level1),
         subcategory = gsub(" ", "-", level2)) %>%
  group_by(category, subcategory) %>%
  summarise(sales = n() ^ 3 ) %>%
  ungroup() %>%
  sample_n(31)



      thm <- hc_theme(
    colors = c( "#434348","#434348", "#90ed7d"),
    chart = list(
      title = "sdffs",
      backgroundColor = "transparent",
      style = list(fontFamily = "Source Sans Pro")
    ),
    xAxis = list(
      gridLineWidth = 1
    )
  )


tm <- treemap(dfitemsg, index = c("category", "subcategory"),
              vSize = "sales", vColor = "sales",
              type = "value", palette = rev(viridis(6)))

highchart() %>%
  hc_add_series_treemap(tm, allowDrillToNode = TRUE,
                        layoutAlgorithm = "squarified") %>%
  hc_add_theme(thm)

    })


output$map <- renderHighchart({
  data("USArrests", package = "datasets")
  data("usgeojson")

  USArrests <- USArrests %>%
    mutate(state = rownames(.))

  n <- 4
  colstops <- data.frame(
    q = 0:n/n,
    c = substring(viridis(n + 1), 0, 7)) %>%
    list.parse2()

  thm <- hc_theme(
    colors = c("#434348", "#434348", "#90ed7d"),
    chart = list(
      backgroundColor = "transparent",
      style = list(fontFamily = "Source Sans Pro")
    ),
    xAxis = list(
      gridLineWidth = 1
    )
  )

  highchart() %>%
    hc_add_series_map(usgeojson, USArrests, name = "Sales",
                      value = "Murder", joinBy = c("woename", "state"),
                      dataLabels = list(enabled = TRUE,
                                        format = '{point.properties.postalcode}')) %>%
    hc_colorAxis(stops = colstops) %>%
    hc_legend(valueDecimals = 0, valueSuffix = "%") %>%
    hc_mapNavigation(enabled = TRUE) %>%
    hc_add_theme(thm)


        })
  }
)
