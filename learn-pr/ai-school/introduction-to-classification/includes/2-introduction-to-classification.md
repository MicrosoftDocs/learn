Models that sort examples into categories are called __classification algorithms__. The graph below shows a logistic regression, an example of a classification algorithm, where the values are classified into two categories - satisfied customers and dissatisfied customers.

![Scatter plot showing a logistic regression classification. The Y-axis represents independent variable 2, and the X-axis represents independent variable 1. The plot is roughly divided in two diagonally, with blue data points on one side, and green data points on the other side. There is a black line of best fit, splitting the two categories diagonally.](../media/3.1_LogisticRegression-01.png)

If you have done some data science before you might be used to seeing logistic regression with only one feature, with the label on the y axis.

![Scatter plot showing a logistic regression with only one feature. The Y-axis represents satisfaction likelihood and the X-axis represent coca percent. The blue data points on the bottom of the Y-axis, with low levels of cocoa percent. The green data points are at the top of the Y-axis with high levels of cocoa percent. There is a non-linear black line that divides the two categories.](../media/3.1_LogisticRegression-02.png)  
  
Email spam filters are another example of a classification algorithm (spam or not spam).

Classification differs from the regression algorithms we have covered so far – where we try to predict a number rather than a category. If we wanted to predict the speed a bird can fly or the price of a house, that would be a regression problem. Here we're going to predict if a customer is satisfied or dissatisfied. This is a classification problem.

### Classification predicts labels

In AI, when we predict an example’s category, we __label__ the example with a category. Labels don’t have to be binary - a label might be a breed of a dog or the species of a tree.  
  
#### How we predict labels
  
To build a classification model we need to use examples that are already labeled.  The model learns from these labeled examples, and will be able to predict labels for new unlabeled examples.

So if we want to predict the breed of dogs, we would create a data set and label the examples ourselves with the features of dogs (height, weight, fur color, ear shape, etc.).  If we label enough features in a big enough data set of dogs, we can create an AI model that can guess the breed of any new dog we meet.

There are lots of different classification algorithms we can use. We’ll use a simple, but powerful, classification algorithm next - __logistic regression__.

Stay with us! Don't worry if you feel a bit lost right now - next up we'll walk you through logistic regression.