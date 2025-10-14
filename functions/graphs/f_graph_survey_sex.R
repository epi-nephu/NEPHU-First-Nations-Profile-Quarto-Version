# NEPHU Population Profile - Aboriginal Health
# Author: Alana Little, NEPHU (alana.little@austin.org.au)
# Version 2.0, 15/08/2025
#
# Chart type: bar (grouped)
# Grouping variables: sex
# Data source: National Aboriginal and Torres Strait Islander Health Survey

# Estimated number of people
f_graph_survey_sex_n <- function(data, x_levels, x_labels, x_angle = 0, y_max, y_breaks, y_expand) {
  
  data <- data %>% 
    dplyr::select(sex,
                  ends_with(paste0("_", "n")),
                  -starts_with("answered")) %>% 
    #
    dplyr::filter(sex != "Total") %>% 
    #
    tidyr::pivot_longer(cols      = !sex,
                        names_to  = "comparison",
                        values_to = "n") %>% 
    #
    dplyr::mutate(comparison = factor(comparison,
                                      levels = x_levels)) %>% 
    #
    dplyr::mutate(estimate_text = paste0("\nSex: ", sex,
                                         "\nEstimate: ", format(n, big.mark = ",")))
  
  figure <- data %>%
    ggplot(aes(x = comparison, y = n, group = sex, fill = sex, text = estimate_text)) +
    #
    geom_col(position = "dodge",
             col      = colour_gray) +
    #
    scale_x_discrete(labels = x_labels) +
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
    theme(plot.margin = margin(5, 5, 0, 5),
          axis.text.x = element_text(angle = x_angle))
  
  figure <- figure %>%
    plotly::ggplotly(tooltip = "text") %>% 
    #
    plotly::layout(yaxis = list(title = list(font = list(family = "Arial",
                                                         size   = 13),
                                             standoff = 10)))
  
  return(figure)

}

# Percentage of people
f_graph_survey_sex_prop <- function(data, x_levels, x_labels, x_angle = 0, y_max, y_breaks, y_expand) {
  
  data <- data %>% 
    dplyr::select(sex,
                  ends_with(paste0("_", "prop")),
                  -starts_with("answered")) %>% 
    #
    dplyr::filter(sex != "Total") %>% 
    #
    tidyr::pivot_longer(cols      = !sex,
                        names_to  = "comparison",
                        values_to = "percentage") %>% 
    #
    dplyr::mutate(comparison = factor(comparison,
                                      levels = x_levels)) %>% 
    #
    dplyr::mutate(prop_text = paste0("\nSex: ", sex,
                                     "\nPercentage: ", sprintf("%.1f", percentage)))
  
  figure <- data %>% 
    ggplot(aes(x = comparison, y = percentage, group = sex, fill = sex, text = prop_text)) +
    #
    geom_col(position = "dodge",
             col      = colour_gray) +
    #
    scale_x_discrete(labels = x_labels) +
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
    theme(plot.margin = margin(5, 5, 0, 5),
          axis.text.x = element_text(angle = x_angle))
  
  figure <- figure %>%
    plotly::ggplotly(tooltip = "text") %>% 
    #
    plotly::layout(yaxis = list(title = list(font = list(family = "Arial",
                                                         size   = 13),
                                             standoff = 10)))
  
  return(figure)

}

# Combine into two-panel figure (estimated number and percentage)
f_graph_survey_sex_combine <- function(figure_number, figure_percent) {
  
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

f_graph_survey_sex_combine_xrotate <- function(figure_number, figure_percent) {
  
  figure <- plotly::subplot(figure_number, figure_percent,
                            titleY = TRUE,
                            margin = 0.05) %>% 
    #
    plotly::layout(legend = list(x = 0.5,
                                 y = -0.3,
                                 orientation = "h",
                                 xanchor     = "center"))
  
  figure$x$data[[3]]$showlegend <- FALSE
  figure$x$data[[4]]$showlegend <- FALSE
  
  return(figure)
  
}

