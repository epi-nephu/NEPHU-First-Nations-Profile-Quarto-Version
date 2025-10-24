# NEPHU Population Profile - Aboriginal Health
# Author: Alana Little, NEPHU (alana.little@austin.org.au)
# Version 2.0, 15/08/2025
#
# Chart type: simple line chart

################################################################################
# Classic simple line chart
################################################################################
f_line_simple <- function(data, y_variable, y_max, y_breaks, y_expand, y_title, ctg_target = NA) {
  
  y_variable <- rlang::enquo(y_variable)
  
  ctg_target <- ctg_target
  
  figure <- data %>% 
    ggplot(aes(x = year, y = !!y_variable, group = 1, text = hover_text)) +
    #
    geom_line(col       = colour_lightblue,
              linewidth = 1.5)
  
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
    theme(axis.title.y = element_text(size = 10, family = "Arial"))
  
  figure <- figure %>%
    plotly::ggplotly(tooltip = "text") %>%
    #
    plotly::layout(hovermode = "x",
                   #
                   yaxis = list(title = list(text     = y_title,
                                             standoff = 10)))
  
  return(figure)

}

################################################################################
# Combine count and percentage charts into two-panel figure
################################################################################
f_line_simple_combine <- function(figure_number, figure_percent) {
  
  figure <- plotly::subplot(figure_number, figure_percent,
                            titleY = TRUE,
                            margin = 0.05) %>% 
    #
    plotly::layout(legend = list(x = 0.775,
                                 #
                                 orientation = "h",
                                 xanchor     = "center"))
  
  return(figure)
  
}
