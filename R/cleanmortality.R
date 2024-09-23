# import libraries
library("tidyr")
library("dplyr")
library("readr")
library("purrr")
library("countrycode")

clean_mortality <- function(file, people){
  # import data
  mort <- file
  
  # pivot table
  mort_sub <- select(mort, c("Country Name", "2000":"2019")) %>% 
    pivot_longer(cols = "2000":"2019")
  
  # change col names
  colnames(mort_sub) <- c("Country.name", "year", people)
  
  # force year as integers
  mort_sub$year <- as.numeric(mort_sub$year)
  
  return(mort_sub)
}

new_infantmortality <- clean_mortality(
  maternalmortality <- read_csv("original/maternalmortality.csv"),
  "matmor")
new_maternalmortality <- clean_mortality(
  infantmortality <- read_csv("original/infantmortality.csv"),
  "infmor")
new_neonatalmortality <- clean_mortality(
  neonatalmortality <- read_csv("original/neonatalmortality.csv"),
  "neomor")
new_under5mortality <- clean_mortality(
  under5mortality <- read_csv("original/under5mortality.csv"),
  "under5mor")

new_morts <- list(new_infantmortality, new_maternalmortality,
                  new_neonatalmortality, new_under5mortality)

full_data <- reduce(new_morts, full_join, 
                    by = c("Country.name", "year"))

full_data$ISO <- countrycode(full_data$Country.name,
                            origin = "country.name",
                            destination = "iso3c")

full_data <- full_data %>% select(-c("Country.name"))
