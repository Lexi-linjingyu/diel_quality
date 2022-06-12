library(readr)
library(dplyr)
library(stringr)
library(tidyr)
library(naniar)
library(lubridate)

selectSet <- readr::read_csv(
  "F:/wangjinz/lexi/diel_quality/chinawater/selectSet.csv")

#### 1. data cleaning ####

# change data into numeric data
selectSet$NH4 <- as.numeric(selectSet$NH4)
selectSet$TN <- as.numeric(selectSet$TN)

# get rid of the first column and remove duplicated rows###
non_dup <- selectSet %>% 
  select(-...1) %>% 
  distinct() %>% 
  drop_na() 

#change data
non_dup$DATE <-ymd(non_dup$DATE) 
non_dup <- non_dup %>% 
  mutate(address = paste(PRO,NAME,sep = ""))
list <- split(non_dup,f = non_dup$address)
address <- data.frame(unique(non_dup$address))
names(address)[1] <- "address"
write_excel_csv(address,"address.csv")

#### 2. Add lon lat for each province ####
