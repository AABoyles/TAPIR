navbarPage("Traptir",
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
    column(2, offset = 1,
      source('./views/table/manAggCtrlsUI.R', local = TRUE)$value
    ),
    column(8,
      DT::dataTableOutput("displayTable")
    ),
    value = 'tableTab'
  ),
  tabPanel("Plot",
    column(2, offset = 1,
      source('./views/plot/plotCtrlsUI.R', local = TRUE)$value,
      source('./views/modals/modalPanels.R',local = TRUE)$value
    ),
    column(8,
      plotOutput("plot", brush = brushOpts(id = "zoom_brush", resetOnNew = TRUE))
    ),
    value = 'plotTab'
  ),
  id = "conditionedPanels"
)