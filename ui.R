navbarPage("Tapir",
  tabPanel('Import',
    column(4, offset = 4,
      shinyjs::useShinyjs(),
      tags$head(
       tags$script(
         'Shiny.addCustomMessageHandler("myCallbackHandler", function(typeMessage) {if(typeMessage == 1){$("a:contains(Plot)").click();}});'
       ),
       tags$link(
         rel = "stylesheet", type = "text/css", href="style.css"
       )
      ),
      source('./views/import/dataImportCtrlsUI.R', local = TRUE)$value,
      uiOutput('datasetCtrl')
    ),
    value = 'importTab'),
  tabPanel("Table",
    div(class = "col-sm-2 col-sm-offset-1 affix",
      verticalLayout(
        bsCollapse(open = "Column Selection",
          bsCollapsePanel("Column Selection",
            uiOutput('columnPicker')
          ),
          bsCollapsePanel("Aggregation",
            uiOutput('aggByCtrl'),
            uiOutput('aggTargetCtrl'),
            uiOutput('aggMethCtrl'),
            uiOutput('shareOfCtrl'),
            uiOutput('shareTargetCtrl')
          ),
          bsCollapsePanel("Export",
            uiOutput('dlBtnCSV')
          )
        )
      )
    ),
    column(8, offset = 3,
      DT::dataTableOutput("displayTable")
    ),
    value = 'tableTab'
  ),
  tabPanel("Plot",
    column(2, offset = 1,
      verticalLayout(
        bsCollapse(open = "Basics",
          bsCollapsePanel("Basics",
            selectInput(inputId = "plotType", label = "Plot Type", 
              choices = c(
                'Scatter'='scatter',
                'Line'='line',
                'Bar'='bar',
                'Histogram'='histogram', 
                'Density'='density',
                'Box'='box',
                'Path'='path',
                'Violin'='violin' 
                #'Image'='image', 
                #'2-Density', 'density2d'
              )
            ),
            fluidRow(
              column(6, uiOutput('xCtrl')),
              column(6, uiOutput('yCtrl'))
            )
          ),
          bsCollapsePanel("Aesthetics",
            uiOutput('showAesWgtsCtrl'),
            verticalLayout(
              fluidRow(
                column(6, uiOutput('colCtrl')),
                column(6, uiOutput('treatAsFacVarColCtrl'))
              ),
              
              fluidRow(
                column(6, uiOutput('fillCtrl')),
                column(6, uiOutput('posCtrl'))
              ),
              
              uiOutput('ptsOverlayCondCtrl'),
              
              fluidRow(
                column(6, uiOutput('sizeCtrl')),
                column(6, uiOutput('shapeCtrl'))
              ),
              
              fluidRow(
                column(6, uiOutput('smthCtrl'))
              ),

              uiOutput('alphaCtrl'),
              uiOutput('sizeMagCtrl'),
              uiOutput('binWidthCtrl'),
              
              uiOutput('jitCtrl'),
              uiOutput('coordFlipCtrl'),
              uiOutput('densBlkLineCondCtrl')
            )
          ),
          bsCollapsePanel("Faceting",
            uiOutput('showFacetWgtsCtrl'),
            verticalLayout(
              fluidRow(
                column(6, uiOutput('facetRowCtrl')),
                column(6, uiOutput('facetColCtrl'))
              ),
              
              fluidRow(
                column(6, uiOutput('facetWrapCtrl')),
                column(6, uiOutput('facetScaleCtrl'))
              )  
            )
          ),
          bsCollapsePanel("Range",
            uiOutput('showXYRangeWgtsCtrl'),
            verticalLayout(
              uiOutput('xlimCtrl'),
              uiOutput('ylimCtrl')
            )
          ),
          bsCollapsePanel("Aggregation",
            uiOutput('showDSTypeAndPlotAggWgtsCtrl'),
            verticalLayout(
              fluidRow(
                column(6, uiOutput('rawVsManAggCtrl')),
                column(6, uiOutput('plotAggMethCtrl'))
              ),
              uiOutput('plotAddAggByCtrl')
              ## widgets to show/hide advanced control widgets
              #uiOutput('showPlotAggWgtCtrl')
            )
          ),
          bsCollapsePanel("Theme",
            uiOutput('showThemeWgtsCtrl'),
            verticalLayout(
              uiOutput('plotTitleCtrl'),
              fluidRow(
                column(6, uiOutput('xLabelCtrl')),
                column(6, uiOutput('yLabelCtrl'))
              ),
              fluidRow(
                column(6, uiOutput('labelFontFamilyCtrl')),
                column(6, uiOutput('labelFontFaceCtrl'))
              ),
              fluidRow(
                column(6, uiOutput('labelFontSizeCtrl')),
                column(6, uiOutput('labelFontColorCtrl'))
              ), 
              fluidRow(
                column(6, uiOutput('hjustCtrl')), 
                column(6, uiOutput('vjustCtrl'))
              ),
              uiOutput('plotThemeCtrl')
            )
          ),
          bsCollapsePanel("Export",
            uiOutput('fileHeightCtl'),
            uiOutput('fileWidthCtl'),
            uiOutput('fileDPICtl'),
            uiOutput('fileTypeCtl'),
            uiOutput('dlBtnPlot')
          )
        )
      )
    ),
    column(8,
      plotOutput("plot", brush = brushOpts(id = "zoom_brush", resetOnNew = TRUE))
    ),
    value = 'plotTab'
  ),
  id = "conditionedPanels"
)