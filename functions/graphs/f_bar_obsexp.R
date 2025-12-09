# NEPHU Population Profile - Aboriginal Health
# Author: Alana Little, NEPHU (alana.little@austin.org.au)
# Version 2.0, 15/08/2025
#
# Chart type: observed/expected bar chart

################################################################################
# By LGA
################################################################################
f_bar_obsexp_lga <- function(data, y_max = NA, y_breaks, y_expand, 
                             y_title = "Number of people") {
  
  data <- data %>% 
    dplyr::filter(lga_name %in% nephu_lga) %>%
    #
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
        comparison == "aboriginal_n"       ~ "Observed number identifying as Aboriginal and/or Torres Strait Islander",
        comparison == "aboriginal_exp_non" ~ "Expected number based on NEPHU non-Indigenous population",
        TRUE ~ NA_character_),
        levels = c("Observed number identifying as Aboriginal and/or Torres Strait Islander", 
                   "Expected number based on NEPHU non-Indigenous population"))) %>% 
    #
    dplyr::mutate(hover_text = paste0(lga_name, " LGA", "\n",
                                      comparison_label, "\n",
                                      "Count: ", format(n, big.mark = ",")))

  figure <- data %>% 
    ggplot(aes(x = lga_name, y = n, group = comparison, fill = comparison, text = hover_text)) +
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
    theme(axis.text.x = element_text(angle = 90))
  
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
# By age and sex
################################################################################
f_bar_obsexp_agesex <- function(data, y_max = NA, y_breaks, y_expand, 
                                y_title = "Number of people") {
  
  data <- data %>% 
    dplyr::filter(age_group %in% age_group_lvl) %>%
    #
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
        comparison == "aboriginal_n"       ~ "Observed number identifying as Aboriginal and/or Torres Strait Islander",
        comparison == "aboriginal_exp_non" ~ "Expected number based on NEPHU non-Indigenous population",
        TRUE ~ NA_character_),
        levels = c("Observed number identifying as Aboriginal and/or Torres Strait Islander", 
                   "Expected number based on NEPHU non-Indigenous population"))) %>% 
    #
    dplyr::mutate(hover_text = paste0(sex, "\n",
                                      age_group, "\n",
                                      comparison_label, "\n",
                                      "Count: ", format(n, big.mark = ",")))
  
  figure <- data %>% 
    ggplot(aes(x = age_group, y = n, group = comparison, fill = comparison, text = hover_text)) +
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

