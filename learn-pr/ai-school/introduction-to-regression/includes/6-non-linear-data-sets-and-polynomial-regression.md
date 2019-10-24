Linear regression is easy to use, but more complex data sets may require more complex algorithms. Many real life data sets require a non-linear model. For example, in the plot below you can see that a straight line doesn't accurately predict coffee sales.

![A scatter plot that shows a linear trend line and an actual trend line for coffee sales. The Y-axis represents sales. And the X-axis represents time of day. There's a noticeable rise in sales in the middle of the X-axis between 10am and 12pm, then a drop of sales after that to 5pm. Also present is a non-linear black line of best fit that is a good fit. Along with a red line of best fit that is linear, that isn't accurate.](../media/2-4-a.png)

For a regression analysis in the plot above, the straight line would not produce very accurate predictions. We can use a non-linear regression algorithm to model this data - **polynomial regression**.

Polynomial regression is actually a simple modification of multiple linear regression, allowing linear regression to fit non-linear data sets.

![Scatter plot showing polynomial regression. The Y-axis represents independent variable 2, and the X-axis represents independent variable 1. The data points are displayed similar to a quarter circle, with a non-linear line of best fit accurately following the data points.](../media/2-4-b.png)

As polynomial regression and multiple linear regression are easy and quick to use, it is common to approach regression problems by using both algorithms to get an idea of how different algorithms may perform on your data set.

## Using complex models

A polynomial is a type of mathematical expression that can be expensive to compute, but can fit very complex trends. Although using polynomial regression is very similar to multiple linear regression, behind the scenes the model is more elaborate. As training time increases when models get more complex, it is vital to ensure your data is in an appropriate format.

To increase the chance of having a successful AI project, you should allocate a large proportion of your time to collecting and preparing good data first. After you’ve made sure your data is good, then you can experiment with different algorithms to increase your model’s accuracy.

Good data sets don't contain duplicates, and good features don't contain missing values or bad data points. Often data is not missing but incorrect, such as having a 0 for the height of a child. You can save a lot of time by checking for inaccurate or bad data points early, such as having a negative value in a column of values that should only be positive.

Next up we'll build and use a polynomial regression model in Azure Notebooks.
