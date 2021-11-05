In this unit you'll learn about choosing a scenario, selecting a training environment, and preparing your data for training in Model Builder.

Training is the process by which you apply algorithms to historical data in order to create an artifact or model that captures underlying patterns and can be used to make predictions on new data.

The model training process can be further broken down into the following steps:

- **Choose a scenario**
- **Choose an environment**
- **Load and prepare your data**
- **Train your model**
- **Evaluate your model**

This unit focuses on the first three: Choose a scenario, choose an environment, and load and prepare your data.

## Starting the training process

In order to start the training process, you need to add a new Machine Learning Model (ML.NET) item to a new or existing .NET application.

> [!TIP]
> Portability is one of the benefits that class libraries provide you. Class libraries make it easy to reference any models that are part of it from console, desktop, web, and any other type of .NET application. Therefore, it's recommended to add Machine Learning Model (ML.NET) items to a class library.

The Machine Learning Model (ML.NET) item adds a file to your project with the *.mbconfig* file extension.

Files that use the *.mbconfig* extension are Model Builder configuration files authored in JSON that allow you to:

- Provide a name for your model.
- Collaborate with others on your team via source control.
- Persist state. If at any point in the training process you need to close Model Builder, your state is saved and you can pick up right where you left off.

## Choose a scenario

The first step to train a machine learning model is deciding which scenario and machine learning task is the most appropriate to solve it given what you're trying to predict.

### What is a scenario?

A scenario describes the problem you're trying to solve using your data. Some common scenarios include:

- Categorizing data (organize news articles by topic)
- Predicting a numerical value (estimate the price of a home)
- Recommending items (recommend movies)
- Grouping items with similar characteristics (customer segmentation)
- Classifying images (tag an image based on its contents)
- Detecting objects in an image (detect pedestrians and bicycles at an intersection)

These scenarios map to machine learning tasks. A machine learning task is the type of prediction or inference being made, based on the problem or question that is being asked, and the available data.

Machine learning tasks tend to fall into two categories:

- Supervised
- Unsupervised

The main difference between them is whether the label, or value you're trying to predict, is known or not.

For supervised tasks, the **label is known**. Examples of supervised machine learning tasks include:

- Classification
  - Binary (2 categories)
  - Multiclass (2 or more categories)
  - Image
- Regression

For unsupervised tasks, the **label is unknown**. Examples of unsupervised machine learning tasks include:

- Clustering
- Anomaly detection

### Scenarios in Model Builder

Model Builder supports the following scenarios which map to the respective machine learning tasks.

| Scenario | Machine Learning Task | Use Case |
| --- | --- | --- |
| Data classification | Binary and multiclass classification | Organize articles by topic |
| Value prediction | Linear regression | Predict the price of a home based on features of the home |
| Image classification | Image Classification (Deep Learning) | Organize images by animal species based on the content of an image |
| Recommendation | Recommendation | Recommend movies based on the preferences of similar users |
| Object detection | Object Detection (Deep Learning) | Identify physical damage in an image |

### Choosing a scenario for predictive maintenance

Depending on what your data looks like, the predictive maintenance problem can be modeled using different tasks. For your use case, since the label is a binary value 0 or 1 that describes whether a machine is broken or not, the data classification scenario is appropriate.

## Choose your environment

Now that you've selected the data classification, it's time to choose the environment you want to train your machine learning model in. Environments describe the compute resources you'll use to train your machine learning model.

### Which environments are supported in Model Builder?

Model Builder supports the following environment options:

| Scenario | Local CPU | Local GPU | Azure GPU |
| --- | --- | --- | --- |
| Data classification | :heavy_check_mark: | :x: | :x: |
| Value prediction | :heavy_check_mark: | :x: | :x: |
| Recommendation | :heavy_check_mark: | :x: | :x: |
| Image classification | :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: |
| Object detection | :x: | :x: | :heavy_check_mark: |

Depending on your use case, there are various reasons why you might choose a local or Azure environment.

#### Local environments

Some reasons why you might consider local compute environments include:

