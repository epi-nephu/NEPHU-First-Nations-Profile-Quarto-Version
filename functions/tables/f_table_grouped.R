# NEPHU Population Profile - Aboriginal Health
# Author: Alana Little, NEPHU (alana.little@austin.org.au)
# Version 2.0, 15/08/2025
#
# Table type: grouped tables

################################################################################
# By sex
################################################################################
f_table_grouped_sex <- function(data, n_variable, column_name, total_row = nrow(table)) {
  
  if (n_variable == "count") {
    
    table_headers <- c("Count", "Percent", "Count", "Percent", "Total")

  }
  
  if (n_variable == "estimate") {
    
    table_headers <- c("Estimate", "Percent", "Estimate", "Percent", "Estimate", "Percent")
  
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
                         bold = TRUE)

  if (n_variable == "count") {
    
    table <- table %>% 
      kableExtra::add_header_above(c(" "      = 1,
                                     "Male"   = 2,
                                     "Female" = 2,
                                     "Total"  = 1)) %>% 
      #
      kableExtra::column_spec(2:6,
                              width = "1in")

  }
  
  if (n_variable == "estimate") {
    
    table <- table %>%
      kableExtra::add_header_above(c(" "      = 1,
                                     "Male"   = 2,
                                     "Female" = 2,
                                     "Total"  = 2)) %>% 
      #
      kableExtra::column_spec(2:7,
                              width = "1in")

  }
  
  return(table)

}

################################################################################
# By Indigenous status
################################################################################
f_table_grouped_indigenous <- function(data, n_variable, column_name, total_row = nrow(table), last_column = ncol(table)) {

  if (n_variable == "count") {
    
    table_headers <- c("Count", "Percent", "Count", "Percent", "Total")
    
  }
  
  if (n_variable == "estimate") {
    
    table_headers <- c("Estimate", "Percent", "Estimate", "Percent", "Total")
    
  }
  
  if (n_variable == "rate") {
    
    table_headers <- c("Count", "Rate", "Count", "Rate", "Total")
    
  }
  
  table <- data %>% 
    knitr::kable(format      = "html",
                 format.args = list(big.mark = ","),
                 align       = "lrrrrr",
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
    kableExtra::column_spec(2:last_column,
                            width = "1.25in") %>% 
    #
    kableExtra::add_header_above(c(" " = 1,
                                   "Identified as Aboriginal\nand/or Torres Strait Islander"       = 2,
                                   "Did not identify as Aboriginal\nand/or Torres Strait Islander" = 2,
                                   " " = 1),
                                 align = "right")
  
  return(table)
  
}

