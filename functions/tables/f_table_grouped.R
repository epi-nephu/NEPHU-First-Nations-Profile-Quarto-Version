# NEPHU Population Profile - Aboriginal Health
# Author: Alana Little, NEPHU (alana.little@austin.org.au)
# Version 2.0, 15/08/2025
#
# Table type: grouped tables

################################################################################
# By sex
################################################################################
f_table_grouped_sex <- function(data, n_variable, column_name, total_row) {
  
  if (n_variable == "count") {
    
    table_headers <- c("Count", "Percent", "Count", "Percent", "Total")

  }
  
  if (n_variable == "estimate") {
    
    table_headers <- c("Estimate", "Percent", "Estimate", "Percent", "Total")
  
  }
  
  table <- data %>% 
    knitr::kable(format      = "html",
                 format.args = list(big.mark = ","),
                 align       = "lrrrrrr",
                 col.names   = c(column_name, table_headers),
                 escape      = FALSE) %>%
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
    kableExtra::add_header_above(c(" "      = 1,
                                   "Female" = 2,
                                   "Male"   = 2,
                                   "Total"  = 1)) %>% 
    #
    kableExtra::column_spec(2:6,
                            width = "1in")
  
  return(table)

}

################################################################################
# By Indigenous status
################################################################################
f_table_grouped_indigenous <- function(data, column_name, total_row) {
  
  table <- data %>% 
    knitr::kable(format      = "html",
                 format.args = list(big.mark = ","),
                 align       = "lrrrrrr",
                 col.names   = c(column_name, "Yes (n)", "Yes (%)", "No (n)", "No (%)"),
                 escape      = FALSE) %>%
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
    kableExtra::add_header_above(c(" " = 1,
                                   "Identified as Aboriginal and/or Torres Strait Islander" = 4),
                                 align = "right")
  
  return(table)
  
}

