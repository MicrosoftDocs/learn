Let's suppose you work in the analytics department of a large used-car dealer. You're working on creating a machine-learning model that will make predictions for sales prices and affordability in the used-car market. Your team has decided to use Azure Databricks to train your machine-learning model to achieve the following results:

- Investigate how the age of a used car influences its sales price.
- Find cars with specific features that a person with a set budget can afford.

Azure Databricks provides capabilities to train and evaluate your machine learning model. You can create your model based on a base dataset and then further train and polish your model by using different data sets.

## Machine-learning-model training process

The process of training your machine-learning process includes the following broad steps:

- **Split the dataset:** Before you start training your machine-learning model, you must prepare your dataset by splitting it into training and testing data.

  Learning the parameters of a prediction function and then testing it on the same data is a methodological mistake. A sufficiently advanced model will repeat the labels of the samples that it's just seen. In this case, the model will have a perfect score but will fail to predict anything useful on yet-unseen data. This situation is called *overfitting*. 

  To avoid overfitting when you're working with (supervised) machine learning, split the data into at least two categories:

   - **Training data:** Use this data to teach the algorithm. Training data is the data that the algorithm will learn from.
   - **Test data:** Keep this data "secret" and don't share it with the algorithm during the learning phase. After the system has been trained, use this data to test the performance of the trained system.

- **Identify the technique:** Depending on your dataset and the outcome you require, select the type of machine-learning technique. You can choose either basic regression, classification, or advanced regression techniques.

- **Tune the model:** *Model tuning* is the process of achieving optimal performance of your machine-learning model. You can tune your model by making your model go through several iterations of the following steps until you achieve the desired result.

  1. Select the parameters.
  1. Train the model by using the selected parameters.
  1. Use the model to make predictions on a test dataset.
  1. Correct the errors by adjusting the parameters.

- **Minimize cost functions:** One of the important aims while training your model is to reduce the *cost function*. The cost function, also called the *sum of squared errors cost function*, is a measure of how far your model is from correctly predicting the relationship between two values.

- **Evaluate and validate your model:** An important step in creating a robust machine-learning model is to evaluate and validate the predictive accuracy of your model. Cross validation is a method of validating the stability and performance of your machine-learning model. You cannot adjust the attributes in your model based on the test dataset to improve its performance. You also can't base the model's performance on a single test dataset and hope that it works accurately in real-world scenarios. Training your model multiple times by using different datasets is required to cross-validate your model's stability.

## Techniques to train machine-learning models

The technique you choose for training your machine-learning model must be based on the prediction and outcomes that you require of the dataset.

### Basic regression

**Linear regression:** Linear regression is one of the most common basic regression techniques that predicts that value of a dependent variable based on its relationship with one or more independent variables. Linear regression is the most straight-forward way to make a linear model, in the shape of the familiar equation y = ax + b.

### Classification

In machine learning and statistics, classification is the problem of identifying to which of a set of existing categories a new observation belongs. The following are a few common types of algorithms used for classification problems.

- **Logistic regression:** Logistic regression is one of the most common and widely used algorithm to solve classification problems. The underlying technique used in this method is similar to linear regression, but it differs in the treatment of the dependent variable. The dependent variable in logistic regression is a binary value, which means it's used when the outcome is required as either 0 or 1 (yes or no value). This method uses the Logit function and hence the name logistic.

- **Support vector machines:** Support vector machines is a form of machine learning algorithm that is primarily used for classification problems and regression challenges. These methods are used in  high dimensional spaces. To learn more about support vector machines, [click here](https://scikit-learn.org/stable/modules/svm.html).

- **Decision tree classifier:** The decision tree is popular for working with classification problems, both two-class and multi-class types. Models that are based on multiple decision trees, Random Forest, boosted trees, and XDGBoost are common in machine learning today. Single decision trees are also used partly because they are easier to plot and inspect.

### Advanced regression

**Polynomial regression:** Polynomial regression is used in machine learning models for a complex and distributed dataset that can't be captured using the straight-line linear regression technique. Polynomial regression techniques allow you to adjust your model to eliminate over-fitting and under-fitting scenarios to achieve optimal results. Under-fitting is resolved by adding powers of the original independent variables in the equation to increase the complexity to the model. Over-fitting is eliminated by adding more training data sets.