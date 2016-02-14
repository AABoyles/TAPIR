
## display plot and data table
observe({
  ## display plot reactively
  output$plot <- renderPlot({
    plotInput()
  }, height=700)
  
  ## display data table reactively
  output$displayTable <- DT::renderDataTable({
    DT::datatable(manAggDataset(), filter='bottom', options=list(searching=TRUE))
  })
})

## disable/enable toggle between facet grid and facet wrap
observeEvent(c(input$facetCol, input$facetRow, input$facetWrap), {
  if (input$showFacetWgts) {
    if (noFacetSelected()) {
      shinyjs::enable('facetCol')
      shinyjs::enable('facetRow')
      shinyjs::enable('facetWrap')
    } else if (facetGridSelected()) {
      shinyjs::enable('facetCol')
      shinyjs::enable('facetRow')
      shinyjs::disable('facetWrap')
    } else if (facetWrapSelected()) {
      shinyjs::disable('facetCol')
      shinyjs::disable('facetRow')
      shinyjs::enable('facetWrap')
    } 
  }
})
