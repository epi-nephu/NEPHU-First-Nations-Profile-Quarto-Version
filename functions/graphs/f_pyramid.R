# NEPHU Population Profile - Aboriginal Health
# Author: Alana Little, NEPHU (alana.little@austin.org.au)
# Version 2.0, 15/08/2025
#
# Chart type: population pyramid

f_pyramid <- function(data, prop_variable, fill_variable, fill_values, chart_title = NULL) {
  
  prop_variable <- rlang::enquo(prop_variable)
  fill_variable <- rlang::enquo(fill_variable)
  
  padding_data <- data %>% 
    dplyr::group_by(sex) %>% 
    dplyr::summarise(min = min(!!prop_variable),
                     max = max(!!prop_variable)) %>% 
    dplyr::ungroup() %>%
    #
    dplyr::mutate(
      padding = dplyr::case_when(
        sex == "Female" ~ padding_female,
        sex == "Male"   ~ padding_male),
      #
      age_group        = "50+ years",
      !!fill_variable := "ZZZ_dummy",
      hover_text       = NA_character_)
  
  figure <- ggplot(data,
                   aes(x = age_group, y = !!prop_variable, fill = !!fill_variable, text = hover_text)) +
    #
    geom_col(linewidth = 0.25,
             position  = "dodge") +
    #
    geom_blank(data = padding_data,
               aes(x = age_group, y = padding)) +
    #
    geom_hline(yintercept = 0) +
    #
    scale_y_continuous(breaks = seq(from = -30, to = 30, by = 5),
                       labels = abs(seq(from = -30, to = 30, by = 5)),
                       expand = expansion(mult = c(0, 0))) +
    #
    scale_fill_manual(values = fill_values) +
    #
    facet_wrap(.~ sex,
               scale          = "free_x",
               strip.position = "bottom") +
    #
    labs(title = chart_title,
         x     = NULL,
         y     = "Percentage of total population",
         fill  = NULL) +
    #
    coord_flip() +
    #
    theme_classic() +
    #
    theme(plot.title   = element_text(size = 12, family = "Arial", face = "bold"),
          axis.title.x = element_text(size = 10, family = "Arial", margin = margin(t = 10)))

  figure <- figure %>%
    plotly::ggplotly(tooltip = "text") %>%
    #
    plotly::layout(modebar = list(orientation = 'v'),
                   #                   
                   legend = list(x = 0.5,
                                 y = -0.15,
                                 #
                                 orientation = "h",
                                 xanchor     = "center"))

  return(figure)

}

