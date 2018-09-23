## -------------------------------------------------------------------------
##       VISUALIZATIONS
## -------------------------------------------------------------------------

## -------------------------------------------------------------------------
##### 1. Import Libraries #####

install.packages("tidyverse")
library(tidyverse)

# set as working directory 
setwd("~/TFM/TFM_TurnOver_Ratio/1.visualizations")

##### 2. Loading Data #####

hr_data <- read.csv("data/HR_data_cleaned.csv",stringsAsFactors = FALSE)

## -------------------------------------------------------------------------
##### 3. Quick review of DataSet #####

str(hr_data)
head(hr_data)
summary(hr_data)

## -------------------------------------------------------------------------
##### 4. Analysis thought some visualization  #####

# salary range by Department
ggplot(hr_data,aes(x=salary, col=salary, fill=salary))+
  geom_bar(width = .7)+
  facet_grid(left~department)+
  theme(legend.position="right")+
  xlab("Salary level ")+ 
  ylab("Number of Employees")+
  ggtitle("Employees by Salary range")

