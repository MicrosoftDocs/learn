The most fundamental type of regression is linear regression. Linear regression tries to draw a straight line as near to the data points as possible.

## What is simple linear regression

Simple linear regression is when we use one feature (x) to predict y. Below we have a data set with men's height (x) and shoe size (y):

![Scatter plot graph showing height and shoe size. The Y-axis represents show size and the X-axis represents height in centimeters. The graph shows shoe size beginning at 6, with height at 120 centimeters. As height increases to 200 centimeters, shoe size increases, almost perfectly linearly, from 6 to 15.](../media/2-1-b.png)

This will be our *training data*, which allows linear regression to identify the trend line. In this case, a straight line fits the data very well and so linear regression is appropriate.

![Scatter plot graph showing height and shoe size with a line of best fit showing a linear relationship between shoe size and height. The Y-axis represents show size and the X-axis represents height in centimeters. The graph shows shoe size beginning at 6, with height at 120 centimeters. As height increases to 200 centimeters, shoe size increases, almost perfectly linearly, from 6 to 15.](../media/2-1-d.png)

## Make predictions with simple linear regression

The training data allows us to create a linear regression model that knows the trend in the data. Once we've used our existing data (both features and the label) to determine where the line belongs, we can use this model to make predictions make predictions at future labels given a feature.

With the previous example, we could predict a person’s shoe size when we only know their height. If we are asked to guess the shoe size of someone who is 180 centimeters tall, we can use that line to guess a little over 14.

### How it knows where to put the line

All data contains variability. This means that a straight-line prediction will almost never perfectly pass through every data point. In the graph below, the dashed red lines show where our model doesn't exactly fit the data – the error. For example, at x = 1, the model predicts that y = 5. We have a data point, however, at x=1 and can see that the value is actually 6. This means the prediction error for this data point is 1.

![The same line graph displaying linear regression prediction and actual values is displayed again, but zoomed into 3 data points. The Y-axis represents the dependent variable, and the X-axis represents the independent variable. On the plot, there are three data points in blue which are the actual values. There is a black line of best fit, which closely fits the trend of the data points, but does not overlap with them. The black line of best fit is our predicted value. Crucially, there is a red line between the blue data points and the black line of best fit, which is labeled as our error.](../media/2-2-b.png)

Error is a natural part of building a model. In AI, it’s a tool rather than something to avoid.

Linear regression works by finding the line through your training data that minimizes the total error of all training examples.