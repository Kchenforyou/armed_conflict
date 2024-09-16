# import libraries
library("tidyr")
library("dplyr")
library("readr")

# import data
dis <- read_csv("original/disaster.csv") 

# change col name
colnames(dis)[7] <- "Disaster.type"

# filter year and disaster type
dis_sub <- filter(dis, Year %in% c(2000:2019), 
                  Disaster.type == "Earthquake" |
                  Disaster.type == "Drought"
                  ) 

# subset for year,country, and disaster type
dis_sub <- select(dis_sub, c("Year", "ISO", "Disaster.type"))
           
# create dummy variables
dis_sub$earthquake <- ifelse(dis_sub$Disaster.type == "Earthquake", 1, 0)
dis_sub$drought <- ifelse(dis_sub$Disaster.type == "Drought", 1, 0)

# remove disaster.type column
dis_sub <- select(dis_sub, -c("Disaster.type")) 

# grouped dataframe by year and ISO (country)
dis_sub <- group_by(dis_sub, Year, ISO) 

# used summarize to remove duplicate countries in each year
dis_sub <- summarize(dis_sub, earthquake = max(earthquake), 
            drought = max(drought))

