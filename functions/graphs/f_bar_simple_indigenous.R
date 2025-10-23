# NEPHU Population Profile - Aboriginal Health
# Author: Alana Little, NEPHU (alana.little@austin.org.au)
# Version 2.0, 15/08/2025
#
# Chart type: simple bar chart
# Grouping variables: Indigenous status

f_bar_simple_indigenous <- function(data, x_variable, x_angle = 0, y_variable, y_max, y_breaks, y_expand, y_title) {
  
  x_variable <- rlang::enquo(x_variable)
  y_variable <- rlang::enquo(y_variable)
  
  figure <- data %>% 
    ggplot(aes(x = !!x_variable, y = !!y_variable, group = indigenous_status, fill = indigenous_status, text = hover_text)) +
    #
    geom_col(position = "dodge",
             col      = colour_gray) +
    #
    scale_y_continuous(limits = c(0, y_max),
                       breaks = scales::breaks_width(y_breaks),
                       expand = expansion(add = c(0, y_expand)),
                       labels = scales::comma_format(big.mark = ",")) +
    #
    scale_fill_manual(values = c(colour_lightblue, colour_burgundy),
                      name   = NULL) +
    #
    labs(x = NULL,
         y = NULL) +
    #
    theme_classic() +
    #
    theme(axis.text.x  = element_text(angle = x_angle),
          axis.title.y = element_text(size = 10, family = "Arial"))
  
  figure <- figure %>% 
    plotly::ggplotly(tooltip = "text") %>%
    #
    plotly::layout(hovermode = "closest",
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

