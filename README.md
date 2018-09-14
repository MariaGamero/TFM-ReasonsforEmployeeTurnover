# Why People Really Quit Their Jobs? 

### Master's End Project in KSchool - VII Edition - 
#### by María Gamero

# Study purpose

It is said that one of the most valuable assets for companies is human capital.  In a moment of recovery of markets and employment, companies are challenged to capture talent but also to know how to retain it and motivate it. 

The reasons for leaving a job can be many and vary according to different factors such as age, profession, country, etc. In order to avoid highly talented individuals quit their jobs, many companies spend a great amount of time and also money investigating the causes of employee turnover. 

The project will be addressed to analize and understand in detail: 

 - #### **Which are the features of the employees who leave the company**
 - #### **From the point of view of the company, detect which are the employees the company is interested in retaining**
 - #### **Using machine learning tools, try to predict whether the employee will leave the company or not**

# Personal Motivation
I have always been interested in themes related to human relations so, I have done my best to be able to address it in this project. Although it has not been easy to find HR information the truth is that I feel confortable with the dataset and also very excited. 

# Data Description
For HR analysis it will use a popular dataset called: "HR_comma_sep.csv". From now on : "HR_data_origin.csv". 

Raw size: 14999 rows and 10 columns

## Brief description of columns in DataSet:

- **Satisfaction_level** : Level of satisfaction on the employee. It has a rather subjective character and should be strongly correlated with the fact of leaving or not the company.

- **Last_evaluation**: Column can be used to evaluate the performance of an employee. The data ranges from 0–1, 0 being low performance and 1 being the highest.

- **Number_projects**: number of projects employees done.

- **average_montly_hours**: average monthly hours per employee.

- **time_spend_company**: The data ranges from 1 to 10. Data unit not specified.

- **Work_accident**: Whether the employee had a workplace accident,: 1 yes, 0 no.

- **left**: Whether the employee has left or not the company: 1 yes, 0 no.

- **promotion_last_5years**: Whether the employee has had a promotion in the last 5 years.

- **Sales**: It seems to indicate the different areas or departments the employees belong: Sales, Technical, Support, IT, Product Managment, Marketing ,Accounting, Human Resources, Managment and Others.

- **Salary**: Salary level classified by Low, Medium, High.


# The study case is divided as follows:

## 1. Load the dataset, scrub and explore the data by making some basic visualizations 
To understand the information included in the dataset and be sure that I am working with cleaned data — data that is organized, complete, recent, and generally high quality.

- _Programming languaje_: Python

## 2. Headcount segmentation:
The aim is to segregate groups with similar traits and assign them into clusters based on feature similarity. 

- _Programming languaje_: for the analysis, I will use Clustering K-means in R.

Using classification or clustering methods in HR, companies can work on target areas or department, even segment employees based on performance history, evaluations or satisfaction level monitoring, avoiding possible future "brain drain".

## 3. Machine Learning
Using machine learning tools, try to predict whether the employee will leave the company or not. 

- _Programming languaje_: Python

