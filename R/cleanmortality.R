# import libraries
library("tidyr")
library("dplyr")
library("readr")
library("purrr")
library("countrycode")

# morts <- list(mat = list(maternalmortality, "matmor"), 
#               inf = list(infantmortality, "infmor"), 
#               neo = list(neonatalmortality, "neomort"), 
#               und = list(under5mortality, "under5mort"))

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

# create_mort_df <- function(mort_list){
#   for(i in 1:length(mort_list)){
#     
#   }
# }

new_morts <- list(new_infantmortality, new_maternalmortality, 
                  new_neonatalmortality, new_under5mortality)

full_data <- reduce(new_morts, full_join, 
                    by = c("Country.name", "year"))

full_data$ISO <- countrycode(full_data$Country.name,
                            origin = "country.name",
                            destination = "iso3c")

full_data %>% select(-c("Country.name"))
