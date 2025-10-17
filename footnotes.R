# NEPHU Population Profile - Aboriginal Health
# Author: Alana Little, NEPHU (alana.little@austin.org.au)
# Version 2.0, 15/08/2025

# Footnotes used across multiple indicators/sections of report

# ------------------------------------------------------------------------------
# Data sources
# ------------------------------------------------------------------------------
note_data_census <- glue::glue("
- Data were obtained from the [ABS Census 2021](https://www.abs.gov.au/census) and are publicly available at Local Government Area (LGA), ABS Statistical Area Level 2 (SA2), and Indigenous Area of Residence (IARE) level.
  
  - The 2021 Census was held on the evening of August 10th 2021.
                                     
  - Aboriginal and/or Torres Strait Islander peoples were defined as those who identified themselves as Aboriginal and/or Torres Strait Islander in the Census.")

# ------------------------------------------------------------------------------
# Caveats and data notes
# ------------------------------------------------------------------------------
note_caveat_underidentification <- glue::glue("
- Reported counts and percentages are a likely underestimate due to under-identification.")

note_caveat_unknown_agesex <- glue::glue("
- People with an unknown or not stated age or sex have been excluded from age/sex breakdowns.")
