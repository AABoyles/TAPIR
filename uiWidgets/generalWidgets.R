## dataset drop-down options 
output$datasetCtrl <- renderUI({
  selectInput("dataset", "Or choose a sample dataset", 
              choices = rawDatasetNames())
})
