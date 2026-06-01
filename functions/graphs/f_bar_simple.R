# NEPHU Population Profile - Aboriginal Health
# Author: Alana Little, NEPHU (alana.little@austin.org.au)
# Version 2.0, 15/08/2025
#
# Chart type: simple bar chart

################################################################################
# Classic simple bar chart
################################################################################
f_bar_simple <- function(data, x_variable, y_variable, y_title = "Number of people", x_angle = 90, ctg_target = NA) {
  
  x_variable <- rlang::enquo(x_variable)
  y_variable <- rlang::enquo(y_variable)
  
  ctg_target <- ctg_target
  
  y_max    <- max(data$aboriginal_n, na.rm = TRUE)
  y_upper  <- y_upper_n(y_max)
  y_breaks <- y_breaks(y_max)
  
  figure <- data %>% 
    ggplot(aes(x = !!x_variable, y = !!y_variable, text = hover_text)) +
    #
    geom_col(fill = colour_simplebar)
  
  if (!is.na(ctg_target)) {
    
    figure <- figure +
      geom_hline(aes(yintercept = ctg_target, linetype = "CtG target (%)"),
                 col         = colour_ctgtarget,
                 linewidth   = 0.5,
                 show.legend = TRUE) +
      #
      scale_linetype_manual(name   = NULL,
                            values = c("CtG target (%)" = "dashed"))
    
  }
  
  figure <- figure +
    scale_y_continuous(limits = c(0, y_upper),
                       breaks = scales::breaks_width(y_breaks),
                       expand = expansion(add = c(0, 0)),
                       labels = scales::comma_format(big.mark = ",")) +
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
                   modebar = list(orientation = 'v'),
                   #
                   xaxis = list(tickfont = list(family = "Karla")),
                   #
                   yaxis = list(tickfont = list(family = "Karla"),
                                #
                                title = list(text     = y_title,
                                             font     = list(size = 13, family = "Karla"),
                                             standoff = 10)))
  
  return(figure)

}

################################################################################
# Flipped x-axis and y-axis
################################################################################
f_bar_simple_flip <- function(data, x_variable, y_variable, x_title = "Number of people") {
  
  x_variable <- rlang::enquo(x_variable)
  y_variable <- rlang::enquo(y_variable)
  
  y_max    <- max(data$aboriginal_n, na.rm = TRUE)
  y_upper  <- y_upper_n(y_max)
  y_breaks <- y_breaks(y_max)
  
  figure <- data %>% 
    ggplot(aes(x = !!x_variable, y = !!y_variable, text = hover_text)) +
    #
    geom_col(fill = colour_simplebar) +
    #
    scale_y_continuous(limits = c(0, y_upper),
                       breaks = scales::breaks_width(y_breaks),
                       expand = expansion(add = c(0, 0)),
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
                   modebar = list(orientation = 'v'),
                   #
                   yaxis = list(tickfont = list(family = "Karla")),
                   #
                   xaxis = list(tickfont = list(family = "Karla"),
                                #
                                title = list(text     = x_title,
                                             font     = list(size = 13, family = "Karla"),
                                             standoff = 10)))
  
  return(figure)
  
}

################################################################################
# By LGA
################################################################################
f_bar_simple_lga <- function(data, y_variable, n_level = "people", ctg_target = NA) {
  
  y_variable <- rlang::enquo(y_variable)
  
  ctg_target <- ctg_target
  
  data <- data %>% 
    dplyr::filter(lga_name %in% nephu_lga)
  
  if (rlang::as_name(y_variable) == "aboriginal_n") {
    
    y_title <- paste("Number of ", n_level)
    
    y_max    <- max(data$aboriginal_n, na.rm = TRUE)
    y_upper  <- y_upper_n(y_max)
    y_breaks <- y_breaks(y_max)
    
    data <- data %>% 
      dplyr::mutate(hover_text = paste0(lga_name, " LGA", "\n",
                                        "Count: ", format(!!y_variable, big.mark = ",")))

  }
  
  if (rlang::as_name(y_variable) == "aboriginal_prop") {
    
    y_title <- paste("Percentage of ", n_level)
    
    y_max    <- max(data$aboriginal_prop, na.rm = TRUE)
    y_upper  <- y_upper_prop(y_max)
    y_breaks <- y_breaks(y_max)
    
    data <- data %>% 
      dplyr::mutate(hover_text = paste0(lga_name, " LGA", "\n",
                                        "Percentage: ", sprintf("%.1f", !!y_variable)))

  }

  figure <- data %>% 
    ggplot(aes(x = lga_name, y = !!y_variable, text = hover_text)) +
    #
    geom_col(fill = colour_simplebar)
  
  if (!is.na(ctg_target)) {
    
    figure <- figure +
      geom_hline(aes(yintercept = ctg_target, linetype = "CtG target (%)"),
                 col         = colour_ctgtarget,
                 linewidth   = 0.5,
                 show.legend = TRUE) +
      #
      scale_linetype_manual(name   = NULL,
                            values = c("CtG target (%)" = "dashed"))
    
  }
  
  figure <- figure +
    scale_y_continuous(limits = c(0, y_upper),
                       breaks = scales::breaks_width(y_breaks),
                       expand = expansion(add = c(0, 0)),
                       labels = scales::comma_format(big.mark = ",")) +
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
                                             standoff = 10)))
  
  return(figure)
  
}

