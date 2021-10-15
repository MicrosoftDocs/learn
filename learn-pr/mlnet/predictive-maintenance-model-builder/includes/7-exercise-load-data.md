In this module you'll load the predictive maintenance dataset into Model Builder

## Download the data

[Download the dataset](https://archive.ics.uci.edu/ml/machine-learning-databases/00601/) and save it anywhere on your computer.

After some time, a file with the name *ai4i2020.csv* should appear in the location you specified.

## Choose your data source type

The predictive maintenance dataset is a CSV file.

In the Data step of the Model Builder screen, select **File (csv, tsv, txt)** for Data source type.

## Provide the location of your data

Select the **Browse** button and use the file explorer to provide the location of your *ai4i2020.csv* dataset.

## Choose your label column

Choose **Machine failure** from the Column to predict (Label) dropdown

:::image type="content" source="../media/load-training-data.png" alt-text="Load predictive maintenance csv file dataset":::

## Advanced data options

By default, all columns that are not the label are used as features. As previously mentioned though, some columns contain redundant information while others don't inform the prediction. Therefore, you want to ignore those columns. To do so, use the advanced data options.

1. Select **Advanced data options...**.
1. In the Advanced data options dialog, select the **Column settings** tab.

    :::image type="content" source="../media/configure-advanced-data-options.png" alt-text="Configure advanced data options for predictive maintenance dataset":::

1. Configure the column settings as follows:

    | Columns | Purpose | Data type | Categorical |
    | --- | --- | --- | --- |
    | UDI | Ignore | Single | |
    | Product ID | Feature | String | |
    | Type | Feature | String | X |
    | Air temperature [K]| Feature | Single | |
    | Process temperature [K]| Feature | Single | |
    | Rotational speed [rpm]| Feature | Single | |
    | Torque [Nm]| Feature | Single | |
    | Tool wear [min]| Feature | Single | |
    | Machine failure| Label | Single | X |
    | TWF | Ignore | Single | X |
    | HDF | Ignore | Single | X |
    | PWF | Ignore | Single | X |
    | OSF | Ignore | Single | X |
    | RNF | Ignore | Single | X |

1. Select **Save**.
1. In the Data step of the Model Builder screen, select **Next step**.

In the next unit, you'll learn about training with Model Builder.