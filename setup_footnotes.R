# NEPHU Population Profile - Aboriginal Health
# Author: Alana Little, NEPHU (alana.little@austin.org.au)
# Version 2.0, 15/08/2025

# Footnotes used across multiple indicators/sections of report

# ------------------------------------------------------------------------------
# Caveat boxes - data notes and caveats
# ------------------------------------------------------------------------------
note_box_comparisons <- glue::glue("
Comparisons between Aboriginal and/or Torres Strait Islanders and non-Indigenous people in this section are provided as a rough guide only and should be interpreted with caution. Where different data sources have been used to provide comparisons, data may not be directly comparable due to differences in data collection, geographical areas, definitions, and analysis methods between data sources.")

note_box_different_sources <- glue::glue("
Different data sources (e.g. ABS Census 2021 and 2022-23 ABS National Aboriginal and Torres Strait Islander Health Survey) may include data on the same or similar topics. However, data from these different data sources should not be directly compared, as the people included in each data collection (e.g. inclusion and exclusion criteria, participation rates, and non-response rates), data collection methods (e.g. administrative data, online questionnaires, in-person interviews), and survey or data collection design (e.g. wording and interpretation of questions asked, definitions used) may differ substantially between different data sources.")

note_box_notifiable <- glue::glue("
The data presented here are for notifications where Aboriginal and/or Torres Strait Islander status was known. The completeness of data on Aboriginal and/or Torres Strait Islander status varies across conditions and over time, as the percentage of notifications signed out for case management and follow-up varies across conditions and has increased since the transition of case management and follow-up to Local Public Health Units during 2022-2023. Data broken down by Aboriginal and/or Torres Strait Islander status are publicly available for a [selection of conditions at statewide level](https://www.health.vic.gov.au/infectious-diseases/aboriginal-and-torres-strait-islander-summary-state-wide-victoria), and additional data may be made available upon request to the Victorian Department of Health.")

note_box_obsexp <- glue::glue("
The observed vs. expected charts and tables compare what we see in the data (the observed number) with what we would have seen if there was no gap or difference between Aboriginal and/or Torres Strait Islander people and non-Aboriginal and/or Torres Strait Islander people in each LGA or sex/age group (the expected number). If all things were truly equitable, then the observed and expected numbers within each LGA or within each sex/age group would be the same.")

note_box_olderage <- glue::glue("
Older Aboriginal and/or Torres Strait Islander people are defined as those aged 50 years and over. This is the [age range used by the Australian Institute of Health and Welfare](https://www.aihw.gov.au/reports/older-people/older-australians/contents/population-groups-of-interest/indigenous-australians), because Aboriginal and Torres Strait Islander people are more likely to develop serious medical conditions earlier in life and have a lower life expectancy than non-Indigenous Australians.")

note_box_underidentification <- glue::glue("
When considering the total number of people who identify as Aboriginal and/or Torres Strait Islander, under-identification is a key consideration. The impact of this is that population numbers are likely to be underestimated, and the true population number is likely to be higher than what is reported here. This needs to be considered not only within this section but throughout this report, and has implications not only for population size, but also for any inferences about service requirements.")

# ------------------------------------------------------------------------------
# Definitions
# ------------------------------------------------------------------------------
note_aboriginality_aedc <- glue::glue("
In the Australian Early Development Census, Aboriginal and/or Torres Strait Islander children were defined as those who had been identified as Aboriginal and/or Torres Strait Islander by their parent or guardian.")

note_aboriginality_air <- glue::glue("
In the Australian Immunisation Register, Aboriginal and/or Torres Strait Islander peoples were defined as those recorded as Aboriginal and/or Torres Strait Islander based on their Medicare records or as recorded by an immunisation provider.")

note_aboriginality_bowel <- glue::glue("
In the National Cancer Screening Register, Aboriginal and/or Torres Strait Islander peoples were defined based on the recording of Aboriginal and/or Torres Strait Islander status in the National Bowel Cancer Screening Program data.")

note_aboriginality_breast <- glue::glue("
In the BreastScreen Australia dataset, Aboriginal and/or Torres Strait Islander women were defined as those who had identified themselves as Aboriginal and/or Torres Strait Islander at the time of their breast screening appointment.")

note_aboriginality_census <- glue::glue("
In the ABS Census, Aboriginal and/or Torres Strait Islander peoples were defined as those who had identified themselves as Aboriginal and/or Torres Strait Islander when they completed the Census.")

note_aboriginality_cervical <- glue::glue("
In the National Cancer Screening Register, Aboriginal and/or Torres Strait Islander peoples were defined based on the recording of Aboriginal and/or Torres Strait Islander status in Medicare, pathology, or colposcopy records.")

note_aboriginality_childprotection <- glue::glue("
Aboriginal and/or Torres Strait Islander peoples were defined as those who were identified as such in the individual state and territory data collections that make up the AIHW Child Protection National Minimum Dataset.")

note_aboriginality_crime <- glue::glue("
Aboriginal and/or Torres Strait Islander status for affected family members and other parties was based on the most frequent recording of the Indigenous status for each person in the Law Enforcement Assistance Program (LEAP) database. If a person appeared in the database multiple times, the most frequently recorded response was taken as being correct.")

note_aboriginality_naplan <- glue::glue("
In NAPLAN, a student was classified as being of Aboriginal and/or Torres Strait Islander origin, based on information provided by the student, or their parent or guardian, on the school enrolment form.")

note_aboriginality_natsihs <- glue::glue("
In the National Aboriginal and Torres Strait Islander Health Survey, Aboriginal and/or Torres Strait Islander peoples were defined as those who had identified themselves as Aboriginal and/or Torres Strait Islander when they completed the survey.")

note_aboriginality_nececc <- glue::glue("
In the National Early Childhood Education and Care Collection (NECECC), Aboriginal and/or Torres Strait Islander children were defined as those who had been identified as Aboriginal and/or Torres Strait Islander by their parent or guardian.")

note_aboriginality_nhs <- glue::glue("
In the National Health Survey, Aboriginal and/or Torres Strait Islander peoples were defined as those who had identified themselves as Aboriginal and/or Torres Strait Islander when they completed the survey.")

note_aboriginality_perinatal <- glue::glue("
In the National Perinatal Data Collection, Aboriginal and/or Torres Strait Islander mothers were defined as those who had identified themselves as Aboriginal and/or Torres Strait Islander at the time of childbirth.")

note_aboriginality_prisoners <- glue::glue("
In the ABS Prisoners in Australia Dataset, Aboriginal and/or Torres Strait Islander peoples were defined as those who had identified themselves as Aboriginal and/or Torres Strait Islander at the time of their contact with a corrective service agency.")

note_aboriginality_reconciliation <- glue::glue("
In the Australian Reconciliation Barometer, Aboriginal and/or Torres Strait Islander peoples were defined as those who had identified themselves as Aboriginal and/or Torres Strait Islander when they completed the survey.")

note_aboriginality_vaed <- glue::glue("
In the Victorian Admitted Episodes Dataset, Aboriginal and/or Torres Strait Islander peoples were defined as those who had identified themselves as Aboriginal and/or Torres Strait Islander at the time of their contact with the health service.")

note_aboriginality_vcams <- glue::glue("
In the Victorian Adolescent and Child Monitoring System (VCAMS), Aboriginal and/or Torres Strait Islander children were defined as those who were recorded as Aboriginal and/or Torres Strait Islander in the datasets that comprise VCAMS. For preschool enrolments, these data were sourced from the [Kindergarten Information Management System](https://www.vic.gov.au/kims).")

note_aboriginality_vemd <- glue::glue("
In the AIHW National Non-Admitted Patient Emergency Department Care Database, Aboriginal and/or Torres Strait Islander peoples were defined as those who had identified themselves as Aboriginal and/or Torres Strait Islander at the time of their contact with the health service.")

note_aboriginality_youthjustice <- glue::glue("
In the AIHW Youth Justice National Minimum Dataset, Aboriginal and/or Torres Strait Islander peoples were defined as those who had identified themselves as Aboriginal and/or Torres Strait Islander at the time of their contact with the youth justice system.")

note_definition_survey_agegroups <- glue::glue("
Adults were defined as persons aged 18 years and over, and children were defined as people aged 2 to 17 years.")

# ------------------------------------------------------------------------------
# Chart notes - data sources
# ------------------------------------------------------------------------------
note_data_aedc <- glue::glue("
- Data were obtained from the [Closing the Gap Information Repository](https://www.pc.gov.au/closing-the-gap-data/), compiled from the [Australian Early Development Census (AEDC)](https://www.aedc.gov.au/).
  - The Closing the Gap Information Repository brings together data from a wide range of data sources to provide up to date information for each Closing the Gap target, indicator, and contextual factors.
  - The AEDC is a population-based measure of children’s development as they enter their first year of full-time school. It measures five important domains of early childhood development: physical health and wellbeing, social competence, emotional maturity, language and cognitive skills, and communication skills and general knowledge.
  - Aboriginal and/or Torres Strait Islander children were defined as those who were identified as Aboriginal and/or Torres Strait Islander by their parent or guardian.")

note_data_census <- glue::glue("
- Data were obtained from the [ABS Census 2021](https://www.abs.gov.au/census) and are publicly available at Local Government Area (LGA), ABS Statistical Area Level 2 (SA2), and Indigenous Area of Residence (IARE) level.
  - The 2021 Census was held on the evening of August 10th 2021.
  - Aboriginal and/or Torres Strait Islander peoples were defined as those who had identified themselves as Aboriginal and/or Torres Strait Islander in the Census.")

note_data_childprotection <- glue::glue("
- Data were obtained from the [AIHW Child Protection National Minimum Dataset](https://www.aihw.gov.au/about-our-data/our-data-collections/child-protection-national-minimum-data-set).
  - The AIHW Child Protection National Minimum Dataset includes information about children who come into contact with State and Territory departments responsible for child protection.
  - Aboriginal and/or Torres Strait Islander peoples were defined as those who are identified as such in the individual state and territory data collections that make up the AIHW Child Protection National Minimum Dataset.
  - Children were defined as persons aged 0-17 years.")

note_data_crime <- glue::glue("
- Data were obtained from the [Victorian Crime Statistics Agency](https://www.crimestatistics.vic.gov.au/crime-statistics/latest-aboriginal-crime-data/family-incidents-by-aboriginal-and-torres-strait).
  - The Victorian Crime Statistics Agency collates information about crimes reported to Victoria Police and recorded in the Law Enforcement Assistance Program (LEAP) database.
  - Aboriginal and/or Torres Strait Islander status for affected family members and other parties is based on the most frequent recording of the Indigenous status for each person in the LEAP database. If a person appears in the database multiple times, the most frequently recorded response is taken as being correct.")

note_data_ctg_nativetitle <- glue::glue("
- Data were obtained from the [Closing the Gap Information Repository](https://www.pc.gov.au/closing-the-gap-data/), compiled from the [National Native Title Tribunal Geospatial Data Model](https://www.nntt.gov.au/assistance/Geospatial/Pages/Spatial-aata.aspx).
  - The Closing the Gap Information Repository brings together data from a wide range of data sources to provide up to date information for each Closing the Gap target, indicator, and contextual factors.
  - The National Native Title Tribunal Geospatial Data Model brings together information about native title claimant applications, native title determinations, Indigenous estates, registered and notified Indigenous Land Use Agreements, and registered native title bodies corporate.")

note_data_framework_air <- glue::glue("
- Data were obtained from the [AIHW Aboriginal and Torres Strait Islander Health Performance Framework](https://www.indigenoushpf.gov.au/), compiled from the [Australian Immunisation Register (AIR)](https://www.servicesaustralia.gov.au/australian-immunisation-register).
  - The AIHW Aboriginal and Torres Strait Islander Health Performance Framework brings together information from a wide range of national, jurisdictional, and regional data sources to report on determinants of health, health outcomes, and health system performance for Aboriginal and/or Torres Strait Islander peoples.
  - The AIR records all vaccines given to people in Australia and includes vaccines given under the National Immunisation Program, through school programs, and privately (e.g. travel-related vaccines).
  - Aboriginal and/or Torres Strait Islander peoples were defined as those recorded as Aboriginal and/or Torres Strait Islander in the AIR based on their Medicare records or as recorded by an immunisation provider.")

note_data_framework_breastfed <- glue::glue("
- Data were obtained from the [AIHW Aboriginal and Torres Strait Islander Health Performance Framework](https://www.indigenoushpf.gov.au/), compiled from the [2018-19 ABS National Aboriginal and Torres Strait Islander Health Survey](https://www.abs.gov.au/statistics/people/aboriginal-and-torres-strait-islander-peoples/national-aboriginal-and-torres-strait-islander-health-survey/latest-release) and the [2017-18 ABS National Health Survey](https://www.abs.gov.au/statistics/health/health-conditions-and-risks/national-health-survey/latest-release).
  - The AIHW Aboriginal and Torres Strait Islander Health Performance Framework brings together information from a wide range of national, jurisdictional, and regional data sources to report on determinants of health, health outcomes, and health system performance for Aboriginal and/or Torres Strait Islander peoples.
  - The 2018-19 ABS National Aboriginal and Torres Strait Islander Health Survey collected information from Aboriginal and/or Torres Strait Islander people of all ages in non-remote and remote areas of Australia, including discrete Aboriginal and/or Torres Strait Islander communities. 
  - The 2017-18 ABS National Health Survey collected information from Australian residents of all ages living in private dwellings in both urban and rural areas of all Australian states and territories, including very remote communities and discrete Aboriginal and/or Torres Strait Islander communities.")

note_data_justice_adult <- glue::glue("
- Data were obtained from the [ABS Prisoners in Australia Dataset](https://www.abs.gov.au/statistics/people/crime-and-justice/prisoners-australia/latest-release).
  - The ABS Prisoners in Australia Dataset includes all persons remanded or sentenced to adult custodial corrective services agencies in each Australian state and territory.
  - Aboriginal and/or Torres Strait Islander peoples were defined as those who identified themselves as Aboriginal and/or Torres Strait Islander at the time of their contact with a corrective service agency.
  - Adults were defined as persons aged 18 years and over.")

note_data_justice_youth <- glue::glue("
- Data were obtained from the [AIHW Youth Justice National Minimum Dataset](https://www.aihw.gov.au/about-our-data/our-data-collections/youth-justice).
  - The AIHW Youth Justice National Minimum Dataset includes information about young people in Australia who were under youth justice supervision in each Australian state and territory.
  - Aboriginal and/or Torres Strait Islander peoples were defined as those who identified themselves as Aboriginal and/or Torres Strait Islander at the time of their contact with the youth justice system.
  - Young people were defined as persons aged 10-17 years.")

note_data_mortality <- glue::glue("
- Data were obtained from the ABS Technical Note [The impact of using multiple sources for deriving the Indigenous status of deaths in 2023](https://www.abs.gov.au/articles/technical-note-impact-using-multiple-sources-deriving-indigenous-status-deaths-2023-changes-victoria-and-coroner-referred-deaths).
  - The ABS has implemented an enhanced process for ascertaining Aboriginal and/or Torres Strait Islander status for deaths registered from 2023 onwards in Victoria.
  - This enhanced process assigns Aboriginal and/or Torres Strait Islander status based on data from three sources: the Death Registration Statement (completed by the person who notified the death, usually the funeral director or a family member), the Medical Certificate Cause of Death (for deaths that were certified by a doctor), and the National Coronial Information System (for deaths that were referred to the coroner).
  - If these data sources do not agree, identification on any source is usually given preference over recording the deceased as non-Indigenous.
  - Prior to 2023, Aboriginal and/or Torres Strait Islander status was assigned based on the Death Registration Statement only in Victoria. Data for 2023 onwards cannot be reliably compared to data from previous years.")

note_data_naplan <- glue::glue("
- Data were obtained from the [National Assessment Program — Literacy and Numeracy (NAPLAN) program](https://www.acara.edu.au/reporting/national-report-on-schooling-in-australia/naplan-national-results), administered by the Australian Curriculum, Assessment, and Reporting Authority (ACARA).
  - NAPLAN is a national assessment that tests students’ ability in three domains of literacy (reading, writing, and language conventions) and in numeracy. Students sit NAPLAN tests in Term 1 of Years 3, 5, 7, and 9.
  - Students with a language background other than English, who arrived from overseas less than a year before the tests, and those with significant disabilities may be exempted from NAPLAN testing.")

note_data_natsihs <- glue::glue("
- Data were obtained from the [2022-23 ABS National Aboriginal and Torres Strait Islander Health Survey](https://www.abs.gov.au/statistics/people/aboriginal-and-torres-strait-islander-peoples/national-aboriginal-and-torres-strait-islander-health-survey/latest-release).
  - The 2022-23 ABS National Aboriginal and Torres Strait Islander Health Survey collected information from Aboriginal and/or Torres Strait Islander people of all ages in non-remote and remote areas of Australia, including discrete Aboriginal and/or Torres Strait Islander communities.
  - Data were collected through face-to-face interviews with survey respondents or their parent/guardian.")

note_data_phess <- glue::glue("
- Data were obtained from the [Victorian Public Health Event Surveillance System (PHESS)](https://www.health.vic.gov.au/infectious-diseases/infectious-diseases-surveillance-in-victoria).
  - PHESS contains data on conditions that are legally required to be notified to the Victorian Department of Health by medical practitioners and pathology services (laboratories) under the *Public Health and Wellbeing Act 2008*.
  - Aboriginal and/or Torres Strait Islander peoples were defined based on the recording of Aboriginal and/or Torres Strait Islander status at the time of notification by a pathology service or medical practitioner or as determined during case management and follow-up by Local Public Health Units or the Victorian Department of Health.
  - Data presented here are for notifications where Aboriginal and/or Torres Strait Islander status was known. The completeness of data on Aboriginal and/or Torres Strait Islander status varies across conditions and over time, as the percentage of notifications signed out for case management and follow-up varies across conditions and has increased since the transition of case management and follow-up to Local Public Health Units during 2022-2023.
  - Data broken down by Aboriginal and/or Torres Strait Islander status are publicly available for a [selection of conditions at statewide level](https://www.health.vic.gov.au/infectious-diseases/aboriginal-and-torres-strait-islander-summary-state-wide-victoria). Additional data may be made available upon request to the Victorian Department of Health.")

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

note_data_reconciliation <- glue::glue("
- Data were obtained from the [Australian Reconciliation Barometer](https://www.reconciliation.org.au/reconciliation/australian-reconciliation-barometer/).
  - The Australian Reconciliation Barometer is a national survey undertaken every two years since 2008, and aims to measure the progress of reconciliation between Aboriginal and/or Torres Strait Islander and non-Indigenous peoples.
  - Aboriginal and/or Torres Strait Islander peoples were defined as those who self-identified as Aboriginal and/or Torres Strait Islander when completing the survey.")

note_data_tax <- glue::glue("
- Data were obtained from the [ABS Census 2021](https://www.abs.gov.au/census) linked to data from the Australian Taxation Office and Department of Social Services held in the [Person Level Integrated Data Asset (PLIDA)](https://www.abs.gov.au/about/data-services/data-integration/integrated-data/person-level-integrated-data-asset-plida). Data are publicly available at Local Government Area (LGA), ABS Statistical Area Level 2 (SA2), and Indigenous Area of Residence (IARE) level.
  - PLIDA is a secure linked data asset maintained by the ABS that brings together information on health, education, government payments, income and taxation, employment, and population demographics.
  - The 2021 Census was held on the evening of August 10th 2021.
  - Aboriginal and/or Torres Strait Islander peoples were defined as those who had identified themselves as Aboriginal and/or Torres Strait Islander in the Census.")

note_data_vcsf <- glue::glue("
- Data were obtained from the [Victorian Cancer Screening Framework (VCSF)](https://acpcc.org.au/services/population-health/), maintained by the Australian Centre for the Prevention of Cervical Cancer (ACPCC).
  - The VCSF collates data from the [National Cancer Screening Register](https://www.ncsr.gov.au/) (cervical and bowel screening) and [BreastScreen Victoria](https://www.breastscreen.org.au/) in order to monitor and improve prevention and early detection of breast, bowel, and cervical cancers in Victoria, particularly among priority communities.
  - Aboriginal and/or Torres Strait Islander peoples were defined based on the recording of Aboriginal and/or Torres Strait Islander status in the individual datasets that make up the VCSF.
  - Data broken down by Aboriginal and/or Torres Strait Islander status are not publicly available on the VCSF website but can be requested from the ACPCC.")

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

