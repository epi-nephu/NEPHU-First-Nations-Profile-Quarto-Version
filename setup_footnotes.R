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

note_data_ctg_aedc <- glue::glue("
- Data were obtained from the [Closing the Gap Information Repository](https://www.pc.gov.au/closing-the-gap-data/), compiled from the [2021 Australian Early Development Census (AEDC)](https://www.aedc.gov.au/).
  - The Closing the Gap Information Repository brings together data from a wide range of data sources to provide up to date information for each Closing the Gap target, indicator, and contextual factors.
  - The AEDC is a population-based measure of children’s development as they enter their first year of full-time school. It measures five important domains of early childhood development: physical health and wellbeing, social competence, emotional maturity, language and cognitive skills, and communication skills and general knowledge.
  - Aboriginal and/or Torres Strait Islander children were defined as those who were identified as Aboriginal and/or Torres Strait Islander by their parent or guardian.")

note_data_naplan <- glue::glue("
- Data were obtained from the [National Assessment Program — Literacy and Numeracy (NAPLAN) program](https://www.acara.edu.au/reporting/national-report-on-schooling-in-australia/naplan-national-results), administered by the Australian Curriculum, Assessment, and Reporting Authority (ACARA).
  - NAPLAN is a national assessment that tests students’ ability in three domains of literacy (reading, writing, and language conventions) and in numeracy. Students sit NAPLAN tests in Term 1 of Years 3, 5, 7, and 9.
  - Students with a language background other than English, who arrived from overseas less than a year before the tests, and those with significant disabilities may be exempted from NAPLAN testing.
  - The NAPLAN proficiencies include four levels for each assessment area at each year level:
    - Exceeding: the student’s result exceeds expectations at the time of testing.
    - Strong: the student’s result meets challenging but reasonable expectations at the time of testing.
    - Developing: the student’s result indicates that they are working towards expectations at the time of testing.
    - Needs additional support: the student’s result indicates that they are not achieving the learning outcomes expected at the time of testing. They are likely to need additional support to progress satisfactorily.")

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

# ------------------------------------------------------------------------------
# Chart notes - caveats
# ------------------------------------------------------------------------------
note_caveat_household <- glue::glue("
- Households include both family and non-family households.")

note_caveat_iare_nephu <- glue::glue("
- IAREs that are partly or entirely within the NEPHU catchment include: Craigieburn/Sunbury (Craigieburn), Knox, Maroondah, Melbourne East (Melbourne (E)), Melbourne North-East (Melbourne (NE)), Melbourne/Port Phillip (Port Phillip), Moreland/Broadmeadows (Broadmeadows), Northcote/Preston/Whittlesea (Northcote), Whitehorse, and Yarra Ranges.")

note_caveat_iare_suppress <- glue::glue("
- IAREs marked with 'Data not available' or '--' have data suppressed due to small numbers.")

note_caveat_multipleresponse <- glue::glue("
- Totals may not sum to 100% as respondents could select multiple options.")

note_caveat_survey_estimate <- glue::glue("
- Survey data do not represent exact numbers of people. As only a sample of people were surveyed, their results were converted into estimates for the entire population and/or reported as percentages.")

note_caveat_survey_unknown <- glue::glue("
- Unknown, not applicable, and not stated survey responses have been excluded.")

note_caveat_rounding <- glue::glue("
- Counts may not sum to the total and percentages may not sum to 100 due to small cell suppression, data masking, and rounding.")

note_caveat_underidentification <- glue::glue("
- Reported counts and percentages are a likely underestimate due to under-identification.")

note_caveat_unknown_agesex <- glue::glue("
- People with an unknown or not stated age or sex have been excluded from age/sex breakdowns.")
