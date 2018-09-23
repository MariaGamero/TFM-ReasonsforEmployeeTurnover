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
##### 4. Variables treatment  #####

hr_data$left <- as.factor(hr_data$left)
hr_data$left <- factor(hr_data$left,levels=c(0,1),
                       labels=c("People who stay","People who left"))

hr_data$promotion_last_5years <- as.factor(hr_data$promotion_last_5years)
hr_data$promotion_last_5years <- factor(hr_data$promotion_last_5years,levels=c(0,1),
                         labels=c("Not Promoted","Promoted")) 

hr_data$work_accident <- as.factor(hr_data$work_accident)
hr_data$work_accident <-factor(work_accident,levels=c(0,1),
                            labels=c("No Accident","Accident")) 

## -------------------------------------------------------------------------
##### 5. Analysis thought some visualization  #####

# Graph1: Salary by Department
salary_by_department <- ggplot(hr_data,aes(x=salary, fill=salary))+
  geom_bar(width = .7)+
  facet_grid(left~department)+
  theme(legend.position="right")+
  xlab("Salary level ")+ ylab("Number of Employees")+
  ggtitle("Graph 1. Employees by salary range")+
  scale_fill_manual(values = c('orange1', 'lightblue1', 'darkblue'))+
  theme(axis.text.x = element_text(angle = 50, hjust = 1))

  #Saving
  ggsave("salary_by_department.jpg",width = 12, height = 8)

#Graph 2: Distribution of Level of satisfaction
ggplot(hr_data, aes(satisfaction_level)) +
  geom_histogram(fill = 'lightblue') +
  xlab('Nivel de Satisfacción') +
  ylab('') +
  labs(title = 'Graph 2: Distribution of Level of satisfaction')

#Graph 3: Level of satisfaction by salary
ggplot(hr_data, aes(satisfaction_level)) +
  geom_histogram(aes(fill = salary)) +
  xlab('Nivel de Satisfacción')+ ylab(' ')+
  scale_fill_manual(values = c('orange1', 'lightblue1', 'darkblue'))+
  labs(title = 'Graph 4: Level of satisfaction by salary')


#Graph 4: Level of satisfaction by people who left vs. people who stay
ggplot(hr_data, aes(satisfaction_level)) +
  geom_histogram(aes(fill = left)) +
  xlab('Nivel de Satisfacción')+ ylab(' ')+
  scale_fill_manual(values = c('aquamarine2', 'blue3'))+
  labs(title = 'Graph 4: Level of satisfaction by salary')


#Graph 5: Level of satisfaction by department
ggplot(hr_data)+
  aes(x=department,y=satisfaction_level,col=department)+
  geom_boxplot()+
  ggtitle('Graph 5: Level of satisfaction by department')+
  ylab('satisfaction level')


