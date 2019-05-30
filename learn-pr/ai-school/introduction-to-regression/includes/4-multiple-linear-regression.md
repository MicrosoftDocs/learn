Linear regression using multiple features is called __multiple linear regression__. It is sometimes known as linear regression with multiple variables or non-linear regression, due to confusion with a different algorithm called multivariate linear regression (which is not commonly used in machine learning).
 
Multiple linear regression is very similar to simple linear regression, but rather than just using one feature to predict another, it uses multiple features to predict one other. Below is a plot where we use two features, weight and horsepower, to predict fuel efficiency. As you can see, rather than just a line (which is one dimensional) it fits a flat surface (which is two dimensional). It is common to use many more features than two, but these analyzes become very difficult or impossible to visualize as a graph.

![2.3 MultipleLinearRegression](../media/2-3-a.gif)

## Programming exercise
  
> It's time to do our next programming exercice - multiple linear regression.
>  
> Multiple linear regression is commonly used in science, is quick to run and many modern tools can take care of the hard parts for you. Let’s try out multiple linear regression in Azure Notebooks.  
>  
> **Python users** click __[here](https://notebooks.azure.com/home/libraries/Python "here")__ to go to your library.  
> Select the exercise `03. Multiple Linear Regression - Python.ipynb`.  
> Then click then click __'Run on Free Compute'__.  
>  
> **R users** click __[here](https://notebooks.azure.com/home/libraries/R-Exercises "here")__ to go to your library.  
> Select the exercise `03. Multiple Linear Regression - R.ipynb`.  
> Then click then click __'Run on Free Compute'__.  
>  
> If you haven’t set up your library and Azure Notebooks account the links above won't work. For instructions to get started click [__here__](https://aischool.microsoft.com/en-us/machine-learning/learning-paths/ml-crash-course/introduction-to-ai/introduction-to-azure-notebooks).

## Summary

That's it! Here we covered:

* __Multiple linear regression__ - linear regression that uses more than one feature.

You’ve built a multiple linear regression model and visualized it. Next we'll use a linear regression again with a slight modification: polynomial regression. This will allow linear regression to fit complex, non-linear data sets.