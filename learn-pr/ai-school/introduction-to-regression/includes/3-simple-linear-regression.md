Simple linear regression tries to draw a straight line as near to the data points as possible. The plot below gives an example of simple linear regression, using one feature (x) to predict y.

![Line graph displaying linear regression prediction and actual values. The Y-axis represents the dependent variable, and the X-axis represents the independent variable. On the plot, there are four data points in blue which are the actual values. There is a black line of best fit, which closely fits the trend of the data points, but does not overlap with them. The black line of best fit is our predicted value.](../media/2-2-a.png)

### How it knows where to put the line

All data contains variability. This means that a straight-line prediction will almost never perfectly pass through every data point. In the graph below, the dashed red lines show the error in our model. For example, at x = 1, the model predicts that y = 5. We have a data point, however, at x=1 and can see that the value is actually 6. This means the predicted error for this data point is 1.

![The same line graph displaying linear regression prediction and actual values is displayed again, but zoomed into 3 data points. The Y-axis represents the dependent variable, and the X-axis represents the independent variable. On the plot, there are three data points in blue which are the actual values. There is a black line of best fit, which closely fits the trend of the data points, but does not overlap with them. The black line of best fit is our predicted value. Crucially, there is a red line between the blue data points and the black line of best fit, which is labeled as our error.](../media/2-2-b.png)

Error is a natural part of building a model. In AI, it’s a tool rather than something to avoid. *Simple linear regression finds a best line by calculating which straight line would give the least amount of error*.

## Summary

Here we covered:

* __Simple linear regression__ - uses one feature to predict a value.
* __Linear regression__ - fits the line that gives the least amount of error.

Next up we're going to build a simple linear regression model in Azure Notebooks.