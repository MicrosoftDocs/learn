
So you've trained a predictive model. How do you know if it's any good?

To evaluate a model, you need to use the validation data you held back. For supervised machine learning models, this approach enables you to compare the labels predicted by the model to the actual labels in the validation dataset. By comparing the predictions to the true label values, you can calculate a range of evaluation metrics to quantify the predictive performance of the model.

## Evaluating regression models

Regression models predict numeric values, so any evaluation of the model's predictive performance requires you to consider the differences between the predicted values and the actual label values in the validation dataset. Since the validation dataset includes multiple cases, some of which may have more accurate predictions than others, you need some way to aggregate the differences and determine an overall metric for performance. Typical metrics used to evaluate a regression model include:

- **Mean Squared Error (*MSE*)**: This metric is calculated by squaring the differences between each prediction and actual value, and adding the squared differences together, and calculating the mean (average). Squaring the values makes the differences *absolute* (ignoring whether the difference is negative or positive) and gives more weight to larger differences.
- **Root Mean Squared Error (*RMSE*)**: While the MSE metric is a good indication of the level of error in the models predictions, it doesn't relate to the actual unit of measurement of the label. For example, in a model that predicts sales (in US dollars), the MSE value actually represents the dollar values squared. To evaluate how far off the predictions are in terms of dollars, you need to calculate the square root of the MSE.
- **Coefficient of Determination (*R<sup>2</sup>*)**: The R<sup>2</sup> metric measures the correlation between the squared feature and predicted values. This results in a value between 0 and 1 that measures the amount of variance that can be explained by the model. The closer this value is to 1, the better the model predicts.

Most machine learning frameworks provide classes that calculate these metrics for you. For example, the Spark MLlib library provides the **RegressionEvaluator** class, which you can use as shown in this code example:

```python
from pyspark.ml.evaluation import RegressionEvaluator

# Inference predicted labels from validation data
predictions_df = model.transform(validation_df)

# Assume predictions_df includes a 'prediction' column with the predicted labels
# and a 'label' column with the actual known label values

# Use an evaluator to get metrics
evaluator = RegressionEvaluator()
evaluator.setPredictionCol("prediction")
mse = evaluator.evaluate(predictions_df, {evaluator.metricName: "mse"})
rmse = evaluator.evaluate(predictions_df, {evaluator.metricName: "rmse"})
r2 = evaluator.evaluate(predictions_df, {evaluator.metricName: "r2"})
print("MSE:", str(mse))
print("RMSE:", str(rmse))
print("R2", str(r2))
```

## Evaluating classification models

Classification models predict categorical labels (*classes*) by calculating a probability value for each possible class and selecting the class label with the highest probability. The metrics used to evaluate a classification model reflect how often these class predictions were correct when compared to the actual known labels in the validation dataset. Typical metrics used to evaluate a classification model include:

- **Accuracy**: A simple metric that indicates the proportion of class predictions made by the model that were correct. While this may seem like the obvious way to evaluate the performance of a classification model, consider a scenario where a model is used to predict whether a person will commute to work by car, bus, or tram. Let's say that 95% of cases in the validation set use a car, 3% take the bus, and 2% catch a tram. A model that simply always predicts a car will be 95% accurate - even though it actually has no predictive ability to discriminate between the three classes.
- Per-class metrics:
  - **Precision**: The proportion of predictions of the specified class that were correct. This is measured as the number of *true positives* (correct predictions of this class) divided by the total number of predictions of this class (including *false positives*).
  - **Recall**: The proportion of actual instances of this class that were correctly predicted (*true positives* divided by the total number if instances of this class in the validation dataset, including *false negatives* - cases where the model incorrectly predicted a different class).
  - **F1 score**: A combined metric for precision and recall (calculated as the *harmonic mean* of precision and recall).
- Combined (weighted) **precision**, **recall**, and **F1** metrics for all classes.

As for regression, most machine learning frameworks include classes that can calculate classification metrics. For example, the following code uses the **MulticlassClassificationEvaluator** in the Spark MLlib library.

```python
from pyspark.ml.evaluation import MulticlassClassificationEvaluator

# Inference predicted labels from validation data
predictions_df = model.transform(validation_df)

# Assume predictions_df includes a 'prediction' column with the predicted labels
# and a 'label' column with the actual known label values

# Use an evaluator to get metrics
accuracy = evaluator.evaluate(predictions_df, {evaluator.metricName:"accuracy"})
print("Accuracy:", accuracy)

labels = [0,1,2]
print("\nIndividual class metrics:")
for label in sorted(labels):
    print ("Class %s" % (label))
    precision = evaluator.evaluate(predictions_df, {evaluator.metricLabel:label,
                                                    evaluator.metricName:"precisionByLabel"})
    print("\tPrecision:", precision)
    recall = evaluator.evaluate(predictions_df, {evaluator.metricLabel:label,
                                                 evaluator.metricName:"recallByLabel"})
    print("\tRecall:", recall)
    f1 = evaluator.evaluate(predictions_df, {evaluator.metricLabel:label,
                                             evaluator.metricName:"fMeasureByLabel"})
    print("\tF1 Score:", f1)
    
overallPrecision = evaluator.evaluate(predictions_df, {evaluator.metricName:"weightedPrecision"})
print("Overall Precision:", overallPrecision)
overallRecall = evaluator.evaluate(predictions_df, {evaluator.metricName:"weightedRecall"})
print("Overall Recall:", overallRecall)
overallF1 = evaluator.evaluate(predictions_df, {evaluator.metricName:"weightedFMeasure"})
print("Overall F1 Score:", overallF1)
```

## Evaluating unsupervised clustering models

Unsupervised clustering models don't have known true label values. The goal of the clustering model is to group similar cases into clusters based on their features. To evaluate a cluster, you need a metric that indicates the level of separation between clusters. You can think of the clustered cases as plotted points in multidimensional space. Points in the same cluster should be close to one another, and far away from points in a different cluster.

One such metric is the **Silhouette** measure, which computes squared Euclidean distance and provides an indication of consistency within clusters. Silhouette values can be between 1 and -1, with a value close to 1 indicating that the points in a cluster are close to the other points in the same cluster and far from the points of the other clusters.

The Spark MLlib library provides the **ClusteringEvaluator** class, which computes the **Silhouette** for the predictions made by a clustering model as shown here:

```python
from pyspark.ml.evaluation import ClusteringEvaluator
from pyspark.ml.linalg import Vectors

# Inference predicted labels from validation data
predictions_df = model.transform(validation_df)

# Assume predictions_df includes a 'prediction' column with the predicted cluster

# Use an evaluator to get metrics
evaluator = ClusteringEvaluator(predictionCol="prediction")
silhouetteVal  = evaluator.evaluate(predictions_df)
print(silhouetteVal)
```