################################################################################
# By IARE
################################################################################
f_bar_simple_iare <- function(data, y_variable, n_level = "people", ctg_target = NA, hospital = "no") {
  
  y_variable <- rlang::enquo(y_variable)
  
  ctg_target <- ctg_target
  
  if (hospital == "admission" & rlang::as_name(y_variable) == "aboriginal_n") {
    
    y_title <- "Number of admissions"

  }
  
  if (hospital == "emergency" & rlang::as_name(y_variable) == "aboriginal_n") {
    
    y_title <- "Number of presentations"
    
  }
  
  if (hospital == "no" & rlang::as_name(y_variable) == "aboriginal_n") {
    
    y_title <- paste0("Number of ", n_level)

  }
  
  if (hospital == "no" & rlang::as_name(y_variable) == "aboriginal_prop") {
    
    y_title <- paste0("Percentage of ", n_level)

  }
  
  if (hospital %in% c("admission", "emergency") & rlang::as_name(y_variable) == "aboriginal_rate") {
    
    y_title <- "Age-standardised rate (per 100,000 population)"
    
  }
  
  data <- data %>% 
    dplyr::filter(iare_name %in% iare_names)
  
  if (rlang::as_name(y_variable) == "aboriginal_n") {
    
    data <- data %>% 
      dplyr::mutate(
        aboriginal_plot = dplyr::case_when(
          is.na(!!y_variable) ~ 0,
          TRUE ~ !!y_variable),
        #
        hover_text = ifelse(
          is.na(!!y_variable),
          paste0(iare_name, " IARE", "\n",
                 "Count: ", "Data not available"),
          paste0(iare_name, " IARE", "\n",
                 "Count: ", format(!!y_variable, big.mark = ","))))
    
    y_max    <- max(data$aboriginal_n, na.rm = TRUE)
    y_upper  <- y_upper_n(y_max)
    y_breaks <- y_breaks(y_max)

  }
  
  if (rlang::as_name(y_variable) == "aboriginal_prop") {
    
    data <- data %>% 
      dplyr::mutate(
        aboriginal_plot = dplyr::case_when(
          is.na(!!y_variable) ~ 0,
          TRUE ~ !!y_variable),
        #
        hover_text = ifelse(
          is.na(!!y_variable),
          paste0(iare_name, " IARE", "\n",
                 "Percentage: ", "Data not available"),
          paste0(iare_name, " IARE", "\n",
                 "Percentage: ", sprintf("%.1f", !!y_variable))))
    
    y_max    <- max(data$aboriginal_prop, na.rm = TRUE)
    y_upper  <- y_upper_prop(y_max)
    y_breaks <- y_breaks(y_max)

  }
  
  if (rlang::as_name(y_variable) == "aboriginal_rate") {
    
    data <- data %>% 
      dplyr::mutate(
        aboriginal_plot = dplyr::case_when(
          is.na(!!y_variable) ~ 0,
          TRUE ~ !!y_variable),
        #
        hover_text = ifelse(
          is.na(!!y_variable),
          paste0(iare_name, " IARE", "\n",
                 "Rate: ", "Data not available"),
          paste0(iare_name, " IARE", "\n",
                 "Rate: ", format(round(!!y_variable, digits = 0), big.mark = ","))))
    
    y_max    <- max(data$aboriginal_rate, na.rm = TRUE)
    y_upper  <- y_upper_rate(y_max)
    y_breaks <- y_breaks(y_max)
    
  }
  
  figure <- data %>% 
    ggplot(aes(x = iare_name_short, y = aboriginal_plot, text = hover_text)) +
    #
    geom_col(fill = colour_simplebar)
  
  if (!is.na(ctg_target)) {
    
    figure <- figure +
      geom_hline(aes(yintercept = ctg_target, linetype = "CtG target (%)"),
                 col         = colour_ctgtarget,
                 linewidth   = 0.5,
                 show.legend = TRUE) +
      #
      scale_linetype_manual(name   = NULL,
                            values = c("CtG target (%)" = "dashed"))
    
  }
  
  figure <- figure +
    scale_y_continuous(limits = c(0, y_upper),
                       breaks = scales::breaks_width(y_breaks),
                       expand = expansion(add = c(0, 0)),
                       labels = scales::comma_format(big.mark = ",")) +
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
                                             standoff = 10)))
  
  return(figure)
  
}

################################################################################
# Combine count and percentage charts into two-panel figure
################################################################################
f_bar_simple_combine <- function(figure_number, figure_percent, legend_offset = -0.3) {
  
  figure <- plotly::subplot(figure_number, figure_percent,
                            titleY = TRUE,
                            margin = 0.05) %>% 
    #
    plotly::layout(legend = list(x = 0.775,
                                 y = legend_offset,
                                 #
                                 font = list(family = "Karla"),
                                 #
                                 orientation = "h",
                                 xanchor     = "center"))
  
  return(figure)

}

