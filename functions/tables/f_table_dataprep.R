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
                  obs_exp_difference = aboriginal_diff_label)
  
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
                  obs_exp_difference = aboriginal_diff_label)
  
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
                  obs_exp_difference = aboriginal_diff_label)
  
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
# Columns grouped by age and sex
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
# Columns grouped by sex
################################################################################
f_preptable_grouped_sex <- function(data, variable_name) {
  
  data <- data %>% 
    tidyr::pivot_wider(names_from  = "sex",
                       values_from = c("n", "prop"),
                       names_vary  = "slowest") %>% 
    #
    janitor::clean_names() %>% 
    #
    dplyr::rename(!!variable_name := answer)
  
  return(data)
  
}

################################################################################
# Columns grouped by Indigenous status
################################################################################
f_preptable_grouped_indigenous <- function(data, x_variable, n_variable) {
  
  x_variable <- rlang::enquo(x_variable)
  
  if (n_variable == "n and prop") {
    
    data <- data %>% 
      dplyr::select(-indigenous_status) %>% 
      #
      pivot_wider(names_from  = c("indigenous_label", "unit"),
                  names_vary  = "slowest",
                  values_from = "vic") %>% 
      #
      janitor::clean_names() %>%
      #
      dplyr::mutate(total_n = aboriginal_n + non_indigenous_n)
    
    data <- data %>%
      dplyr::select(!!x_variable,
                    aboriginal_n,
                    aboriginal_prop,
                    non_indigenous_n,
                    non_indigenous_prop,
                    total_n) %>% 
      #
      dplyr::arrange(!!x_variable)
    
  }
  
  if (n_variable == "prop only") {
    
    data <- data %>% 
      dplyr::select(-indigenous_status) %>% 
      #
      pivot_wider(names_from  = "indigenous_label",
                  names_vary  = "slowest",
                  values_from = "prop") %>% 
      #
      janitor::clean_names() %>% 
      #
      dplyr::rename(aboriginal_prop = aboriginal,
                    non_aboriginal_prop = non_indigenous)
    
  }
  
  if (n_variable == "n and rate") {
    
    data <- data %>% 
      dplyr::select(-indigenous_status) %>% 
      #
      pivot_wider(names_from  = c("indigenous_label", "unit"),
                  names_vary  = "slowest",
                  values_from = "vic") %>% 
      #
      janitor::clean_names() %>%
      #
      dplyr::mutate(total_n = aboriginal_n + non_indigenous_n)
    
    data <- data %>%
      dplyr::select(!!x_variable,
                    aboriginal_n,
                    aboriginal_rate,
                    non_indigenous_n,
                    non_indigenous_rate,
                    total_n) %>% 
      #
      dplyr::arrange(!!x_variable)
    
  }
  
  if (n_variable == "rate only") {
    
    data <- data %>% 
      dplyr::select(-indigenous_status) %>% 
      #
      pivot_wider(names_from  = "indigenous_label",
                  names_vary  = "slowest",
                  values_from = "rate") %>% 
      #
      janitor::clean_names() %>% 
      #
      dplyr::rename(aboriginal_rate = aboriginal,
                    non_aboriginal_rate = non_indigenous)
    
  }
  
  return(data)

} 

################################################################################
# NAPLAN data
################################################################################
f_preptable_naplan <- function(data) {
  
  data <- data %>% 
    dplyr::filter(indigenous_status == "Aboriginal and Torres Strait Islander students") %>%
    #
    dplyr::select(-indigenous_status,
                  -year) %>% 
    #
    tidyr::pivot_wider(names_from  = "grade",
                       values_from = "vic") %>% 
    #
    janitor::clean_names() %>% 
    #
    janitor::adorn_totals()
  
  return(data)

}

