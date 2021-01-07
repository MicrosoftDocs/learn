Machine learning models must be trained with existing data. In this case, you'll use a dataset of historical bicycle rental details to train a model that predicts the number of bicycle rentals that should be expected on a given day, based on seasonal and meteorological features.

## Create a dataset

In Azure Machine Learning, data for model training and other operations is usually encapsulated in an object called a *dataset*.

1. In [Azure Machine Learning studio](https://ml.azure.com?azure-portal=true), view the **Datasets** page (under **Assets**), and create a new dataset ***from web files*** with the following settings:
    - **Basic Info**:
        - **Web URL**: https://aka.ms/bike-rentals
        - **Name**: bike-rentals
        - **Dataset type**: Tabular
        - **Description**: Bicycle rental data
    - **Settings and preview**:
        - **File format**: Delimited
        - **Delimiter**: Comma
        - **Encoding**: UTF-8
        - **Column headers**: Use headers from first file
        - **Skip rows**: None
    - **Schema**:
        - Include all columns other than **Path**
        - Review the automatically detected types
    - **Confirm details**:
        - Do not profile the dataset after creation
2. After the dataset has been created, open it and view the **Explore** page to see a sample of the data. This data contains historical features and labels for bike rentals.

> **Citation**: *This data is derived from [Capital Bikeshare](https://www.capitalbikeshare.com/system-data) and is used in accordance with the published data [license agreement](https://www.capitalbikeshare.com/data-license-agreement).*
