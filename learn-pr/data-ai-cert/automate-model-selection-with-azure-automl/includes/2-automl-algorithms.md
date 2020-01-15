You can use automated machine learning in Azure Machine Learning to train models for the following types of machine learning task:

* Classification
* Regression
* Time Series Forecasting

## Task-Specific Algorthms

Azure Machine Learning includes support for numerous commonly used algorithms for these tasks, including:

### Classfication Algorithms

* Logistic Regression
* Light Gradient Boosting Machine (GBM)
* Decision Tree
* Random Forest
* Naive Bayes
* Linear Support Vector Machine (SVM)
* XGBoost
* Deep Neural Network (DNN) Classifier
* Others...

### Regression Algorithms

* Linear Regression
* Light Gradient Boosting Machine (GBM)
* Decision Tree
* Random Forest
* Elastic Net
* LARS Lasso
* XGBoost
* Others...

### Forecasting Algorithms

* Linear Regression
* Light Gradient Boosting Machine (GBM)
* Decision Tree
* Random Forest
* Elastic Net
* LARS Lasso
* XGBoost
* Others...

> **More Information**: For a full list of supported algorithms, see [How to define a machine learning task](https://aka.ms/AA70rrr) in the documentation.

## Restricting Algorithm Selection

By default, automated machine learning will randomly select from the full range of algorithms for the specified task. You can choose to block individual algorithms from being selected; which can be useful if you know that your data is not suited to a particular type of algorithm, or you have to comply with a policy that restricts the type of machine learning algorithms you can use in your organization.
