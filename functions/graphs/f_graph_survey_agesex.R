# NEPHU Population Profile - Aboriginal Health
# Author: Alana Little, NEPHU (alana.little@austin.org.au)
# Version 2.0, 15/08/2025
#
# Chart type: bar (grouped)
# Grouping variables: age group and sex
# Data source: National Aboriginal and Torres Strait Islander Health Survey

# Estimated number of people
f_graph_survey_agesex_n <- function(data, y_max, y_breaks, y_expand) {
  
  data <- data %>% 
    dplyr::mutate(estimate_text = paste0("Age group: ", age_group,
                                         "\nSex: ", sex,
                                         "\nEstimate: ", format(estimate, big.mark = ",")))

  figure <- data %>%
    ggplot(aes(x = age_group, y = estimate, group = sex, fill = sex, text = estimate_text)) +
    #
    geom_col(position = "dodge",
             col      = colour_gray) +
    #
    scale_x_discrete(labels = c("Adults", "Children")) +
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
         y = "Estimated number of people") +
    #
    theme_classic() +
    #
    theme(plot.margin = margin(5, 5, 0, 5))
  
  figure <- figure %>%
    plotly::ggplotly(tooltip = "text") %>% 
    #
    plotly::layout(yaxis = list(title = list(font = list(family = "Arial",
                                                         size   = 13),
                                             standoff = 10)))

  return(figure)

}

# Percentage of people
f_graph_survey_agesex_prop <- function(data, y_max, y_breaks, y_expand) {
  
  data <- data %>% 
    dplyr::mutate(prop_text = paste0("Age group: ", age_group,
                                     "\nSex: ", sex,
                                     "\nPercentage: ", sprintf("%.1f", proportion)))
  
  figure <- data %>%
    ggplot(aes(x = age_group, y = proportion, group = sex, fill = sex, text = prop_text)) +
    #
    geom_col(position = "dodge",
             col      = colour_gray) +
    #
    scale_x_discrete(labels = c("Adults", "Children")) +
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
         y = "Percentage of survey respondents") +
    #
    theme_classic() +
    #
    theme(plot.margin = margin(5, 5, 0, 5))
  
  figure <- figure %>%
    plotly::ggplotly(tooltip = "text") %>% 
    #
    plotly::layout(yaxis = list(title = list(font = list(family = "Arial",
                                                         size   = 13),
                                             standoff = 10)))
  
  return(figure)
  
}

# Combine into two-panel figure (estimated number and percentage)
f_graph_survey_agesex_combine <- function(figure_number, figure_percent) {
  
  figure <- plotly::subplot(figure_number, figure_percent,
                            titleY = TRUE,
                            margin = 0.05) %>% 
    #
    plotly::layout(legend = list(x = 0.5,
                                 orientation = "h",
                                 xanchor     = "center"))
  
  figure$x$data[[3]]$showlegend <- FALSE
  figure$x$data[[4]]$showlegend <- FALSE
  
  return(figure)
  
}

