library(readxl)
library(dplyr)
library(kableExtra)
library(htmltools)

# 1) Read file into a data frame called 'samples'
setwd("C:/Users/Dell/Downloads/Patient Sample Script")
samples <- read_excel("HER pat sampling23_11_25.xlsx")

# 2) Create folder for HTML files
dir.create("Generated Samples", showWarnings = FALSE)

# 3) All unique Site_Visit_IDs
site_ids <- unique(samples$Site_Visit_ID)

# 4) Loop
for (id in site_ids) {
  
  # Filter for this Site_Visit_ID
  df_site <- samples %>% filter(Site_Visit_ID == id)
  
  # Create HTML table
  tbl <- df_site %>%
    kable(format = "html",
          table.attr = 'class="waffle" cellspacing="0" cellpadding="0"') %>%
    kable_styling(full_width = FALSE)
  
  # Build HTML page
  html_page <- tags$html(
    tags$head(
      tags$title(paste("Site Visit ID", id)),
      tags$style(HTML("
        table.waffle {
          border-collapse: collapse;
          margin: auto;
          font-family: Calibri, Arial, sans-serif;
          font-size: 11pt;
        }
        table.waffle th, table.waffle td {
          border: 1px solid #000000;
          padding: 2px 3px;
          text-align: center;
          white-space: nowrap;
        }
        table.waffle thead th {
          background-color: #46bdc6;
          color: #ffffff;
          font-size: 10pt;
        }
      "))
    ),
    tags$body(
      tags$h2(paste("Site Visit ID:", id)),
      HTML(tbl)
    )
  )
  
  # Save file using FullProvince_FullHealthFacilityName.html
  prov  <- df_site$Province[1]
  hf    <- df_site$`Health Facility Name`[1]
  
  prov_clean <- gsub("[^A-Za-z0-9]+", "_", prov)
  hf_clean   <- gsub("[^A-Za-z0-9]+", "_", hf)
  
  file_name <- paste0(prov_clean, "_", hf_clean, ".html")
  
  save_html(html_page,
            file = file.path("Generated Samples", file_name))
}

