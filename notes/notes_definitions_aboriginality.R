# NEPHU Population Profile - Aboriginal Health
# Author: Alana Little, NEPHU (alana.little@austin.org.au)

# Aboriginality definitions for each data source

note_aboriginality_aedc <- glue::glue("
In the Australian Early Development Census, Aboriginal and/or Torres Strait Islander children were defined as those who had been identified as Aboriginal and/or Torres Strait Islander by their parent or guardian.")

note_aboriginality_air <- glue::glue("
In the Australian Immunisation Register, Aboriginal and/or Torres Strait Islander peoples were defined as those recorded as Aboriginal and/or Torres Strait Islander based on their Medicare records or as recorded by an immunisation provider.")

note_aboriginality_bowel <- glue::glue("
For bowel screening data in the National Cancer Screening Register, Aboriginal and/or Torres Strait Islander peoples were defined using the Indigenous Status Ever Identified field which indicates if a screening participant has ever indicated that they were Aboriginal, Torres Strait Islander, or Aboriginal and Torres Strait Islander at the time of bowel screening.
  - Due to an increase in the number of participants with Indigenous Status Ever Identified when compared with earlier ad-hoc data requests the verification of Indigenous data accuracy is ongoing.")

note_aboriginality_breast <- glue::glue("
In BreastScreen Victoria data, Aboriginal and/or Torres Strait Islander peoples were defined as those who identified as Aboriginal, Torres Strait Islander, or Aboriginal and Torres Strait Islander at the time of breast screening.")

note_aboriginality_census <- glue::glue("
In the ABS Census, Aboriginal and/or Torres Strait Islander peoples were defined as those who had identified themselves as Aboriginal and/or Torres Strait Islander when they completed the Census.")

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

