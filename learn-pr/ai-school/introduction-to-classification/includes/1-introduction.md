Classification can be thought of as sorting examples into categories. The graph below shows a logistic regression, an example of a classification algorithm, where the values are classified into two categories - satisfied customers and dissatisfied customers.

![Scatter plot showing a logistic regression classification. The Y-axis represents independent variable 2, and the X-axis represents independent variable 1. The plot is roughly divided in two diagonally, with blue data points on one side, and green data points on the other side. There is a black line of best fit, splitting the two categories diagonally.](../media/31-lr-01.png)

Unlike with regression, the line isn't the prediction. Instead the line divides data points to  predict categories. For example, a data point left of the line would be predicted as the blue, dissatisfied customer category. To the right of the line would be the green, satisfied customer category.

If you have done some data science before you might be used to seeing logistic regression with only one feature, with the label on the y axis.

![Scatter plot showing a logistic regression with only one feature. The Y-axis represents satisfaction likelihood and the X-axis represent coca percent. The blue data points on the bottom of the Y-axis, with low levels of cocoa percent. The green data points are at the top of the Y-axis with high levels of cocoa percent. There is a non-linear black line that divides the two categories.](../media/31-lr-02.png)

Classification is different to regression – where we try to predict a number rather than a category. If we wanted to predict the speed a bird can fly or the price of a house, that would be a regression problem. Predicting if a customer is satisfied or dissatisfied is a classification problem.

**In this module, you will learn to:**

* Define classification.
* Build logistic regression and support vector machine models.
* Describe what training, irreducible error, and Bayes error are.

There are lots of different classification models we can use. We’ll use a simple, but powerful, classification algorithm next - __logistic regression__.
