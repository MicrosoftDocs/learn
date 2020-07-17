<!--- Reviewers note: This unit uses LaTeX syntax to format mathematical content. A dollar sign $ starts and ends the LaTeX statement. -->

Perhaps the simplest form of machine learning is to draw a line connecting two points and make predictions about where that trend might lead.

But what if you have more than two points, and those points don't line up neatly? What if you have points in more than two dimensions? This is where linear regression comes in.

Formally, linear regression is used to predict a quantitative _response_ (the values on a $Y$ axis) that's dependent on one or more _predictors_ (values on one or more axes that are orthogonal to $Y$, commonly thought of collectively as $X$). The working assumption is that the relationship between predictors and response is more or less linear.

The goal of linear regression is to fit a straight line in the best possible way to minimize the deviation between our observed responses in the dataset and the responses predicted by our line, the linear approximation. The most common means of assessing this error is called the *least squares method*. The method consists of minimizing the number you get when you square the difference between your predicted value and the actual value and adding up all of those squared differences for your entire dataset.

:::image type="content" alt-text="A graph showing linear regression." source="../media/linear-regression.png" loc-scope="azure":::

Statistically, we can represent this relationship between response and predictors as:

$Y = B_0 + B_1X + E$

Remember high school geometry? $B_0$ is the intercept of our line, and $B_1$ is its slope. We commonly refer to $B_0$ and $B_1$ as coefficients and to $E$ as the error term, which represents the margin of error in the model.

Let's practice with actual data. (Note that no graph paper will be harmed in the course of these predictions.)
