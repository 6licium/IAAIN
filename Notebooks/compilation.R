
library("dplyr")
data <- read_excel("DataVdt.xlsx", sheet = "DataRetravaille", skip = 2)

data1 <- data %>%
  rename( "code" = "...2") 


data1 <- data1%>%
  filter (Taxon != "DB" ) 


data1 <- data1[ , -1]

data1 <- data1%>%
  select(-"Taxon")

data1 <- data1[ , !(names(data1) %in% "Taxon")]

data1 <- data1 %>%
  
  rename("Age" = "...4") %>%
  rename("Surface"= "...5")

data1 <- data1[ , !(names(data1) %in% "...43")]
data1 <- data1[ , !(names(data1) %in% "...44")]
data1 <- data1[ , !(names(data1) %in% "...45")]

data2 <- data1 %>%
  mutate(across(tail(names(.), 36), ~ ifelse(!is.na(.), 1, NA)))

data3 <- data2 %>%
  mutate(across(tail(names(.), 36), ~ ifelse(is.na(.), 0, .)))


data3 <- data3 %>%
  rename( "Code" = "code") 

data4 <- data3 %>%
  filter(!is.na(Code))

write.csv2(data4, "DataVdt_N.csv", row.names = F, fileEncoding = "latin1" )                

