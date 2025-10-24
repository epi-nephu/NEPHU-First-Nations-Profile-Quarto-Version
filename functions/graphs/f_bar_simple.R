# NEPHU Population Profile - Aboriginal Health
# Author: Alana Little, NEPHU (alana.little@austin.org.au)
# Version 2.0, 15/08/2025
#
# Chart type: simple bar chart

################################################################################
# Classic simple bar chart
################################################################################
f_bar_simple <- function(data, x_variable, y_variable, y_max, y_breaks, y_expand, 
                         y_title, x_angle = 90, ctg_target = NA) {
  
  x_variable <- rlang::enquo(x_variable)
  y_variable <- rlang::enquo(y_variable)
  
  ctg_target <- ctg_target
  
  figure <- data %>% 
    ggplot(aes(x = !!x_variable, y = !!y_variable, text = hover_text)) +
    #
    geom_col(col  = colour_black,
             fill = colour_lightblue)
  
  if (!is.na(ctg_target)) {
    
    figure <- figure +
      geom_hline(aes(yintercept = ctg_target, linetype = "CtG target (%)"),
                 col         = colour_gradient_mid,
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
    labs(x = NULL,
         y = NULL) +
    #
    theme_classic() +
    #
    theme(axis.text.x  = element_text(angle = x_angle))
  
  figure <- figure %>% 
    plotly::ggplotly(tooltip = "text") %>%
    #
    plotly::layout(hovermode = "x",
                   #
                   yaxis = list(title = list(text     = y_title,
                                             font     = list(size = 13, family = "Arial"),
                                             standoff = 10)))
  
  return(figure)

}

################################################################################
# Flipped x-axis and y-axis
################################################################################
f_bar_simple_flip <- function(data, x_variable, y_variable, y_max, y_breaks, y_expand, x_title) {
  
  x_variable <- rlang::enquo(x_variable)
  y_variable <- rlang::enquo(y_variable)
  
  figure <- data %>% 
    ggplot(aes(x = !!x_variable, y = !!y_variable, text = hover_text)) +
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
    coord_flip()
  
  figure <- figure %>% 
    plotly::ggplotly(tooltip = "text") %>%
    #
    plotly::layout(hovermode = "y",
                   #
                   xaxis = list(title = list(text     = x_title,
                                             font     = list(size = 13, family = "Arial"),
                                             standoff = 10)))
  
  return(figure)
  
}

################################################################################
# Combine count and percentage charts into two-panel figure
################################################################################
f_bar_simple_combine <- function(figure_number, figure_percent, legend_offset = -0.4) {
  
  figure <- plotly::subplot(figure_number, figure_percent,
                            titleY = TRUE,
                            margin = 0.05) %>% 
    #
    plotly::layout(legend = list(x = 0.775,
                                 y = legend_offset,
                                 #
                                 orientation = "h",
                                 xanchor     = "center"))
  
  return(figure)

}

