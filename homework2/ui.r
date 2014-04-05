library(shiny)

data(movies)

shinyUI(
    pageWithSidebar(
      headerPanel("IMDB Moive Ratings"),
      
      sidebarPanel(
        radioButtons(
          "format",
          "Change Format:",
          c("Single ScatterPlot","Multiple Scatterplot"),
          ("Single Scatterplot")
          ),
        radioButtons(
          "highlight",
          "MPAA Ratings:",
          c("NC-17","PG","PG-13","R","All" )
        ),
        br(),
        checkboxGroupInput(
          "genre",
          "Movie Genres",
          c("Action","Animation","Comedy","Documentary","Drama","Mixed","None",
            "Romance","Short")
          ),
        br(),
        selectInput("colorscheme",
                    "Color Scheme",
                    c("Default", "Accent", "Set1", "Set2", "Set3", "Dark2", "Pastel1",
                      "Pastel2")),
        sliderInput("dotsize", "Dot Size", 1, 10,5),
        sliderInput("alphavalue", "Dot Alpha", 0.1, 1.0, 0.5,step=0.1),
        width = 2
      ),
      
      mainPanel(
        tabsetPanel(
          tabPanel("Scatter Plot", plotOutput("scatterplot")),
          tabPanel("Other Statistic", tableOutput("table"),width = 10)
        ))
    )
  )
