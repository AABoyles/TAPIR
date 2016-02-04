verticalLayout(
  bsCollapse(
    bsCollapsePanel("Aggregation",
      uiOutput('aggByCtrl'),
      uiOutput('aggTargetCtrl'),
      uiOutput('aggMethCtrl'),
      uiOutput('shareOfCtrl'),
      uiOutput('shareTargetCtrl')
    ),
    bsCollapsePanel("Export", uiOutput('dlBtnCSV'))
  )
)
