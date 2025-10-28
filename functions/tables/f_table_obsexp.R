# NEPHU Population Profile - Aboriginal Health
# Author: Alana Little, NEPHU (alana.little@austin.org.au)
# Version 2.0, 15/08/2025
#
# Table type: observed/expected tables

f_table_obsexp <- function(data, total_row, column_name, header_name) {
  
  if (is.null(header_name) || header_name == "") {
    header_name <- " "
  }
  
  table <- data %>% 
    dplyr::mutate(aboriginal_prop     = sprintf("%.1f", aboriginal_prop),
                  non_aboriginal_prop = sprintf("%.1f", non_aboriginal_prop)) %>%
    #
    knitr::kable(format      = "html",
                 format.args = list(big.mark = ","),
                 align       = "lrrrrrrrrrrrrrrrrrrrr",
                 col.names   = c(column_name, "n", "%", "n", "%", " "),
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
    kableExtra::column_spec(2:5,
                            width = "1in") %>%
    #
    kableExtra::column_spec(6,
                            width = "1.25in")

  header_labels <- c(header_name, 
                     "Observed values\n(identified as Aboriginal\nand/or Torres Strait Islander)",
                     "Expected values\n(based on NEPHU\nnon-Aboriginal population)",
                     "Differenc\nbetween observed\nand expected")
  
  header_widths <- c(1, 2, 2, 1)
  
  names(header_widths) <- header_labels
  
  table <- table %>%
    kableExtra::add_header_above(header = header_widths,
                                 align = "right")
  
  return(table)
  
}

