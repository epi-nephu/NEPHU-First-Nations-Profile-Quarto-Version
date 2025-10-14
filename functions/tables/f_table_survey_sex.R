# NEPHU Population Profile - Aboriginal Health
# Author: Alana Little, NEPHU (alana.little@austin.org.au)
# Version 2.0, 15/08/2025
#
# Grouping variables: sex
# Data source: National Aboriginal and Torres Strait Islander Health Survey

f_table_survey_sex <- function(data, digits = 1, x_labels, variable_label, total_row) {
  
  data_number <- data %>% 
    dplyr::select(sex,
                  ends_with(paste0("_", "n"))) %>%
    #
    tidyr::pivot_longer(cols      = !sex,
                        names_to  = "comparison",
                        values_to = "n") %>%
    #
    dplyr::mutate(comparison = stringr::str_remove(comparison, "\\_.*"),
                  comparison = dplyr::recode(comparison, !!!x_labels),
                  comparison = factor(comparison, levels = x_labels))
  
  data_percent <- data %>%
    dplyr::select(sex,
                  ends_with(paste0("_", "prop"))) %>%
    #
    tidyr::pivot_longer(cols      = !sex,
                        names_to  = "comparison",
                        values_to = "prop") %>%
    #
    dplyr::mutate(comparison = stringr::str_remove(comparison, "\\_.*"),
                  comparison = dplyr::recode(comparison, !!!x_labels),
                  comparison = factor(comparison, levels = x_labels),
                  #
                  prop = round(prop, digits = 1))

  table <- data_number %>%
    dplyr::left_join(data_percent, by = c("sex", "comparison")) %>%
    #
    tidyr::pivot_wider(names_from  = sex,
                       values_from = c("n", "prop"),
                       names_vary  = "slowest") %>%
    #
    dplyr::arrange(comparison) %>%
    #
    knitr::kable(format.args = list(big.mark = ","),
                 align       = "lrrrrrr",
                 col.names   = c(variable_label,
                                 "Estimate", "Percent",
                                 "Estimate", "Percent",
                                 "Estimate", "Percent")) %>%
    #
    kableExtra::kable_styling(bootstrap_options = c("hover", "responsive"),
                              #
                              full_width = FALSE,
                              position   = "center",
                              html_font  = "Arial",
                              font_size  = 12) %>%
    #
    kableExtra::row_spec(row  = c(0, total_row),
                         bold = TRUE) %>%
    #
    kableExtra::column_spec(1,
                            width = "2in") %>%
    #
    kableExtra::column_spec(2:7,
                            width = "0.15in") %>%
    #
    kableExtra::add_header_above(c(" "      = 1,
                                   "Male"   = 2,
                                   "Female" = 2,
                                   "Total"  = 2))

  return(table)

}

