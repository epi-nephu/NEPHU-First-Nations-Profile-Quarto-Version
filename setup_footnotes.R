# NEPHU Population Profile - Aboriginal Health
# Author: Alana Little, NEPHU (alana.little@austin.org.au)
# Version 2.0, 15/08/2025

# Footnotes used across multiple indicators/sections of report

# ------------------------------------------------------------------------------
# Caveat boxes - data notes and caveats
# ------------------------------------------------------------------------------
note_box_comparisons <- glue::glue("
Comparisons between Aboriginal and/or Torres Strait Islanders and non-Indigenous people in this section are provided as a rough guide only and should be interpreted with caution. Where different data sources have been used to provide comparisons, data may not be directly comparable due to differences in data collection, geographical areas, definitions, and analysis methods between data sources.")

note_box_obsexp <- glue::glue("
The observed vs. expected charts and tables compare what we see in the data (the observed number) with what we would have seen if there was no gap or difference between Aboriginal and/or Torres Strait Islander people and non-Aboriginal and/or Torres Strait Islander people in each LGA or sex/age group (the expected number). If all things were truly equitable, then the observed and expected numbers within each LGA or within each sex/age group would be the same.")

note_box_olderage <- glue::glue("
Older Aboriginal and/or Torres Strait Islander people are defined as those aged 50 years and over. This is the [age range used by the Australian Institute of Health and Welfare](https://www.aihw.gov.au/reports/older-people/older-australians/contents/population-groups-of-interest/indigenous-australians), because Aboriginal and Torres Strait Islander people are more likely to develop serious medical conditions earlier in life and have a lower life expectancy than non-Indigenous Australians.")

note_box_underidentification <- glue::glue("
When considering the total number of people who identify as Aboriginal and/or Torres Strait Islander, under-identification is a key consideration. The impact of this is that population numbers are likely to be underestimated, and the true population number is likely to be higher than what is reported here. This needs to be considered not only within this section but throughout this report, and has implications not only for population size, but also for any inferences about service requirements.")

# ------------------------------------------------------------------------------
# Chart notes - data sources
# ------------------------------------------------------------------------------
note_data_census <- glue::glue("
- Data were obtained from the [ABS Census 2021](https://www.abs.gov.au/census) and are publicly available at Local Government Area (LGA), ABS Statistical Area Level 2 (SA2), and Indigenous Area of Residence (IARE) level.
  - The 2021 Census was held on the evening of August 10th 2021.
  - Aboriginal and/or Torres Strait Islander peoples were defined as those who identified themselves as Aboriginal and/or Torres Strait Islander in the Census.")

note_data_natsihs <- glue::glue("
- Data were obtained from the [2022-23 ABS National Aboriginal and Torres Strait Islander Health Survey](https://www.abs.gov.au/statistics/people/aboriginal-and-torres-strait-islander-peoples/national-aboriginal-and-torres-strait-islander-health-survey/latest-release).
  - The 2022-23 ABS National Aboriginal and Torres Strait Islander Health Survey collected information from Aboriginal and/or Torres Strait Islander people of all ages in non-remote and remote areas of Australia, including discrete Aboriginal and/or Torres Strait Islander communities.
  - Data were collected through face-to-face interviews with survey respondents or their parent/guardian.")

note_data_phidu_perinatal <- glue::glue("
- Data were obtained from the [PHIDU Social Health Atlas](https://phidu.torrens.edu.au/social-health-atlases), compiled from the [National Perinatal Data Collection (NPDC)](https://www.aihw.gov.au/about-our-data/our-data-collections/national-perinatal-data-collection).
  - The PHIDU Social Health Atlas is a compendium of demographic, social, health status, and health service utilisation indicators compiled by Torrens University Australia from a wide range of national, jurisdictional, and regional data sources.
  - The NPDC collates data about births reported by midwives and other birth attendants to the perinatal data collections in each state and territory in Australia.
  - Aboriginal and/or Torres Strait Islander mothers are defined as those who identified themselves as Aboriginal and/or Torres Strait Islander at the time of childbirth.
  - Data were aggregated for a three-year period (January 2019 to December 2021).")

note_data_phidu_vaed <- glue::glue("
- Data were obtained from the [PHIDU Social Health Atlas](https://phidu.torrens.edu.au/social-health-atlases), compiled from the [Victorian Admitted Episodes Dataset (VAED)](https://www.health.vic.gov.au/data-reporting/victorian-admitted-episodes-dataset).
  - The PHIDU Social Health Atlas is a compendium of demographic, social, health status, and health service utilisation indicators compiled by Torrens University Australia from a wide range of national, jurisdictional, and regional data sources.
  - The VAED includes data from all Victorian public and private hospitals, including rehabilitation centres, extended care facilities, and day procedure centres.
  - Aboriginal and/or Torres Strait Islander peoples were defined as those who identified themselves as Aboriginal and/or Torres Strait Islander at the time of their contact with the health service.
  - Data were aggregated for a four-year period (July 2017 to June 2021).")

note_data_phidu_vemd <- glue::glue("
- Data were obtained from the [PHIDU Social Health Atlas](https://phidu.torrens.edu.au/social-health-atlases), compiled from the [AIHW National Non-Admitted Patient Emergency Department Care Database (NNAPEDCD)](https://www.aihw.gov.au/reports/hospitals/non-admitted-patient-emergency-dept-care-nmds/summary).
  - The PHIDU Social Health Atlas is a compendium of demographic, social, health status, and health service utilisation indicators compiled by Torrens University Australia from a wide range of national, jurisdictional, and regional data sources.
  - The NNAPEDCD provides information on care provided to non-admitted patients in public hospital emergency departments in each state and territory in Australia. These departments must meet the following criteria:
    - A purposely designed and equipped area with designated assessment, treatment, and resuscitation areas,
    - The ability to provide resuscitation, stabilisation, and initial management of all emergencies,
    - Availability of medical staff in the hospital 24 hours a day,
    - Designated emergency department nursing staff 24 hours per day, 7 days per week, and
    - A designated emergency department nursing unit manager.
  - Aboriginal and/or Torres Strait Islander peoples were defined as those who identified themselves as Aboriginal and/or Torres Strait Islander at the time of their contact with the health service.")

# ------------------------------------------------------------------------------
# Chart notes - caveats
# ------------------------------------------------------------------------------
note_caveat_admissions <- glue::glue("
- Data were based on the number of separations, or completions of episodes of care for a patient in hospital.
  - The completion of an episode of care can be due to discharge from hospital, death, transfer to another hospital, or change in the type of care within the same hospital (e.g. from acute care to rehabilitation).
  - The data presented in this report relate to short-term episodes of care, and as a result the number of admissions will be similar to the number of separations in a given time period. The term 'admissions' has been used throughout this report.
  - Repeated admissions for the same person and transfers between hospitals were counted as separate admissions.")

note_caveat_dialysis_exclude <- glue::glue("
- Same day admissions for renal dialysis were excluded.")

note_caveat_household <- glue::glue("
- Households include both family and non-family households.")

note_caveat_iare_nephu <- glue::glue("
- IAREs that are partly or entirely within the NEPHU catchment include: Craigieburn/Sunbury (Craigieburn), Knox, Maroondah, Melbourne East (Melbourne (E)), Melbourne North-East (Melbourne (NE)), Melbourne/Port Phillip (Port Phillip), Moreland/Broadmeadows (Broadmeadows), Northcote/Preston/Whittlesea (Northcote), Whitehorse, and Yarra Ranges.")

note_caveat_iare_suppress <- glue::glue("
- IAREs marked with 'Data not available' or '--' have data suppressed due to small numbers.")

note_caveat_multipleresponse <- glue::glue("
- For survey or Census questions where respondents could select multiple options, counts or estimates may not sum to the total displayed and percentages may not sum to 100%.")

note_caveat_survey_agegroups <- glue::glue("
- Adults were defined as persons aged 18 years and over, and children were defined as people aged 2 to 17 years.")

note_caveat_survey_estimate <- glue::glue("
- Survey data do not represent exact numbers of people. As only a sample of people were surveyed, their results were converted into estimates for the entire population and/or reported as percentages. The total number of respondents may differ across different survey questions.")

note_caveat_survey_unknown <- glue::glue("
- Unknown, not applicable, and not stated survey responses have been excluded.")

note_caveat_rounding <- glue::glue("
- Counts may not sum to the total and percentages may not sum to 100 due to small cell suppression, data masking, and rounding.")

note_caveat_underidentification <- glue::glue("
- Reported counts and percentages are a likely underestimate due to under-identification.")

note_caveat_unknown_agesex <- glue::glue("
- People with an unknown or not stated age or sex have been excluded from age/sex breakdowns.")
