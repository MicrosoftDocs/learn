Azure Databricks supports different techniques for performing basic and advanced exploratory data analysis (EDA) on your data set.

## Basic exploratory data analysis 

Azure Databricks provides capabilities to perform basic EDA actions such as data cleansing, handling missing values, and correlation analysis. To start, you need to import your data sets. There are many options to import your data within Azure Databricks:

- Directly importing small data sets to tables using the Azure Databricks UI
- Mounting blob storage accounts and data lakes
- Connecting to external databases
- Using an orchestrator like Azure Data Factory.

Once you have access to the data, you can load it into Spark DataFrames for simplified processing. You can also use Pandas DataFrames and convert one to the other easily using Azure Databricks, as required.

## Advanced exploratory data analysis

Azure Databricks allows you to fully harness the power of Apache Spark to conduct advanced EDA. You can also use a number of languages, such as Python, R, SQL, and Scala. For additional functionality, you can load custom-built libraries or select from a wide variety of Python, Maven, and R libraries as needed.

This lab explores the following features that allow you to perform advanced EDA with your data set:

- **Parsimonious model**. It's a basic model that gives you an idea about the predictive capability of your data using minimum number of variables. Azure Databricks notebook has built-in capabilities to plot the data from the DataFrame that helps you to visually represent the results of your model using graphs.

- **One hot encoding and feature scaling**. In machine learning literature, one hot encoding is defined as an approach to encode categorical integer features using a one-hot or one-of-K scheme. Every distinct value of the categorical integer feature becomes a new column. Each new column a binary value of either 0 or 1 depending upon the fact whether that value exists for the category or not. Converting the dataset in the format makes it easier or machines to read and process.

 For example, if you are working on the following dataset that contains prices for different brands of cars.

   | Brand | Categorical value| Price |
   | ------------- | ------------- | ------------- |
   | Nissan | 1 | 20000  |
   | Nissan | 1 | 50000  |
   | Nissan | 1 | 80000  |
   | Toyota | 2 | 20000  |
   | Hyundai| 3 | 25000  |
 
  When this dataset goes through the one-hot process, it's converted into the following:

   | Nissan | Toyota | Hyundai | Price|
   | ------------- | ------------- | ------------- | --------------|
   | 1 | 0 | 0 |20000  |
   | 1 | 0 | 0 |50000  |
   | 1 | 0 | 0 |80000  |
   | 0 | 1 | 0 |20000  |
   | 0 | 0 | 1 |25000  |

- **Dimensionality reduction**. Dimensionality reduction is the operation that transforms data with n dimensions to a representation of the data in m dimensions, where m is less than n.