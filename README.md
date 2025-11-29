Health Facility Sample Generator (R Automation)

This project automates the creation of HTML sample files for health facilities based on their Site Visit IDs.

The script:
- Reads data from Excel
- Splits the data by Site_Visit_ID
- Generates clean HTML tables using kableExtra
- Applies custom CSS styling
- Saves separate HTML files for each facility using dynamic file names

Technologies Used
- R
- tidyverse (dplyr)
- readxl
- kableExtra
- htmltools

How It Works
Load the Excel dataset
Identify unique Site Visit IDs
Create a filtered dataset for each ID
Convert the dataset to a styled HTML table
Save each table as a standalone HTML file
