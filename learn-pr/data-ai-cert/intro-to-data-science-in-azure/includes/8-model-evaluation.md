This part of the process uses the results from the model to see how well it did in predicting the outcome, referred to as *Y*. Depending on how well your model performs, you might need to fine-tune some hyper-parameters within the model to improve results.

## Tune the hyperparameters

*Hyperparameters* are parameters used in model training that cannot be learned by the training process. These parameters must be set before model training begins. Hyperparameters control how model training is done, which can have a significant impact on model accuracy. An example of a hyperparameter is the K parameter of the KNN model. This model defines regions of similar classes of items and determines which class a new item falls into by looking at the other items it has already classified. Basically, KNN asks "what is this new item most similar too?". 

The K parameter tells the model how many other items to consider in making the determination. A K of 1 means only look at the single most similar item, and a K of 3 means look at the three most similar (closest) neighbors. 

The value of K can have a significant impact on model accuracy. Deep learning models use several hyperparameters. However, when there is a large amount of data, tuning hyperparameters can be a computationally heavy task for a machine. If the dataset isn't too large, a process called *grid searching* allows you to get more accurate results as to which hyperparameters are best for your data because it looks at many more cases for each parameter. Another approach called the *random search method* searches randomly for the best hyperparameter values. This method is much less expensive computationally.

Since the dataset is only 10,000 rows, you move forward with grid searching. Note that when using this method, two hyperparameters need to be defined: learning rate, and number of layers help identify the extent of  fine-tuning.

> [!TIP]
> Hyperparameter tuning should be used with cross-validation so that the model is not overfitted to the training dataset.

Models can be configured to improve accuracy using hyperparameter tuning. This enables you to improve probabilistic outcomes, but at the cost of increased compute resources and time.

Don't worry if you don't understand this if you're not a data scientist. The key takeaway is that models can be configured.

## Evaluate the results

This is the final step of the modeling process. However, since you'll usually have the modeling process repeat more than once, the first time this step runs is usually is not the end. When you evaluate the results you'll look at how accurate or inaccurate your predictions are. Let's look at two different techniques for evaluating results: you can evaluate a classifier model, or assess a numerical prediction model.

### Look for accuracy and precision

 When evaluating a classification model a couple of metrics that are useful are accuracy and precision. To understand these terms, it's essential to understand what a confusion matrix is.

A confusion matrix includes the following:

- **True positive**: the number of times a model predicts true (or yes) when it is actually yes
- **True negative**: the number of times a model predicts false (or no) when it is actually false
- **False negative**: the number of times a model predicts false when it is actually true
- **False positive**: the number of times a model predicts true when it is actually false

This data is formatted in a matrix format to understand how accurate the predictive model is:

|                  | **Predicted No**       | **Predicted Yes**  |
|------------------|:------------------:|:------------------:|
| **Actually No**  | True Negative      | False Positive  |
| **Actually Yes** | False Negative | True Positive |

**Accuracy** is the value of accurate predictions of yes and no over the total number of predictions. You want this number to be as close to 1 as possible.

$${\dfrac{true\ positive + true\ negative}{true\ positive + true\ negative + false\ positive + false\ negative}}$$

You want the result to be as close to **one** as possible.

*Precision* is a measure of the consistency of the predictions. This is represented by the following equation.

$${\dfrac{true\ positive}{true\ positive + false\ positive}}$$

As with accuracy, the precision of your model increases as the result moves closer to **one**.


## Evaluate the metrics with mean squared error

Mean squared error (MSE) is one of the most popular model evaluation metrics in statistical modeling. It allows you to look at how far your predictions are on average from the correct  values. In the example with time series analysis, MSE is a valid approach to model evaluation.

The few metrics we have examined are just a subset of what is available for model evaluation. The type of model will drive the direction of the model evaluation, but the technique you choose will depend on whether the model is a classification or numerical prediction.