library(shiny)
library(ggplot2)
library(dplyr)

ui <- fluidPage(
  sidebarLayout
  (
    sidebarPanel(
      width = 3,
      h3("Menu"),
      br(),
      actionButton("home", "Home", style = "width: 100%; margin-bottom: 10px;"),
      actionButton("data_home", "Single Year Analysis", style = "width: 100%; margin-bottom:  10px;"),
      actionButton("over_years", " Multi Year Trends", style = "width: 100%; margin-bottom: 10px;"),
      actionButton("about", "About", style = "width: 100%; margin-bottom: 10px;")
    ),
    mainPanel(
      width = 9,
      conditionalPanel(
        condition = "input.current_page == 'home'",
        br(), br(), br(), br(), br(), br(), br(),
        h1("NIRF Rankings: Trends,Variations, and Insights", style = "text-align: center; margin-top: 50px;font-size: 90px;font-weight: bold;")
      ),
      conditionalPanel(
        condition = "input.current_page == 'over_years'",
        h1("Over the Years Analysis"),
        br(),
        tabsetPanel(
          id = "over_years_tabs",
          tabPanel(
            "Overall Score Trends",
            br(),
            h3("Average Overall Score Over the Years"),
            p("Track how the average overall score has changed across all institutes:"),
            br(),
            fluidRow(
              column(
                4,
                selectInput("topn_c", "Average of Top N Colleges:",
                  choices = c("10", "50", "100"),
                  selected = "100"
                )
              )
            ),
            br(),
            plotOutput("overall_yearly_plot", height = "600px")
          ),
          tabPanel(
            " Institute-wise Score Trends",
            br(),
            h3("Institute-wise Score Variation"),
            p("Select a state and institute to view score variation:"),
            br(),
            fluidRow(
              column(
                4,
                selectInput("yearly_state", "State:",
                  choices = NULL
                )
              ),
              column(
                4,
                selectInput("yearly_institute", "Institute:",
                  choices = NULL
                )
              )
            ),
            br(),
            plotOutput("instituteplot", height = "600px"),
            h5("*Note:Here graph going to 0 represent the data of that year is not available.", style = "text-align: right;"),
            h5("-The college was not in top 100 that year.", style = "text-align: right;")
          )
        )
      ),

      # About
      conditionalPanel(
        condition = "input.current_page == 'about'",
        h2("About This App", style = "font-weight:bold;"),
        br(),
        p("The National Institutional Ranking Framework (NIRF) is an initiative by the Government of India
   to rank higher education institutions across the country based on parameters such as Teaching, Learning & Resources,
   Research, Graduation Outcomes, Outreach, and Perception."),
        br(),
        p("This Shiny app is developed as part of a data visualization project to explore NIRF data interactively.
   The app allows users to analyze how institutes have performed over the years, view trends across categories,
   and compare states or institutions on multiple parameters."),
        br(),
        h3("Features of This App:"),
        tags$ul(
          tags$li("A clean Home Page displaying the title and the menu to navigate in the app."),
          tags$li("Single Year Analysis -The user can select any year from 2017–2025.
                    Data Table Preview (Preview of all institutes ranks),
                    Lollipop Chart (Institutes visualized by overall score),
                    Summary Statistics (Mean, median, and dispersion of all five NIRF metrics),
                    Distribution Plots (Histograms of TLR, RPC, GO, OI, PR and Score),
                    State-wise Distribution (Number of colleges ranked in top 100 per state),
                    Custom Scatter Plot (X–Y metric comparison of any two selected parameters (e.g., TLR vs. RPC) to study correlation)."),
          tags$li("Multi-Year Trends - Average Overall Score Trends (Mean overall score of top N (10,50,100) institutes across years),
                   Institute Score Evolution (Line Diagram for overall score for selected institutions)."),
          tags$li("Sidebar navigation for smooth switching between sections without reloading the app.")
        ),
        br(),
        h3("Technology Stack:"),
        tags$ul(
          tags$li("Developed in R using the Shiny framework."),
          tags$li("Visualization built with ggplot2 for clean, elegant charts."),
          tags$li("Data cleaning and summarization done using dplyr.")
        ),
        br(),
        h3("Requirements:"),
        tags$ul(
          tags$li("Download the project Zip folder."),
          tags$li("All yearly NIRF .csv files are read from the CSVs folder."),
          tags$li("Install the libraries: rvest, shiny, ggplot2, dplyr"),
          tags$li("Run app.R in RStudio and click Run App.")
        ),
        p("The resulting Shiny web application provides an accessible, reproducible, engaging and innovative way to
         analyze trends in educational performance in India and contribute to developing data-informed approaches to
         educational ranking policy."),
        br()
      ),
      conditionalPanel(
        condition = "input.current_page == 'data'",
        h1("Data Repository"),
        p("Select a year to view the data:"),
        br(),
        fluidRow(
          column(2, actionButton("y_17", "2017", style = "width: 100%; height: 60px; font-size: 16px; margin: 5px;")),
          column(2, actionButton("y_18", "2018", style = "width: 100%; height: 60px; font-size: 16px; margin: 5px;")),
          column(2, actionButton("y_19", "2019", style = "width: 100%; height: 60px; font-size: 16px; margin: 5px;")),
          column(2, actionButton("y_20", "2020", style = "width: 100%; height: 60px; font-size: 16px; margin: 5px;")),
          column(2, actionButton("y_21", "2021", style = "width: 100%; height: 60px; font-size: 16px; margin: 5px;"))
        ),
        br(),
        fluidRow(
          column(2, actionButton("y_22", "2022", style = "width: 100%; height: 60px; font-size: 16px; margin: 5px;")),
          column(2, actionButton("y_23", "2023", style = "width: 100%; height: 60px; font-size: 16px; margin: 5px;")),
          column(2, actionButton("y_24", "2024", style = "width: 100%; height: 60px; font-size: 16px; margin: 5px;")),
          column(2, actionButton("y_25", "2025", style = "width: 100%; height: 60px; font-size: 16px; margin: 5px; ")),
          column(2, div()),
          column(2, div())
        ),
        br(),
        conditionalPanel(
          condition = "input.selected_year != ''",
          h3("Currently selected year:", strong(span(textOutput("selected_year", inline = TRUE)))),
          br(),
          tabsetPanel(
            id = "data_tabs",
            tabPanel(
              "Data Preview",
              br(),
              h2("Data Preview"),
              fluidRow(
                column(
                  6,
                  numericInput("num_rows", "Number of rows to display:",
                    value = 10, min = 10, max = 100, step = 10
                  )
                )
              ),
              h4("Data Table"),
              div(
                style = "overflow-x: auto; max-height: 400px;",
                tableOutput("datatable")
              ),
              br(),
              h3("Lollipop Chart - Institute Rankings"),
              plotOutput("lpop", height = "600px")
            ),
            tabPanel(
              "EDA",
              br(),
              h3("Exploratory Data Analysis"),
              p("Select a metric to get analysis:"),
              br(),
              tabsetPanel(
                id = "edatabs",
                tabPanel(
                  "Score Analysis",
                  br(),
                  h4("Overall Score"),
                  verbatimTextOutput("scoresum"),
                  # Summary statistics
                  br(),
                  plotOutput("scorehist", height = "400px") # Histogram
                ),
                tabPanel(
                  "TLR Analysis",
                  br(),
                  h4("Teaching, Learning & Resources (TLR)"),
                  verbatimTextOutput("tlrsum"),
                  br(),
                  plotOutput("tlrhist", height = "400px")
                ),
                tabPanel(
                  "RPC Analysis",
                  br(),
                  h4("Research & Professional Practice (RPC)"),
                  verbatimTextOutput("rpcsum"),
                  br(),
                  plotOutput("rpchist", height = "400px")
                ),
                tabPanel(
                  "GO Analysis",
                  br(),
                  h4("Graduation Outcomes (GO)"),
                  verbatimTextOutput("gosum"),
                  br(),
                  plotOutput("gohist", height = "400px")
                ),
                tabPanel(
                  "OI Analysis",
                  br(),
                  h4("Outreach & Inclusivity (OI)"),
                  verbatimTextOutput("oisum"),
                  br(),
                  plotOutput("oihist", height = "400px")
                ),
                tabPanel(
                  "Perception Analysis",
                  br(),
                  h4("Perception Score"),
                  verbatimTextOutput("perceptionsum"),
                  br(),
                  plotOutput("perceptionhist", height = "400px")
                )
              )
            ),
            tabPanel(
              "State-wise Analysis",
              br(),
              h3("Colleges per State "),
              p("View the distribution of colleges across states:"),
              br(),
              h4("State-wise College Count Table"),
              div(
                style = "overflow-x: auto; max-height: 400px;",
                tableOutput("state_table")
              ),
              br(),
              h4("Number of Colleges per State - Visualization"),
              plotOutput("collegesperstate", height = "600px")
            ),
            tabPanel(
              "Scatter Plot Analysis",
              br(),
              h3("Custom Scatter Plot"),
              p("Select any two variables:"),
              br(),
              fluidRow(
                column(
                  4,
                  selectInput("x_var", "X-Axis Variable:",
                    choices = c("TLR", "RPC", "GO", "OI", "Perception", "Score"),
                    selected = "TLR"
                  )
                ),
                column(
                  4,
                  selectInput("y_var", "Y-Axis Variable:",
                    choices = c("TLR", "RPC", "GO", "OI", "Perception", "Score"),
                    selected = "RPC"
                  )
                )
              ),
              br(),
              plotOutput("scatter", height = "600px")
            )
          )
        )
      )
    )
  ),
  tags$div(
    textInput("current_page", "", value = "home"),
    textInput("selected_year", "", value = ""),
    style = "display: none;"
  )
)
# Server logic
server <- function(input, output, session) {
  output$selected_year <- renderText({
    input$selected_year
  })
  observeEvent(input$home, {
    updateTextInput(session, "current_page", value = "home")
  })

  observeEvent(input$about, {
    updateTextInput(session, "current_page", value = "about")
  })

  observeEvent(input$data_home, {
    updateTextInput(session, "current_page", value = "data")
  })

  observeEvent(input$over_years, {
    updateTextInput(session, "current_page", value = "over_years")
  })
  data_files <- list(
    "2017" = "CSVs/2017_overall.csv",
    "2018" = "CSVs/2018_overall.csv",
    "2019" = "CSVs/2019_overall.csv",
    "2020" = "CSVs/2020_overall.csv",
    "2021" = "CSVs/2021_overall.csv",
    "2022" = "CSVs/2022_overall.csv",
    "2023" = "CSVs/2023_overall.csv",
    "2024" = "CSVs/2024_overall.csv",
    "2025" = "CSVs/2025_overall.csv"
  )
  loaded_data <- reactive({
    req(input$selected_year)
    file_path <- data_files[[input$selected_year]]
    data <- read.csv(file_path)
    names(data) <- trimws(names(data))
    data
  })
  # FOR year tabs
  observeEvent(input$y_17, {
    updateTextInput(session, "selected_year", value = "2017")
  })
  observeEvent(input$y_18, {
    updateTextInput(session, "selected_year", value = "2018")
  })
  observeEvent(input$y_19, {
    updateTextInput(session, "selected_year", value = "2019")
  })
  observeEvent(input$y_20, {
    updateTextInput(session, "selected_year", value = "2020")
  })
  observeEvent(input$y_21, {
    updateTextInput(session, "selected_year", value = "2021")
  })
  observeEvent(input$y_22, {
    updateTextInput(session, "selected_year", value = "2022")
  })
  observeEvent(input$y_23, {
    updateTextInput(session, "selected_year", value = "2023")
  })
  observeEvent(input$y_24, {
    updateTextInput(session, "selected_year", value = "2024")
  })
  observeEvent(input$y_25, {
    updateTextInput(session, "selected_year", value = "2025")
  })

  output$datatable <- renderTable(
    {
      data <- head(loaded_data(), input$num_rows)
      data <- data[, c("Name", "Score", "Rank", "TLR", "RPC", "GO", "OI", "Perception", "City", "State")]
      numeric_cols <- c("Score", "TLR", "RPC", "GO", "OI", "Perception")
      data[numeric_cols] <- lapply(data[numeric_cols], \(x) round(x, 2))
      data
    },
    striped = TRUE,
    hover = TRUE,
    bordered = TRUE,
    width = "100%"
  )

  # Lollipop Plot
  output$lpop <- renderPlot({
    data <- loaded_data()
    n_rows <- min(input$num_rows, nrow(data))
    plot_data <- data[1:n_rows, ]
    plot_data <- subset(plot_data, !is.na(Score) & !is.na(Name))

    ggplot(plot_data, aes(x = Score, y = reorder(Name, Score))) +
      geom_segment(aes(x = 0, xend = Score, y = reorder(Name, Score), yend = reorder(Name, Score)),
        color = "gray70"
      ) +
      geom_point(aes(color = Score), size = 3) +
      scale_color_gradient(low = "red", high = "green") +
      labs(
        title = paste("Institute Rankings -", input$selected_year),
        subtitle = paste("Showing top", n_rows, "institutes"),
        x = "Overall Score",
        y = "Institute Name"
      ) +
      theme_minimal() +
      theme(
        axis.text.y = element_text(size = 8),
        plot.title = element_text(hjust = 0.5, size = 14, face = "bold"),
        plot.subtitle = element_text(hjust = 0.5, size = 10)
      )
  })

  output$tlrsum <- renderPrint({
    data <- loaded_data()
    cat("Teaching, Learning & Resources (TLR) Analysis\n")
    cat("Summary Statistics:\n")
    print(summary(data$TLR))
    cat("\nTop 5 Institutes by TLR:\n")
    top_tlr <- data[order(data$TLR, decreasing = TRUE), c("Name", "TLR", "Rank")][1:5, ]
    print(top_tlr)
  })

  output$tlrhist <- renderPlot({
    data <- loaded_data()
    ggplot(data, aes(x = TLR)) +
      geom_histogram(bins = 20, fill = "blue", alpha = 0.7, color = "black") +
      labs(
        title = "Distribution of TLR Scores",
        x = "TLR Score", y = "Frequency"
      ) +
      theme_minimal() +
      theme(plot.title = element_text(hjust = 0.5, size = 12, face = "bold"))
  })

  output$rpcsum <- renderPrint({
    data <- loaded_data()
    cat("Research & Professional Practice (RPC) Analysis\n")
    cat("Summary Statistics:\n")
    print(summary(data$RPC))
    cat("\nTop 5 Institutes by RPC:\n")
    top_rpc <- data[order(data$RPC, decreasing = TRUE), c("Name", "RPC", "Rank")][1:5, ]
    print(top_rpc)
  })

  output$rpchist <- renderPlot({
    data <- loaded_data()
    ggplot(data, aes(x = RPC)) +
      geom_histogram(bins = 20, fill = "darkgreen", alpha = 0.7, color = "black") +
      labs(
        title = "Distribution of RPC Scores",
        x = "RPC Score", y = "Frequency"
      ) +
      theme_minimal() +
      theme(plot.title = element_text(hjust = 0.5, size = 12, face = "bold"))
  })

  output$gosum <- renderPrint({
    data <- loaded_data()
    cat("Graduation Outcomes (GO) Analysis\n")
    cat("Summary Statistics:\n")
    print(summary(data$GO))
    cat("\nTop 5 Institutes by GO:\n")
    top_go <- data[order(data$GO, decreasing = TRUE), c("Name", "GO", "Rank")][1:5, ]
    print(top_go)
  })

  output$gohist <- renderPlot({
    data <- loaded_data()
    ggplot(data, aes(x = GO)) +
      geom_histogram(bins = 20, fill = "orange", alpha = 0.7, color = "black") +
      labs(
        title = "Distribution of GO Scores",
        x = "GO Score", y = "Frequency"
      ) +
      theme_minimal() +
      theme(plot.title = element_text(hjust = 0.5, size = 12, face = "bold"))
  })

  output$oisum <- renderPrint({
    data <- loaded_data()
    cat("Outreach & Inclusivity (OI) Analysis\n")
    cat("Summary Statistics:\n")
    print(summary(data$OI))
    cat("\nTop 5 Institutes by OI:\n")
    top_oi <- data[order(data$OI, decreasing = TRUE), c("Name", "OI", "Rank")][1:5, ]
    print(top_oi)
  })

  output$oihist <- renderPlot({
    data <- loaded_data()
    ggplot(data, aes(x = OI)) +
      geom_histogram(bins = 20, fill = "purple", alpha = 0.7, color = "black") +
      labs(
        title = "Distribution of OI Scores",
        x = "OI Score", y = "Frequency"
      ) +
      theme_minimal() +
      theme(plot.title = element_text(hjust = 0.5, size = 12, face = "bold"))
  })

  output$perceptionsum <- renderPrint({
    data <- loaded_data()
    cat("Perception Score Analysis\n")
    cat("Summary Statistics:\n")
    print(summary(data$Perception))
    cat("\nTop 5 Institutes by Perception:\n")
    top_perception <- data[order(data$Perception, decreasing = TRUE), c("Name", "Perception", "Rank")][1:5, ]
    print(top_perception)
  })

  output$perceptionhist <- renderPlot({
    data <- loaded_data()
    ggplot(data, aes(x = Perception)) +
      geom_histogram(bins = 20, fill = "red", alpha = 0.7, color = "black") +
      labs(
        title = "Distribution of Perception Scores",
        x = "Perception Score", y = "Frequency"
      ) +
      theme_minimal() +
      theme(plot.title = element_text(hjust = 0.5, size = 12, face = "bold"))
  })

  output$scoresum <- renderPrint({
    data <- loaded_data()
    cat("Overall Score Analysis\n")
    cat("Summary Statistics:\n")
    print(summary(data$Score))
  })

  output$scorehist <- renderPlot({
    data <- loaded_data()
    ggplot(data, aes(x = Score)) +
      geom_histogram(bins = 20, fill = "yellow", alpha = 0.7, color = "black") +
      labs(
        title = "Distribution of Overall Scores",
        x = "Overall Score", y = "Frequency"
      ) +
      theme_minimal() +
      theme(plot.title = element_text(hjust = 0.5, size = 12, face = "bold"))
  })

  # State part
  output$state_table <- renderTable(
    {
      data <- loaded_data()
      state_summary <- data %>%
        group_by(State) %>%
        summarise(
          Colleges = n(),
          .groups = "drop"
        ) %>%
        arrange(desc(Colleges))

      state_summary
    },
    striped = TRUE,
    hover = TRUE,
    bordered = TRUE,
    width = "100%"
  )

  output$collegesperstate <- renderPlot({
    data <- loaded_data()
    state_summary <- data %>%
      group_by(State) %>%
      summarise(
        Colleges = n(),
        .groups = "drop"
      ) %>%
      arrange(desc(Colleges))

    ggplot(state_summary, aes(x = reorder(State, Colleges), y = Colleges)) +
      geom_bar(stat = "identity", fill = "blue", alpha = 0.7) +
      coord_flip() +
      labs(
        title = paste("Number of Colleges per State -", input$selected_year),
        x = "State",
        y = "Number of Colleges"
      ) +
      theme_minimal() +
      theme(plot.title = element_text(hjust = 0.5, size = 14, face = "bold"), axis.text.y = element_text(size = 10), axis.title = element_text(size = 12))
  })

  # Scatter plot
  output$scatter <- renderPlot({
    data <- loaded_data()
    p <- ggplot(data, aes_string(x = input$x_var, y = input$y_var)) +
      geom_point(color = "blue", alpha = 0.6, size = 3) +
      labs(
        title = paste(input$x_var, "vs", input$y_var, "-", input$selected_year),
        x = input$x_var,
        y = input$y_var
      ) +
      theme_minimal() +
      theme(
        plot.title = element_text(hjust = 0.5, size = 14, face = "bold"), axis.title = element_text(size = 12)
      )
    p <- p + geom_smooth(method = "lm", se = TRUE, color = "red", linetype = "dashed")
    p
  })

  all_years_data <- reactive({
    alldata <- lapply(names(data_files), function(year) {
      file_path <- data_files[[year]]
      data <- read.csv(file_path)
      names(data) <- trimws(names(data))
      data$Year <- year
      data
    })
    alldata <- Filter(Negate(is.null), alldata)

    if (length(alldata) > 0) {
      do.call(rbind, alldata)
    } else {
      data.frame()
    }
  })
  observe({
    data <- all_years_data()
    states <- unique(data$State[!is.na(data$State)])
    updateSelectInput(session, "yearly_state", choices = sort(states)) # Extracting all unique states
  })
  observe({
    data <- all_years_data()
    state <- input$yearly_state
    institutes <- unique(data$Name[data$State == state & !is.na(data$Name)])
    updateSelectInput(session, "yearly_institute", choices = sort(institutes))
  })

  # Institute-wise yearly plot
  output$instituteplot <- renderPlot({
    data <- all_years_data()
    institute <- input$yearly_institute
    all_years <- sort(unique(data$Year))
    institute_data <- data %>%
      filter(Name == institute) %>%
      select(Year, Score)
    complete_data <- data.frame(
      Year = all_years,
      Score = 0
    )
    for (i in 1:nrow(complete_data)) {
      yr <- complete_data$Year[i]
      match_score <- institute_data$Score[institute_data$Year == yr]
      if (length(match_score) > 0) {
        complete_data$Score[i] <- match_score
      }
    }
    ggplot(complete_data, aes(x = Year, y = Score, group = 1)) +
      geom_line(color = "darkgreen", linewidth = 2) +
      geom_point(color = "darkgreen", size = 4) +
      geom_text(aes(label = round(Score, 2)), vjust = -0.5, size = 4) +
      labs(title = paste(institute, "- Score Variation Over Years"), x = "Year", y = "Overall Score") +
      theme_minimal() +
      theme(plot.title = element_text(hjust = 0.5, size = 16, face = "bold"), axis.title = element_text(size = 12), axis.text = element_text(size = 10))
  })
  output$overall_yearly_plot <- renderPlot({
    data <- all_years_data()
    top_n <- input$topn_c
    yearly_avg <- data %>%
      group_by(Year) %>%
      summarise(
        AvgScore = if (top_n == "All") {
          mean(Score, na.rm = TRUE)
        } else {
          mean(
            head(sort(Score, decreasing = TRUE), as.numeric(top_n)),
            na.rm = TRUE
          )
        },
        .groups = "drop"
      )
    title_text <- paste(
      "Average Overall Score Across All Years (",
      if (top_n == "All") "All Colleges" else paste("Top", top_n, "Colleges"), ")"
    )

    ggplot(yearly_avg, aes(x = Year, y = AvgScore, group = 1)) +
      geom_line(color = "blue", linewidth = 2) +
      geom_point(color = "blue", size = 4) +
      geom_text(aes(label = round(AvgScore, 2)), vjust = -1, size = 4) +
      labs(title = title_text, x = "Year", y = "Average Overall Score") +
      theme_minimal() +
      theme(plot.title = element_text(hjust = 0.5, size = 16, face = "bold"), axis.title = element_text(size = 12), axis.text = element_text(size = 10))
  })
}
shinyApp(ui, server)
