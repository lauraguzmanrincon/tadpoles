
setwd("/home/laura/Documents/PostPhD/JUNIPER/local_data_interventions/Data_local_scale/Tadpoles/")

library(data.table)
library(ggplot2)
source("tadpoleFn.R")

load("DataForTadpole.RData")
tadpoleFn(dataSource = dataExample, dayToPlot = 14, sizePole = 14, dotFill = "IMD")
