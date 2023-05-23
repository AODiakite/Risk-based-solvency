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
      menuItem(text = "Courbe des taux", tabName = "courbe_taux", icon = icon("chart-line")),
      menuItem(text = "Non-vie hors rentes", tabName = "nonvieHR", icon = icon("car-burst"))
    )
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
      ),
      tabItem(
        tabName = "nonvieHR",
          uiOutput("valueBoxs")
        ,
        fluidRow(
          box(
            status = "navy", solidHeader = T, width = 6,
            title = "Importation du triangle de réglement",
            # Input: Select a file
            fileInput("fileTriangle", "Choisir le triangle de réglements",
              buttonLabel = "Parcourir...",
              multiple = FALSE,
              accept = c(
                "text/csv",
                "text/comma-separated-values,text/plain",
                ".csv",
                ".xls",
                ".xlsx"
              )
            ),
            # Horizontal line
            tags$hr(),
            fluidRow(
              column(
                12,
                # Input: Checkbox if file has header
                checkboxInput("cumuler", "Voulez vous cumuler le triangle ?", FALSE)
              )
            ),
            # Horizontal line
            tags$hr(),
            fluidRow(
              column(
                4,
                # Input: Select separator
                radioButtons("sep", "Separator",
                             choices = c(
                               Comma = ",",
                               Semicolon = ";",
                               Tab = "\t"
                             ),
                             selected = ","
                )
              ),
              column(
                5,
                offset = 1,
                # Input: Select quotes
                radioButtons("quote", "Quote",
                             choices = c(
                               None = "",
                               "Double Quote" = '"',
                               "Single Quote" = "'"
                             ),
                             selected = '"'
                )
              )
            ),
            column(
              12,
                actionButton(inputId = "tgl_btn", "Confirmer la lecture du triangle" , status = "success", width = "100%")
            )


          ),
          box(
            status = "navy", solidHeader = T, width = 6,
            title = "Paramètrages",
            fluidRow(
              column(
                12,
                tags$h5(tags$b("Primes Acquises (PA)")),
                tags$hr()
              ),
              column(
                4,
                numericInput("pa0", "Année n",value = NULL)
              ),
              column(
                4,
                numericInput("pa1", "Année n-1",value = NULL)
              ),
              column(
                4,
                numericInput("pa2", "Année n-2",value = NULL)
              )
            ),
            tags$hr(),
            fluidRow(
              column(
                4,
                numericInput("ppna","PPNA",value = NULL)
              ),
              column(
                4,
                numericInput("pfp","Primes futurs",value = NULL)
              ),
              column(
                4,
                numericInput("taux_acq","Taux frais d’acquisition",value = NULL)
              )
            ),
            fluidRow(
              column(
                9,
                numericInput("tx_FG_Moyen", label = "Taux de frais gestion moyens", value = NULL, min = 0,max = 1)
              ),
              column(
                3,
                actionButton(inputId = "param_btn", "Confirmer", style = "margin-top:30px", status = "success", width = "100%")
              )
            )
          )

        ),
        fluidRow(
          tabBox(
             solidHeader = T, width = 12,maximizable = TRUE,
            type = "tabs", side = "right",status = "navy",
            tabPanel(
              tags$b("Apperçu du triangle"),
              # Triangle de réglements
              DT::dataTableOutput("trgl_data", width = "100%")
            ),
            tabPanel(
              tags$b("Calcul des règlements cumulés futurs"),
              # Triangle de reglements
              DT::dataTableOutput("trgl_global", width = "100%")
            )

            )
        ),
        fluidRow(
          tabBox(
            solidHeader = T, width = 6,
            type = "tabs", side = "right",status = "navy",
            title = "Cadence de liquidations",
            tabPanel(
              tags$b("Graphique"),
              plotlyOutput("cad_plot")
            ),
            tabPanel(
              tags$b("Table"),
              DT::dataTableOutput("cad_data")
            )
          ),
          tabBox(
            solidHeader = T, width = 6,
            type = "tabs", side = "right",status = "navy",
            title = "Cash flows",
            tabPanel(
              tags$b("Graphique"),
              plotlyOutput("cf_plot")
            ),
            tabPanel(
              tags$b("Table"),
              DT::dataTableOutput("cf_data")
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
  # Parametrage ------
  parametrage <- reactive(
    {
      list(
        Sum_PA = sum(c(input$pa0,input$pa1,input$pa2),na.rm = TRUE),
        PPNA = input$ppna,
        Prime_Futur = input$pfp,
        tx_acq = input$taux_acq,
        tx_FG_Moy = input$tx_FG_Moyen
      )
    }
  ) %>%
    bindEvent(input$param_btn)
  # Ratio de sinistralité
  RS <- reactive({
    decumul = decumul_tri(triangleAT(),c_hat())
    CU = apply(decumul,1,sum)
    nn = length(CU)
    parametrage()$Sum_PA/sum(CU[(nn-3):nn])
  })
  # BE sinistre
  BE_Sin_nv <- reactive({
    BE_Sinistre_nv(r_hat = Cash_flows(),ZC = TZC()[["Taux zéro coupon"]])
  })
  # BE prime
  BE_Prime <- reactive({
    BE_Prime_nv(frfp_hat = FRFP_hat(cad_liq = cadence(),
                                    RS = RS(),PPNA = parametrage()[["PPNA"]],
                                    PFP = parametrage()[["Prime_Futur"]]),
                ZC = TZC()[["Taux zéro coupon"]],
                PFPA = parametrage()[["Prime_Futur"]]*parametrage()[["tx_acq"]]
                )
  })
  PSAP = reactive({
    Diag = diag(apply(triangleAT(),1,rev))
    c_hat <- C_hat(triangle = triangleAT(),fdc = calculer_fdc(triangleAT()))
    psap =  sum(c_hat[,ncol(c_hat)] - Diag,na.rm = TRUE)
    psap
  })
  output$valueBoxs <- renderUI(
    fluidRow(
      column(
        4,
        valueBox(
          value =  tags$h3(round(BE_Sin_nv(),3)),
          subtitle  = tags$h5("BE Sinistre"),
          icon = icon("car-burst"),
          width = 12,color = "lightblue",gradient = TRUE,
          footer = div("Meilleure estimation des engagements pour sinistres")
        )
      ),
      column(
        4,
        valueBox(
          value =  tags$h3(round(BE_Prime(),3)),
          subtitle  = tags$h5("BE Prime"),
          icon = icon("sack-dollar"),
          width = 12,color = "lightblue",gradient = TRUE,
          footer = div("Meilleure estimation des engagements pour prime")
        )
      ),
      column(
        4,
        valueBox(
          value =  tags$h3(round(PSAP(),3)),
          subtitle  = tags$h5("PSAP"),
          icon = icon("hand-holding-dollar"),
          width = 12,color = "lightblue",gradient = TRUE,
          footer = div("Provision pour sinistre à payer")
        )
      )


    )
  )

  # Triangle de réglement ----
  triangleAT <- reactive({
    tryCatch(
      {req(input$fileTriangle)
        inFile <- input$fileTriangle
        if (tools::file_ext(inFile$name) == "csv") {
          dat <- read.csv(inFile$datapath,sep =  input$sep, input$quote)
        } else {
          dat <- read_excel(inFile$datapath,col_names = TRUE)
        }
        colnames(dat) = c("Année",0:(nrow(dat)-1))
        annee = dat[["Année"]]
        dat = dat[,-1]
        dat = as.matrix(dat)
        if(input$cumuler ) dat = t(apply(dat,1,cumsum))
        dat = Triangulariser(dat)
        dat = as.data.frame(dat)
        dat[["Année"]] = annee
        dat = dplyr::relocate(dat,"Année")
        dat = as.data.frame(dat)
        rownames(dat) = annee
        dat = dat[,-1]
        colnames(dat) = 0:(nrow(dat)-1)
        as.matrix(dat)
      },
      error = function(e) {
        # return a safeError if a parsing error occurs
        stop(safeError(e))
      }
    )
  }) %>%
    bindEvent(input$tgl_btn)
  observeEvent(input$tgl_btn,
               shinyalert::shinyalert("OK !", "Lecture du triangle confirmée avec succès" ,"success")
               )


  output$trgl_data <- DT::renderDataTable(
    tryCatch(
      {req(input$fileTriangle)
        inFile <- input$fileTriangle
        if (tools::file_ext(inFile$name) == "csv") {
          dat <- read.csv(inFile$datapath,sep =  input$sep, input$quote)
        } else {
          dat <- read_excel(inFile$datapath,col_names = TRUE)
        }
        colnames(dat) = c("Année",0:(nrow(dat)-1))
        annee = dat[["Année"]]
        dat = dat[,-1]
        dat = as.matrix(dat)
        if(input$cumuler ) dat = t(apply(dat,1,cumsum))
        dat = Triangulariser(dat)
        dat = as.data.frame(dat)
        dat[["Année"]] = annee
        dat = dplyr::relocate(dat,"Année")
        dat = as.data.frame(dat)
        rownames(dat) = annee
        dat = dat[,-1]
        colnames(dat) = 0:(nrow(dat)-1)
        dat
      },
      error = function(e) {
        # return a safeError if a parsing error occurs
        stop(safeError(e))
      }
    ),
    extensions = "Buttons",
    options = list(
      searching = FALSE,
      dom = "Bfrtip",
      buttons = c("copy", "csv", "excel", "pdf", "print"),
      paging = FALSE, ## paginate the output
      pageLength = 100,
      scrollX = TRUE,
      scrollY = 500
    )

  )
  # Calcul des règlements cumulés futurs par année de survenance
  c_hat <- reactive(
    {
      fdc = calculer_fdc(triangleAT())
      C_hat(triangleAT(),fdc)
    }
  )
  # Cadence de liquidqtion
  cadence = reactive({
    decumul = decumul_tri(triangleAT(),c_hat())
    CU = apply(decumul,1,sum)
    rglts = apply(decumul,2,sum)
    cad_liq = rglts/sum(CU)
    cad_liq
  })
  # Cash flows
  Cash_flows <- reactive(
    {
      decumul = decumul = decumul_tri(triangleAT(),c_hat())
      r_hat = R_hat(decumul)
      r_hat
    }
  )
  output$trgl_global <- DT::renderDT(
    {
      tglinf = c_hat()
      rownames(tglinf) = rownames(triangleAT())
      colnames(tglinf) = colnames(triangleAT())
      tglinf

    },
    extensions = "Buttons",
    options = list(
      searching = FALSE,
      dom = "Bfrtip",
      buttons = c("copy", "csv", "excel", "pdf", "print"),
      paging = FALSE, ## paginate the output
      pageLength = 100,
      scrollX = TRUE,
      scrollY = 500
    )
  )
  output$cad_plot <- renderPlotly(
    {
      cad_liq = cadence()
      cad_liq = data.frame("Cadence de liquidation" = cadence(),check.names = FALSE)
      cad_liq$`Cadence de liquidation (%)` = paste0(gsub(",","\\.",round(100*cadence(),2)),"%")
      plot_ly(
        data = cad_liq, y= ~`Cadence de liquidation`,
        type = "bar", mode = "markers",
        hovertext = glue("Année de développement : {0:(nrow(cad_liq)-1)}
                         Cadence de liquidation (%) : {cad_liq$`Cadence de liquidation (%)`}") ,
        hoverinfo = 'text'
      ) %>%
        layout(
          title = "Cadence de liquidation",
          xaxis = list(title = "Année de développement",showline= T, linewidth=2, linecolor='black'),
          yaxis = list(title = "")
        )
      }
  )
  output$cad_data <- DT::renderDT(
    {
      cad_liq = cadence()
      cad_liq = data.frame("Cadence de liquidation" = cadence(),check.names = FALSE)
      cad_liq$`Cadence de liquidation (%)` = paste0(gsub(",","\\.",round(100*cadence(),2)),"%")
      cad_liq
    },
    extensions = "Buttons",
    options = list(
      searching = FALSE,
      dom = "Bfrtip",
      buttons = c("copy", "csv", "excel", "pdf", "print"),
      paging = FALSE, ## paginate the output
      pageLength = 100,
      scrollX = TRUE,
      scrollY = 500
    )
  )
  output$cf_plot <- renderPlotly(
    {
      r_hat = data.frame("Flux de règlements futurs nets de recours" = Cash_flows(),check.names = FALSE)
      nn = nrow(triangleAT())

      rownames(r_hat) = as.numeric(rownames(triangleAT())[nn]) + 1:(nn-1)
      r_hat[["Année"]] = rownames(r_hat)
      plot_ly(data = r_hat,
              x =~`Année`,y =~`Flux de règlements futurs nets de recours`,
              type = 'bar'
              ) %>%
        layout(
          title = "Flux de règlements futurs nets de recours",
          legend = list(orientation = "h", xanchor = "center", x = 0.5),
          xaxis = list(title = "",showline= T, linewidth=2, linecolor='black'),
          yaxis = list(title = "",showline= T, linewidth=2, linecolor='black')
        )

    }
  )
  output$cf_data <- DT::renderDT(
    {
      r_hat = data.frame("Flux de règlements futurs nets de recours " = Cash_flows(),check.names = FALSE)
      nn = nrow(triangleAT())

      rownames(r_hat) = as.numeric(rownames(triangleAT())[nn]) + 1:(nn-1)
      r_hat
    },
    extensions = "Buttons",
    options = list(
      searching = FALSE,
      dom = "Bfrtip",
      buttons = c("copy", "csv", "excel", "pdf", "print"),
      paging = FALSE, ## paginate the output
      pageLength = 100,
      scrollX = TRUE,
      scrollY = 500
    )
  )

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
