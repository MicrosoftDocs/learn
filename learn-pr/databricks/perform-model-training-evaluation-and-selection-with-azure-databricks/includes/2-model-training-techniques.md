Let's suppose you work in the analytics department of a large used-car dealer. You're working on creating a machine-learning model that will make predictions about sales prices and affordability in the used-car market. Your team has decided to use Azure Databricks to train your machine-learning model to achieve the following results:

- Investigate how the age of a used car influences its sales price.
- Find cars with specific features that a person with a set budget can afford.

Azure Databricks provides capabilities to train and evaluate your machine-learning model. You can create your model from a base dataset and then further train and polish your model by using different datasets.

## Train your machine-learning model

The process of training your machine-learning model includes the following broad steps:

- **Split the dataset:** Before you start training your machine-learning model, you must prepare your dataset by splitting it into training and testing data.

  Learning the parameters of a prediction function and then testing it on the same data is a methodological mistake. A sufficiently advanced model repeats the labels of the samples that it's seen. In this case, the model has a perfect score but fails to predict anything useful on data it hasn't seen yet. This situation is called *overfitting*.

  To avoid overfitting when you're working with (supervised) machine learning, split the data into at least two categories:

  - **Training data:** Use this data to teach the algorithm. Training data is the data that the algorithm will learn from.
  - **Test data:** Keep this data "secret," and don't share it with the algorithm during the learning phase. After the system has been trained, use this data to test the performance of the trained system.

- **Identify the technique:** Depending on your dataset and the outcomes you require, select the type of machine-learning technique. You can choose basic regression, classification, or advanced regression techniques.

- **Tune the model:** *Model tuning* is the process of achieving optimal performance of your machine-learning model. To tune your model, send it through the following steps multiple times, until you achieve the results you want:

  1. Select the parameters.
  1. Train the model by using the selected parameters.
  1. Use the model to make predictions on a test dataset.
  1. Correct the errors by adjusting the parameters.

- **Minimize cost functions:** One of the important aims when you're training your model is to reduce the *cost function*. The cost function, also called the *sum of squared errors cost function*, is a measure of how far your model is from correctly predicting the relationship between two values.

- **Evaluate and validate your model:** An important step in creating a robust machine-learning model is to evaluate and validate the predictive accuracy of your model. Cross validation is a method of validating the stability and performance of your machine-learning model.

  For example, you can't adjust the attributes in your model based on the test dataset to improve its performance. You also can't base the model's performance on a single test dataset and hope that it works accurately in real-world scenarios. To cross-validate your model's stability, you must train your model multiple times by using different datasets.

## Techniques to train machine-learning models

The technique you choose for training your machine-learning model must be based on the predictions and outcomes that you require of the dataset.

### Basic regression

**Linear regression:** One of the most common basic regression techniques is linear regression. Linear regression predicts the value of a dependent variable based on its relationship with one or more independent variables. This technique is the most straightforward way to make a linear model, in the shape of the familiar equation *y* = *ax* + *b*.

### Classification

In machine learning and statistics, classification is the problem of identifying which of a set of existing categories a new observation belongs to. A few common types of algorithms used for classification problems are:

- **Logistic regression:** Logistic regression is one of the most common and widely used algorithms to solve classification problems. The underlying technique used in this method is similar to linear regression, but it differs in the treatment of the dependent variable. The dependent variable in logistic regression is a binary value, which means it's used when the outcome is required to be either 0 or 1 (a yes or no value). This method uses the **Logit** function.

- **Support-vector machines:** Support-vector machines are supervised machine-learning models with associated algorithms that are primarily used for classification problems and regression challenges. These models are used in high-dimensional spaces. To learn more about support-vector machines, see [this article](https://scikit-learn.org/stable/modules/svm.html).

- **Decision-tree classifier:** The decision tree is popular for working with classification problems, both two-class and multiclass types. Models that are based on multiple decision trees, Random Forests, boosted trees, and XDGBoost are common in machine learning today. Single decision trees are also used, partly because they're easier to plot and inspect.

### Advanced regression

**Polynomial regression:** Polynomial regression is used in machine-learning models for complex and distributed datasets that can't be captured by using the straight-line linear regression technique. Polynomial regression techniques allow you to achieve optimal results by adjusting your model to eliminate overfitting and underfitting scenarios. You can eliminate underfitting by adding powers of the original independent variables in the equation to increase the model's complexity. To address overfitting, add more training datasets.