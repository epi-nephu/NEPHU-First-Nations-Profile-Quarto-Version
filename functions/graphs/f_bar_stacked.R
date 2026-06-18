# NEPHU Population Profile - Aboriginal Health
# Author: Alana Little, NEPHU (alana.little@austin.org.au)
# Version 2.0, 15/08/2025
#
# Chart type: stacked bar chart

################################################################################
# Classic stacked bar chart
################################################################################
f_bar_stacked <- function(data, total_data = stacked_total, x_variable, y_variable, fill_variable, fill_values, n_level, legend_offset = -0.1, x_angle = 0, facet_wrap = "no", legend_order = "normal") {
  
  x_variable    <- rlang::enquo(x_variable)
  y_variable    <- rlang::enquo(y_variable)
  fill_variable <- rlang::enquo(fill_variable)
  
  if (rlang::as_name(y_variable) == "aboriginal_n") {
    
    y_title <- paste0("Number of ", n_level)
    
    y_max    <- max(total_data$total, na.rm = TRUE)
    y_upper  <- y_upper_n(y_max)
    y_breaks <- y_breaks(y_max)
    
  }
  
  if (rlang::as_name(y_variable) == "aboriginal_prop") {
    
    y_title <- paste0("Percentage of ", n_level)
    
    y_max    <- max(total_data$total, na.rm = TRUE)
    y_upper  <- y_upper_prop(y_max)
    y_breaks <- y_breaks(y_max)
    
  }
  
  figure <- data %>% 
    ggplot(aes(x = !!x_variable, y = !!y_variable, fill = !!fill_variable, text = hover_text)) +
    #
    geom_col() +
    #
    scale_y_continuous(limits = c(0, y_upper),
                       breaks = scales::breaks_width(y_breaks),
                       expand = expansion(add = c(0, 0)),
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
    theme(axis.text.x = element_text(angle = x_angle))
  
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
                   modebar = list(orientation = 'v'),
                   #
                   xaxis = list(tickfont = list(family = "Karla")),
                   #
                   yaxis = list(tickfont = list(family = "Karla"),
                                #
                                title = list(text     = y_title,
                                             font     = list(size = 13, family = "Karla"),
                                             standoff = 10)),
                   #
                   legend = list(x = 0.5,
                                 y = legend_offset,
                                 #
                                 font = list(family = "Karla"),
                                 #
                                 orientation = "h",
                                 xanchor     = "center",
                                 traceorder  = legend_order))

  return(figure)

}

