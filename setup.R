# NEPHU Population Profile - Aboriginal Health
# Author: Alana Little, NEPHU (alana.little@austin.org.au)
# Version 2.0, 15/08/2025

# General code that applies to all indicators
# - Packages and options
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
               tidyr,
               quarto,
               bsicons,
               rlang,
               glue,
               janitor,
               readxl,
               sf,
               knitr,
               kableExtra,
               colorRamps,
               extrafont,
               ggnewscale,
               plotly,
               leaflet)

options(knitr.kable.NA = '--')

# ------------------------------------------------------------------------------
# Data folders
# ------------------------------------------------------------------------------
root_folder <- str_extract(getwd(), "^.+Epidemiology")

# NEPHU map objects
load(file.path(root_folder, "Population Health Data/NEPHU Maps", "NEPHU_basemaps_sf.RData"))

# Convert from GRS80 to WGS84 coordinate system for leaflet maps
nephu_lga.sf <- st_transform(nephu_lga.sf, crs = 4326)
nephu_sa2.sf <- st_transform(nephu_sa2.sf, crs = 4326)

# ABS Census 2021
census_lga_data_subfolder <- "Population Health Data/ABS Census Population Housing 2021 (GCP)/Data/LGA/VIC"
census_sa2_data_subfolder <- "Population Health Data/ABS Census Population Housing 2021 (GCP)/Data/SA2/VIC"
tablebuilder_subfolder    <- "Population Health Data/ABS Census Population Housing 2021 (GCP)/Data/TableBuilder/Aboriginal"

# Other data sources
subfolder_birth       <- "Population Health Data/ABS Births and Mortality/Data/Raw data"
subfolder_cancer      <- "Population Health Data/VIC Cancer Registry/Data"
subfolder_coroner     <- "Population Health Data/VIC Coroners Court/Data"
subfolder_corrective  <- "Population Health Data/Corrective Services/Data"
subfolder_crime       <- "Population Health Data/Crime Statistics Agency/Data"
subfolder_ctg         <- "Population Health Data/Closing the Gap/Data"
subfolder_death       <- "Population Health Data/ABS Births and Mortality/Data/Raw data"
subfolder_framework   <- "Population Health Data/AIHW Aboriginal Health Performance Framework/Data"
subfolder_natsihs     <- "Population Health Data/ABS National Aboriginal Health Survey 2022-23/Data"
subfolder_phidu       <- "Population Health Data/PHIDU/Data"
subfolder_projections <- "Population Health Data/Population Projections/Data"
subfolder_protection  <- "Population Health Data/Child Protection/Data"
subfolder_screening   <- "Population Health Data/Cancer Screening Participation Data/Data"
subfolder_vcams       <- "Population Health Data/VCAMS/Data"

# ------------------------------------------------------------------------------
# Functions
# ------------------------------------------------------------------------------
source(here::here("functions", "data prep", "f_read_census.R"))
source(here::here("functions", "data prep", "f_read_ctg.R"))
source(here::here("functions", "data prep", "f_read_framework.R"))
source(here::here("functions", "data prep", "f_read_mortality.R"))
source(here::here("functions", "data prep", "f_read_naplan.R"))
source(here::here("functions", "data prep", "f_read_natsihs.R"))
source(here::here("functions", "data prep", "f_read_phess.R"))
source(here::here("functions", "data prep", "f_read_phidu.R"))
source(here::here("functions", "data prep", "f_read_vcsf.R"))

source(here::here("functions", "graphs", "f_bar_grouped.R"))
source(here::here("functions", "graphs", "f_bar_obsexp.R"))
source(here::here("functions", "graphs", "f_bar_simple.R"))
source(here::here("functions", "graphs", "f_bar_stacked.R"))
source(here::here("functions", "graphs", "f_line_grouped.R"))
source(here::here("functions", "graphs", "f_line_simple.R"))
source(here::here("functions", "graphs", "f_map_density.R"))
source(here::here("functions", "graphs", "f_pyramid.R"))

source(here::here("functions", "tables", "f_table_dataprep.R"))
source(here::here("functions", "tables", "f_table_grouped.R"))
source(here::here("functions", "tables", "f_table_obsexp.R"))
source(here::here("functions", "tables", "f_table_simple.R"))

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

# IAREs
iare_names <- c("Craigieburn/Sunbury", "Knox", "Maroondah", "Melbourne East",
                "Melbourne North-East", "Melbourne/Port Phillip", 
                "Moreland/Broadmeadows", "Northcote/Preston/Whittlesea",
                "Whitehorse", "Yarra Ranges")

iare_short <- c("Craigieburn*", "Knox", "Maroondah", "East Melbourne",
                "North East Melbourne", "Port Phillip*", 
                "Broadmeadows*", "Northcote*",
                "Whitehorse", "Yarra Ranges")

iare_inc_vic_lvl <- c("Craigieburn/Sunbury", "Knox", "Maroondah", "Melbourne East",
                      "Melbourne North-East", "Melbourne/Port Phillip", 
                      "Moreland/Broadmeadows", "Northcote/Preston/Whittlesea",
                      "Whitehorse", "Yarra Ranges",
                      #
                      "Greater Melbourne", "Rest of Victoria", "Victoria")

# Population counts for rate calculations
# Based on ABS Census 2021
population_vic_aboriginal    <- 65639
population_vic_nonaboriginal <- 6482401

population_nephu_aboriginal    <- 12065
population_nephu_nonaboriginal <- 1781207

# Maximum x-axis values for population pyramids
padding_female <- -26
padding_male   <- 26

# ------------------------------------------------------------------------------
# Colours
# ------------------------------------------------------------------------------
colour_white <- "white"
colour_black <- "black"
colour_gray  <- "#AFAFAF"

colour_simplebar  <- "#3856A7"
colour_simpleline <- "#3856A7"

colour_ctgtarget <- "#41B6C4"

colour_maplow  <- "#FFFF99"
colour_mapmid  <- "#41B6C4"
colour_maphigh <- "#253494"

colour_pyramidnephu <- "#B56734"
colour_pyramidvic   <- "#FDF3A8"

colour_aboriginal    <- "#3856A7"
colour_nonaboriginal <- "#CF998D"

colour_female <- "#3856A7"
colour_male   <- "#1C86EE"

colour_landmass <- "#D5E1BC"
colour_seaarea  <- "#3856A7"

colour_stack1    <- "#3856A7"
colour_stack2    <- "#D5E1BC"
colour_stack3    <- "#B56734"
colour_stack4    <- "#FDF3A8"
colour_stack5    <- "#CF998D"
colour_stack6    <- "#2E258D"
colour_stackgrey <- "#AFAFAF"

