# ui.R
ui <- dashboardPage(
  dashboardHeader(
    title = tags$span(icon("chart-line"), "Interactive Data Explorer"),
    titleWidth = 300
  ),
  dashboardSidebar(
    width = 300,
    sidebarMenu(
      menuItem("Data Upload", tabName = "data", icon = icon("database"),
               fileInput("file", "Choose CSV File",
                         accept = c("text/csv", ".csv"),
                         buttonLabel = "Upload...",
                         placeholder = "Select file"),
               tags$hr()
      ),
      menuItem("Visulization Settings", tabName = "viz", icon = icon("sliders"),
               prettyRadioButtons(
                 "plot.type", "Plot", choices = c("Scatter" = "scatter", "Histogram" = "histogram", "Boxplot" = "boxplot","Area"="area","Sankey"="sankey"), inline = TRUE, status = "danger",
               ),
               selectizeInput("xcol", "Xaxis", choices = NULL, options = list(placeholder = "Select Column")),
               selectizeInput("ycol", "Yaxis", choices = NULL, options = list(placeholder = "Select Column")),
               tags$hr()
      ),
      menuItem("point setting", tabName = "opa", icon = icon("chart-line"),
               sliderInput("alpha", "point opacity", min = 0, max = 1, step = 0.2, value = 0.8),
               colourInput("color", "Select Color:", "#0FA3B1")
      )
    )
  ),
  dashboardBody(
    tags$style(HTML("
      .box-title { font-size: 18px; font-weight: bold; }
      .main-header .logo { font-weight: bold; }
      .skin-black .main-header .logo { background-color: #222D32; }
      .skin-black .main-header .navbar { background-color: #222D32; }
    ")),
    fluidRow(
      valueBoxOutput("rows_c", width = 4),
      valueBoxOutput("file_status", width = 4),
      valueBoxOutput("columns_c", width = 4)
    ),
    fluidRow(
      tabBox(
        title = tagList("Vizulaization", icon = icon("database")),
        width = 12, height = "600px",
        tabPanel("Plot", plotlyOutput("plot")),
        tabPanel("Summary", div(style = "overflow-y:auto", verbatimTextOutput("summary")))
      ),
    ),
    fluidRow(
      box(title = "Data Preview", status = "primary", solidHeader = TRUE,
          width = 12, collapsible = TRUE,
          DTOutput("data_preview")
      ),
    ),
  ),
  skin = "blue"
)