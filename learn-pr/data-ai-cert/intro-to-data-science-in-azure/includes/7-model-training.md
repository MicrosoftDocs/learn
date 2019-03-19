Model training is where you can finally use the data to get a prediction. This process never looks the same because it is unique to the data available.

## Selecting the model

Many types of models are available.  Not all of them are suitable for the outcome you want to predict. It is critical to identify whether you are trying to get a numerical or a classification prediction. After that, you can decide which type of model to use.

Since you are trying to predict the number of brooms that will sell each month, you pick an ARIMA model. ARIMA stands for Autoregressive Integrated Moving Average, and it is a modeling technique for time series analysis. Time series analysis is a modeling technique when trying to predict something concerning time.

## Splitting the data

![Screenshot of Steps to Predictive Modeling](../media/7-steps-predictive-modeling.png)

When you train a model, you need to split your data into training and testing sets so that you do not train your model on all the data. You will need a way to test the performance of the model, which splitting the data into training and testing sets permits. The idea is to hold a subset of the data back and use it later to test the model's effectiveness. When you feed it to the model, you do not give it the answer, that is, you make the model predict the answer. Next you compare the predictions against the actual values to see how well the model performed Data leakage, also known as bias, occurs when data included in the training set is highly correlated to what you're trying to predict.  In other words, the training data includes information about what you're trying to predict. Doing predictions based on time, requires you use about 70%-80% of the  data for the training set and 20%-30% for the testing set. Otherwise the train, test split should be random.

When using time series data, it is essential to split the data based on time. Since our data goes from 2009 to 2014, we will use the data from 2009 to 20013 for the training set and 2014 for the testing set.

## Cross-validation

When building a model, there is another common practice to improve model performance called cross-validation. This will split the data into subsets of the full dataset to ensure you are not overfitting a model to one training set. Overfitting means that the model works well only with the data used to train it. This happens when too many data elements are used in model training. A sign of overtraining is getting a very high level of prediction accuracy, i.e. close to 100%.  Cross-validation is often used in tandem with the train test split.

The data is based on time so we will skip this step because it is only used when the data used for prediction are the differences of the projections, which are often the case when there is a trend in the data.

## Get a probabilistic prediction

Everything has led up to this point in the data science process, and it's generally a glorified portion of what data scientists do.  Getting a prediction can be simple once everything else is in place.

Since you have chosen the ARIMA modeling technique, you simply call the ARIMA model and look at the results.

## Summary

This is an overview of how to approach  model training.  By using choosing the correct model, splitting your data into training and testing sets, and cross-validating your results, you will improve your solution and avoid overfitting and data leakage. In the next section, we will discuss how to evaluate the model.