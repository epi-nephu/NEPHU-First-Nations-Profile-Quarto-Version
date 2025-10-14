# NEPHU Population Profile - Aboriginal Health
# Author: Alana Little, NEPHU (alana.little@austin.org.au)
# Version 2.0, 15/08/2025
#
# Grouping variables: age group and sex
# Data source: National Aboriginal and Torres Strait Islander Health Survey

f_table_survey_agesex <- function(data, table_header) {
  
  data <- data %>%
    tidyr::pivot_wider(names_from  = "sex",
                       values_from = c("estimate", "proportion"),
                       names_vary  = "slowest") %>%
    #
    janitor::clean_names() %>%
    #
    dplyr::select(-age_group)
  
  table <- data %>%
    knitr::kable(format.args = list(big.mark = ","),
                 align       = "lrrrrrr",
                 col.names   = c(table_header,
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
    kableExtra::row_spec(row  = 0,
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
                                   "Total"  = 2)) %>%
    #
    kableExtra::pack_rows("Adults", 1, 3) %>% 
    #
    kableExtra::pack_rows("Children", 4, 6)

  return(table)

}

