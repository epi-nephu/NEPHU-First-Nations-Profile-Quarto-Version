# NEPHU Population Profile - Aboriginal Health
# Author: Alana Little, NEPHU (alana.little@austin.org.au)
# Version 2.0, 15/08/2025
#
# Chart type: grouped line chart

################################################################################
# Grouped line chart
################################################################################
f_line_grouped <- function(data, y_variable, fill_variable, fill_values, 
                           y_max, y_breaks, y_expand, y_title, ctg_target = NA) {

  y_variable    <- rlang::enquo(y_variable)
  fill_variable <- rlang::enquo(fill_variable)
  
  ctg_target <- ctg_target
  
  figure <- data %>% 
    ggplot(aes(x = year, y = !!y_variable, group = !!fill_variable, col = !!fill_variable, text = hover_text)) +
    #
    geom_line(linewidth = 1.5)
  
  # Add the CtG target line if relevant
  if (!is.na(ctg_target)) {
    figure <- figure +
      geom_hline(aes(yintercept = ctg_target, linetype = "CtG target (%)"),
                 col         = colour_ctgtarget,
                 linewidth   = 0.5,
                 show.legend = TRUE) +
      #
      scale_linetype_manual(name = NULL,
                            values = c("CtG target (%)" = "dashed"))
    
  }
  
  figure <- figure +
    scale_y_continuous(limits = c(0, y_max),
                       breaks = scales::breaks_width(y_breaks),
                       expand = expansion(add = c(0, y_expand)),
                       labels = scales::comma_format(big.mark = ",")) +
    #
    scale_color_manual(values = fill_values,
                       name   = NULL) +
    #
    labs(x = NULL,
         y = NULL) +
    #
    theme_classic()
  
  figure <- figure %>% 
    plotly::ggplotly(tooltip = "text")
  
  # Finicky wrangling to get combined legend to display properly when CtG line present
  legend_labels <- levels(factor(data$indigenous_status))
  
  line_traces <- which(vapply(figure$x$data, function(tr) tr$type == "scatter" && tr$mode == "lines", logical(1)))
  
  for (i in seq_along(line_traces)) {
    
    if (i <= length(legend_labels)) {
      
      figure$x$data[[line_traces[i]]]$name <- legend_labels[i]
      
    }
  }
  
  for (i in seq_along(figure$x$data)) {
    
    if (!is.null(figure$x$data[[i]]$name) &&
        grepl("CtG", figure$x$data[[i]]$name, ignore.case = TRUE)) {
      
      figure$x$data[[i]]$name <- "CtG target (%)"
      
    }
  }

  figure <- figure %>% 
    plotly::layout(hovermode = "x",
                   #
                   yaxis = list(title = list(text     = y_title,
                                             font     = list(size = 13, family = "Arial"),
                                             standoff = 10)),
                   #
                   legend = list(x = 0.5,
                                 #
                                 orientation = "h",
                                 xanchor     = "center"))
  
  return(figure)

}

