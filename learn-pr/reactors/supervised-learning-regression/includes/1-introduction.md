<!--- Reviewers note: This unit uses LaTeX syntax to format mathematical content. A dollar sign $ starts and ends the LaTeX statement. -->

So far in this track, we have largely investigated just machine-learning classification techniques. With linear regression, we'll look at one of the most important predictive algorithms in machine learning.

The essence of linear regression is a simple form of machine learning: drawing a line through points. You might have done this in your high school physics class: plot the results of a series of experiments on graph paper and then draw a line through as many points as possible. In that kind of a graph, you include as many points below the line as above the line where the points don't fall on the line.

We'll build on that conceptual foundation to address more complex situations. Those situations include having points in more than two dimensions or even points whose relationship seems nonlinear.

Formally, linear regression is used to predict a quantitative *response* (the values on a Y-axis). The response is dependent on one or more *predictors* (values on one or more axes that are orthogonal to $Y$, commonly thought of collectively as $X$). 

The working assumption is that the relationship between the predictors and the response is more or less linear. The goal of linear regression is to fit a straight line in the best possible way to minimize the deviation between our observed responses in the dataset and the responses predicted by our line, the linear approximation.

How do we tell that we have the best fit possible for our line? The most common means of assessing the error between the fit of our line - our model - and the data is called the [least squares method](https://en.wikipedia.org/wiki/Least_squares?azure-portal=true). This method consists of minimizing the number you get when you square the differences between your predicted values (the line) and the actual values (the data), and you add up all of those squared differences for your entire dataset.

## Learning objectives

In this module, you will:

- Learn to fit linear-regression models
- Become familiar with interpreting the output of linear-regression models

## Prerequisites

- Introduction to Python
- Beginners Data Science for Python Developers
- Join and clean datasets: Deep dive

[!INCLUDE [Set up your environment](../../includes/set-up-environment.md)]