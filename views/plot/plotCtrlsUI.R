## plot options
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
      source('./views/plot/aesCtrlsUI.R'             )$value
    ),
    bsCollapsePanel("Faceting",
      uiOutput('showFacetWgtsCtrl'),
      source('./views/plot/facetCtrlsUI.R'           )$value
    ),
    bsCollapsePanel("Range",
      uiOutput('showXYRangeWgtsCtrl'),
      source('./views/plot/xyRangeCtrlsUI.R'         )$value
    ),
    bsCollapsePanel("Aggregation",
      uiOutput('showDSTypeAndPlotAggWgtsCtrl'),
      source('./views/plot/DSTypeAndPlotAggCtrlsUI.R')$value
    ),
    bsCollapsePanel("Theme",
      uiOutput('showThemeWgtsCtrl'),
      source('./views/plot/labelAndStyleCtrlsUI.R'   )$value
    ),
    bsCollapsePanel("Export",
      uiOutput('exportPlotCtl')
    )
  )
  
  ## widgets to show/hide advanced control widgets
  #uiOutput('showPlotAggWgtCtrl')
  
)