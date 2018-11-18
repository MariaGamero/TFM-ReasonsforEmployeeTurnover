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
##### 6. Model Segmentation RFM 12M  #####

#First of all, I need to change the scale, calculating the mean and standard deviation of the entire vector. 
#I am not changing the data, rather I am changing the scale (the axis values when plotting)

people_who_leaveScaled=scale(people_who_leave_numericos) 

#The result will be the dataset used to run the algorithm K-Means Clustering, a simple unsupervised machine 
#learning algorithm that groups a dataset into a user-specified number (k) of clusters.

#let´s try a random number of clusters:

NUM_CLUSTERS=1
set.seed(20) 
Modelo=kmeans(people_who_leaveScaled,NUM_CLUSTERS)

people_who_leave$Segmentos=Modelo$cluster
people_who_leave_numericos$Segmentos=Modelo$cluster

table(people_who_leave_numericos$Segmentos) #table of the counts at each combination of clusters
#A brief description of the cluster:
aggregate(people_who_leave_numericos, by = list(people_who_leave_numericos$Segmentos), mean)


NUM_CLUSTERS=2
set.seed(20) 
Modelo=kmeans(people_who_leaveScaled[, 1:2],NUM_CLUSTERS)

people_who_leave$Segmentos=Modelo$cluster
people_who_leave_numericos$Segmentos=Modelo$cluster

table(people_who_leave_numericos$Segmentos)
#A brief description of the clusters:
aggregate(people_who_leave_numericos, by = list(people_who_leave_numericos$Segmentos), mean)

NUM_CLUSTERS=8
set.seed(20) 
Modelo=kmeans(people_who_leaveScaled[, 1:2],NUM_CLUSTERS)

people_who_leave$Segmentos=Modelo$cluster
people_who_leave_numericos$Segmentos=Modelo$cluster

table(people_who_leave_numericos$Segmentos)
#A brief description of the clusters:
aggregate(people_who_leave_numericos, by = list(people_who_leave_numericos$Segmentos), mean)

## -------------------------------------------------------------------------
##### 7. Determine the optimal number of clusters (Elbow Method) #####

#One method to validate the number of clusters is the elbow method. 
#The goal is to choose a small value of "k" that still has a low sum of squared errors, 
#and the elbow usually represents where we start to have diminishing returns by increasing k.

Intra <- (nrow(people_who_leave_numericos)-1)*sum(apply(people_who_leave_numericos,2,var))
for (i in 2:15) Intra[i] <- sum(kmeans(people_who_leave_numericos, centers=i)$withinss)
plot(1:15, Intra, type="b", xlab="Numero de Clusters", ylab="Suma de Errores intragrupo")

#Graph shows that at k = 3 the elbow appears, indicating that 3 is the best number of clusters.

NUM_CLUSTERS=3
set.seed(20) 
Modelo=kmeans(people_who_leaveScaled[, 1:2],NUM_CLUSTERS)

people_who_leave$Segmentos=Modelo$cluster
people_who_leave_numericos$Segmentos=Modelo$cluster

table(people_who_leave_numericos$Segmentos)
#A brief description of the clusters:
aggregate(people_who_leave_numericos, by = list(people_who_leave_numericos$Segmentos), mean)


## -------------------------------------------------------------------------
##### 8. Visual Representation and conclusions #####

people_who_leave_numericos$Segmentos <- as.factor(people_who_leave_numericos$Segmentos)
Clusters <-factor(people_who_leave_numericos$Segmentos,levels=c(1,2,3),labels=c("1.Satisfied","2.Frustrated","3.Overworked")) 

ClusterGraph <- ggplot(people_who_leave_numericos, aes(satisfaction_level, last_evaluation, color = Clusters))+
  geom_point(size=2)+
  ggtitle("Graph 1. Cluster Analysis for employees who quit their jobs")

ClusterGraph 

#The graph shows 3 distinct clusters for employees who left the company:

  #1.High satisfaction level and high performance: people well valorated and valious for company. 
  #Company should focus on them and try to monitoring and manage their needs.
  #Reasons for leaving: probably they found a better job opportunity


  #2.Low satisfaction level and low performance. Reasons for leaving: Frustration. When employees underperform, a business 
  #can't operate at its full capabilities.It typically involves that employees are failing to perform the duties of their role or 
  #are failing to complete their duties to the level that the company expects of them. 
  #It will require HR talk to their employees in order to understand what is happening and found a solution to deal with the problem.  

  #3.Low satisfaction level and high performance: Company should focus on this group. 
  #Reasons for leaving: overworked. A heavy workload during a long period of time can be a source of stress. 
  #The company must also try to better understand this group of employees by offering, for example, more flexible forms of 
  #work that allow greater work-life balance for the employee  

#Saving
ggsave("ClusterGraph.jpg",width = 12, height = 8)

