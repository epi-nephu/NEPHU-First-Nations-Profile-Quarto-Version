# NEPHU Population Profile - Aboriginal Health
# Author: Alana Little, NEPHU (alana.little@austin.org.au)
# Version 2.0, 15/08/2025
#
# Code for importing and wrangling data
# Data source: ABS National Aboriginal and Torres Strait Islander Health Survey
# https://www.abs.gov.au/statistics/people/aboriginal-and-torres-strait-islander-peoples/national-aboriginal-and-torres-strait-islander-health-survey/latest-release

# ----------------------------------------------------------------------------------
# National Aboriginal and Torres Strait Islander Health Survey data - statewide
# ----------------------------------------------------------------------------------
f_read_natsihs <- function(data_sheet, variable, row_range) {

  variable <- rlang::enquo(variable)

  data <- readxl::read_excel(file.path(root_folder, subfolder_natsihs, "Data_Tables_Victoria_Clean.xlsx"),
                             sheet = data_sheet) %>%
    #
    janitor::clean_names() %>%
    #
    dplyr::rename(!!variable := x1) %>%
    #
    dplyr::filter(row_number() %in% row_range)

  data <- data %>%
    tidyr::pivot_longer(cols = male_estimate:total_proportion,
                        #
                        names_to  = c("sex", "measure"),
                        names_sep = "_",
                        values_to = c("value")) %>%
    #
    tidyr::pivot_wider(names_from  = "measure",
                       values_from = "value") %>%
    #
    dplyr::mutate(sex = stringr::str_to_title(sex),
                  #
                  estimate = estimate * 1000) %>% 
    #
    dplyr::rename(n = estimate,
                  prop = proportion)

  return(data)

}

# ---------------------------------------------------------------------------------------
# National Aboriginal and Torres Strait Islander Health Survey data - by sex
# ---------------------------------------------------------------------------------------
f_read_natsihs_sex <- function(data, iare_level = "Melbourne") {
  
  data <- read.csv(file.path(root_folder, subfolder_natsihs, data),
                   skip        = 9,
                   strip.white = TRUE) %>%
    #
    dplyr::rename(iare_name = colnames(.)[1],
                  sex       = colnames(.)[2]) %>%
    #
    janitor::clean_names() %>%
    #
    dplyr::mutate(iare_name = if_else(iare_name == "", NA_character_, iare_name),
                  sex       = if_else(sex == "", NA_character_, sex)) %>%
    #
    tidyr::fill(iare_name, sex)
  
  if (iare_level == "Melbourne"){
    
    data <- data %>%
      dplyr::filter(iare_name == "Melbourne" & sex %in% c("Male", "Female")) %>%
      #
      dplyr::mutate(iare_name = dplyr::case_when(
        iare_name == "Melbourne" ~ "Greater Melbourne",
        TRUE ~ NA_character_))
  
  }
  
  if (iare_level == "Victoria"){
    
    data <- data %>%
      dplyr::filter(iare_name == "Total" & sex %in% c("Male", "Female")) %>%
      #
      dplyr::mutate(iare_name = dplyr::case_when(
        iare_name == "Total" ~ "Victoria",
        TRUE ~ NA_character_))

  }
  
  data <- data %>% 
    dplyr::select(iare_name,
                  everything(),
                  -ends_with("_rse"),
                  -ends_with("_annotations"),
                  -x_1) %>%
    #
    dplyr::rename_with(.fn = ~ paste0(., "_n"), .cols = 3:ncol(.)) %>% 
    #
    dplyr::mutate(across(!c(iare_name, sex), as.numeric)) %>%
    #
    dplyr::mutate_if(is.numeric, ~ . * 1000)
  
  return(data)
  
}
