# NEPHU Population Profile - Aboriginal Health
# Author: Alana Little, NEPHU (alana.little@austin.org.au)

# General notes and caveats for each topic

note_chapter_comparisons <- glue::glue("
- Comparisons between Aboriginal and/or Torres Strait Islanders and non-Indigenous people in this section are provided as a rough guide only and should be interpreted with caution. Where different data sources have been used to provide comparisons, data may not be directly comparable due to differences in data collection, geographical areas, definitions, and analysis methods between data sources.")

note_chapter_different_sources <- glue::glue("
- Different data sources (e.g. ABS Census 2021 and 2022-23 ABS National Aboriginal and Torres Strait Islander Health Survey) may include data on the same or similar topics. However, data from these different data sources should not be directly compared, as the people included in each data collection (e.g. inclusion and exclusion criteria, participation rates, and non-response rates), data collection methods (e.g. administrative data, online questionnaires, in-person interviews), and survey or data collection design (e.g. wording and interpretation of questions asked, definitions used) may differ substantially between different data sources.")

note_chapter_masking <- glue::glue("
- Organisations that release publicly available data employ techniques to manage the risk of reidentification of individuals included in these datasets.
  - Commonly used techniques for masking of small numbers include:
    - Suppression: all counts and percentages below a certain threshold, usually 5, are reported as <5. The true value could be any number between 0 and 5.
    - Pertubation: when counts or percentages below a certain threshold, usually 5, are present in a figure or table small, random adjustments are made to some or all of the values in the figure or table so that the overall totals remain accurate but individual values are masked.
  - For tables and figures where small numbers are reported, these small numbers should be interpreted with caution.
  - The column and/or row totals presented in a table or figure may not be equal to the sum of the values across the row or table.")

note_chapter_notifiable <- glue::glue("
- The data presented here are for notifications where Aboriginal and/or Torres Strait Islander status was known, and may not be representative of the true incidence or prevalence of these conditions among Aboriginal and/or Torres Strait Islander people.
  - The completeness of data on Aboriginal and/or Torres Strait Islander status varies across conditions and over time.
  - Aboriginal and/or Torres Strait Islander status can be ascertained during case follow-up through hospital discharge summaries, enhanced surveillance forms collected from GPs, or obtained from the case or their next of kin during case interview.
  - In recent years, data from the Australian Immunisation Register has been used as an additional data source for vaccine preventable disease notifications unless this is contradicted in any of the case paperwork.
  - The percentage of notifications signed out for case management and follow-up varies across conditions and has increased since the transition of case management and follow-up to Local Public Health Units during 2022-2023.
  - Data broken down by Aboriginal and/or Torres Strait Islander status are publicly available for a [selection of conditions at statewide level](https://www.health.vic.gov.au/infectious-diseases/aboriginal-and-torres-strait-islander-summary-state-wide-victoria), and additional data may be made available upon request to the Victorian Department of Health.")

note_chapter_obsexp <- glue::glue("
- The observed vs. expected charts and tables compare what we see in the data (the observed number) with what we would see if there was no gap or difference between Aboriginal and/or Torres Strait Islander people and non-Aboriginal and/or Torres Strait Islander people in each LGA or sex/age group (the expected number) for a particular indicator. These differences should be understood in the context of historical and ongoing impacts of colonisation, as well as social and structural factors that influence health and wellbeing.")

note_chapter_olderage <- glue::glue("
- Older Aboriginal and/or Torres Strait Islander people are defined as those aged 50 years and over, consistent with the [age range used by the Australian Institute of Health and Welfare](https://www.aihw.gov.au/reports/older-people/older-australians/contents/population-groups-of-interest/indigenous-australians). This reflects earlier onset of some health conditions and the broader impacts of social and structural determinants of health experienced by Aboriginal and Torres Strait Islander communities.")

note_chapter_underidentification <- glue::glue("
- When considering the total number of people who identify as Aboriginal and/or Torres Strait Islander, under-identification is a key consideration. The impact of this is that population numbers are likely to be underestimated, and the true population number is likely to be higher than what is reported here. This needs to be considered not only within this section but throughout this report, and has implications not only for population size, but also for any inferences about service requirements.")

