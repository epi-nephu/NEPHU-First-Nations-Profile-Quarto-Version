# NEPHU Population Profile - Aboriginal Health
# Author: Alana Little, NEPHU (alana.little@austin.org.au)
# Version 2.0, 15/08/2025
#
# Chart type: observed/expected bar chart

################################################################################
# By LGA
################################################################################
f_bar_obsexp_lga <- function(data, n_level = "people", legend_offset = -0.4) {
  
  data <- data %>% 
    dplyr::filter(lga_name %in% nephu_lga)
  
  max_obs <- max(data$aboriginal_n, na.rm = TRUE)
  max_exp <- max(data$aboriginal_exp_non, na.rm = TRUE)
  
  y_max    <- max(max_obs, max_exp)
  y_upper  <- y_upper_n(y_max)
  y_breaks <- y_breaks(y_max)
  
  data <- data %>% 
    tidyr::pivot_longer(c(aboriginal_n, aboriginal_exp_non),
                        names_to  = "comparison",
                        values_to = "n") %>%
    #
    dplyr::mutate(
      comparison_label = dplyr::case_when(
        comparison == "aboriginal_n"       ~ "Observed number",
        comparison == "aboriginal_exp_non" ~ "Expected number",
        TRUE ~ NA_character_),
      #
      comparison = factor(dplyr::case_when(
        comparison == "aboriginal_n"       ~ "Observed number identifying as\nAboriginal and/or Torres Strait Islander",
        comparison == "aboriginal_exp_non" ~ "Expected number based on NEPHU\nnon-Indigenous population",
        TRUE ~ NA_character_),
        levels = c("Observed number identifying as\nAboriginal and/or Torres Strait Islander", 
                   "Expected number based on NEPHU\nnon-Indigenous population"))) %>% 
    #
    dplyr::mutate(hover_text = paste0(lga_name, " LGA", "\n",
                                      comparison_label, "\n",
                                      "Count: ", format(n, big.mark = ",")))

  figure <- data %>% 
    ggplot(aes(x = lga_name, y = n, group = comparison, fill = comparison, text = hover_text)) +
    #
    geom_col(position = "dodge") +
    #
    scale_y_continuous(limits = c(0, y_upper),
                       breaks = scales::breaks_width(y_breaks),
                       expand = expansion(add = c(0, 0)),
                       labels = scales::comma_format(big.mark = ",")) +
    #
    scale_fill_manual(values = c(colour_aboriginal, colour_nonaboriginal),
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
    plotly::style(hoverlabel = list(font = list(family = "Karla"))) %>%
    #
    plotly::layout(font = list(family = "Karla"),
                   #
                   hovermode = "x",
                   #
                   modebar = list(orientation = 'v'),
                   #
                   yaxis = list(title = list(text     = paste0("Number of ", n_level),
                                             font     = list(size = 13),
                                             standoff = 10)),
                   #
                   legend = list(x = 0.5,
                                 y = legend_offset,
                                 #
                                 orientation = "h",
                                 entrywidth  = 200,
                                 xanchor     = "center"))
  
  return(figure)
  
}

################################################################################
# By age and sex
################################################################################
f_bar_obsexp_agesex <- function(data, n_level = "people", legend_offset = -0.3) {
  
  data <- data %>% 
    dplyr::filter(age_group %in% age_group_lvl)

  max_obs <- max(data$aboriginal_n, na.rm = TRUE)
  max_exp <- max(data$aboriginal_exp_non, na.rm = TRUE)
  
  y_max    <- max(max_obs, max_exp)
  y_upper  <- y_upper_n(y_max)
  y_breaks <- y_breaks(y_max)
  
  data <- data %>%
    tidyr::pivot_longer(c(aboriginal_n, aboriginal_exp_non),
                        names_to  = "comparison",
                        values_to = "n") %>%
    #
    dplyr::mutate(
      comparison_label = dplyr::case_when(
        comparison == "aboriginal_n"       ~ "Observed number",
        comparison == "aboriginal_exp_non" ~ "Expected number",
        TRUE ~ NA_character_),
      #
      comparison = factor(dplyr::case_when(
        comparison == "aboriginal_n"       ~ "Observed number identifying as\nAboriginal and/or Torres Strait Islander",
        comparison == "aboriginal_exp_non" ~ "Expected number based on NEPHU\nnon-Indigenous population",
        TRUE ~ NA_character_),
        levels = c("Observed number identifying as\nAboriginal and/or Torres Strait Islander", 
                   "Expected number based on NEPHU\nnon-Indigenous population"))) %>% 
    #
    dplyr::mutate(hover_text = paste0(sex, "\n",
                                      age_group, "\n",
                                      comparison_label, "\n",
                                      "Count: ", format(n, big.mark = ",")))
  
  figure <- data %>% 
    ggplot(aes(x = age_group, y = n, group = comparison, fill = comparison, text = hover_text)) +
    #
    geom_col(position = "dodge") +
    #
    scale_y_continuous(limits = c(0, y_upper),
                       breaks = scales::breaks_width(y_breaks),
                       expand = expansion(add = c(0, 0)),
                       labels = scales::comma_format(big.mark = ",")) +
    #
    scale_fill_manual(values = c(colour_aboriginal, colour_nonaboriginal),
                      name   = NULL) +
    #
    labs(x = NULL,
         y = NULL) +
    #
    theme_classic() +
    #
    theme(axis.text.x = element_text(angle = 90),
          strip.text  = element_text(size = 11, family = "Karla", margin = margin(t = 5))) +
    #
    facet_wrap(.~ sex,
               scale          = "free_x",
               strip.position = "bottom")
  
  figure <- figure %>% 
    plotly::ggplotly(tooltip = "text") %>%
    #
    plotly::style(hoverlabel = list(font = list(family = "Karla"))) %>%
    #
    plotly::layout(font = list(family = "Karla"),
                   #
                   hovermode = "x",
                   #
                   modebar = list(orientation = 'v'),
                   #
                   yaxis = list(title = list(text     = paste0("Number of ", n_level),
                                             font     = list(size = 13),
                                             standoff = 10)),
                   #
                   legend = list(x = 0.5,
                                 y = legend_offset,
                                 #
                                 orientation = "h",
                                 entrywidth  = 200,
                                 xanchor     = "center"))
  
  return(figure)
  
}

