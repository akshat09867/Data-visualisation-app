server <- function(input, output, session) {
  data <- reactive({
    req(input$file)
    validate(
      need(grepl("\\.csv$", input$file$name), "Please upload a CSV file.")
    )
    read.csv(input$file$datapath)
  })
  
  observe({
    req(data())
    updateSelectizeInput(session, "xcol", choices = names(data()))
    updateSelectizeInput(session, "ycol", choices = names(data()))
  })
  
  output$summary <- renderPrint({
    req(data())
    summary(data())
  })
  
  output$file_status <- renderValueBox({
    valueBox(
      ifelse(is_null(input$file), "File not uploaded", "Uploaded"),
      "File Status",
      icon = icon(ifelse(is_null(input$file), "times-circle", "check-circle")),
      color = ifelse(is_null(input$file), "red", "yellow")
    )
  })   
  
  output$rows_c <- renderValueBox({
    req(data())
    valueBox(
      nrow(data()),
      "Rows",
      icon = icon("list-ol"),
      color = "yellow"
    )
  })
  
  output$columns_c <- renderValueBox({
    req(data())
    valueBox(
    ncol(data()),
    "Columns",
    icon= icon("list-ol"),
    color= "yellow"
    )
  })
  
  output$data_preview <- renderDataTable({
    req(data())
    datatable(data(), options = list(scrollX = TRUE, pageLength = 4))
  })
  
  output$plot <- renderPlotly({
    req(data(), input$xcol, input$ycol)
    xl <- input$xcol
    yl <- input$ycol
    if (input$plot.type == "scatter") {
      plot_ly(data(), x = ~get(xl), y = ~get(yl), type = "scatter", mode = "markers",
      marker=list(color=input$color,opacity=input$alpha)) %>% 
        layout(xaxis = list(title = xl),
               yaxis = list(title = yl)
        )
    }
    else if (input$plot.type == "histogram") {
      plot_ly(data(), x = ~get(xl), type = "histogram",marker=list(color=input$color,opacity=input$alpha)) %>%
        layout(
          xaxis = list(title = xl),
          yaxis = list(title = "Frequency")
        )
    }
    else if (input$plot.type == "boxplot") {
      plot_ly(data(), y = ~get(yl), color = ~get(xl), type = "box",marker=list(opacity=input$alpha)) %>%
        layout(xaxis = list(title = xl),
              yaxis = list(title = yl)
        )
    }
      else if (input$plot.type == "sankey") {
      validate(
        need(ncol(data()) >= 3, "Sankey diagrams require at least 3 columns of data")
      )
      
      nodes <- data.frame(name = unique(c(data()[[xl]], data()[[yl]])))
      links <- data.frame(
        source = match(data()[[xl]], nodes$name) - 1,
        target = match(data()[[yl]], nodes$name) - 1,
        value = if("value" %in% names(data())) data()$value else 1
      )
      
      plot_ly(
        type = "sankey",
        orientation = "h",
        node = list(
          label = nodes$name,
          color = input$color,
          pad = 15,
          thickness = 20,
          line = list(color = "black", width = 0.5)
        ),
        link = list(
          source = links$source,
          target = links$target,
          value = links$value
        )
      ) %>% 
        layout(title = paste("Sankey:", xl, "to", yl),
               font = list(size = 10))
    }
        else if (input$plot.type == "area") {
      plot_ly(data(), x = ~get(xl), y = ~get(yl), type = "scatter", mode = "lines",
              fill = 'tozeroy', 
              line = list(color = input$color),
              fillcolor = paste0(substr(input$color, 1, 7), as.character(input$alpha * 100))) %>%
        layout(xaxis = list(title = xl),
               yaxis = list(title = yl))
    }
  })
}
