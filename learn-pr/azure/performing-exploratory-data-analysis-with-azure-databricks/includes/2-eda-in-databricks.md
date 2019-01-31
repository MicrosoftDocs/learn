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

- **One hot encoding and feature scaling**. In machine learning literature, one hot encoding is defined as an approach to encode categorical integer features using a one-hot or one-of-K scheme. Every distinct value of the categorical integer feature becomes a new column, which has all zero values except for rows where that value is present, where it has a value of 1. This is a way to transform categorical values into a form that can be more efficiently used by machine learning algorithms.

- **Dimensionality reduction**. Dimensionality reduction is the operation that transforms data with n dimensions (in Pandas world n columns in the DataFrame) to a representation of the data in m dimensions. Obviously m is less than n, and for visualizations we set m to be 2 or 3.