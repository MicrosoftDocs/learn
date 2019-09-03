

## Error

It is important to understand that all data has variability, which means that a models accuracy cannot usually reach 100%.

![Scatter plot showing a logistic regression classification. The Y-axis represents independent variable 2, and the X-axis represents independent variable 1. The plot is roughly divided in two diagonally, with blue data points on one side, and green data points on the other side. There is a black line of best fit, splitting the two categories diagonally. There are several blue data points within the group of green data points, and vice-versa. These data points are highlighted, as it is impossible to categorize them correctly.](../media/3.3_Error.png)

Note the outlier data points (indicated by the red dashes around them.) These outliers are examples of data that the model cannot possibly predict accurately. This error is known as “irreducible error” or “Bayes error”.

## Data quality

Much of the work in building an AI system is thinking about what data we need, how to get it, and - this is vitally important - evaluating the data quality. Checking for missing or incorrect values and removing or correcting data is called **data cleaning**.

It is common in machine learning and statistics to have datasets that have missing values. It is important, however, to be careful about how we deal with these missing values. For example, let’s say we are working with medical test results. Not all possible medical tests are run on each person, which leaves blanks in our dataset. It is important that we are careful with these empty entries. If we use a 0, for example, where no blood-pressure test was taken, and feed this data to an AI model, that model will assume that some people had blood pressure measurements of 0mmHg. This is likely to mean that the machine learning model will not perform well.

Now that you’ve had an introduction to classification, let’s wrap up everything you’ve learned with a quick summary of the module.
