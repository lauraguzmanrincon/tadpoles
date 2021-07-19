
library(data.table)
library(ggplot2)
source("Functions/tadpoleFn.R")

load("Data/DataForTadpole.RData")
tadpoleFn(dataSource = dataExample, dayToPlot = 14, sizePole = 14, dotFill = "IMD")

