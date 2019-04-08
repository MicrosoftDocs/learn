Machine learning modeling is often thought of when people think of the role of a data scientist. It is a procedure that takes place within the data science process. In this phase, the data scientist uses EDA, feature engineering, and modeling, to give a probabilistic outcome based on the data at hand.

## The Cycle

The modeling step is often a cycle of data understanding, feature engineering, modeling, and model evaluation. Each of the steps in the modeling cycle can take a significant amount of time. A common misconception is that modeling is data science, but the reality is each of the components of the process are vital.

![Screenshot of Modeling Cycle](../media/3-modeling-cycle.png)

Later in the module we will discuss each of the steps of the cycle, but first, let's review the cycle.

## Exploratory Data Analysis (EDA)

EDA can be an extremely useful step. There are many techniques that can be used to explain what is going on with the data. Often, this part of the cycle will give insight into what needs to be done during feature engineering and modeling to produce the best results. Depending on the types of data, different techniques can be used. A few common visualization techniques are histograms, distribution plots, box plots, and heat maps.

## Feature engineering

Feature engineering is a large part of the modeling procedure. Creating features using the data available often goes hand in hand with EDA because when a feature is created, it is important to see how it relates to the rest of the data. Therefore, it is common to move in between EDA and feature engineering. Some techniques used in feature engineering are moving averages and different types of aggregations. A moving average is the change in average for a specific constant time interval. Aggregations are combinations of the data based on another feature. Some examples of aggregations are sum, average, and count.

## Modeling

What is a model? It is an algorithm that learns information about the data and with that provides a probabilistic prediction.

Creating models is the portion of the cycle that gets the most recognition. Here, there are many different techniques available, so it is important to identify the type of problem being solved. There are a few different types of algorithms you can use based on the what you're predicting: classification, or continuous value prediction. A classification algorithm predicts discrete values and continuous value prediction algorithms predict continuous values. For example, to classify something the only options are models that are based on that assumption. Some examples of classification models are logistic regression and random forest classifier. The outcome predicted by a classification model is finite, i.e. it must be one of a pre-defined set of values. Continuous values are numeric and can take on an infinite number of possible values. For examples, in theory total goods sold is infinite and includes a decimal portion. In reality, factors constrain the range of the value such as number of goods produced and number of customers. It is still considered continuous.

## Model evaluation

Evaluation of the model allows us to see how and where the model is doing well and/or failing and helps you find the best model for your data. There are a few different methods that are useful, depending on the type of predictive algorithm you're using. If you have a classifier model, it's important to use a confusion matrix to identify misclassification using precision and accuracy. If you are predicting numerical values, you can use evaluation metrics like mean squared error to see on average how far the predicted values are away from the true values.

![Screenshot of RMSE Visualization](../media/3-rmse.png)

## Summary

Performing the tasks in the model cycle is the primary role of a data scientist. The cycle always begins at EDA, but the movement from there varies depending on the data. It is common to iterate through this cycle multiple times before being satisfied with the result. At the end of this cycle, there may be other questions that arise creating another opportunity.