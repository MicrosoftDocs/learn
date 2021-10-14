In this module, you'll learn how to load and prepare data into Model Builder.

## Loading data into Model Builder

Data is the most important component for building machine learning models. The process for loading data into Model Builder consists of 3 steps:

1. Choose your data source type
1. Provide the location of your data
1. Choose column purpose

## Choose your data source type

Model Builder supports loading data from the following sources:

- Delimited files (comma, semicolon, tab)
- Local and remote SQL Server databases
- Images (*.jpg* and *.png*)
- Visual  (for object detection scenarios)

## Provide the location of your data

Once you've selected your data source type, you have to provide the location where your dataset is stored. This can be a file path, the connection string of a database, or in the case of images, 

When a data source is selected in Model Builder, it makes it parses the data and makes its best effort to recognize:

- Headers and column names
- Delimiters
- Column data types
- Decimal separators
- Column purpose

### Advanced data

## Choose column purpose


