# NEPHU Population Profile - Aboriginal Health
# Author: Alana Little, NEPHU (alana.little@austin.org.au)
# Version 2.0, 15/08/2025
#
# Code for importing and wrangling data
# Data source: Victorian Public Health Event Surveillance System
# https://www.health.vic.gov.au/infectious-diseases/infectious-diseases-surveillance-in-victoria
#
# ------------------------------------------------------------------------------
# Wrangle PHESS data
# ------------------------------------------------------------------------------
f_wrangle_phess <- function(data, condition_name) {
  
  vic_cases <- cases_all %>% 
    dplyr::filter(condition == condition_name) %>% 
    #
    dplyr::group_by(year, indigenous_status) %>% 
    dplyr::summarise(vic_n = n()) %>% 
    dplyr::ungroup() %>% 
    #
    tidyr::complete(year, indigenous_status,
                    fill = list(vic_n = 0)) %>%
    #
    dplyr::mutate(
      vic_rate = dplyr::case_when(
        indigenous_status == "aboriginal"     ~ (vic_n / population_vic_aboriginal) * 100000,
        indigenous_status == "non_aboriginal" ~ (vic_n / population_vic_nonaboriginal) * 100000,
        TRUE ~ NA_integer_))
  
  notnephu_cases <- cases_all %>% 
    dplyr::filter(condition == condition_name & nephu_case == "Rest of Victoria") %>% 
    #
    dplyr::group_by(year, indigenous_status) %>% 
    dplyr::summarise(notnephu_n = n()) %>% 
    dplyr::ungroup() %>% 
    #
    tidyr::complete(year, indigenous_status,
                    fill = list(notnephu_n = 0)) 
  
  nephu_cases <- cases_all %>% 
    dplyr::filter(condition == condition_name & nephu_case == "NEPHU") %>% 
    #
    dplyr::group_by(year, indigenous_status) %>% 
    dplyr::summarise(nephu_n = n()) %>% 
    dplyr::ungroup() %>% 
    #
    tidyr::complete(year, indigenous_status,
                    fill = list(nephu_n = 0)) %>%
    #
    dplyr::mutate(
      nephu_rate = dplyr::case_when(
        indigenous_status == "aboriginal"     ~ (nephu_n / population_nephu_aboriginal) * 100000,
        indigenous_status == "non_aboriginal" ~ (nephu_n / population_nephu_nonaboriginal) * 100000,
        TRUE ~ NA_integer_)) 
  
  cases_combined <- nephu_cases %>%
    dplyr::left_join(notnephu_cases, by = c("year", "indigenous_status")) %>% 
    dplyr::left_join(vic_cases, by = c("year", "indigenous_status")) %>%
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
  
  return(cases_combined)
  
}

