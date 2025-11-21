# NEPHU Population Profile - Aboriginal Health
# Author: Alana Little, NEPHU (alana.little@austin.org.au)
# Version 2.0, 15/08/2025
#
# Chart type: grouped bar chart

################################################################################
# Classic grouped bar chart
################################################################################
f_bar_grouped <- function(data, x_variable, y_variable, fill_variable, fill_values,
                          y_max, y_breaks, y_expand, y_title, x_angle = 90, legend_offset = -0.3) {
  
  x_variable    <- rlang::enquo(x_variable)
  y_variable    <- rlang::enquo(y_variable)
  fill_variable <- rlang::enquo(fill_variable)
  
  figure <- data %>% 
    ggplot(aes(x = !!x_variable, y = !!y_variable, group = !!fill_variable, fill = !!fill_variable, text = hover_text)) +
    #
    geom_col(position = "dodge",
             col      = colour_gray) +
    #
    scale_y_continuous(limits = c(0, y_max),
                       breaks = scales::breaks_width(y_breaks),
                       expand = expansion(add = c(0, y_expand)),
                       labels = scales::comma_format(big.mark = ",")) +
    #
    scale_fill_manual(values = fill_values,
                      guide  = "none") +
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
                                             standoff = 10)),
                   legend = list(x = 0.5,
                                 y = legend_offset,
                                 #
                                 orientation = "h",
                                 xanchor     = "center"))
  
  return(figure)
  
}

################################################################################
# By age and sex
################################################################################
f_bar_grouped_agesex <- function(data, y_variable, y_max, y_breaks, y_expand, y_title) {
  
  y_variable <- rlang::enquo(y_variable)
  
  data <- data %>% 
    dplyr::filter(age_group %in% age_group_lvl)
  
  if (rlang::as_name(y_variable) == "aboriginal_n") {
    
    y_title <- "Number of people"
    
    data <- data %>% 
      dplyr::mutate(hover_text = paste0(sex, "\n",
                                        age_group, "\n",
                                        "Count: ", format(!!y_variable, big.mark = ",")))
    
  }
  
  if (rlang::as_name(y_variable) == "aboriginal_prop") {
    
    y_title <- "Percentage of people"
    
    data <- data %>% 
      dplyr::mutate(hover_text = paste0(sex, "\n",
                                        age_group, "\n",
                                        "Percentage: ", sprintf("%.1f", !!y_variable)))
    
  }

  figure <- data %>% 
    ggplot(aes(x = age_group, y = !!y_variable, group = sex, fill = sex, text = hover_text)) +
    #
    geom_col(position = "dodge",
             col      = colour_gray) +
    #
    scale_y_continuous(limits = c(0, y_max),
                       breaks = scales::breaks_width(y_breaks),
                       expand = expansion(add = c(0, y_expand)),
                       labels = scales::comma_format(big.mark = ",")) +
    #
    scale_fill_manual(values = c(colour_female, colour_male),
                      guide  = "none") +
    #
    labs(x = NULL,
         y = NULL) +
    #
    theme_classic() +
    #
    theme(axis.text.x  = element_text(angle = 90))
  
  figure <- figure %>% 
    plotly::ggplotly(tooltip = "text") %>%
    #
    plotly::layout(hovermode = "x",
                   #
                   yaxis = list(title = list(text     = y_title,
                                             font     = list(size = 13, family = "Arial"),
                                             standoff = 10)),
                   legend = list(x = 0.5,
                                 y = -0.3,
                                 #
                                 orientation = "h",
                                 xanchor     = "center"))
  
  return(figure)
  
}

################################################################################
# By sex
################################################################################
f_bar_grouped_sex <- function(data, x_variable, y_variable, y_max, y_breaks, y_expand, y_title, x_angle = 0, legend_offset = -0.1) {
  
  x_variable <- rlang::enquo(x_variable)
  y_variable <- rlang::enquo(y_variable)
  
  if (rlang::as_name(y_variable) == "n") {
    
    y_title <- "Estimated number of people"
    
    data <- data %>% 
      dplyr::mutate(hover_text = paste0(sex, "\n",
                                        answer, "\n",
                                        "Estimate: ", format(!!y_variable, big.mark = ",")))
    
  }
  
  if (rlang::as_name(y_variable) == "prop") {
    
    y_title <- "Percentage of survey respondents"
    
    data <- data %>% 
      dplyr::mutate(hover_text = paste0(sex, "\n",
                                        answer, "\n",
                                        "Percentage: ", sprintf("%.1f", !!y_variable)))
    
  }
  
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
    scale_fill_manual(values = c(colour_female, colour_male),
                      guide  = "none") +
    #
    labs(x = NULL,
         y = NULL) +
    #
    theme_classic() +
    #
    theme(axis.text.x = element_text(angle = x_angle))
  
  figure <- figure %>% 
    plotly::ggplotly(tooltip = "text") %>%
    #
    plotly::layout(hovermode = "x",
                   #
                   yaxis = list(title = list(text     = y_title,
                                             font     = list(size = 13, family = "Arial"),
                                             standoff = 10)),
                   legend = list(x = 0.5,
                                 y = legend_offset,
                                 #
                                 orientation = "h",
                                 xanchor     = "center"))
  
  return(figure)
  
}

################################################################################
# By Indigenous status
################################################################################
f_bar_grouped_indigenous <- function(data, x_variable, y_variable, y_max, y_breaks, y_expand, y_title, x_angle = 90, legend_offset = -0.3) {
  
  x_variable <- rlang::enquo(x_variable)
  y_variable <- rlang::enquo(y_variable)
  
  if (rlang::as_name(y_variable) == "n") {
    
    data <- data %>% 
      dplyr::mutate(hover_text = paste0(!!x_variable, "\n",
                                        indigenous_label, "\n",
                                        "Count: ", format(!!y_variable, big.mark = ",")))
    
  }
  
  if (rlang::as_name(y_variable) == "estimate") {
    
    data <- data %>% 
      dplyr::mutate(hover_text = paste0(!!x_variable, "\n",
                                        indigenous_label, "\n",
                                        "Count: ", format(!!y_variable, big.mark = ",")))
    
  }
  
  if (rlang::as_name(y_variable) == "prop") {
    
    data <- data %>% 
      dplyr::mutate(hover_text = paste0(!!x_variable, "\n",
                                        indigenous_label, "\n",
                                        "Percentage: ", sprintf("%.1f", !!y_variable)))
    
  }
  
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
    scale_fill_manual(values = c(colour_aboriginal, colour_nonaboriginal),
                      guide  = "none") +
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
                                             standoff = 10)),
                   legend = list(x = 0.5,
                                 y = legend_offset,
                                 #
                                 orientation = "h",
                                 xanchor     = "center"))
  
  return(figure)
  
}

################################################################################
# Combine count and percentage charts into two-panel figure
################################################################################
f_bar_grouped_combine <- function(figure_number, figure_percent, legend_offset = -0.3) {
  
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

