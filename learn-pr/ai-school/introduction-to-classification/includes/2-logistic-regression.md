In machine learning, when we predict an example’s category, we __label__ the example with a category. Labels don’t have to be binary - a label might be a breed of a dog or the species of a tree. Email spam filters are another example of classification (spam or not spam).

## How classification models predict labels
  
To build a classification model we need to use training examples that are already labeled. The model learns from these labeled examples, and will be able to predict labels for new unlabeled examples.

So if we want to predict the breed of dogs, we could create a data set with the features of dogs (height, weight, fur color, ear shape, etc.) and label the examples ourselves. If we label enough examples in a big enough data set of dogs, we can create a machine learning model that can predict the breed of any new dog we meet.

### Training

In the exercises, the models we build ‘train’ themselves to improve their accuracy.

![Scatter plot showing a logistic regression classification. The Y-axis represents independent variable 2, and the X-axis represents independent variable 1. The plot is roughly divided in two diagonally, with blue data points on one side, and green data points on the other side. There is a black line of best fit, which moves iteratively from the bottom of the X-axis to divide the data points diagonally.](../media/33-ct.gif)

The diagram above shows an algorithm trying to find the line that best separates the blue from the green dots. As you can see above, the algorithm changes its variables (the starting point and gradient of the line) until it finds the line that most accurately does so. This process of adjusting these variables is called __training__. Once the algorithm has completed training, and we can use it to predict new examples, it’s called a model.

There are many different ways training can work. One common method is to start with a random guess (in this case, a random line), and see whether adjustments (for example, a more or less steep gradient) give a better result. This process is repeated until adjustments do not improve the model any further, until the improvements for a change are small, or some sort of attempt limit is reached.

## Logistic regression

Logistic regression is a binary classification algorithm, meaning it predicts 2 categories (e.g. yes or no, win or loss etc.). Don’t be fooled by the ‘regression’ in the name, this simply means that it predicts the probability of a category.

In the plot below we compare customer satisfaction with different cocoa percentages using logistic regression.

![Scatter plot showing a logistic regression with only one feature. The Y-axis represents satisfaction likelihood and the X-axis represent cocoa percent. The blue data points on the bottom of the Y-axis, with low levels of cocoa percent. The green data points are at the top of the Y-axis with high levels of cocoa percent. There is a non-linear black line that divides the two categories.](../media/31-lr-02.png)

Logistic regression can plot a curve that can help us predict the likelihood that a customer is satisfied based on the cocoa percentage of the chocolate bar. Behind the scenes, logistic regression uses a powerful equation which can plot complex curves to accurately separate examples into categories.

Logistic regression is a nice, easy introduction to classification algorithms. Similar to the variations of linear regression we have covered, variations of logistic regression can model some quite complicated data and even predict multiple categories.

Next up we have a programming exercise to do - we'll use logistic regression to predict which team will win a football (soccer) match.
