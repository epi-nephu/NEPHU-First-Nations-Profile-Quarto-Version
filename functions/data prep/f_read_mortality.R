# NEPHU Population Profile - Aboriginal Health
# Author: Alana Little, NEPHU (alana.little@austin.org.au)
# Version 2.0, 15/08/2025
#
# Code for importing and wrangling data
# Data source: Data from ABS Technical Report
# https://www.abs.gov.au/articles/technical-note-impact-using-multiple-sources-deriving-indigenous-status-deaths-2023-changes-victoria-and-coroner-referred-deaths
#
# ------------------------------------------------------------------------------
# Read in ABS data
# ------------------------------------------------------------------------------
f_read_mortality <- function(file, data_sheet = "Sheet1", skip_rows = 2, column_select) {
  
  data <- readxl::read_excel(file.path(root_folder, subfolder_death, file),
                             sheet        = data_sheet,
                             skip         = skip_rows,
                             trim_ws      = TRUE,
                             .name_repair = "universal_quiet") %>% 
    #
    janitor::clean_names() %>% 
    #
    dplyr::select(!!!column_select)

  return(data)
  
}

