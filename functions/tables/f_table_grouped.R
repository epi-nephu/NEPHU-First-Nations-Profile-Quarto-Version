# NEPHU Population Profile - Aboriginal Health
# Author: Alana Little, NEPHU (alana.little@austin.org.au)
# Version 2.0, 15/08/2025
#
# Grouping variables: varies depending on indicator (comparison)
# Data source: ABS Census 2021

f_table_grouped <- function(data, table_headers, total_row, last_column) {

  table <- data %>%
    knitr::kable(format.args = list(big.mark = ","),
                 align       = "lrrrrrrrrrrrrrrrrrrrrrrr",
                 col.names   = c(table_headers,
                                 "Total")) %>%
    #
    kableExtra::kable_styling(bootstrap_options = c("hover", "responsive"),
                              #
                              full_width = TRUE,
                              position   = "center",
                              html_font  = "Arial",
                              font_size  = 12) %>%
    #
    kableExtra::row_spec(row  = c(0, total_row),
                         bold = TRUE) %>%
    #
    kableExtra::column_spec(1,
                            width = "1in") %>% 
    #
    kableExtra::column_spec(2:last_column,
                            width = "0.75in") 

  return(table)

}

