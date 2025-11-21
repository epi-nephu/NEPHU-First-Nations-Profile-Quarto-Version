# NEPHU Population Profile - Aboriginal Health
# Author: Alana Little, NEPHU (alana.little@austin.org.au)
# Version 2.0, 15/08/2025
#
# Code for importing and wrangling data
# Data source: AIHW Aboriginal and Torres Strait Islander Health Performance Framework
# https://www.indigenoushpf.gov.au/
#
# ------------------------------------------------------------------------------
# Read in HPF data
# ------------------------------------------------------------------------------
f_read_hpf <- function(file, data_sheet, skip_rows, column_select, row_select) {
  
  data <- readxl::read_excel(file.path(root_folder, subfolder_framework, file),
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
# Wrangle HPF data - vaccination
# ------------------------------------------------------------------------------
f_wrangle_hpf_vaccination <- function(data) {
  
  data <- data %>% 
    dplyr::mutate(indigenous_status = dplyr::case_when(
    indigenous_status == "Indigenous" ~ "aboriginal",
    TRUE ~ "non_aboriginal")) %>%
    #
    dplyr::mutate(across(!indigenous_status, as.numeric)) %>% 
    #
    tidyr::pivot_longer(!indigenous_status,
                        names_to  = "vaccine",
                        values_to = "prop") %>% 
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
                   "Did not identify as Aboriginal\nand/or Torres Strait Islander")))
  
  return(data)
  
}

