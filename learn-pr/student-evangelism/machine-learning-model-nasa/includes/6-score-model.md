Doing a simple comparison of percentage of data that resulted in a `Y` launch is useful for checking if the model is even close to correct, but it is even more useful to actually score the model. 

## Scoring the Model

Just like with an exam, learning can be measured with a score on an exam. As you might have expected, there is a one-line function you can call to see how accurate the model was at predicting whether a launch would happen:

```python
# Calculate accuracy
tree_model.score(X_test,y_test)
```

Using the `score()` function you pass in the `X_test` input data and the `y_test` output data to essentially grade the model.The higher the score, the more accurate our model is at predicting the outcome of a rocket launch based on weather data.

## Understanding the Score

The model in this example is 98.3% accurate, which is pretty good! In fact, with the little bit of data cleansing and manipulation we did and with the known issues of the data, it seems a little "too" good. 

It might be that we have the best data and correctly trained our model to get so accurate, but it also might mean that we are just really great at guessing this somewhat manufactured data, and so this wouldn't be reliable "in the real world". For context, 70% accuracy with a decision tree classifier (when run the first time) it pretty common.

How might you ensure that the score itself is an accurate representation of how accurate the model is?

One way could be to ask an expert to fill in the `Y` and `N` data for the non-launch dates instead of just guessing `N`. For example, the likelihood of the day right before or right after a launch *also* being a good day to launch is probably higher than we represented in this data.