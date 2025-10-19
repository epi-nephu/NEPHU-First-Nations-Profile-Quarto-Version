# NEPHU Population Profile - Aboriginal Health
# Author: Alana Little, NEPHU (alana.little@austin.org.au)
# Version 2.0, 15/08/2025

# Footnotes used across multiple indicators/sections of report

# ------------------------------------------------------------------------------
# Consultation boxes - data notes and caveats
# ------------------------------------------------------------------------------
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

# ------------------------------------------------------------------------------
# Chart notes - caveats
# ------------------------------------------------------------------------------
note_caveat_underidentification <- glue::glue("
- Reported counts and percentages are a likely underestimate due to under-identification.")

note_caveat_unknown_agesex <- glue::glue("
- People with an unknown or not stated age or sex have been excluded from age/sex breakdowns.")
