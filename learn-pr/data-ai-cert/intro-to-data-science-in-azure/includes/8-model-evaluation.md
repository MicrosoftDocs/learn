This part of the process uses the results from the model to see how well the model did in predicting the outcome referred to as y.  Depending on how well your model performs, you may fine-tune some hyper-parameters within the model to improve the results.

## Hyperparameter tuning

Hyperparameters are parameters used in model training that cannot be learned by the training process. These parameters must be set before the model training begins. Hyperparameters control how the model training is done and can have a significant impact on the model accuracy. An example of a hyperparameter is the K parameter of the KNN model. This model defines regions of similar classes of items and determines which class a new item falls into by looking at the other items it has already classified. Basically, it asks "what is this new item most similar too?". The K parameter tells the model how many other items to consider in making the determination. A K of 1 means only look at the single most similar item and a K of 3 means look at the three most similar (closest) neighbors. The value of K can have a significant impact on the model accuracy. Deep learning models use several hyperparameters.  Tuning hyper-parameters can be a computationally heavy task for a machine if there is a large amount of data. If the dataset isn't too large, a process called grid searching allows you to get more accurate results as to which hyperparameters are best for your data because it looks at many more cases for each parameter. Another approach called the random search method, searches randomly for the best hyper-parameter values which is much less expensive computationally.

Since the dataset is only 10,000 rows, you move forward with grid searching. Note that when using this method, two hyperparameters need to be defined. They are learning rate and number of layers which help identify the extent of the fine-tuning.

> [!TIP]
> Hyperparameter tuning should be used with cross-validation so that the model is not overfitting to the training dataset.

Models can be configured to improve accuracy using hyperparameter tuning, this enables you to improve probabilistic outcomes but at a cost of increased compute resources and time.

Don't worry if you don't understand this to know this if you're not a data scientist. The key takeaway is that models can be configured.

## Evaluation the results

Evaluating the results is the final step of the modeling process, but since the modeling process ordinarily repeats more than once, this step usually is not the end. Here you can expect to look at how accurate or inaccurate our predictions are. Let's look at two different techniques for this. The first is a way to evaluate a classifier model, and the second is a method of assessing a numerical prediction model.

### Accuracy and precision

A couple of metrics that are useful when evaluating a classification model are accuracy and precision. To understand these terms, it is essential to understand what a confusion matrix is.

A _confusion matrix_ includes the following data.

- **True positive**: the number of times a model predicts true (or yes) when it is actually yes
- **True negative**: the number of times a model predicts false (or no) when it is actually false
- **False negative**: the number of times a model predicts false when it is actually true
- **False positive**: the number of times a model predicts true when it is actually false

This data is formatted in a matrix format to understand how accurate the predictive model is.

|                  | Predicted No       | **Predicted Yes**  |
|------------------|:------------------:|:------------------:|
| Actually No      | True Negative      | **True Positive**  |
| **Actually Yes** | **False Negative** | **False Positive** |

**Accuracy** is the value of accurate predictions of yes and no over the total number of predictions as shown in the following equation.

```
             True Positive + True Negative
———————————————————————————————————————————————————————————————
True Positive + True Negative + False Positive + False Negative
```

You want the result to be as close to **one** as possible.

**Precision** is a measure of the consistency of the predictions. This is represented by the following equation.

```
       True Positive
——————————————————————————————
True Positive + False Positive
```

As with accuracy, the precision of your model increases as the result moves closer to **one**.

## Mean squared error

Mean squared error (MSE) is one of the most popular model evaluation metrics in statistical modeling. It allows you to look at how far your predictions are on average from the correct y values.

In the example, and with time series analysis, MSE is a valid approach to model evaluation.

The few metrics we have examined are just a subset of what is available for model evaluation. The type of model will drive the direction of the model evaluation, but the technique you choose will depend on whether the model is a classification or numerical prediction.