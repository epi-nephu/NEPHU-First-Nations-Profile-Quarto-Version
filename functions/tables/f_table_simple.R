# NEPHU Population Profile - Aboriginal Health
# Author: Alana Little, NEPHU (alana.little@austin.org.au)
# Version 2.0, 15/08/2025
#
# Table type: simple (univariate) tables

f_table_simple <- function(data, total_row = nrow(table), last_column = ncol(table), 
                           table_headers, iare = "no", hospital = "no", column_width = "1in") {
  
  if (hospital == "admission") {
    
    table_headers <- c("IARE",
                       "Number of<br>admissions",
                       "Age-standardised rate<br>(per 100,000)",
                       "Standardised<br>ratio")

  }
  
  if (hospital == "emergency") {
    
    table_headers <- c("IARE",
                       "Number of<br>presentations",
                       "Age-standardised rate<br>(per 100,000)",
                       "Standardised<br>ratio")
    
  }
  
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
                              html_font  = "Karla",
                              font_size  = 12) %>%
    #
    kableExtra::row_spec(row  = c(0, total_row),
                         bold = TRUE) %>% 
    #
    kableExtra::column_spec(2:last_column,
                            width = column_width)
  
  if (iare == "yes") {
    
    table <- table %>% 
      kableExtra::row_spec(row    = 11:12,
                           italic = TRUE)

  }
  
  if (hospital %in% c("admission", "emergency")) {
    
    table <- table %>% 
      kableExtra::column_spec(2:last_column,
                              width = "1.75in")

  }
  
  return(table)
  
}

