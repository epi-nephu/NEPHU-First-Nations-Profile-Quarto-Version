# NEPHU Population Profile - Aboriginal Health
# Author: Alana Little, NEPHU (alana.little@austin.org.au)
# Version 2.0, 15/08/2025
#
# Table type: simple (univariate) tables

f_table_simple <- function(data, total_row = nrow(table), last_column = ncol(table), table_headers, iare = "no") {
  
  table <- data %>% 
    knitr::kable(format      = "html",
                 format.args = list(big.mark = ","),
                 align       = "lrrrrrrrrrrrrrrrrrrrr",
                 col.names   = c(table_headers),
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
                            width = "1in")
  
  if (iare == "yes") {
    
    table <- table %>% 
      kableExtra::row_spec(row    = 11:12,
                           italic = TRUE)

  }
  
  return(table)
  
}

