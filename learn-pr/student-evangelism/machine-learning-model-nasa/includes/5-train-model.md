After the data is separated into the training and testing sections, we can train our machine learning model. One of the reasons Python is a popular language for data science and machine learning is because of all the libraries that exist to support the study of data. As we've seen, getting the machine learning model created and the data split was simple. Fitting and testing our model will also be simple.

## Fit the model

The next step in the data science lifecycle is to fit the model to the training data. The act of "fitting" is basically where the model is learning. This process was described with the berry example. The human was being "fitted" when they brought a berry and were told what kind it was. To fit the model, you call `fit()` on the machine learning classifier and pass in the `X_train` and `y_train` data.

Fitting the model is like doing a practice exam where you have access to the answers to ensure you understand the concepts.

```python
# Fitting the model to the training data
tree_model.fit(X_train,y_train)
```

## Test the model

Testing your model is also made easy with the libraries we've imported. Testing the model is like taking the exam. You'll provide `X_test` (the 20% of the input data you reserved for testing) to the classifier's `predict()` function. This function returns a list of `Y` and `N` that represents what the model thinks would happen if a rocket launch was attempted given a particular set of weather conditions.

Paste the following code in Visual Studio Code to predict, and then print the predictions.

```python
# Do prediction on test Data
y_pred = tree_model.predict(X_test)
print(y_pred)
```

How many `Y`s did you get? Do the predictions look representative of the data that was input? It's unclear without further investigation, but so far the output contains ~9 `Y` responses out of 60 input values. About 20% of the total data yielded a `Y`. This percentage is about 15% of this predicted data, so it's relatively close.