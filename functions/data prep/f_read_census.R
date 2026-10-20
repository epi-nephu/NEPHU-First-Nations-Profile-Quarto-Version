# Gumunatj Ngarrngatj - NEPHU First Nations Population Profile
# Author: Alana Little, NEPHU (alana.little@austin.org.au)

# Code for importing and wrangling data
# Data source: ABS Census 2021
# https://www.abs.gov.au/census

# ------------------------------------------------------------------------------
# Read in Census population data - by LGA or SA2
# ------------------------------------------------------------------------------
f_read_census_population <- function(table, level) {
  
  if(level=="lga") {
    file   = paste0("2021Census_", table, "_VIC_LGA.csv")
    output = read.csv(file.path(root_folder, census_lga_data_subfolder, file))
  }
  
  if(level=="poa") {
    file   = paste0("2021Census_", table, "_VIC_POA.csv")
    output = read.csv(file.path(root_folder, census_poa_data_subfolder, file))
  } 
  
  if(level=="sa2") {
    file   = paste0("2021Census_", table, "_VIC_SA2.csv")
    output = read.csv(file.path(root_folder, census_sa2_data_subfolder, file))
  } 
  
  return(output)
  
}

# ------------------------------------------------------------------------------
# Read in Census TableBuilder data - by LGA
# ------------------------------------------------------------------------------
f_read_census_lga <- function(file, variable) {
  
  data <- read.csv(file.path(root_folder, tablebuilder_subfolder, file), 
                   skip        = 9, 
                   strip.white = TRUE) %>% 
    #
    janitor::clean_names()
    
  data <- data[2:(grep("Data source", data[, 1]) -1), ] %>%
    dplyr::rename(lga_name    = colnames(data)[1],
                  !!variable := colnames(data)[2]) %>% 
    #
    dplyr::mutate(lga_name  = if_else(lga_name == "Total", "VIC", lga_name),
                  lga_name  = if_else(lga_name == "", NA_character_, lga_name)) %>%
    #
    tidyr::fill(lga_name)

  data <- data %>%
    dplyr::left_join(lphu_assign %>%
                       dplyr::select(lga_name,
                                     lphu_long,
                                     lphu_short),
                     by = "lga_name") %>%
    #
    dplyr::filter(lga_name %in% c(nephu_lga))
  
  return(data)
  
}

# ------------------------------------------------------------------------------
# Wrangle Census TableBuilder data - by LGA
# ------------------------------------------------------------------------------
f_wrangle_census_lga <- function(data, variable, level, dichot) {
  
  variable <- rlang::enquo(variable)
  
  if (level == "person") {
    
    data <- data %>%
      dplyr::group_by(lga_name, !!variable) %>%
      dplyr::summarise(across(non_indigenous:total, sum)) %>%
      dplyr::ungroup() %>%
      #
      dplyr::mutate(aboriginal_n     = aboriginal + torres_strait_islander + both_aboriginal_and_torres_strait_islander,
                    non_aboriginal_n = non_indigenous + not_stated)
    
  } else if (level == "household") {
    
    data <- data %>%
      dplyr::mutate(aboriginal_n     = household_with_aboriginal_and_or_torres_strait_islander_person_s,
                    non_aboriginal_n = other_households + not_applicable)
    
    data <- data %>%
      dplyr::group_by(lga_name, !!variable) %>%
      #
      dplyr::summarise(aboriginal_n     = sum(aboriginal_n),
                       non_aboriginal_n = sum(non_aboriginal_n)) %>%
      #
      dplyr::ungroup()
    
  }
  
  data <- data %>%
    tidyr::pivot_wider(id_cols     = "lga_name",
                       names_from  = !!variable,
                       values_from = c(aboriginal_n, non_aboriginal_n)) %>%
    #
    janitor::clean_names() %>%
    #
    dplyr::mutate(aboriginal_total     = rowSums(select(., starts_with("aboriginal_"))),
                  non_aboriginal_total = rowSums(select(., starts_with("non_aboriginal_"))))
  
  if (dichot == "yes") {
    
    data <- data %>%
      dplyr::mutate(aboriginal_prop     = aboriginal_n_yes / aboriginal_total * 100,
                    non_aboriginal_prop = non_aboriginal_n_yes / non_aboriginal_total * 100)
    
    data <- data %>%
      dplyr::mutate(aboriginal_exp_non    = round((non_aboriginal_prop / 100) * aboriginal_total, digits = 0),
                    aboriginal_difference = aboriginal_n_yes - aboriginal_exp_non) %>%
      #
      dplyr::mutate(across(where(is.numeric), ~replace(., is.na(.), 0)),
                    across(where(is.numeric), ~replace(., is.nan(.), 0))) %>% 
      #
      janitor::adorn_totals(name = "NEPHU") %>% 
      #
      dplyr::mutate(aboriginal_prop     = aboriginal_n_yes / aboriginal_total * 100,
                    non_aboriginal_prop = non_aboriginal_n_yes / non_aboriginal_total * 100,
                    #
                    aboriginal_diff_format = formatC(abs(aboriginal_difference), big.mark = ","),
                    #
                    aboriginal_diff_label = dplyr::case_when(
                      aboriginal_difference > 0 ~ paste0(aboriginal_diff_format, " more"),
                      aboriginal_difference < 0 ~ paste0(aboriginal_diff_format, " fewer"),
                      TRUE ~ "None")) %>% 
      #
      dplyr::select(lga_name,
                    aboriginal_n = aboriginal_n_yes,
                    aboriginal_total,
                    aboriginal_prop,
                    aboriginal_exp_non,
                    non_aboriginal_n = non_aboriginal_n_yes,
                    non_aboriginal_total,
                    non_aboriginal_prop,
                    aboriginal_difference,
                    aboriginal_diff_label)
    
  } else if (dichot == "no") {
    
    data <- data %>% 
      janitor::adorn_totals(name = "NEPHU")
    
  }
  
  return(data)
  
}

