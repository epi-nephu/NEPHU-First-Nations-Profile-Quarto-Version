# NEPHU Population Profile - Aboriginal Health
# Author: Alana Little, NEPHU (alana.little@austin.org.au)
# Version 2.0, 15/08/2025
#
# Chart type: simple bar chart
# Grouping variables: sex

f_bar_simple_sex <- function(data, x_variable, x_angle = 90, y_variable, y_max, y_breaks, y_expand, y_title) {
  
  x_variable <- rlang::enquo(x_variable)
  y_variable <- rlang::enquo(y_variable)
  
  figure <- data %>% 
    ggplot(aes(x = !!x_variable, y = !!y_variable, group = sex, fill = sex, text = hover_text)) +
    #
    geom_col(position = "dodge",
             col      = colour_gray) +
    #
    scale_y_continuous(limits = c(0, y_max),
                       breaks = scales::breaks_width(y_breaks),
                       expand = expansion(add = c(0, y_expand)),
                       labels = scales::comma_format(big.mark = ",")) +
    #
    scale_fill_manual(values = c(colour_lightblue, colour_dodgerblue),
                      guide  = "none") +
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
                                             standoff = 10)))
  
  return(figure)

}

# Combine count and percentage charts into two-panel figure
f_bar_simple_sex_combine <- function(figure_number, figure_percent, legend_offset = -0.3) {
  
  figure <- plotly::subplot(figure_number, figure_percent,
                            titleY = TRUE,
                            margin = 0.05) %>% 
    #
    plotly::layout(legend = list(x = 0.5,
                                 y = legend_offset,
                                 #
                                 orientation = "h",
                                 xanchor     = "center"))
  
  figure$x$data[[3]]$showlegend <- FALSE
  figure$x$data[[4]]$showlegend <- FALSE
  
  return(figure)
  
}

