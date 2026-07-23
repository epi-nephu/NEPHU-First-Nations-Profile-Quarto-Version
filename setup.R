# NEPHU Population Profile - Aboriginal Health
# Author: Alana Little, NEPHU (alana.little@austin.org.au)

# General code that applies to all indicators
# - Packages and options
# - Data folders
# - Data notes
# - Functions
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
               RColorBrewer,
               extrafont,
               ggnewscale,
               plotly,
               leaflet)

options(knitr.kable.NA = '--')

# ------------------------------------------------------------------------------
# Data folders
# ------------------------------------------------------------------------------
root_folder <- str_extract(getwd(), "^.+Epidemiology")

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
# Data notes
# ------------------------------------------------------------------------------
source(here::here("notes", "notes_chapter_caveats.R"))
source(here::here("notes", "notes_definitions_aboriginality.R"))
source(here::here("notes", "notes_definitions_other.R"))
source(here::here("notes", "notes_footnotes_caveats.R"))
source(here::here("notes", "notes_footnotes_data_sources.R"))

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
source(here::here("functions", "graphs", "f_map_simple.R"))
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
# Shape file data for maps
# ------------------------------------------------------------------------------
# NEPHU map objects
load(file.path(root_folder, "Population Health Data/NEPHU Maps", "NEPHU_basemaps_sf.RData"))

# All Victorian LGAs mapped to LPHUs
vic_lga.sf <- sf::st_read(here::here("Data/LGA_2022_AUST_GDA2020_SHP/LGA_2022_AUST_GDA2020.shp"),
                          quiet = TRUE) %>% 
  #
  dplyr::select(-STE_CODE21, 
                -AUS_CODE21, 
                -AUS_NAME21, 
                -LOCI_URI21,
                -LGA_NAME22) %>% 
  #
  dplyr::rename(lga_code   = LGA_CODE22,
                ste_name   = STE_NAME21,
                areasqkm   = AREASQKM,
                shp_length = SHAPE_Leng, 
                shp_area   = SHAPE_Area) %>% 
  #
  dplyr::mutate(lga_code = as.numeric(lga_code)) %>% 
  #
  dplyr::filter(ste_name == "Victoria" & lga_code < 29000) %>% 
  #
  dplyr::left_join(lphu_assign, by = c("lga_code" = "lga_id")) %>% 
  #
  dplyr::mutate(
    lphu_short = dplyr::case_when(
      lphu_short == "GPHU"    ~ "GRPHU",
      lphu_short == "GWSMPHU" ~ "GPHU",
      TRUE ~ as.character(lphu_short)),
    #
    lphu_long = dplyr::case_when(
      lphu_short == "NEPHU"  ~ "North Eastern",
      lphu_short == "SEPHU"  ~ "South Eastern",
      lphu_short == "WPHU"   ~ "Western",
      lphu_short == "BSWPHU" ~ "Barwon South West",
      lphu_short == "LMPHU"  ~ "Loddon Mallee",
      lphu_short == "GRPHU"  ~ "Gippsland",
      lphu_short == "GVPHU"  ~ "Goulburn Valley",
      lphu_short == "GPHU"   ~ "Grampians",
      lphu_short == "OMPHU"  ~ "Ovens Murray",
      TRUE ~ NA_character_))

# All Victorian IAREs
vic_iare.sf <- sf::st_read(here::here("Data/IARE_2021_AUST_GDA2020_SHP/IARE_2021_AUST_GDA2020.shp"),
                           quiet = TRUE) %>% 
  # 
  dplyr::select(iare_code   = IAR_CODE21,
                iare_name   = IAR_NAME21,
                region_name = IRE_NAME21,
                ste_name   = STE_NAME21,
                areasqkm   = AREASQKM21,
                shp_length = SHAPE_Leng, 
                shp_area   = SHAPE_Area,
                geometry) %>% 
  #
  dplyr::filter(ste_name == "Victoria" & iare_code < 29000) %>% 
  #
  dplyr::mutate(region_name = dplyr::case_when(
    region_name == "Melbourne" ~ "Greater Melbourne",
    TRUE ~ as.character(region_name)))

# Convert from GRS80 to WGS84 coordinate system for leaflet maps
nephu_lga.sf <- st_transform(nephu_lga.sf, crs = 4326)
nephu_sa2.sf <- st_transform(nephu_sa2.sf, crs = 4326)
vic_lga.sf   <- st_transform(vic_lga.sf, crs = 4326)
vic_iare.sf  <- st_transform(vic_iare.sf, crs = 4326)

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

# y-axis upper limits for counts
y_upper_n <- function(y_max){
  #
  dplyr::case_when(y_max <= 1     ~ 1.0025,
                   y_max <= 2.5   ~ 2.625,
                   y_max <= 5     ~ 5.125,
                   y_max <= 10    ~ (ceiling(y_max / 1) * 1) + (y_max * 0.025),
                   y_max <= 50    ~ (ceiling(y_max / 5) * 5) + (y_max * 0.025),
                   y_max <= 100   ~ (ceiling(y_max / 10) * 10) + (y_max * 0.025),
                   y_max <= 200   ~ (ceiling(y_max / 20) * 20) + (y_max * 0.025),
                   y_max <= 250   ~ (ceiling(y_max / 25) * 25) + (y_max * 0.025),
                   y_max <= 500   ~ (ceiling(y_max / 50) * 50) + (y_max * 0.025),
                   y_max <= 1000  ~ (ceiling(y_max / 100) * 100) + (y_max * 0.025),
                   y_max <= 2000  ~ (ceiling(y_max / 200) * 200) + (y_max * 0.025),
                   y_max <= 2500  ~ (ceiling(y_max / 250) * 250) + (y_max * 0.025),
                   y_max <= 5000  ~ (ceiling(y_max / 500) * 500) + (y_max * 0.025),
                   y_max <= 10000  ~ (ceiling(y_max / 1000) * 1000) + (y_max * 0.025),
                   y_max <= 15000 ~ (ceiling(y_max / 1500) * 1500) + (y_max * 0.025),
                   y_max <= 20000 ~ (ceiling(y_max / 2000) * 2000) + (y_max * 0.025),
                   y_max <= 25000 ~ (ceiling(y_max / 2500) * 2500) + (y_max * 0.025),
                   y_max <= 50000 ~ (ceiling(y_max / 5000) * 5000) + (y_max * 0.025),
                   TRUE ~ NA)

}

