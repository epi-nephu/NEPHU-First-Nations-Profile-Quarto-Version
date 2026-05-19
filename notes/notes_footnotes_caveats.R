# NEPHU Population Profile - Aboriginal Health
# Author: Alana Little, NEPHU (alana.little@austin.org.au)

# Caveats and data notes for footnotes

note_caveat_admissions <- glue::glue("
- Data were based on the number of separations, or completions of episodes of care for a patient in hospital.
  - The completion of an episode of care can be due to discharge from hospital, death, transfer to another hospital, or change in the type of care within the same hospital (e.g. from acute care to rehabilitation).
  - The data presented in this report relate to short-term episodes of care, and as a result the number of admissions will be similar to the number of separations in a given time period. The term 'admissions' has been used throughout this report.
  - Repeated admissions for the same person and transfers between hospitals were counted as separate admissions.")

note_caveat_dialysis_exclude <- glue::glue("
- Same day admissions for renal dialysis were excluded.")

note_caveat_iare_nephu <- glue::glue("
- IAREs that are partly or entirely within the NEPHU catchment include: Craigieburn/Sunbury (Craigieburn), Knox, Maroondah, Melbourne East (Melbourne (E)), Melbourne North-East (Melbourne (NE)), Melbourne/Port Phillip (Port Phillip), Moreland/Broadmeadows (Broadmeadows), Northcote/Preston/Whittlesea (Northcote), Whitehorse, and Yarra Ranges.")

note_caveat_iare_ratio <- glue::glue("
- The standardised ratio compares the age-standardised rate in each IARE (the observed value) with the age-standardised rate for Greater Melbourne (the expected value).
  - A ratio of 100 indicates that there is no difference between the IARE and Greater Melbourne overall.
  - A ratio above 100 indicates a higher than expected rate compared with Greater Melbourne.
  - A ratio below 100 indicates a lower than expected rate compared with Greater Melbourne.")

note_caveat_iare_suppress <- glue::glue("
- IAREs marked with 'Data not available' or '--' have data suppressed due to small numbers.")

note_caveat_multipleresponse <- glue::glue("
- For survey or Census questions where respondents could select multiple options, counts or estimates may not sum to the total displayed and percentages may not sum to 100%.")

note_caveat_notification_rate <- glue::glue("
- Notification rates were calculated as the crude rate per 100,000 population, based on population data from the ABS Census 2021.")

note_caveat_pandemic_decrease <- glue::glue("
- The public health measures implemented during the COVID-19 pandemic impacted the epidemiology of many notifiable conditions, with lower than expected numbers of notifications seen for many conditions during the pandemic.")

note_caveat_pandemic_screening <- glue::glue("
- The COVID-19 pandemic affected the availability of screening services and health seeking behaviours, which may have had an impact on screening participation.")

note_caveat_survey_estimate <- glue::glue("
- Survey data do not represent exact numbers of people. As only a sample of people were surveyed, their results were converted into estimates for the entire population and/or reported as percentages. The total number of respondents may differ across different survey questions.")

note_caveat_survey_unknown <- glue::glue("
- Unknown, not applicable, and not stated survey responses have been excluded.")

note_caveat_rounding <- glue::glue("
- Counts may not sum to the total and percentages may not sum to 100 due to small cell suppression, data masking, and rounding.")

note_caveat_underidentification <- glue::glue("
- Reported counts and percentages are a likely underestimate of the true population value due to variable reporting of Aboriginal and/or Torres Strait Islander status and the likely under-identification of Aboriginal and/or Torres Strait Islander people in the data source for this indicator.")

note_caveat_unknown_agesex <- glue::glue("
- People with an unknown or not stated age and/or sex have been excluded from age/sex breakdowns.")

