# import libraries
library("tidyr")
library("dplyr")
library("readr")

# import data
dis <- read_csv("original/disaster.csv") 

colnames(dis)[7] <- "Disaster.type"

dis_sub <- filter(dis, Year %in% c(2000:2019), 
                  Disaster.type == "Earthquake" |
                  Disaster.type == "Drought"
                  ) %>%
           select(c("Year", "ISO", "Disaster.type"))

dis_sub$earthquake <- ifelse(dis_sub$Disaster.type == "Earthquake", 1, 0)
dis_sub$drought <- ifelse(dis_sub$Disaster.type == "Drought", 1, 0)

dis_sub<- dis_sub %>% select(-c("Disaster.type")) %>% 
  group_by(Year, ISO) %>% 
  summarize(earthquake = max(earthquake), 
            drought = max(drought))

