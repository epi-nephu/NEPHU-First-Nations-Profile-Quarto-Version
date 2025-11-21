# NEPHU Population Profile - Aboriginal Health
# Author: Alana Little, NEPHU (alana.little@austin.org.au)
# Version 2.0, 15/08/2025
#
# Code for importing and wrangling data
# Data source: Victorian Cancer Screening Framework
# https://acpcc.org.au/services/population-health/
#
# ------------------------------------------------------------------------------
# Read in VCSF data
# ------------------------------------------------------------------------------
f_read_vcsf <- function(file, data_sheet, skip_rows, row_select, column_select) {
  
  data <- readxl::read_excel(file.path(root_folder, subfolder_screening, file),
                             sheet        = data_sheet,
                             skip         = skip_rows,
                             trim_ws      = TRUE,
                             .name_repair = "universal_quiet") %>% 
    #
    janitor::clean_names() %>% 
    #
    dplyr::filter(row_number() %in% row_select) %>% 
    #
    dplyr::select(!!!column_select)

  return(data)
  
}

# ------------------------------------------------------------------------------
# Wrangle VCSF data
# ------------------------------------------------------------------------------
f_wrangle_vcsf <- function(data) {
  
  data <- data %>% 
    dplyr::mutate(across(!indigenous_status, as.numeric)) %>% 
    #
    tidyr::pivot_longer(!indigenous_status,
                        names_to  = "variable",
                        values_to = "n") %>%
    #
    tidyr::separate(variable, into = c("type", "period"), sep = "_n_") %>% 
    #
    tidyr::pivot_wider(names_from  = "type",
                       values_from = "n") %>%
    #
    dplyr::mutate(
      indigenous_label = dplyr::case_when(
        indigenous_status == "aboriginal"     ~ "Aboriginal",
        indigenous_status == "non_aboriginal" ~ "Non-Indigenous",
        TRUE ~ NA_character_),
      #
      indigenous_status = factor(dplyr::case_when(
        indigenous_status == "aboriginal"     ~ "Identified as Aboriginal\nand/or Torres Strait Islander",
        indigenous_status == "non_aboriginal" ~ "Did not identify as Aboriginal\nand/or Torres Strait Islander",
        TRUE ~ NA_character_),
        #
        levels = c("Identified as Aboriginal\nand/or Torres Strait Islander",
                   "Did not identify as Aboriginal\nand/or Torres Strait Islander")),
      #
      screened = as.numeric(screened),
      eligible = as.numeric(eligible),
      #
      prop = screened / eligible * 100)
  
  return(data)
  
}

