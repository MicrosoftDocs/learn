Let's suppose you work in the analytics department of a large used cars dealer. You're working on creating a machine learning model that will make predictions for sales prices and affordability in the used car market. Your team has decided to use Azure Databricks to train your machine learning model to achieve the following results:

- Investigate how the age of a used car influences its sales price.
- Find cars with specific features that a person with a set budget can afford.

Azure Databricks provides capabilities to train and evaluate your machine learning model. You can create your model based on a base data set and then further train and polish your model using different data sets.

## Machine learning model training process

The process of training your machine learning process broadly includes the following steps:

- **Splitting data set**. Before you start training your machine learning model, you must prepare your data set by splitting it into training and testing data. Learning the parameters of a prediction function and testing it on the same data is a methodological mistake. A sufficiently advanced model that would repeat the labels of the samples that it has just seen would have a perfect score but would fail to predict anything useful on yet-unseen data. This situation is called over-fitting (or simply cheating!). To avoid it when working with (supervised) machine learning, you should split the data into at least two categories:

 1. Training data: The data we'll use to "teach" the algorithm. Training data is the data that the machine/algorithm  will learn from.
 1. Test data: We keep this data "secret", and won't share it with the algorithm during the learning phase. After the system has been trained, we use this data to test the performance of the trained system.

- **Identifying the technique**. Depending upon your data set and outcome required, select the type of machine learning technique. You can choose, either basic regression, classification, or advanced regression techniques.

- **Tuning the model**. Model tuning is the process of achieving optimal performance of your machine learning model. You can tune your model by making your model go through several iterations of the following steps until you achieve the desired result.

  1. Select the parameters.
  1. Train the model using selected parameters.
  1. Use the model to make predictions on a test data set.
  1. Correct the errors by adjusting the parameters.

- **Minimizing cost functions**. One of the important aims while training your model is to reduce the cost function. Cost function, also called sum of squared errors cost function, is a measure of how far your model is from correctly predicting the relationship between two values.

- **Evaluating and validating your model**. An important step in creating a robust machine learning model is to evaluate and validate the predictive accuracy of your model. Cross validation is a method of validating the stability and performance of your machine learning model. You cannot adjust the attributes in your model based on test-data set to improve your its performance, neither can you base the performance on a single test-data set and hope that it works accurately in the real-world scenarios. Training your model multiple times using different data set is required to cross-validate your models stability.

## Techniques to train machine learning model

Technique for training machine learning model must be chosen base on the prediction and outcomes required of the data set.

### Basic regression

**Linear regression**. Linear regression is one of the most common basic regression techniques that predicts that value of a dependent variable based on its relationship with one or more independent variables. Linear regression is the most straight-forward way to make a linear model, in the shape of the familiar equation y = ax + b.

### Classification

In machine learning and statistics, classification is the problem of identifying to which of a set of existing categories a new observation belongs. The following are a few common types of algorithms used for classification problems.

- **Logistic regression**. Logistic regression is one of the most common and widely used algorithm to solve classification problems. The underlying technique used in this method is similar to linear regression, but it differs in the treatment of the dependent variable. The dependent variable in logistic regression is a binary value, which means it's used when the outcome is required as either 0 or 1 (yes or no value). This method uses the Logit function and hence the name logistic.

- **Support vector machines**. Support vector machines is a form of machine learning algorithm that is primarily used for classification problems and regression challenges. These methods are used in  high dimensional spaces. To learn more about support vector machines, [click here](https://scikit-learn.org/stable/modules/svm.html).

- **Decision tree classifier**. The decision tree is popular for working with classification problems, both two-class and multi-class types. Models that are based on multiple decision trees, Random Forest, boosted trees, and XDGBoost are common in machine learning today. Single decision trees are also used partly because they are easier to plot and inspect.

### Advanced regression

**Polynomial regression**. Polynomial regression is used in machine learning models for a complex and distributed data set that can't be captured using the straight-line linear regression technique. Polynomial regression techniques allow you to adjust your model to eliminate over-fitting and under-fitting scenarios to achieve optimal results. Under-fitting is resolved by adding powers of the original independent variables in the equation to increase the complexity to the model. Over-fitting is eliminated by adding more training data sets.