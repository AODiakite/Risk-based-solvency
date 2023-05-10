#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
source("functions.R")
# Define UI for application that draws a histogram
ui <- dashboardPage(
  dashboardHeader(
    title = "SBR Application ",
    skin = "light"
  ),
  controlbar = dashboardControlbar(
    collapsed = TRUE,
    div(class = "p-3", skinSelector()),
    pinned = FALSE
  ),
  # Sidebar content-------------
  dashboardSidebar(
    status = "navy", skin = "light", collapsed = F,
    br(),
    sidebarMenu(
      menuItem(text = "Paramètres", tabName = "parametres", icon = icon("sliders")),
      menuItem(text = "Courbe des taux", tabName = "courbe_taux", icon = icon("chart-line"))
    ),
  ),
  # Body content----------
  dashboardBody(
    # Boxes need to be put in a row (or column)
    # Sidebar Items
    tabItems(
      # Parametres-------
      tabItem(
        tabName = "parametres",
        tags$h2("Cet onglet contiendra les paramètres de l'application")
      ),
      # Courbe des taux ----------
      tabItem(
        tabName = "courbe_taux",
        add_busy_spinner(
          spin = "breeding-rhombus",
          margins = c(300, 600), width = "100px", height = "100px"
        ),
        fluidRow(
          column(
            6,

            # Import:  Importaion
            box(
              status = "navy", solidHeader = T, width = 12,
              title = "Taux de référence des bons du Trésor",
              tags$caption("Veuillez choisir une date pour télécharger les données du site de la Bank Al-Maghrib"),
              # Date: Select a file
              fluidRow(
                column(
                  9,
                  dateInput("date_taux", label = "Date de la valeur", max = Sys.Date())
                ),
                column(
                  3,
                  actionButton(inputId = "date_btn", "Télécharger", style = "margin-top:30px", status = "success", width = "100%")
                )
              ),
              tags$hr(),
              # Table des taux
              DT::dataTableOutput(outputId = "datataux_ref", width = "100%")
            ),
            box(
              status = "navy", solidHeader = T, width = 12,
              title = "Taux zéro coupon",
              tags$caption("Ces taux sont obtenues par la méthode de boostrapping sur
                         les taux actuariels de maturités pleines"),
              tags$hr(),
              # Taux zero coupon
              DT::dataTableOutput("data_taux_zc", width = "100%")
            )
          ),
          column(
            6,
            tabBox(
              status = "navy", solidHeader = T, width = 12,
              type = "tabs", side = "right",
              title = h4(tags$b("Taux actuariel")),
              tabPanel(
                tags$b("Maturités disponibles"),
                # Taux actuariels
                DT::dataTableOutput("mat_dispo", width = "100%")
              ),
              tabPanel(
                tags$b("Maturités pleines"),
                DT::dataTableOutput("mat_pleine", width = "100%")
              )
            ),
            box(
              status = "navy", solidHeader = T, width = 12, maximizable = T,
              title = "Graphique",
              # Graphique taux ZC
              plotlyOutput("plot_ZC", width = "auto")
            )
          )
        )
      )
    )
  )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  useAutoColor()
  # Donnees a utiliser---
  # Taux de reference des bons de tresors
  TRBT <- reactive(
    get_taux_BAM(input$date_taux)
  ) %>%
    bindEvent(input$date_btn)


  # Taux actuariel
  TA <- reactive(get_taux_act(TRBT()))
  # Taux actuariel de maturité pleine (interpolation)
  T_INTER <- reactive(interpolation(TA()))
  # Taux ZC
  TZC <- reactive(boostrapping(T_INTER()))

  output$datataux_ref <- DT::renderDataTable(
    TRBT(),
    extensions = "Buttons",
    options = list(
      searching = FALSE,
      dom = "Bfrtip",
      buttons = c("copy", "csv", "excel", "pdf", "print"),
      paging = FALSE, ## paginate the output
      # pageLength = 6,
      scrollX = TRUE,
      scrollY = 200
    )
  )

  output$mat_dispo <- DT::renderDataTable(
    TA(),
    extensions = "Buttons",
    options = list(
      searching = FALSE,
      dom = "Bfrtip",
      buttons = c("copy", "csv", "excel", "pdf", "print"),
      paging = FALSE, ## paginate the output
      # pageLength = 6,
      scrollX = TRUE,
      scrollY = 200
    )
  )
  output$mat_pleine <- DT::renderDataTable(
    T_INTER(),
    extensions = "Buttons",
    options = list(
      searching = FALSE,
      dom = "Bfrtip",
      buttons = c("copy", "csv", "excel", "pdf", "print"),
      paging = FALSE, ## paginate the output
      pageLength = 10,
      scrollX = TRUE,
      scrollY = 200
    )
  )
  output$data_taux_zc <- DT::renderDataTable(
    merge(TZC(), T_INTER()),
    extensions = "Buttons",
    options = list(
      searching = FALSE,
      dom = "Bfrtip",
      buttons = c("copy", "csv", "excel", "pdf", "print"),
      paging = FALSE, ## paginate the output
      pageLength = 10,
      scrollX = TRUE,
      scrollY = 200
    )
  )
  output$plot_ZC <- renderPlotly({
    df_plot <- merge(TZC(), T_INTER())
    df_plot <- df_plot %>%
      select(Maturité, `Taux zéro coupon`, `Taux actuariel`) %>%
      pivot_longer(
        cols = -Maturité,
        names_to = "Courbe",
        values_to = "Taux"
      ) %>%
      mutate(
        pct = gsub("\\.", ",", paste0(round(Taux * 100, 3), "%"))
      )
    df_plot %>%
      plot_ly(
        x = ~Maturité,
        y = ~Taux,
        color = ~Courbe,
        hoverinfo = "text",
        colors = c("darkgrey", "navy"),
        text = glue("{df_plot$Courbe} : {df_plot$pct}\nMaturité : {df_plot$Maturité}"),
        type = "scatter",
        mode = "lines+markers"
      ) %>%
      layout(
        title = "Courbe des taux",
        legend = list(orientation = "h", xanchor = "center", x = 0.5),
        xaxis = list(title = ""),
        yaxis = list(title = "")
      )
  })
}

# Run the application
shinyApp(ui = ui, server = server)
