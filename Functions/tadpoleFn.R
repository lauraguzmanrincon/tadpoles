
#' Tadpole function
#' dataSource: dataset with data to plot
#' dayToPlot: most visible day in the tadpole
#' sizePole: length of tail per point
tadpoleFn <- function(dataSource, dayToPlot, sizePole, dotFill = "IMD"){
  dataToPlot <- dataSource[dayToPlot - sizePole + 1 <= dayId & dayId <= dayToPlot]
  
  # Create fill scale
  dotFill <- "IMD"
  if(dotFill == "IMD"){
    dataToPlot[, labels := labelsIMD]
    scaleFill <- scale_fill_manual(name = "average\nIMD rank*\nof positives\n(thousands)", values = c("#0864A7", "#2690CC", "#7DCBD8", "#E3F5D8", "#FBFCB9"), drop = F)
    tagText <- "* 0: more deprived\n32844: less deprived"
  }
  
  # Create ggplot object
  ggM4.a <- ggplot(dataToPlot[order(dayId)], aes(x = medianGR, y = medianProportion)) + theme_set(theme_grey(base_size = 16)) +
    theme(panel.grid.major = element_blank(),
          panel.grid.minor = element_blank(),
          panel.background = element_blank(),
          panel.border = element_rect(colour = "gray", fill = NA))
  ggM4.b <- ggM4.a +
    geom_segment(data = dataToPlot[dayId == dayToPlot], aes(y = q0.025Proportion, yend = q0.975Proportion, xend = medianGR), colour = "gray90", size = 0.1) +
    geom_segment(data = dataToPlot[dayId == dayToPlot], aes(x = q0.025GR, xend = q0.975GR, yend = medianProportion), colour = "gray90", size = 0.1) +
    labs(x = "growth rate", y = "(estimated) proportion Pillar 2 testing positive (%)", title = paste0("Proportion Pillar 2 testing positive (estimated mean) vs. Growth Rate"),
         subtitle = paste("On", format(as.Date("2020-01-01"), "%a. %d %b %Y"), "and the 14 previous days"), colour = "") +
    coord_cartesian(xlim = range(dataToPlot$medianGR), ylim = c(0, max((dataToPlot$medianProportion))))
  
  ggbld <- ggplot_build(ggM4.a)
  sec_breaks <- ggbld$layout$panel_params[[1]][["x"]]$breaks
  ggM4 <- ggM4.b +
    geom_vline(xintercept = 0, colour = "gray50", linetype = 2) +
    geom_path(aes(group = areaName, colour = dayId)) +
    geom_point(aes(colour = dayId), pch = 20, size = 2) +
    geom_point(data = dataToPlot[dayId == dayToPlot], aes(fill = labels), pch = 22, size = 4, colour = "gray50") +
    scaleFill +
    geom_text_repel(data = dataToPlot[dayId == dayToPlot & labelInBoth_abbr == T], aes(label = areaName), min.segment.length = 0, size = 3) + # areaName / abbr*
    scale_color_gradient(guide = F, low = "gray90", high = "gray30") +
    geom_hline(yintercept = 0, colour = "gray50", linetype = 2) +
    scale_x_continuous(sec.axis = sec_axis(name = "doubling time (days)", trans = (~.),
                                           breaks = sec_breaks,
                                           labels = sprintf("%.1f", abs(log(2)/sec_breaks))), breaks = sec_breaks) + # NEW 18.05.2021
    coord_cartesian(xlim = ggbld$layout$panel_params[[1]][["x"]]$limits, ylim = ggbld$layout$panel_params[[1]][["y"]]$limits) +
    theme(legend.key = element_blank(), legend.position = "right", title = element_text(size = 14))
  return(ggM4)
}