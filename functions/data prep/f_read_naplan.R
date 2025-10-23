# NEPHU Population Profile - Aboriginal Health
# Author: Alana Little, NEPHU (alana.little@austin.org.au)
# Version 2.0, 15/08/2025
#
# Code for importing and wrangling data
# Data source: NAPLAN
# https://www.acara.edu.au/reporting/national-report-on-schooling-in-australia/naplan-national-results

f_read_naplan <- function(data, data_sheet) {
  
  data <- readxl::read_excel(file.path(root_folder, subfolder_ctg, "CTG05_Learning_Potential_Data_Tables.xlsx"),
                             skip  = 1,
                             sheet = data_sheet) %>% 
    janitor::clean_names() %>% 
    #
    dplyr::rename(year = x2,
                  grade = x3,
                  indigenous_status = x4,
                  achievement = x5) %>%
    #
    tidyr::fill(year, grade, indigenous_status) %>% 
    #
    dplyr::filter(!is.na(vic)) %>% 
    dplyr::filter(year == "2024") %>% 
    #
    dplyr::select(year,
                  indigenous_status,
                  grade,
                  achievement,
                  vic)
  
  data <- data %>% 
    dplyr::mutate(achievement = factor(achievement,
                                       levels = c("Exceeding",
                                                  "Strong",
                                                  "Developing",
                                                  "Needs additional support",
                                                  "Exempt")))
  
  return(data)
  
}

