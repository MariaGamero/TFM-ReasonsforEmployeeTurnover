## -------------------------------------------------------------------------
##             TFM - REASONS FOR TURNOVER EMPLOYEES -
## -------------------------------------------------------------------------
##                 PART 1: VISUALIZATIONS
## -------------------------------------------------------------------------
##### 1. Import Libraries #####

if (!require("tidyverse")){
  install.packages("tidyverse")
  library("tidyverse")
}
if (!require("ggplot2")){
  install.packages("ggplot2")
  library("ggplot2")
}

# set as working directory 
setwd("~/TFM/TFM_TurnOver_Ratio/1.visualizations")

## -------------------------------------------------------------------------
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
hr_data$work_accident <-factor(hr_data$work_accident,levels=c(0,1),
                            labels=c("No Accident","Accident")) 


## -------------------------------------------------------------------------
##### 5. Analysis thought some visualization  #####

# Graph1: Salary by Department
  Employees_by_salary_range <- ggplot(hr_data,aes(x=salary, fill=salary))+
  geom_bar(width = .7)+
  facet_grid(left~department)+
  theme(legend.position="right")+
  xlab("Salary level ")+ ylab("Number of Employees")+
  ggtitle("Graph 1. Employees by salary range")+
  scale_fill_manual(values = c('orange1', 'lightblue1', 'darkblue'))+
  theme(axis.text.x = element_text(angle = 50, hjust = 1))

  #Saving
  ggsave("Employees_by_salary_range.jpg",width = 12, height = 8)

  #CONCLUSIONS:
  #Majority of employees who left either had low or medium salary.
  #Sales, Support and Technical were the areas with the highest number of people who left.
  #Barley employees with high salaries left the company.
  
#Graph 2: Distribution of Level of satisfaction
  Distribution_of_level_of_satisfaction <- ggplot(hr_data, aes(satisfaction_level)) +
  geom_histogram(fill = 'lightblue') +
  xlab('Satisfaction Level') +
  ylab('') +
  labs(title = 'Graph 2: Distribution of Level of satisfaction')

  #Saving
  ggsave("Distribution_of_level_of_satisfaction.jpg",width = 12, height = 8)
   

#Graph 3: Distribution of level of satisfaction by people who left vs. people who stay
  Distribution_of_level_of_satisfaction_people_who_left_or_stay<- ggplot(hr_data, aes(satisfaction_level)) +
  geom_density(aes(fill = left),alpha=0.5) +
  xlab('Satisfacion Level')+ ylab(' ')+
  labs(title = 'Graph 3: Level of satisfaction by type of employee')

  #Saving
  ggsave("Distribution_of_level_of_satisfaction_people_who_left_or_stay.jpg",width = 12, height = 8)
  

#Graph 4: Level of satisfaction by department
  Level_of_satisfaction_by_department<- ggplot(hr_data)+
  aes(x=department,y=satisfaction_level,col=department)+
  geom_boxplot()+
  ggtitle('Graph 4: Level of satisfaction by department')+
  ylab('satisfaction level')
  
  #Saving
  ggsave("Level_of_satisfaction_by_department.jpg",width = 12, height = 8)
  
# Graph 5: Time spend at the company
  Time_spent_at_the_company <- ggplot(hr_data,aes(x=time_spend_company,fill=left))+
  geom_bar(width = .7)+
  facet_grid(~left)+
  xlab("Years")+ ylab("Number of Employees")+
  ggtitle("Graph 5. Time spent at company")
  
  #Saving
  ggsave("Time_spent_at_the_company.jpg",width = 12, height = 8)
    
  #CONCLUSIONS:
  #Most people left the company after working among 2.5-5 years


#Graph 6: Distribution of Average monthly hours
    Average_monthly_hours_people_who_left_or_stay<- ggplot(hr_data, aes(average_montly_hours)) +
    geom_density(aes(fill = left),alpha=0.5) +
    xlab('Average monthly hours worked')+ ylab(' ')+
    labs(title = 'Graph 6: Average monthly hours by type of employee')
    
    #Saving
    ggsave("Average_monthly_hours.jpg",width = 12, height = 8)
    
    #CONCLUSIONS:
    #The employees that worked until 150 hours and also those who worked more than 250 hours, 
    #left the company more 
    
  
#Graph 7: Projects breakdown by type of employee
    Number_of_projects_by_type_of_employee <- ggplot(hr_data,aes(x=number_project,fill=left))+
    geom_bar(width = .7)+
    theme(legend.position="right")+
    xlab("Number of projects")+ ylab("Number of Employees")+
    ggtitle("Graph 7. Projects breakdown by type of employee")+
    theme(axis.text.x = element_text(angle = 50, hjust = 1))
    
    #Saving
    ggsave("Projects_breakdown_by_type_of_employee.jpg",width = 12, height = 8)

#Graph 8: Distribution of employees performance
    Distribution_of_employees_performance <- ggplot(hr_data,aes(x=last_evaluation))+
    geom_density(aes(fill = left),alpha=0.5)+
    theme(legend.position="right")+
    xlab("last evaluation")+ ylab("Number of Employees")+
    ggtitle("Graph 8. Distribution of employees performance")
    
    #Saving
    ggsave("Distribution_of_employees_performance.jpg",width = 12, height = 8)
    
    #CONCLUSIONS:
    #Those employees with a performance between 0.6 and 0.8  remained in the company.
    #However, both employees with performance greater than 0.8 and employees with performance below 0.6, 
    #tended to leave more of the company

    
    