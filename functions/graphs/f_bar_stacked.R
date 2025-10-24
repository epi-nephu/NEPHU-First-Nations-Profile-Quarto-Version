# NEPHU Population Profile - Aboriginal Health
# Author: Alana Little, NEPHU (alana.little@austin.org.au)
# Version 2.0, 15/08/2025
#
# Chart type: stacked bar chart

f_bar_stacked <- function(data, x_variable, y_variable, fill_variable, fill_values,
                          y_max, y_breaks, y_expand, y_title, legend_offset = -0.1, x_angle = 0, facet_wrap = "no") {
  
  x_variable    <- rlang::enquo(x_variable)
  y_variable    <- rlang::enquo(y_variable)
  fill_variable <- rlang::enquo(fill_variable)
  
  figure <- data %>% 
    ggplot(aes(x = !!x_variable, y = !!y_variable, fill = !!fill_variable, text = hover_text)) +
    #
    geom_col(col = colour_gray) +
    #
    scale_y_continuous(limits = c(0, y_max),
                       breaks = scales::breaks_width(y_breaks),
                       expand = expansion(add = c(0, y_expand)),
                       labels = scales::comma_format(big.mark = ",")) +
    #
    scale_fill_manual(values = fill_values,
                      name   = NULL) +
    #
    labs(x = NULL,
         y = NULL) +
    #
    theme_classic() +
    #
    theme(axis.text.x  = element_text(angle = x_angle))
  
  if (facet_wrap == "yes") {
      
      figure <- figure +
        facet_wrap(.~ sex,
                   scale          = "free_x",
                   strip.position = "bottom")

  }
  
  figure <- figure %>% 
    plotly::ggplotly(tooltip = "text") %>%
    #
    plotly::layout(hovermode = "x",
                   #
                   yaxis = list(title = list(text     = y_title,
                                             font     = list(size = 13, family = "Arial"),
                                             standoff = 10)),
                   #
                   legend = list(x = 0.5,
                                 y = legend_offset,
                                 #
                                 orientation = "h",
                                 traceorder  = "reversed",
                                 xanchor     = "center"))

  return(figure)

}

