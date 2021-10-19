In this unit, you'll learn about scenarios in Model Builder.

## What is a scenario?

A scenario describes problem you're trying to solve using your data. Some common scenarios include:

- Categorizing data (organize articles by topic)
- Predicting a numerical value (price of a home)
- Detecting uncommon behavior (credit card fraud)
- Grouping items with similar characteristics (customer segmentation)
- Recommending items (recommend movies)

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
- Linear regression

For unsupervised tasks, the **label is unknown**. Examples of unsupervised machine learning tasks include:

- Clustering
- Anomaly detection

## Scenarios in Model Builder

Model Builder supports the following scenarios which map to the respective machine learning tasks

| Scenario | Machine Learning Task | Use Case |
| --- | --- | --- |
| Data classification | Binary and multiclass classification | Organize articles by topic |
| Value prediction | Linear regression | Predict the price of a home |
| Image classification | Image Classification (Deep Learning) | Organize images by animal species based on the content of an image |
| Recommendation | Recommendation | Recommend movies based on the preferences of similar users |
| Object detection | Object Detection (Deep Learning) | Identify physical damage in an image |

## Predictive maintenance scenario

Depending on what your data looks like, the predictive maintenance problem can be modeled using different tasks. For your use case, since the label is a binary value 0 or 1 describing whether a machine is broken or not, the data classification scenario is appropriate.

In this unit, you'll learn about the computing environments supported by Model Builder

## What are compute environments?

Compute environments describes to the compute resources you'll use to train your machine learning model. 

## Which environments are supported in Model Builder?

Model Builder supports the following environment options:

| Scenario | Compute | CPU | GPU |
| --- | --- | --- |
| Data classification | Local | X | |
| Value prediction | Local | X | |
| Image classification | Local, Azure | X | X |
| Recommendation | Local | X | |
| Object detection | Azure | | X |

Note that for the image classification scenario, GPU training is supported for local and Azure environments.

Depending on your use case and support, there are various reasons why you might choose one over the other.

### Local compute environments

Some reasons why you might consider local compute environments include:

- Training locally doesn't cost you anything since you're using your computer's resources.
- For scenarios where you don't want your data to leave your computer or data center, training locally is a good option.

### Azure compute environments

Scenarios like image classification and object detection are resource intensive. Using a GPU can often speed up the training process. If you don't have a GPU a computer with enough CPU or RAM, offloading the training process to Azure can lighten the load on your system.

In the next unit, you'll choose the compute environment for your predictive maintenance model.

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

In this unit, you'll learn about the training process in Model Builder.

## Training in Model Builder

Training is the process by which a series of algorithms for the scenario you've chosen are applied to your dataset. The goal is to find the "best"
model. We'll get into what "best" means in later units.

In most cases, to train machine learning models in Model Builder, you only have to provide the amount of time you want to let Model Builder search for the best model for your data.

## How long should I train for?

Longer training periods allow Model Builder to explore more models with a wider range of settings.

The table below summarizes the average time taken to get good performance for a suite of example datasets, on a local machine.

|Dataset size|Average time to train|
|------------|---------------------|
|0 - 10 MB|10 sec|
|10 - 100 MB|10 min|
|100 - 500 MB|30 min|
|500 - 1 GB|60 min|
|1 GB+|3+ hours|

These numbers are a guide only. The exact length of training is dependent on:

- the number of features (columns) being used as input to the model
- the type of columns
- the machine learning task
- the CPU, disk, and memory performance of the machine used for training

It's generally advised that you use more than 100 rows as datasets with less than that may not produce any results.

## How does Model Builder find the best model?

You've probably heard machine learning involves complex math. So how is it that Model Builder is able to train a machine learning model if you've only provided a scenario, a dataset, and how long you want Model Builder to train for?

Model Builder uses automated machine learning (AutoML) to identify the set of transformations to prepare your data for training, select an algorithm, and tune the settings (also known as hyperparameters) of the algorithm to create a model that most suits your data. Using evaluation metrics specific to the machine learning task selected, Model Builder is able to determine which model performs "best" for your data.

