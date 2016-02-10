## import libraries
library(shiny)
library(ggplot2)
library(dplyr)
library(DT)
library(stringr)
library(shinyjs)
library(ggthemes)
library(jsonlite)
library(futile.logger)

## set debug logs
source('./debug/debug.R')

## import functions
source('./functions/helper.R')
source('./functions/plot.R')
source('./functions/aggregate.R')

## import global constants
source('./global_constants.R')

## file size options
# by default, the file size limit is 5MB. It can be changed by
# setting this option. Here we'll raise limit to 10GB.
# Note that this does not override other settings that could limit upload sizes.
# For example, if this is deployed behind an nginx server, the server cap must also
# be raised in order to allow larger file uploads.
options(shiny.maxRequestSize = 10*1024^3)

shinyServer(function(input, output, session) {
  ## reactive variables
  source('./reactives/reactives.R',              local=TRUE)  # general/miscellaneous
  source('./reactives/dataset.R',                local=TRUE)  # dataset variables
  source('./reactives/plotWidgetVals.R',         local=TRUE)  # plot widget values
  source('./reactives/plotWidgetNames.R',        local=TRUE)  # plot widget names
  source('./reactives/plotWidgetOpts.R',         local=TRUE)  # plot widget options
  source('./reactives/plotWidgetsDisplayCond.R', local=TRUE)  # plot widgets display condition
  source('./reactives/plotWidgetsLoadedCond.R',  local=TRUE)  # plot widgets load conditions
  source('./reactives/plotWidgetSelectedVals.R', local=TRUE)  # plot widget selected values
  source('./reactives/plot.R',                   local=TRUE)  # plot
  
  ## UI controls
  source('./uiWidgets/generalWidgets.R', local=TRUE)
  source('./uiWidgets/fileWidgets.R',    local=TRUE)
  source('./uiWidgets/manAggWidgets.R',  local=TRUE)
  source('./uiWidgets/plotWidgets.R',    local=TRUE)
  
  ## download handlers
  source('./reactives/download.R', local=TRUE)
  
  ## observed events
  source('./observeEvents.R', local=TRUE)
})
