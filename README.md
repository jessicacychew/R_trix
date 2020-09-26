# R_trix
Little R tricks


#############Example package to pivot long a dataframe###############


install.packages("tidyverse")
library(tidyverse)
install.packages("readxl")
library("readxl")
#install.packages("tidyr")
library("tidyr")
install.packages("writexl")
library("writexl")

##Below is the sample UBI pilot list. It was in a sparse data format initially, but I want to get it into long form to create a log. 

df <- read_excel("C://Users//JXC6ZGR//Downloads//to_transform.xlsx") #read in the Excel

df1 <- pivot_longer(df, 2:40, "Outcomes_Measured" ) #Do the transformation
df2 <- df1 %>% filter(value == 1) #Filter the dataframe to just those projects that measure that particular outcome
df3 <- df2 %>% select (-value) #Remove the now extraneous extra column

write_xlsx(df3, path = "C://Users//JXC6ZGR//Downloads//transformed.xlsx" ) #Export the transofrmed dataframe back out Excel

##################################################################