# ------------------------------------------------------------------------------
# Read in Census TableBuilder data - by age and sex
# ------------------------------------------------------------------------------
f_read_census_agesex <- function(file, variable) {
  
  data <- read.csv(file.path(root_folder, tablebuilder_subfolder, file), 
                   skip        = 9, 
                   strip.white = TRUE) %>% 
    #
    janitor::clean_names()
  
  data <- data[2:(grep("Data source", data[, 1]) -1), ] %>% 
    dplyr::rename(lga_name    = colnames(data)[1],
                  age_group   = colnames(data)[2],
                  sex         = colnames(data)[3],
                  !!variable := colnames(data)[4]) %>%
    #
    dplyr::mutate(lga_name  = if_else(lga_name == "Total", "VIC", lga_name),
                  lga_name  = if_else(lga_name == "", NA_character_, lga_name),
                  age_group = if_else(age_group == "", NA_character_, age_group),
                  sex       = if_else(sex == "", NA_character_, sex)) %>% 
    #
    tidyr::fill(lga_name, age_group, sex)
  
  data <- data %>% 
    dplyr::left_join(lphu_assign %>% 
                       dplyr::select(lga_name,
                                     lphu_long,
                                     lphu_short), 
                     by = "lga_name") %>% 
    #
    dplyr::filter(lga_name %in% c(nephu_lga))
  
  return(data)
  
}

