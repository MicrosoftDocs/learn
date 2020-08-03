After the data is separated into the training and testing sections, we can train our machine learning model. One of the reasons Python is a popular language for data science and machine learning is because of all of the libraries that exist to support the study of data. As we've already seen, getting the machine learning model created and the data split was simple. Fitting and testing our model will be just as simple!

## Fitting the Model

The next step in the data science lifecyle is to fit the model to the training data. The act of "fitting" is basically where the model is learning. This is the process described in LP3M1U7 with the berry example - the human was being "fitted" when they would bring a berry and be told what kind it was. To fit the model, you call `fit()` on the machine learning classifier and pass in the `X_train` and `y_train` data. 

*Remember: This is like doing a practice exam where you have access to the answers to ensure you do understand the concepts*

```python
# Fitting the model to the training data
tree_model.fit(X_train,y_train)
```

## Testing the Model

Testing your model is also made easy with the libraries we have imported. Testing the model is like taking the exam, you will provide `X_test` (the 20% of the input data you reserved for testing) to the classifier's `predict()` function. This will return a list of `Y` and `N` that represents what the model thinks would happen if a rocket were attempted to be launched given a particular set of weather conditions.

Paste the code below in Visual Studio Code to predict and then print the predictions:

```python
# Do prediction on test Data
y_pred = tree_model.predict(X_test)
print(y_pred)
```

How many `Y` did you get? Do the predictions look representative of the data that was input? It's unclear without further investigation, but so far the output contains ~9 `Y` responses out of 60 input values. About 20% of the total data yielded a `Y` and this is about 15% of this predicted data, so it's reltively close! 