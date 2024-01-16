
Training a machine learning model involves fitting a machine learning algorithm to your training data in order to determine an acceptably accurate function that can be applied to its features and calculate the corresponding labels. This may seem like a conceptually simple idea; but the actual process of training a model that produces accurate predictions on new data, not just the data it was trained with, can be challenging and involves an iterative approach of repeatedly training and evaluating models using multiple algorithms and parameters.

## Training and validation data

A common approach when training a machine learning model is to randomly split the data into subsets for *training* and *validation*. You can then use the training dataset to fit an algorithm and train a model, and then test how well the model performs with the validation data you held back. This helps ensure that the model *generalizes* well - in other words it generates accurate predictions for training on which it wasn't trained.

> [!NOTE]
> Models that predict well for the data on which they were trained but which don't work well with new data are described as *overfitted* to the training data.

Typically, you should train the model with around 70% of the data and hold back around 30% for validation.

## Machine learning algorithms

There are many machine learning algorithms, grouped into different algorithm types based on the kind of machine learning problem you need to solve. Most machine learning frameworks include multiple algorithms for regression and classification, and algorithms for unsupervised machine learning problems like clustering.

Having identified the type of problem you want to create a model to solve, you can choose from multiple algorithms of that type. Within each type, there may be multiple algorithms to choose from, often based on different kinds of mathematical operation. For example, within the set of algorithms for classification, there are algorithms of the following kind:

- *Logistic regression* algorithms that iteratively apply logistic functions to calculate a value between 0 and 1 that represents the probability for each possible class, and optimize the function's coefficients based on the differences between the predicted class and the actual known label value.
- *Tree-based* functions that define a decision tree in which an individual feature is considered; and based on its value, another feature is considered, and so on, until an appropriate class label is determined.
- *Ensemble* algorithms that combine multiple techniques to find the optimal overall predictive function.

The "best" algorithm depends on your data, and usually requires iterative trial and error to determine.

## Hyperparameters

The *parameters* to a machine learning algorithm are the data features (and labels) on which it's trained. Additionally, most machine learning algorithms provide *hyperparameters* that you can use to influence the way the algorithm works. Hyperparameters enable you to control things like the level of randomness you want to allow in the model (so it generalizes well but still produces acceptably accurate predictions), the number of iterations performed to find an optimal model (enabling you to avoid overfitting and optimize training time), the number of branches considered in a tree model, and other algorithm-specific factors.

## Fitting a model

To actually train a model, you need to for the algorithm to the data. The specific syntax and data formats used to do this can vary across machine learning frameworks, but the principle is always the same. For supervised machine learning, you fit the algorithm to the features based on the known labels. For unsupervised machine learning, you supply the features and the algorithm attempts to separate them into discrete clusters.

The following example shows the code used to initiate training of a logistic regression model using the Spark MLlib framework. The training data is provided as a dataframe in which the labels are in a column of integer values, and the corresponding features are represented as a single vector (array) of values. In this example, two hyperparameters (*maxIter* and *regParam*) have also been specified.

```python
from pyspark.ml.classification import LogisticRegression

lr = LogisticRegression(labelCol="label", featuresCol="features", maxIter=10, regParam=0.3)
model = lr.fit(training_df)
```
