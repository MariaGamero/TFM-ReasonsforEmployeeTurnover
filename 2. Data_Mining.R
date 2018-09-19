## -------------------------------------------------------------------------
##       PARTE 2: CLUSTERING kMEANS
## -------------------------------------------------------------------------

## -------------------------------------------------------------------------
##### 1. Import Libraries #####

if(!require("dummies")){
  install.packages("dummies")
  library("dummies")
}

# set as working directory 
setwd("~/TFM/TFM_TurnOver_Ratio")

##### 2. Loading Data #####

hr_data <- read.csv("data/HR_data_cleaned.csv",stringsAsFactors = FALSE)

## -------------------------------------------------------------------------
##### 3. Quick review of DataSet #####

str(hr_data)
head(hr_data)
summary(hr_data)

## -------------------------------------------------------------------------
##### 4. Tratamiento de las variables #####
hr_data_numericos=dummy.data.frame(hr_data, dummy.class="character" )


## -------------------------------------------------------------------------
##### 5. Determine the optimal number of clusters (Elbow Method) #####

#One method to validate the number of clusters is the elbow method. 
#The goal is to choose a small value of "k" that still has a low sum of squared errors, 
#and the elbow usually represents where we start to have diminishing returns by increasing k.

Intra <- (nrow(hr_data_numericos)-1)*sum(apply(hr_data_numericos,2,var))
for (i in 2:15) Intra[i] <- sum(kmeans(hr_data_numericos, centers=i)$withinss)
plot(1:15, Intra, type="b", xlab="Numero de Clusters", ylab="Suma de Errores intragrupo")

#As can be seen from the graph, at k = 3 the elbow appears, indicating that 3 is the best number of clusters.


## -------------------------------------------------------------------------
##### 5. Segmentation mediante Modelo RFM 12M  #####

hr_dataScaled=scale(hr_data_numericos)

#K-means is a simple unsupervised machine learning algorithm that groups a dataset 
#into a user-specified number (k) of clusters.

NUM_CLUSTERS=3
set.seed(1234)
Modelo=kmeans(hr_dataScaled,NUM_CLUSTERS)

hr_data$Segmentos=Modelo$cluster
hr_data_numericos$Segmentos=Modelo$cluster

table(hr_data_numericos$Segmentos)

aggregate(hr_data_numericos, by = list(hr_data_numericos$Segmentos), mean)



