## -------------------------------------------------------------------------
##             TFM - REASONS FOR TURNOVER EMPLOYEES -
## -------------------------------------------------------------------------
##                 PART 2: CLUSTER ANALYSIS
## -------------------------------------------------------------------------
##### 1. Import Libraries #####

if(!require("dummies")){
  install.packages("dummies")
  library("dummies")
}

library(dplyr)
library(ggplot2)

# set as working directory 
setwd("~/TFM/TFM_TurnOver_Ratio")

## -------------------------------------------------------------------------
##### 2. Loading Data #####

hr_data <- read.csv("data/HR_data_cleaned.csv",stringsAsFactors = FALSE)

## -------------------------------------------------------------------------
##### 3. Quick review of DataSet #####

str(hr_data)
head(hr_data)
summary(hr_data)

## -------------------------------------------------------------------------
##### 4. Filtering by employees who left #####

#Company is interested in knowing the type of employees who left the company
#in order to determine which are the most valuables and so, the ones it has to retain.

#Let´s start filtering by employees who left the company: 
people_who_leave <- hr_data %>% 
  filter(left==1)

#Now, I can extract the column "left" in the analysis.
people_who_leave <- people_who_leave[ ,!colnames(people_who_leave)=="left"]

#Quick review of this new DataSet
str(people_who_leave)
head(people_who_leave)
summary(people_who_leave)

## -------------------------------------------------------------------------
##### 5. Variables Treatment #####
people_who_leave_numericos=dummy.data.frame(people_who_leave, dummy.class="character" )


## -------------------------------------------------------------------------
##### 6. Determine the optimal number of clusters (Elbow Method) #####

#One method to validate the number of clusters is the elbow method. 
#The goal is to choose a small value of "k" that still has a low sum of squared errors, 
#and the elbow usually represents where we start to have diminishing returns by increasing k.

Intra <- (nrow(people_who_leave_numericos)-1)*sum(apply(people_who_leave_numericos,2,var))
for (i in 2:15) Intra[i] <- sum(kmeans(people_who_leave_numericos, centers=i)$withinss)
plot(1:15, Intra, type="b", xlab="Numero de Clusters", ylab="Suma de Errores intragrupo")

#Graph shows that at k = 3 the elbow appears, indicating that 3 is the best number of clusters.


## -------------------------------------------------------------------------
##### 7. Model Segmentation RFM 12M  #####

people_who_leaveScaled=scale(people_who_leave_numericos)

#K-means is a simple unsupervised machine learning algorithm that groups a dataset 
#into a user-specified number (k) of clusters.

NUM_CLUSTERS=3
set.seed(1234)
Modelo=kmeans(people_who_leaveScaled,NUM_CLUSTERS)

people_who_leave$Segmentos=Modelo$cluster
people_who_leave_numericos$Segmentos=Modelo$cluster

table(people_who_leave_numericos$Segmentos)

aggregate(people_who_leave_numericos, by = list(people_who_leave_numericos$Segmentos), mean)

## -------------------------------------------------------------------------
##### 7. Visual Representation and conclusions #####

ClusterGraph <- ggplot(people_who_leave_numericos,aes(x=satisfaction_level,y=last_evaluation,color=Segmentos))+
  geom_point(size=2)
ClusterGraph 

#The graph shows 3 distinct clusters for employees who left the company:

  #1.High satisfaction level and high performance: people well valorated and valious for company. 
  #Company should focus on them. Reasons for leaving: probably they found a better job opportunity


  #2.Low satisfaction level and low performance: company are not interested on them. Reasons for leaving: frustration. 
  #Probably they don´t feel well valorated for their jobs and that's why are not happy.

  #3.Low satisfaction level and high performance: Company should focus on this group. 
  #A heavy workload can be a source of stress. #Reasons for leaving: probably employees are overloaded.

#Saving
ggsave("ClusterGraph.jpg",width = 12, height = 8)