- Training locally doesn't cost you anything since you're using your computer's resources.
- For scenarios where you don't want your data to leave your computer or data center, training locally is a good option.

#### Azure environments

Scenarios like image classification and object detection are resource intensive. Using a GPU can often speed up the training process. If you don't have a GPU or a computer with enough CPU or RAM, offloading the training process to Azure can lighten the load on your system.

## Load and prepare your data

With your scenario and training environment selected, it's time to load and prepare your data.

Data is the most important component for building machine learning models. The process for loading data into Model Builder consists of three steps:

1. Choose your data source type
1. Provide the location of your data
1. Choose column purpose

### Choose your data source type

Depending on your scenario, Model Builder supports loading data from the following sources:

- Delimited files (comma, semicolon, tab)
- Local and remote SQL Server databases
- Images (*.jpg* and *.png*)
- [Visual Object Tagging Tool (VOTT)](https://github.com/Microsoft/VoTT?azure-portal=true) for object detection scenarios.

### Provide the location of your data

Once you've selected your data source type, you have to provide the location where your dataset is stored. This can be a directory, file path, or database connection string. This too is dependent on the scenario and data source type you've selected previously.

When a data source is selected in Model Builder, it parses the data and makes its best effort to identify:

- Headers and column names
- Column separator
- Column data types
- Column purpose
- Decimal separators

Once the data is loaded, Model Builder displays a preview of some of the elements in your dataset.

### Choose column purpose

Depending on the scenario you choose, you'll have to define the purpose of certain columns. In scenarios like data classification and value prediction, you'll have to choose which of your columns is the column you want to predict (label).

By default, all other columns that are not the label are used as features. Features are columns used as inputs to predict the label.

### Advanced data options

To customize how your data is loaded, Model Builder provides advanced data options. These advanced data options allow you to customize settings pertaining to your columns and dataset formatting.

For columns, you can choose the following settings:

- **Purpose** - Should the column be a feature, label, or ignored? You can only have one column selected as the label.
- **Data type** - Is the value a single-precision float value, string, or boolean?
- **Categorical** - Does the column represent a categorical value (for example: low, medium, high)?

When it comes to data formatting, you can choose whether the data contains column headers, the column separator (comma, semicolon, tab), and the decimal separator type (period or comma).

### Understanding the predictive maintenance dataset

The dataset used in this module is from the 'Explainable Artificial Intelligence for Predictive Maintenance Applications', Stephan Matzka, Third International Conference on Artificial Intelligence for Industries (AI4I 2020), 2020 (in press), and hosted at the UCI Machine Learning Repository - Dua, D. and Graff, C. (2019). UCI Machine Learning Repository [http://archive.ics.uci.edu/ml](http://archive.ics.uci.edu/ml?azure-portal=true). Irvine, CA: University of California, School of Information and Computer Science.

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
- **Air temperature  [K]**, **Process temperature  [K]**, **Rotational speed [rpm]**, **Torque [Nm]**, **Tool wear [min]**: Values collected form sensors.
- **Machine failure**: Binary label (0 or 1) that indicates whether the machine has failed.
- **TWF**, **HDF**, **PWF**, **OSF**, **RNF**: Independent machine failure modes. A value of 1 represents that respective failure mode occurred.

For more details, see [AI4I 2020 Predictive Maintenance Dataset Data Set](https://archive.ics.uci.edu/ml/datasets/AI4I+2020+Predictive+Maintenance+Dataset?azure-portal=true).

For this scenario you won't use all of the columns in the dataset since they either don't inform the prediction or contain redundant information.

Since you'd like to be able to predict whether a machine has failed or not, the Machine failure column is the label.

In Model Builder, for features, you can use data from the Product ID, Type, and various sensor columns.

The failure modes, while they are useful in diagnosing the root cause of the failure, are not useful for your use case since you only want to know whether a machine has failed or not. Additionally, similar information is already captured by the Machine failure column. Therefore, you can ignore these columns.

Proceed to the next unit to check your knowledge on scenarios, environments, and data preparation.