################################################################################
# By LGA 
################################################################################
f_bar_stacked_lga <- function(data, fill_values, n_level, legend_order = "normal") {
  
  data <- data %>% 
    dplyr::mutate(hover_text = paste0(lga_name, " LGA", "\n",
                                      comparison, "\n",
                                      "Count: ", format(aboriginal_n, big.mark = ",")))
  
  y_title <- paste0("Number of ", n_level)
  
  y_max    <- max(data$aboriginal_total, na.rm = TRUE)
  y_upper  <- y_upper_n(y_max)
  y_breaks <- y_breaks(y_max)
  
  figure <- data %>% 
    ggplot(aes(x = lga_name, y = aboriginal_n, fill = forcats::fct_rev(comparison), text = hover_text)) +
    #
    geom_col() +
    #
    scale_y_continuous(limits = c(0, y_upper),
                       breaks = scales::breaks_width(y_breaks),
                       expand = expansion(add = c(0, 0)),
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
    theme(axis.text.x = element_text(angle = 90))
  
  figure <- figure %>% 
    plotly::ggplotly(tooltip = "text") %>%
    #
    plotly::layout(hovermode = "x",
                   #
                   modebar = list(orientation = 'v'),
                   #
                   xaxis = list(tickfont = list(family = "Karla")),
                   #
                   yaxis = list(tickfont = list(family = "Karla"),
                                #
                                title = list(text     = y_title,
                                             font     = list(size = 13, family = "Karla"),
                                             standoff = 10)),
                   #
                   legend = list(x = 0.5,
                                 y = -0.3,
                                 #
                                 font = list(family = "Karla"),
                                 #
                                 orientation = "h",
                                 xanchor     = "center",
                                 traceorder  = legend_order))
  
  return(figure)
  
}

################################################################################
# By age and sex 
################################################################################
f_bar_stacked_agesex <- function(data, fill_values, n_level, legend_order = "normal") {
  
  data <- data %>% 
    dplyr::mutate(hover_text = paste0(sex, "\n",
                                      age_group, "\n",
                                      comparison, "\n",
                                      "Count: ", format(aboriginal_n, big.mark = ",")))
  
  y_title <- paste0("Number of ", n_level)
  
  y_max    <- max(data$aboriginal_total, na.rm = TRUE)
  y_upper  <- y_upper_n(y_max)
  y_breaks <- y_breaks(y_max)
  
  figure <- data %>% 
    ggplot(aes(x = age_group, y = aboriginal_n, fill = forcats::fct_rev(comparison), text = hover_text)) +
    #
    geom_col() +
    #
    scale_y_continuous(limits = c(0, y_upper),
                       breaks = scales::breaks_width(y_breaks),
                       expand = expansion(add = c(0, 0)),
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
    theme(axis.text.x = element_text(angle = 90)) +
    #
    facet_wrap(.~ sex,
               scale          = "free_x",
               strip.position = "bottom")
  
  figure <- figure %>% 
    plotly::ggplotly(tooltip = "text") %>%
    #
    plotly::layout(hovermode = "x",
                   #
                   modebar = list(orientation = 'v'),
                   #
                   xaxis = list(tickfont = list(family = "Karla")),
                   #
                   yaxis = list(tickfont = list(family = "Karla"),
                                #
                                title = list(text     = y_title,
                                             font     = list(size = 13, family = "Karla"),
                                             standoff = 10)),
                   #
                   legend = list(x = 0.5,
                                 y = -0.2,
                                 #
                                 font = list(family = "Karla"),
                                 #
                                 orientation = "h",
                                 xanchor     = "center",
                                 traceorder  = legend_order))
  
  return(figure)
  
}

################################################################################
# By year (PHESS counts)
################################################################################
f_bar_stacked_phess <- function(data, legend_order = "reversed") {
  
  total_data <- data %>% 
    dplyr::filter(indigenous_label == "Aboriginal") %>%
    #
    dplyr::select(year,
                  vic_n)
  
  data <- data %>%
    dplyr::filter(indigenous_label == "Aboriginal") %>%
    #
    dplyr::select(year,
                  nephu_n,
                  notnephu_n) %>% 
    #
    tidyr::pivot_longer(cols      = ends_with("_n"),
                        names_to  = "comparison",
                        values_to = "aboriginal_n") %>%
    #
    dplyr::mutate(
      comparison = factor(dplyr::recode(comparison,
                                        "nephu_n"    = "NEPHU",
                                        "notnephu_n" = "Rest of Victoria"),
                          levels = c("NEPHU",
                                     "Rest of Victoria")),
      #
      hover_text = paste0(year, "\n",
                          comparison, "\n",
                          "Count: ", format(aboriginal_n, big.mark = ",")))
  
  y_max    <- max(total_data$vic_n, na.rm = TRUE)
  y_upper  <- y_upper_n(y_max)
  y_breaks <- y_breaks(y_max) 
  
  figure <- data %>%
    ggplot(aes(x = year, y = aboriginal_n, fill = forcats::fct_rev(comparison), text = hover_text)) +
    #
    geom_col() +
    #
    scale_y_continuous(limits = c(0, y_upper),
                       breaks = scales::breaks_width(y_breaks),
                       expand = expansion(add = c(0, 0)),
                       labels = scales::comma_format(big.mark = ",")) +
    #
    scale_fill_manual(values = c(colour_pyramidvic, colour_pyramidnephu),
                      name   = NULL) +
    #
    labs(x = NULL,
         y = NULL) +
    #
    theme_classic()
  
  figure <- figure %>% 
    plotly::ggplotly(tooltip = "text") %>%
    #
    plotly::layout(hovermode = "x",
                   #
                   modebar = list(orientation = 'v'),
                   #
                   xaxis = list(tickfont = list(family = "Karla")),
                   #
                   yaxis = list(tickfont = list(family = "Karla"),
                                #
                                title = list(text     = "Number of notifications",
                                             font     = list(size = 13, family = "Karla"),
                                             standoff = 10)),
                   #
                   legend = list(x = 0.5,
                                 #
                                 font = list(family = "Karla"),
                                 #
                                 orientation = "h",
                                 traceorder  = legend_order,
                                 xanchor     = "center"))
  
  return(figure)

}

