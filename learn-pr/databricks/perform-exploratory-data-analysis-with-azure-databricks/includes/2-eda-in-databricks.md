Azure Databricks supports different techniques for doing basic and advanced exploratory data analysis (EDA) on your dataset.

## Basic EDA 

With Azure Databricks, you can do basic EDA actions, such as data cleansing, handling of missing values, and correlation analysis.

To start, you need to import your datasets. There are many options to import your data within Azure Databricks:

- Directly import small datasets into tables by using the Azure Databricks UI.
- Mount blob storage accounts and data lakes.
- Connect to external databases.
- Use an orchestrator, like Azure Data Factory.

After you have access to the data, you can load it into Spark DataFrames for simplified processing. You can also use Pandas DataFrames. Azure Databricks allows you to easily convert from one DataFrame type to the other, as needed.

## Advanced EDA

Azure Databricks allows you to harness the power of Apache Spark to conduct advanced EDA. You can also use a number of languages, such as Python, R, SQL, and Scala. For additional functionality, load custom-built libraries or select from a wide variety of Python, Maven, and R libraries.

This lab explores the following features that allow you to do advanced EDA with your dataset:

- **Parsimonious models:** A parsimonious model shows you the predictive capability of your data by using a minimum number of variables. To help you visually represent the results of your model in graphs, Azure Databricks notebooks have built-in capabilities to plot data from a DataFrame.

- **One-hot encoding and feature scaling:** In machine-learning literature, one-hot encoding is an approach to encoding categorical integer features by using a one-hot or one-of-K scheme. Every distinct value of the categorical integer feature becomes a new column. Each new column has a binary value of either 0 or 1, depending on whether that value exists for the category. Converting a dataset into the one-hot format makes it easier for machines to read and process.

   For example, suppose you're working on the following dataset, which contains prices for different brands of cars:

   | Brand | Categorical value| Price |
   | ------------- | ------------- | ------------- |
   | Nissan | 1 | 20000  |
   | Nissan | 1 | 50000  |
   | Nissan | 1 | 80000  |
   | Toyota | 2 | 20000  |
   | Hyundai| 3 | 25000  |

   When this dataset goes through the one-hot process, it's converted into the following structure:

   | Nissan | Toyota | Hyundai | Price|
   | ------------- | ------------- | ------------- | --------------|
   | 1 | 0 | 0 |20000  |
   | 1 | 0 | 0 |50000  |
   | 1 | 0 | 0 |80000  |
   | 0 | 1 | 0 |20000  |
   | 0 | 0 | 1 |25000  |

- **Dimensionality reduction:** Dimensionality reduction transforms data with *n* dimensions to a representation of the data in *m* dimensions, where *m* is less than *n*.