The process of training and validating a machine learning model using Spark ML is fairly straightforward. The steps are as follows:
1. Splitting data.
2. Training a model.
3. Validating a model.

## Splitting data

The first step involves splitting data between **training** and **validation** datasets. Doing so allows a data scientist to train a model with a representative portion of the data, while still retaining some percentage as a hold-out dataset. This hold-out dataset can be useful for determining whether the training model is **overfitting** - that is, latching onto the peculiarities of the training dataset rather than finding generally applicable relationships between variables.

DataFrames support a `randomSplit()` method, which makes this process of splitting data simple.

## Training a model

Training a model relies on three key abstractions: a **transformer**, an **estimator**, and a **pipeline**.

A transformer takes a DataFrame as an input and returns a new DataFrame as an output. Transformers are helpful for performing feature engineering and feature selection, as the result of a transformer is another DataFrame. An example of this might be to read in a text column, map that text column into a set of feature vectors, and output a DataFrame with the newly mapped column. Transformers will implement a `.transform()` method.

An estimator takes a DataFrame as an input and returns a model. It takes a DataFrame as an input and returns a model, which is itself a transformer. An example of an estimator is the `LinearRegression` machine learning algorithm. It accepts a DataFrame and produces a `Model`.  Estimators implement a `.fit()` method.

Pipelines combine together estimators and transformers and implement a `.fit()` method. By breaking out the training process into a series of stages, it's easier to combine multiple algorithms.

## Validating a model

Once a model has been trained, it becomes possible to validate its results. Spark ML includes built-in summary statistics for models based on the algorithm of choice. Using linear regression for example, the model contains a `summary` object, which includes scores such as Root Mean Square Error (RMSE), Mean Absolute Error (MAE), and coefficient of determination (R<sup>2</sup>, pronounced R-squared). These will be the summary measures based on the **training** data.

From there, with a **validation** dataset, it is possible to calculate summary statistics on a never-before-seen set of data, running the model's `transform()` function against the validation dataset.  From there, use evaluators such as the `RegressionEvaluator` to calculate measures such as RMSE, MAE, and R<sup>2</sup>.
