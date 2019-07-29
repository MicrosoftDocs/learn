## Training

So in the programming exercise, how did the models we built ‘train’ themselves to improve their accuracy?

![Scatter plot showing a logistic regression classification. The Y-axis represents independent variable 2, and the X-axis represents independent variable 1. The plot is roughly divided in two diagonally, with blue data points on one side, and green data points on the other side. There is a black line of best fit, which moves iteratively from the bottom of the X-axis to divide the data points diagonally.](../media/3.3_ClassificationTraining.gif)

The diagram above shows an algorithm trying to find the line that best separates the blue from the green dots. As you can see above, the algorithm changes its variables (the starting point and gradient of the line) until it finds the line that most accurately does so. This process of adjusting these variables is called __training__. Once the algorithm has completed training, and we can use it to predict new examples, it’s called a model.

There are many different ways training can work. One common method is to start with a random guess (in this case, a random line), and see whether adjustments (for example, a more or less steep gradient) give a better result. This process is repeated until adjustments do not improve the model any further, until the improvements for a change are small, or some sort of attempt limit is reached.

## Error

It is important to understand that all data has variability, which means that a models accuracy cannot usually reach 100%.

![Scatter plot showing a logistic regression classification. The Y-axis represents independent variable 2, and the X-axis represents independent variable 1. The plot is roughly divided in two diagonally, with blue data points on one side, and green data points on the other side. There is a black line of best fit, splitting the two categories diagonally. There are several blue data points within the group of green data points, and vice-versa. These data points are highlighted, as it is impossible to categorize them correctly.](../media/3.3_Error.png)

Note the outlier data points (indicated by the red dashes around them.) These outliers are examples of data that the model cannot possibly predict accurately. This error is known as “irreducible error” or “Bayes error”.

## Data quality

Much of the work in building an AI system is thinking about what data we need, how to get it, and - this is vitally important - evaluating the data quality. Checking for missing or incorrect values and removing or correcting data is called **data cleaning**.

It is common in machine learning and statistics to have datasets that have missing values. It is important, however, to be careful about how we deal with these missing values. For example, let’s say we are working with medical test results. Not all possible medical tests are run on each person, which leaves blanks in our dataset. It is important that we are careful with these empty entries. If we use a 0, for example, where no blood-pressure test was taken, and feed this data to an AI model, that model will assume that some people had blood pressure measurements of 0mmHg. This is likely to mean that the machine learning model will not perform well.

## Summary

Now you’ve been walked through the basics of classification algorithms, and used logistic regression to predict the probability of a team winning a football (soccer) match! We’ve also covered training a model, and error. Well done.

That's the end of the unit and module! Here we learned:

* __Training__ - the AI algorithm changes the variables it uses to make predictions until it reaches its lowest error rate.
* __Irreducible error__ - data points that the model cannot possibly predict accurately.
* __Bayes error__ - the lowest possible error rate, where an algorithm cannot become any more accurate.  

Now that you’ve had an introduction to classification, let’s wrap up everything you’ve learned with a quick summary of the module.