## Training and consumption code

Once your model is done training, Model Builder generates a few files prefixed with your model's name and adds them to your project. These files are nested under your *.mbconfig* file.

- **\<MODEL-NAME\>.zip**: A serialized version of your model.
- **\<MODEL-NAME\>.training.cs**: This file contains the model training pipeline. Your model training pipeline is made up of the data transformations and algorithm used to train your machine learning model. See [data transforms](/dotnet/machine-learning/resources/transforms) and [how to choose an ML.NET algorithm](/dotnet/machine-learning/how-to-choose-an-ml-net-algorithm) for more details.
- **\<MODEL-NAME\>.consumption.cs**: This file contains the classes that define the schema of your model input and output. It also contains the `Predict` method, that uses your model to create a `PredictionEngine` and make predictions. The `PredictionEngine` is a convenience API, which allows you to perform a prediction on a single instance of data.

In the next unit, you'll use Model Builder to train a classification model for predictive maintenance.

In this unit, you'll learn what makes a model the best model.

## Evaluation metrics

One way to evaluate how well your model performs is by using evaluation metrics. Evaluation metrics are specific to the type of machine learning task that a model performs. For each task, there are various metrics you can look at to determine the performance of your model. Depending on the scenario selected in Model Builder, it uses the evaluation metrics for that scenario to choose the "best" model.

This table shows the evaluation metrics used by Model Builder to choose the best model.

| Scenario | Evaluation metrics | Look for |  
| --- | --- | --- |
| Data classification | Binary (Accuracy) / Multiclass (MicroAccuracy) |  The closer to 1.00, the better.
| Value prediction | R-Squared | The closer to 1.00, the better |
| Recommendation | R-Squared | The closer to 1.00, the better |
| Image classification | Accuracy | The closer to 1.00, the better |
| Object detection | Accuracy | The closer to 1.00, the better |

For more information on ML.NET evaluation metrics, see [Model evaluation metrics](/dotnet/machine-learning/resources/metrics)

## Choosing the model with the highest metrics

Your model has achieved perfect evaluation metrics. Does that mean that you have the perfect model? Not exactly. In fact, if you end up with a "perfect" model as specified by your evaluation metrics, you should be skeptical. In machine learning, there is a concept known as overfitting and it's something you should watch out for. Overfitting is when your model learns the patterns in your training dataset too well. However, when you try to use the model with new data, it doesn't provide accurate results.

Here's a scenario may help illustrate overfitting. Imagine you're studying for an exam. Somehow you have the questions to the exam and the answers ahead of time. As you study for the exam, you focus on memorizing the answers to the questions. When you take the exam and receive the results, you get a high grade. A high grade may signal you know the subject matter you were just evaluated on. However, if someone were to ask you a question on one of the subjects that was not directly on the test, you may get it wrong because you haven't learned the subject, you just memorized the answers. Overfitting works in a similar way.

## Improve your model

If you're not satisfied with the evaluation metrics of your model, there are a few things you can try to improve your model.

- Provide more representative data observations. Experience is the best teacher. When it comes to machine learning, the concept also applies. The more data observations, the broader set of patterns your model is able to recognize.
- Provide more context. Adding columns that add context to your data helps your model identify patterns. For example, let's say you're trying to predict the price of a home and the only data point you have is number of rooms. That by itself may not tell you much. However, what if you knew that the home is located in a suburban neighborhood outside of a major metropolitan area, average household income is $80,000, and schools are in the top 20th percentile. Now you have more information that can help inform the model's decision.
- Use meaningful data and features. Although more data samples and features can help improve the accuracy of the model, they may also introduce noise since not all data and features are meaningful. Therefore, it is important to understand which features are the ones that most heavily impact decisions made by the algorithm 
- Explore more algorithms. Providing model builder with more type to allow it to explore more algorithms and hyperparameters may help improve your model.

In the next unit, you'll evaluate your predictive maintenance model.