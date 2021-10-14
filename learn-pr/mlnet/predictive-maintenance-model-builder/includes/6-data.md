In this module, you'll learn how to load and prepare data into Model Builder and understand the predictive maintenance dataset used in this module.

## Loading data into Model Builder

Data is the most important component for building machine learning models. The process for loading data into Model Builder consists of three steps:

1. Choose your data source type
1. Provide the location of your data
1. Choose column purpose

## Choose your data source type

Model Builder supports loading data from the following sources:

- Delimited files (comma, semicolon, tab)
- Local and remote SQL Server databases
- Images (*.jpg* and *.png*)
- [Visual Object Tagging Tool (VOTT)](https://github.com/Microsoft/VoTT) for object detection scenarios.

## Provide the location of your data

Once you've selected your data source type, you have to provide the location where your dataset is stored. This can be a directory, file path, or database connection string.

When a data source is selected in Model Builder, it parses the data and makes its best effort to identify:

- Headers and column names
- Column separator
- Column data types
- Column purpose
- Decimal separators

Once the data is loaded, Model Builder displays a preview of some of the elements in your dataset.

## Choose column purpose

Depending on the scenario you choose, you'll have to define the purpose of certain columns. In scenarios like data classification and value prediction, you'll have to choose which of your columns is the column you want to predict (label). By default, all other columns that are not the label are used as features. Features are columns used as inputs to predict the label.

## Advanced data options

In cases where you'd like to customize how your data is loaded, Model Builder provides advanced data options. These advanced data options allow you to customize settings pertaining to your columns and dataset formatting.

For columns, you can choose its:

- Purpose - Should the column be a feature, label, or ignored? You can only have one column selected as the label.
- Data type - Is the value a single-precision float value, string, or boolean?
- Categorical - Does the column represent a categorical value?

When it comes to data formatting, you can choose whether the data contains column headers, the column separator (comma, semicolon, tab), and the decimal separator type (period or comma).

## Understanding the predictive maintenance dataset

The dataset used in this module is from the 'Explainable Artificial Intelligence for Predictive Maintenance Applications', Stephan Matzka, Third International Conference on Artificial Intelligence for Industries (AI4I 2020), 2020 (in press), and hosted at the UCI Machine Learning Repository - Dua, D. and Graff, C. (2019). UCI Machine Learning Repository [http://archive.ics.uci.edu/ml]. Irvine, CA: University of California, School of Information and Computer Science.

The AI4I 2020 Predictive Maintenance Dataset is a synthetic dataset that reflects real predictive maintenance data encountered in industry. The dataset consists of 10,000 data points and 14 columns.

Below is a preview of what the data looks like:

|UDI|Product ID|Type|Air temperature [K]|Process temperature [K]|Rotational speed [rpm]|Torque [Nm]|Tool wear [min]|Machine failure|TWF|HDF|PWF|OSF|RNF|
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
|1|M14860|M|298.1|308.6|1551|42.8|0|0|0|0|0|0|0|
|162|L47341|L|298.3|308.1|1412|52.3|218|1|0|0|0|1|0|

The columns are defined as follows:

- **UDI**: The row's index.
- **Product ID**: A product identifier containing a product type category and a variant-specific serial number.
- **Type**: Product quality category. L, M, or H for low (50% of all products), medium (30%) and high (20%).
- **Air temperature**, **Process temperature**, **Rotational speed**, **Torque**, **Tool wear**: Readings collected form sensors.
- **Machine failure**: binary label that indicates whether the machine has failed.
- **TWF**, **HDF**, **PWF**, **OSF**, **RNF**: Independent machine failure modes. A value of 1 represents that failure mode occurred.

For more details, see [AI4I 2020 Predictive Maintenance Dataset Data Set](https://archive.ics.uci.edu/ml/datasets/AI4I+2020+Predictive+Maintenance+Dataset).

For this scenario you won't use all of the columns in the dataset since they either don't inform the prediction or contain redundant information.

Since you'd like to be able to predict whether a machine has failed or not, the Machine failure column is the label.

In Model Builder, for features, you can use information from the Product ID, Type, and various sensor reading columns.

The failure modes, while they are useful in diagnosing the root cause of the failure, for your use case, you only want to know whether a machine has failed or not. Additionally, similar information is already captured by the label column. Therefore, you can ignore these columns.