# ------------------------------------------------------------------------------
# Wrangle Census TableBuilder data - by age and sex
# ------------------------------------------------------------------------------
f_wrangle_census_agesex <- function(data, variable, dichot) {
  
  variable <- rlang::enquo(variable)
  
  data <- data %>% 
    dplyr::mutate(
      aboriginal_n     = aboriginal + torres_strait_islander + both_aboriginal_and_torres_strait_islander,
      non_aboriginal_n = non_indigenous + not_stated,
      #
      age_group = dplyr::case_when(
        age_group == "0-9 years"   ~ "0-9 yrs",
        age_group == "10-19 years" ~ "10-19 yrs",
        age_group == "20-29 years" ~ "20-29 yrs",
        age_group == "30-39 years" ~ "30-39 yrs",
        age_group == "40-49 years" ~ "40-49 yrs",
        age_group == "50-59 years" ~ "50-59 yrs",
        age_group == "60-69 years" ~ "60-69 yrs",
        age_group == "70-79 years" ~ "70-79 yrs",
        age_group == "80-89 years" ~ "80-89 yrs",
        age_group == "90-99 years" ~ "90-99 yrs",
        age_group == "100 years and over" ~ "100+ yrs",
        TRUE ~ NA_character_)) %>%
    #
    dplyr::group_by(age_group,
                    sex,
                    !!variable) %>%
    #
    dplyr::summarise(aboriginal_n     = sum(aboriginal_n),
                     non_aboriginal_n = sum(non_aboriginal_n)) %>%
    #
    dplyr::ungroup()
  
  data <- data %>% 
    tidyr::pivot_wider(names_from  = !!variable,
                       values_from = c("aboriginal_n", "non_aboriginal_n")) %>%
    #
    janitor::clean_names()
  
  if (dichot == "yes") {
    
    data <- data %>%
      dplyr::mutate(aboriginal_total     = aboriginal_n_yes + aboriginal_n_no,
                    non_aboriginal_total = non_aboriginal_n_yes + non_aboriginal_n_no,
                    aboriginal_prop      = aboriginal_n_yes / aboriginal_total * 100,
                    non_aboriginal_prop  = non_aboriginal_n_yes / non_aboriginal_total * 100)
    
    data <- data %>%
      dplyr::mutate(aboriginal_exp_non    = round((non_aboriginal_prop / 100) * aboriginal_total, digits = 0),
                    aboriginal_difference = aboriginal_n_yes - aboriginal_exp_non)
    
    total_female <- data %>% 
      dplyr::filter(sex == "Female") %>% 
      #
      janitor::adorn_totals(name = "Total") %>% 
      #
      dplyr::filter(age_group == "Total") %>%
      #
      dplyr::mutate(sex = "Female")
    
    total_male <- data %>% 
      dplyr::filter(sex == "Male") %>% 
      #
      janitor::adorn_totals(name = "Total") %>% 
      #
      dplyr::filter(age_group == "Total") %>% 
      #
      dplyr::mutate(sex = "Male") 

    data <- data %>%
      dplyr::bind_rows(total_female) %>% 
      dplyr::bind_rows(total_male) %>%
      #
      dplyr::mutate(aboriginal_prop     = aboriginal_n_yes / aboriginal_total * 100,
                    non_aboriginal_prop = non_aboriginal_n_yes / non_aboriginal_total * 100,
                    #
                    aboriginal_diff_format = formatC(abs(aboriginal_difference), big.mark = ","),
                    #
                    aboriginal_diff_label = dplyr::case_when(
                      aboriginal_difference > 0 ~ paste0(aboriginal_diff_format, " more"),
                      aboriginal_difference < 0 ~ paste0(aboriginal_diff_format, " fewer"),
                      TRUE ~ "None")) %>% 
      #
      dplyr::mutate(across(where(is.numeric), ~replace(., is.na(.), 0)),
                    across(where(is.numeric), ~replace(., is.nan(.), 0))) %>% 
      #
      dplyr::mutate(age_group = factor(age_group, levels = c(age_group_lvl, "Total"))) %>% 
      #
      dplyr::arrange(age_group) %>% 
      #
      dplyr::select(age_group,
                    sex,
                    aboriginal_n = aboriginal_n_yes,
                    aboriginal_total,
                    aboriginal_prop,
                    aboriginal_exp_non,
                    non_aboriginal_n = non_aboriginal_n_yes,
                    non_aboriginal_total,
                    non_aboriginal_prop,
                    aboriginal_difference,
                    aboriginal_diff_label)
    
  } else if (dichot == "no") {
    
    total_female <- data %>% 
      dplyr::filter(sex == "Female") %>% 
      #
      janitor::adorn_totals(name = "Total") %>% 
      #
      dplyr::filter(age_group == "Total") %>%
      #
      dplyr::mutate(sex = "Female")
    
    total_male <- data %>% 
      dplyr::filter(sex == "Male") %>% 
      #
      janitor::adorn_totals(name = "Total") %>% 
      #
      dplyr::filter(age_group == "Total") %>% 
      #
      dplyr::mutate(sex = "Male") 
    
    data <- data %>% 
      dplyr::bind_rows(total_female) %>% 
      dplyr::bind_rows(total_male) %>% 
      #
      dplyr::mutate(across(where(is.numeric), ~replace(., is.na(.), 0)),
                    across(where(is.numeric), ~replace(., is.nan(.), 0))) %>% 
      #
      dplyr::mutate(age_group = factor(age_group, levels = c(age_group_lvl, "Total"))) %>% 
      #
      dplyr::arrange(age_group)

  }
  
  return(data)
  
}

