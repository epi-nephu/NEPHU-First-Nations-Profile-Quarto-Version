# NEPHU Population Profile - Aboriginal Health
# Author: Alana Little, NEPHU (alana.little@austin.org.au)
# Version 2.0, 15/08/2025

# General code that applies to all indicators
# - Packages
# - Data folders
# - LGA reference data
# - Constants
# - Colours

# ------------------------------------------------------------------------------
# Packages
# ------------------------------------------------------------------------------
if (!require("pacman")) install.packages("pacman")

pacman::p_load(here,
               tidyverse,
               quarto,
               rlang,
               janitor,
               readxl,
               sf,
               knitr,
               kableExtra,
               colorRamps,
               extrafont,
               ggnewscale,
               plotly)

# ------------------------------------------------------------------------------
# Data folders
# ------------------------------------------------------------------------------
root_folder <- str_extract(getwd(), "^.+Epidemiology")

# NEPHU map objects
load(file.path(root_folder, "Population Health Data/NEPHU Maps", "NEPHU_basemaps_sf.RData"))

# ABS Census 2021
census_lga_data_subfolder <- "Population Health Data/ABS Census Population Housing 2021 (GCP)/Data/LGA/VIC"
census_sa2_data_subfolder <- "Population Health Data/ABS Census Population Housing 2021 (GCP)/Data/SA2/VIC"
tablebuilder_subfolder    <- "Population Health Data/ABS Census Population Housing 2021 (GCP)/Data/TableBuilder/Aboriginal"

# Other data sources
subfolder_birth       <- "Population Health Data/ABS Births and Mortality/Data/Raw data"
subfolder_cancer      <- "Population Health Data/VIC Cancer Registry/Data"
subfolder_coroner     <- "Population Health Data/VIC Coroners Court/Data"
subfolder_corrective  <- "Population Health Data/Corrective Services/Data"
subfolder_ctg         <- "Population Health Data/Closing the Gap/Data"
subfolder_framework   <- "Population Health Data/AIHW Aboriginal Health Performance Framework/Data"
subfolder_natsihs     <- "Population Health Data/ABS National Aboriginal Health Survey 2022-23/Data"
subfolder_phidu       <- "Population Health Data/PHIDU/Data"
subfolder_projections <- "Population Health Data/Population Projections/Data"
subfolder_protection  <- "Population Health Data/Child Protection/Data"
subfolder_vcams       <- "Population Health Data/VCAMS/Data"

# ------------------------------------------------------------------------------
# Functions
# ------------------------------------------------------------------------------
source(here::here("functions", "data prep", "f_read_census_population.R"))

source(here::here("functions", "data prep", "f_read_census_lga.R"))
source(here::here("functions", "data prep", "f_read_census_agesex.R"))
source(here::here("functions", "data prep", "f_read_natsihs.R"))
source(here::here("functions", "data prep", "f_read_natsihs_sex.R"))

source(here::here("functions", "graphs", "f_graph_bar_simple.R"))

source(here::here("functions", "graphs", "f_graph_grouped_lga.R"))
source(here::here("functions", "graphs", "f_graph_grouped_agesex.R"))
source(here::here("functions", "graphs", "f_graph_survey_agesex.R"))
source(here::here("functions", "graphs", "f_graph_survey_sex.R"))

source(here::here("functions", "tables", "f_table_simple.R"))

source(here::here("functions", "tables", "f_table_grouped.R"))
source(here::here("functions", "tables", "f_table_survey_agesex.R"))
source(here::here("functions", "tables", "f_table_survey_sex.R"))

# ------------------------------------------------------------------------------
# LGA reference data
# ------------------------------------------------------------------------------
lphu_assign <- readxl::read_xlsx(file.path(root_folder, "Population Health Data/LPHU", "LPHU Classification.xlsx")) %>%
  dplyr::rename(lga_name_long = lga_name,
                lga_name      = lga_name_2) %>%
  #
  dplyr::mutate(lga_name      = stringr::str_to_title(lga_name),
                LGA_CODE_2021 = paste0("LGA", lga_id))

# ------------------------------------------------------------------------------
# Constants
# ------------------------------------------------------------------------------
# Age groups
age_group_lvl <- c("0-9 yrs", "10-19 yrs", "20-29 yrs", "30-39 yrs",
                   "40-49 yrs", "50-59 yrs", "60-69 yrs", "70-79 yrs",
                   "80-89 yrs", "90-99 yrs", "100+ yrs")

# LPHUs
lphu_names_short <- c("NEPHU", "SEPHU", "WPHU", "BSWPHU", "LMPHU",
                      "GPHU", "GWSMPHU", "GVPHU", "OMPHU")
 
lphu_names_long <- c("North Eastern", "South Eastern", "Western",
                     "Barwon South West", "Loddon Mallee",
                     "Gippsland", "Grampians Wimmera Southern Mallee",
                     "Goulburn Valley", "Ovens Murray")

# NEPHU geographies
nephu_lga <- nephu_lga.sf$lga_name
nephu_poa <- nephu_poa.sf$poa_code
nephu_sa2 <- nephu_sa2.sf$sa2_code
nephu_sal <- nephu_sal.sf$sal_name

# LGA labels to 'nudge' out of the way in maps
nudge_lga <- c("Boroondara", "Darebin", "Yarra", "Maroondah", "Banyule")

# IAREs
iare_names <- c("Craigieburn - Sunbury", "Knox", "Maroondah", "Melbourne - East",
                "Melbourne - North-East", "Melbourne - Port Phillip", 
                "Moreland - Broadmeadows", "Northcote - Preston - Whittlesea",
                "Whitehorse", "Yarra Ranges")

iare_short <- c("Craigieburn*", "Knox", "Maroondah", "East Melbourne",
                "North East Melbourne", "Port Phillip*", 
                "Broadmeadows*", "Northcote*",
                "Whitehorse", "Yarra Ranges")

iare_inc_vic_lvl <- c("Craigieburn - Sunbury", "Knox", "Maroondah", "Melbourne - East",
                      "Melbourne - North-East", "Melbourne - Port Phillip", 
                      "Moreland - Broadmeadows", "Northcote - Preston - Whittlesea",
                      "Whitehorse", "Yarra Ranges",
                      #
                      "Greater Melbourne", "Rest of Victoria", "Victoria")

# ------------------------------------------------------------------------------
# Colours
# ------------------------------------------------------------------------------
colour_burgundy   <- "#5C1441"
colour_darkblue   <- "#191D43"
colour_lightblue  <- "#374091"
colour_dodgerblue <- "#1C86EE"
colour_orange     <- "#D55E00"
colour_green      <- "#5BC788"
colour_yellow     <- "#F0E442"

colour_white      <- "white"
colour_black      <- "black"
colour_gray       <- "gray30"

colour_gradient_low  <- "#FFFF99"
colour_gradient_mid  <- "#41B6C4"
colour_gradient_high <- "#253494"

colour_table_light <- "#B5CEFA"
colour_table_mid   <- "#8FB6F5"
colour_table_dark  <- "#1C86EE"

