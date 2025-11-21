# NEPHU Population Profile - Aboriginal Health
# Author: Alana Little, NEPHU (alana.little@austin.org.au)
# Version 2.0, 15/08/2025
#
# Code for importing and wrangling data
# Data source: Closing the Gap Data repository
# https://www.pc.gov.au/closing-the-gap-data/
#
# ------------------------------------------------------------------------------
# Read in CtG data - by indigenous status
# ------------------------------------------------------------------------------
f_read_ctg_indigenous <- function(file, data_sheet, column_select, fill_variables, row_select) {
  
  data <- readxl::read_excel(file.path(root_folder, subfolder_ctg, file),
                             skip  = 1,
                             sheet = data_sheet) %>% 
    janitor::clean_names() %>% 
    #
    dplyr::select(!!!column_select) %>% 
    #
    tidyr::fill(!!!fill_variables) %>% 
    #
    dplyr::filter(!is.na(vic)) %>% 
    #
    dplyr::filter(row_number() %in% row_select) %>%
    #
    dplyr::mutate(
      vic = as.numeric(vic),
      #
      unit = dplyr::case_when(
        unit == "no." ~ "n",
        unit == "%"   ~ "prop",
        TRUE ~ NA_character_),
      #
      indigenous_label = dplyr::case_when(
        stringr::str_detect(indigenous_status, "Aboriginal")     ~ "Aboriginal",
        stringr::str_detect(indigenous_status, "Non-Indigenous") ~ "Non-Indigenous",
        TRUE ~ NA_character_),
      #
      indigenous_status = factor(dplyr::case_when(
        indigenous_label == "Aboriginal"     ~ "Identified as Aboriginal\nand/or Torres Strait Islander",
        indigenous_label == "Non-Indigenous" ~ "Did not identify as Aboriginal\nand/or Torres Strait Islander",
        TRUE ~ NA_character_),
        levels = c("Identified as Aboriginal\nand/or Torres Strait Islander",
                   "Did not identify as Aboriginal\nand/or Torres Strait Islander")))

  return(data)
  
}