# y-axis upper limits for percentages
y_upper_prop <- function(y_max) {
  #
  dplyr::case_when(y_max <= 1   ~ 1.0025,
                   y_max <= 2.5 ~ 2.625,
                   y_max <= 5   ~ 5.25,
                   y_max <= 10  ~ (ceiling(y_max / 1) * 1) + (y_max * 0.025),
                   y_max <= 20  ~ (ceiling(y_max / 2) * 2) + (y_max * 0.025),
                   y_max <= 50  ~ (ceiling(y_max / 5) * 5) + (y_max * 0.025),
                   y_max <= 100 ~ (ceiling(y_max / 10) * 10) + (y_max * 0.025),
                   y_max > 100  ~ 102.5,
                   TRUE ~ NA)

}

# y-axis upper limits for rates
y_upper_rate <- function(y_max) {
  #
  dplyr::case_when(y_max <= 1      ~ 1.0025,
                   y_max <= 2.5    ~ 2.625,
                   y_max <= 5      ~ 5.25,
                   y_max <= 10     ~ (ceiling(y_max / 1) * 1) + (y_max * 0.025),
                   y_max <= 50     ~ (ceiling(y_max / 5) * 5) + (y_max * 0.025),
                   y_max <= 100    ~ (ceiling(y_max / 10) * 10) + (y_max * 0.025),
                   y_max <= 200    ~ (ceiling(y_max / 20) * 20) + (y_max * 0.025),
                   y_max <= 250    ~ (ceiling(y_max / 25) * 25) + (y_max * 0.025),
                   y_max <= 500    ~ (ceiling(y_max / 50) * 50) + (y_max * 0.025),
                   y_max <= 1000   ~ (ceiling(y_max / 100) * 100) + (y_max * 0.025),
                   y_max <= 2000   ~ (ceiling(y_max / 200) * 200) + (y_max * 0.025),
                   y_max <= 2500   ~ (ceiling(y_max / 250) * 250) + (y_max * 0.025),
                   y_max <= 5000   ~ (ceiling(y_max / 500) * 500) + (y_max * 0.025),
                   y_max <= 10000  ~ (ceiling(y_max / 1000) * 1000) + (y_max * 0.025),
                   y_max <= 15000  ~ (ceiling(y_max / 1500) * 1500) + (y_max * 0.025),
                   y_max <= 20000  ~ (ceiling(y_max / 2000) * 2000) + (y_max * 0.025),
                   y_max <= 25000  ~ (ceiling(y_max / 2500) * 2500) + (y_max * 0.025),
                   y_max <= 50000  ~ (ceiling(y_max / 5000) * 5000) + (y_max * 0.025),
                   y_max <= 100000 ~ (ceiling(y_max / 10000) * 10000) + (y_max * 0.025),
                   TRUE ~ NA)

}

# y-axis breaks
y_breaks <- function(y_max) {
  #
  dplyr::case_when(y_max <= 1      ~ 0.25,
                   y_max <= 2.5    ~ 0.5,
                   y_max <= 10     ~ 1,
                   y_max <= 20     ~ 2,
                   y_max <= 50     ~ 5,
                   y_max <= 100    ~ 10,
                   y_max <= 200    ~ 20,
                   y_max <= 250    ~ 25,
                   y_max <= 500    ~ 50,
                   y_max <= 1000   ~ 100,
                   y_max <= 2000   ~ 200,
                   y_max <= 2500   ~ 250,
                   y_max <= 5000   ~ 500,
                   y_max <= 10000  ~ 1000,
                   y_max <= 15000  ~ 1500,
                   y_max <= 20000  ~ 2000,
                   y_max <= 25000  ~ 2500,
                   y_max <= 50000  ~ 5000,
                   y_max <= 100000 ~ 10000,
                   TRUE ~ NA)

}

# ------------------------------------------------------------------------------
# Colours
# ------------------------------------------------------------------------------
colour_white <- "white"
colour_black <- "black"
colour_gray  <- "#E0E0E0"

colour_simplebar  <- "#3856A7"
colour_simpleline <- "#3856A7"

colour_ctgtarget <- "#57173F"

colour_maplow  <- "#FFFF99"
colour_mapmid  <- "#41B6C4"
colour_maphigh <- "#253494"

colour_pyramidnephu <- "#21372A"
colour_pyramidvic   <- "#426D6A"

colour_aboriginal    <- "#3856A7"
colour_nonaboriginal <- "#CF998D"

colour_female <- "#B56734"
colour_male   <- "#426D6A"

colour_landmass <- "#426D6A"
colour_seaarea  <- "#3856A7"

colour_stack1    <- "#3856A7"
colour_stack2    <- "#D5E1BC"
colour_stack3    <- "#B56734"
colour_stack4    <- "#FDF3A8"
colour_stack5    <- "#CF998D"
colour_stack6    <- "#2E258D"
colour_stackgrey <- "#E0E0E0"

