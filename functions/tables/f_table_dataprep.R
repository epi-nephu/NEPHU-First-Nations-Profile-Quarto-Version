# NEPHU Population Profile - Aboriginal Health
# Author: Alana Little, NEPHU (alana.little@austin.org.au)
# Version 2.0, 15/08/2025
#
# Data prep for outputting tables

################################################################################
# Obs/exp tables, by LGA
################################################################################
f_preptable_obsexp_lga <- function(data) {
  
  data <- data %>% 
    dplyr::filter(lga_name %in% c(nephu_lga, "NEPHU")) %>% 
    #
    dplyr::select(lga_name,
                  aboriginal_n,
                  aboriginal_prop,
                  aboriginal_exp_non,
                  non_aboriginal_prop,
                  aboriginal_diff_label)
  
  return(data)
  
}

################################################################################
# Obs/exp tables, by age and sex
################################################################################
f_preptable_obsexp_agesex <- function(data) {
  
  data <- data %>% 
    dplyr::filter(age_group %in% c(age_group_lvl, "Total")) %>% 
    #
    dplyr::select(age_group,
                  sex,
                  aboriginal_n,
                  aboriginal_prop,
                  aboriginal_exp_non,
                  non_aboriginal_prop,
                  aboriginal_diff_label)
  
  return(data)
  
}

################################################################################
# Obs/exp tables, by sex
################################################################################
f_preptable_obsexp_sex <- function(data) {
  
  data <- data %>% 
    dplyr::select(sex,
                  aboriginal_n,
                  aboriginal_prop,
                  aboriginal_exp_non,
                  non_aboriginal_prop,
                  aboriginal_diff_label)
  
  return(data)
  
}

################################################################################
# Simple counts and percentages, by LGA
################################################################################
f_preptable_simple_lga <- function(data) {
 
  data <- data %>% 
    dplyr::filter(lga_name %in% c(nephu_lga, "NEPHU")) %>%
    #
    dplyr::select(lga_name,
                  aboriginal_n,
                  aboriginal_prop)
  
  return(data)

}

################################################################################
# Simple counts and percentages, by age and sex
################################################################################
f_preptable_simple_agesex <- function(data) {
  
  data <- data %>% 
    dplyr::filter(age_group %in% c(age_group_lvl, "Total")) %>%
    #
    dplyr::select(age_group,
                  sex,
                  aboriginal_n,
                  aboriginal_prop)
  
  return(data)
  
}

################################################################################
# Columns grouped by sex
################################################################################
f_preptable_grouped_agesex <- function(data) {
  
  data <- data %>% 
    dplyr::select(age_group,
                  sex,
                  aboriginal_n,
                  aboriginal_prop) %>%
    #
    tidyr::pivot_wider(names_from  = sex,
                       values_from = c("aboriginal_n", "aboriginal_prop"),
                       names_vary  = "slowest") %>% 
    #
    janitor::clean_names() %>% 
    #
    dplyr::mutate(aboriginal_n_total = aboriginal_n_female + aboriginal_n_male)
  
  return(data)

}

################################################################################
# Columns grouped by Indigenous status, n/% in a single column ("unit")
################################################################################
f_preptable_grouped_indigenous <- function(data, x_variable) {
  
  x_variable <- rlang::enquo(x_variable)
  
  data <- data %>% 
    dplyr::select(-indigenous_status) %>% 
    #
    pivot_wider(names_from  = c("indigenous_label", "unit"),
                names_vary  = "slowest",
                values_from = "vic") %>% 
    #
    janitor::clean_names() %>%
    #
    dplyr::mutate(total_n = aboriginal_n + non_indigenous_n) %>% 
    #
    dplyr::select(!!x_variable,
                  aboriginal_n,
                  aboriginal_prop,
                  non_indigenous_n,
                  non_indigenous_prop,
                  total_n) %>% 
    #
    dplyr::arrange(!!x_variable)
  
  return(data)

} 

