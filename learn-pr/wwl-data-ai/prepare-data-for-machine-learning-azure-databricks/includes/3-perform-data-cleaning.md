**Big Data** has become part of the lexicon of organizations worldwide, as more and more organizations look to leverage data to drive more informed business decisions. With this evolution in business decision-making, the amount of raw data collected, along with the number and diversity of data sources, is growing at an astounding rate. 

Raw data, however, is often noisy and unreliable and may contain missing values and outliers. Using such data for **Machine Learning** can produce misleading results. Thus, data cleaning of the raw data is one of the most important steps in preparing data for Machine Learning. As Machine Learning algorithm learns the rules from data, having clean and consistent data is an important factor in influencing the predictive abilities of the underlying algorithms.

The most common type of data available for machine learning is in tabular format. The tabular data is typically available in the form of rows and columns. In tabular data, the row describes a single observation, and each column describes different properties of the observation. Column values can be continuous (numerical), discrete (categorical), datetime (time-series), or text. Columns that are chosen as inputs to the Machine Learning models are also known as model features. 

Data cleaning deals with issues in the data quality such as errors, missing values and outliers. There are several techniques in dealing with data quality issues and we will discuss some of the common approaches below.

## Imputation of null values

Null values refer to unknown or missing data as well as irrelevant responses. Strategies for dealing with this scenario include:

- Dropping these records: Works when you do not need to use the information for downstream workloads.
- Adding a placeholder (for example, -1): Allows you to see missing data later on without violating a schema.
- Basic imputing: Allows you to have a "best guess" of what the data could have been, often by using the *mean* or *median* of non-missing data for numerical data type, or *most_frequent* value of non-missing data for categorical data type.
- Advanced imputing: Determines the "best guess" of what data should be using more advanced strategies such as clustering machine learning algorithms or oversampling techniques such as SMOTE (Synthetic Minority Over-sampling Technique).

## Converting data types

In some situations, the columns have inconsistent data types. For example, a column can have a combination of numbers presented as strings, like `"44.5"` and `"25.1"`. As part of data cleaning you often have to convert the data in the column to its correct data type.

## Duplicate records

In some situations, you find duplicate records in the table. The easiest solution is to drop the duplicate records.

## Outliers

An outlier is defined as an observation that is significantly different to all other observations in a given column. There are several ways to identify outliers, and one common approach is to compute the *Z-score* for an observation *x*.

You can use similar strategies as imputing null values to deal with outliers. However, it is important to note that outliers are not necessarily invalid data and, in some situations, it is perfectly valid to retain the outliers in your training data.
