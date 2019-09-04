Support vector machines (SVMs) are one of the most elegant solutions in machine learning and are vital tools in biology, and many other areas of science and industry.. They can be used for both classification and regression problems, and can be easily coded in Python and R. In this module, we'll use them for classification.

## Hyperplanes

A hyperplane is a boundary that divides data points - SVMs can try to find a hyperplane that separates different kinds of data points as accurately as possible. In the example below, it has separated the dots on the bottom left (blue) from those in the top right (green) using the black line (hyperplane). Data points are classified based on which side of the black line they fall upon.

![Scatter plot showing a linear support vector machine. The plot has two classes of data points - green and blue data points. They are on opposite diagonal sides of the plot, divided by a black line, which represents the hyperplane. There are two red lines either side of the black line, which intersects with several of the data points on each side - these are margins. There are no data points between the red lines.](../media/2.4_LinearSupportVectorMachine.png)

This is like our logistic regression programming exercise, but the SVM tries to make the margin between the two lines as large as possible. This is known as a maximum margin SVM. This is done so the SVM is as accurate as possible when you introduce new data.

## Error

It is important to understand that all data has variability, which means that a models accuracy cannot usually reach 100%.

![Scatter plot showing a logistic regression classification. The Y-axis represents independent variable 2, and the X-axis represents independent variable 1. The plot is roughly divided in two diagonally, with blue data points on one side, and green data points on the other side. There is a black line of best fit, splitting the two categories diagonally. There are several blue data points within the group of green data points, and vice-versa. These data points are highlighted, as it is impossible to categorize them correctly.](../media/3.3_Error.png)

Note the outlier data points (indicated by the red dashes around them.) These outliers are examples of data that the model cannot possibly predict accurately. This error is known as “irreducible error” or “Bayes error”.

### Data quality

Much of the work in building an AI system is thinking about what data we need, how to get it, and - this is vitally important - evaluating the data quality. Checking for missing or incorrect values and removing or correcting data is called **data cleaning**.

It is common in machine learning and statistics to have datasets that have missing values. It is important, however, to be careful about how we deal with these missing values. For example, let’s say we are working with medical test results. Not all possible medical tests are run on each person, which leaves blanks in our dataset. It is important that we are careful with these empty entries. If we use a 0, for example, where no blood-pressure test was taken, and feed this data to an AI model, that model will assume that some people had blood pressure measurements of 0mmHg. This is likely to mean that the machine learning model will not perform well.
