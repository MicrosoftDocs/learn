Linear regression is easy to use, but more complex data sets may require more complex algorithms. Many real life data sets require a non-linear model. For example, in the plot below you can see that a straight line does not accurately predict coffee sales. 

![Scatter plot showing linear and actual trend line for coffee sales. The Y-axis represents sales and the X-axis represents time of day. There is a noticeable rise in sales in the middle of the X-axis between 10am and 12pm, then a drop of sales after that to 5pm. There is a black line of best fit that is quite accurate, but is not linear. There is a red line of best fit that is linear, that is not accurate.](../media/2-4-a.png)

For a regression analysis in the plot above, the straight line would not produce very accurate predictions. We can use a non-linear regression algorithm to model this data - __polynomial regression__.

## Polynomial regression

Polynomial regression is actually a simple modification of multiple linear regression, allowing linear regression to fit non-linear data sets.

![Scatter plot showing polynomial regression. The Y-axis represents independent variable 2, and the X-axis represents independent variable 1. The data points are displayed similar to a quarter circle, with a non-linear line of best fit accurately following the data points.](../media/2-4-b.png)

As polynomial regression and multiple linear regression are easy and quick to use, it is common to approach regression problems by using both algorithms to get an idea of how different algorithms may perform on your data set.

### Programming exercise

> Next up we'll go through a programming exercise on polynomial regression.
>    
> **Python users** click __[here](https://notebooks.azure.com/home/libraries/Python "here")__ to go to your library.  
> Select the exercise `04. Polynomial Regression - Python.ipynb` exercise.  
> Then click then click __'Run on Free Compute'__.  
>  
> **R users** click __[here](https://notebooks.azure.com/home/libraries/R-Exercises "here")__ to go to your library.  
> Select the exercise `04. Polynomial Regression - R.ipynb`.  
> Then click then click __'Run on Free Compute'__.  
>  
> If you haven’t set up your library and Azure Notebooks account the links above won't work. For instructions to get started click [__here__](https://aischool.microsoft.com/en-us/machine-learning/learning-paths/ml-crash-course/introduction-to-ai/introduction-to-azure-notebooks).

## Summary

All done! Here we covered:

* __Non-linear data sets__ - many relationships can not be predicted by a straight line - we need a non-linear model.
* __Polynomial regression__ - variation of linear regression that can model non-linear data sets.

Next up we have a brief overview of how to select good features for your data set.