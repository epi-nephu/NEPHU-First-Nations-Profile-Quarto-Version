# NEPHU Population Profile - Aboriginal Health
# Author: Alana Little, NEPHU (alana.little@austin.org.au)
# Version 2.0, 15/08/2025
#
# Chart type: simple line chart
# Grouping variables: Indigenous status

f_line_simple_indigenous <- function(data, y_variable, y_max, y_breaks, y_expand, y_title, ctg_target = NA) {
  
  y_variable <- rlang::enquo(y_variable)
  
  ctg_target <- ctg_target
  
  figure <- data %>% 
    ggplot(aes(x = year, y = !!y_variable, group = indigenous_status, col = indigenous_status, text = hover_text)) +
    #
    geom_line(linewidth = 1.5)
  
  if (!is.na(ctg_target)) {
    figure <- figure +
      geom_hline(aes(yintercept = ctg_target),
                 col       = colour_gradient_mid,
                 linetype  = "dashed",
                 linewidth = 0.5)
    
  }
  
  figure <- figure +
    scale_y_continuous(limits = c(0, y_max),
                       breaks = scales::breaks_width(y_breaks),
                       expand = expansion(add = c(0, y_expand)),
                       labels = scales::comma_format(big.mark = ",")) +
    #
    scale_color_manual(values = c(colour_lightblue, colour_burgundy),
                       name   = NULL) +
    #
    labs(x = NULL,
         y = NULL) +
    #
    theme_classic() +
    #
    theme(axis.title.y = element_text(size = 10, family = "Arial"))
  
  figure <- figure %>% 
    plotly::ggplotly(tooltip = "text") %>%
    #
    plotly::layout(hovermode = "x",
                   #
                   yaxis = list(title = list(text     = y_title,
                                             standoff = 10)),
                   #
                   legend = list(x = 0.5,
                                 #
                                 orientation = "h",
                                 xanchor     = "center"))
  
  return(figure)

}

