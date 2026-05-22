# NEPHU Population Profile - Aboriginal Health
# Author: Alana Little, NEPHU (alana.little@austin.org.au)

# Data source information for footnotes

note_data_aedc <- glue::glue("
- Data were obtained from the [Closing the Gap Information Repository](https://www.pc.gov.au/closing-the-gap-data/), compiled from the [Australian Early Development Census (AEDC)](https://www.aedc.gov.au/).
  - The Closing the Gap Information Repository brings together data from a wide range of data sources to provide up to date information for each Closing the Gap target, indicator, and contextual factors.
  - The AEDC is a population-based measure of children’s development as they enter their first year of full-time school. It measures five important domains of early childhood development: physical health and wellbeing, social competence, emotional maturity, language and cognitive skills, and communication skills and general knowledge.
  - Aboriginal and/or Torres Strait Islander children were defined as those who were identified as Aboriginal and/or Torres Strait Islander by their parent or guardian.")

note_data_census <- glue::glue("
- Data were obtained from the [ABS Census 2021](https://www.abs.gov.au/census) and are publicly available at Local Government Area (LGA), ABS Statistical Area Level 2 (SA2), and Indigenous Area of Residence (IARE) level.
  - The 2021 Census was held on the evening of August 10th 2021.")

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
- Data were obtained from the [Aboriginal and Torres Strait Islander Social Health Atlas of Australia](https://phidu.torrens.edu.au/social-health-atlases), compiled from the [National Perinatal Data Collection (NPDC)](https://www.aihw.gov.au/about-our-data/our-data-collections/national-perinatal-data-collection).
  - The Aboriginal and Torres Strait Islander Social Health Atlas of Australia is a compendium of demographic, social, health status, and health service utilisation indicators compiled by Torrens University Australia from a wide range of national, jurisdictional, and regional data sources.
  - The NPDC collates data about births reported by midwives and other birth attendants to the perinatal data collections in each state and territory in Australia.
  - Data were aggregated for a three-year period (January 2019 to December 2021).")

note_data_phidu_vaed <- glue::glue("
- Data were obtained from the [Aboriginal and Torres Strait Islander Social Health Atlas of Australia](https://phidu.torrens.edu.au/social-health-atlases), compiled from the [Victorian Admitted Episodes Dataset (VAED)](https://www.health.vic.gov.au/data-reporting/victorian-admitted-episodes-dataset).
  - The Aboriginal and Torres Strait Islander Social Health Atlas of Australia is a compendium of demographic, social, health status, and health service utilisation indicators compiled by Torrens University Australia from a wide range of national, jurisdictional, and regional data sources.
  - The VAED includes data from all Victorian public and private hospitals, including rehabilitation centres, extended care facilities, and day procedure centres.
  - Aboriginal and/or Torres Strait Islander peoples were defined as those who identified themselves as Aboriginal and/or Torres Strait Islander at the time of their contact with the health service.
  - Data were aggregated for a four-year period (July 2017 to June 2021).")

note_data_phidu_vemd <- glue::glue("
- Data were obtained from the [Aboriginal and Torres Strait Islander Social Health Atlas of Australia](https://phidu.torrens.edu.au/social-health-atlases), compiled from the [AIHW National Non-Admitted Patient Emergency Department Care Database (NNAPEDCD)](https://www.aihw.gov.au/reports/hospitals/non-admitted-patient-emergency-dept-care-nmds/summary).
  - The Aboriginal and Torres Strait Islander Social Health Atlas of Australia is a compendium of demographic, social, health status, and health service utilisation indicators compiled by Torrens University Australia from a wide range of national, jurisdictional, and regional data sources.
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

