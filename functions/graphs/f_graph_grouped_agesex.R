# NEPHU Population Profile - Aboriginal Health
# Author: Alana Little, NEPHU (alana.little@austin.org.au)
# Version 2.0, 15/08/2025
#
# Chart type: bar (stacked)
# Grouping variables: varies depending on indicator (comparison)
# Data source: ABS Census 2021

f_graph_grouped_agesex <- function(data, factor_levels, factor_labels, factor_colours, 
                                   y_breaks, y_expand, y_title = "Number of people") {
  
  data <- data %>% 
    tidyr::pivot_longer(cols      = ends_with("_n"),
                        names_to  = "comparison",
                        values_to = "aboriginal_n") %>%
    #
    dplyr::mutate(comparison = factor(comparison,
                                      levels = factor_levels,
                                      labels = factor_labels),
                  #
                  n_text = paste0("Age group: ", age_group,
                                  "\nType: ", comparison,
                                  "\nCount: ", format(aboriginal_n, big.mark = ",")))

  figure <- data %>% 
    ggplot(aes(x = age_group, y = aboriginal_n, fill = comparison, text = n_text)) +
    #
    geom_col(col = colour_gray) +
    #
    scale_y_continuous(breaks = scales::breaks_width(y_breaks),
                       expand = expansion(add = c(0, y_expand)),
                       labels = scales::comma_format(big.mark = ",")) +
    #
    scale_fill_manual(values = factor_colours,
                      name   = NULL) +
    #
    labs(x = NULL,
         y = NULL) +
    #
    theme_classic() +
    #
    theme(axis.text.x = element_text(angle = 90),
          plot.margin = margin(5, 5, 0, 5)) +
    #
    facet_wrap(~sex)
  
  figure <- figure %>% 
    plotly::ggplotly(tooltip = "text") %>% 
    #
    plotly::layout(yaxis = list(title = list(text = y_title,
                                             font = list(family = "Arial",
                                                         size   = 13),
                                             #
                                             standoff = 10)),
                   #
                   legend = list(x = 0.5,
                                 y = -0.25,
                                 #
                                 orientation = "h",
                                 xanchor     = "center"),
                   #
                   subplot_titles = NULL)

  return(figure)

}

