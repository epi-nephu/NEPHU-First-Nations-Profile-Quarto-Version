# NEPHU Population Profile - Aboriginal Health
# Author: Alana Little, NEPHU (alana.little@austin.org.au)
# Version 2.0, 15/08/2025
#
# Chart type: simple bar chart for population data

f_graph_bar_population <- function(data, x_variable, x_angle = 0, y_max, y_breaks, y_expand) {
  
  x_variable <- rlang::enquo(x_variable)

  figure <- data %>% 
    ggplot(aes(x = forcats::fct_reorder(!!x_variable, desc(aboriginal_n)), y = aboriginal_n, text = hover_text)) +
    #
    geom_col(col  = colour_black,
             fill = colour_lightblue) +
    #
    scale_y_continuous(limits = c(0, y_max),
                       breaks = scales::breaks_width(y_breaks),
                       expand = expansion(add = c(0, y_expand)),
                       labels = scales::comma_format(big.mark = ",")) +
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
    plotly::layout(yaxis = list(title = list(text     = "Number of people",
                                             standoff = 10)))
  
  return(figure)

}

