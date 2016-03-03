navbarPage("Tapir",
  tabPanel('About',
    column(6, offset=3,
      includeMarkdown("./README.md")
    )
  ),
  tabPanel('Import',
    div(class = "col-sm-2 col-sm-offset-1 affix",
      verticalLayout(
        bsCollapse(open = "Active Dataset",
          bsCollapsePanel("Active Dataset",
            p("Choose your Active Dataset")
          ),
          bsCollapsePanel("Upload File",
            column(6,p("Filechooser Here.")),
            column(6,p("format Selector Here."))
          ),
          bsCollapsePanel("Advanced Import Settings",
            p("For text formats, override header reading, set delimiter, quote format, etc.")
          )
        )
      )
    ),
    column(6, offset=3,
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
      dataTableOutput("displayTable")
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
            checkboxInput('showAesWgts', 'Show aesthetics', value=FALSE),
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
            checkboxInput('showFacetWgts', 'Show facets', value=FALSE),
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
            checkboxInput('showXYRangeWgts', 'Show ranges', value=FALSE),
            verticalLayout(
              uiOutput('xlimCtrl'),
              uiOutput('ylimCtrl')
            )
          ),
          bsCollapsePanel("Aggregation",
            checkboxInput('showPlotAggWgt', 'Show plot aggregations', value=FALSE),
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
            checkboxInput('showThemeWgts', 'Show themes', value=FALSE),
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
            numericInput(inputId = "fileHeight", label = "Height (inches)", 
              value = 8.5, min = 0, max = 850
            ),
            numericInput(inputId = "fileWidth", label = "Width (inches)", 
              value = 11, min = 0, max = 1100
            ),
            numericInput(inputId = "fileDPI", label = "Dots Per Inch", 
              value = 300, min = 1, max = 1200
            ),
            selectInput(inputId = "fileType", label = "File Type", 
                        choices = c('PDF'='.pdf',
                                    'PNG'='.png',
                                    'JPG'='.jpg',
                                    'SVG'='.svg')
            ),
            downloadButton('dlPlot', 'Download')
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