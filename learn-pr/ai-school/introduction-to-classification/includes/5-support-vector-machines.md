Support vector machines (SVMs) are one of the most elegant solutions in machine learning and are vital tools in biology, and many other areas of science and industry. They can be used for both classification and regression problems, and can be easily coded in Python and R. In this module, we'll use them for classification.

## Hyperplanes

A hyperplane is a boundary that divides data points - SVMs try to find a hyperplane that separates different kinds of data points as accurately as possible. In the example below, it has separated the dots on the bottom left (blue) from those in the top right (green) using the black line (hyperplane). Data points are classified based on which side of the black line they fall upon.

![Scatter plot showing a linear support vector machine. The plot has two classes of data points - green and blue data points. They are on opposite diagonal sides of the plot, divided by a black line, which represents the hyperplane. There are two red lines either side of the black line, which intersects with several of the data points on each side - these are margins. There are no data points between the red lines.](../media/24-lsvm.png)

This is like our logistic regression programming exercise, but the SVM tries to make the margin between the two lines as large as possible. This is known as a maximum margin SVM. This is done so the SVM is as accurate as possible when you introduce new data.

## Support vectors and margins

The SVM calculates the hyperplanes and margins by using the data points from the different categories that are closest together.  
  
These data points are called support vectors - this is where SVMs get their name from.
  
![Scatter plot showing a linear support vector machine. The plot has two classes of data points - green and blue data points. They are on opposite diagonal sides of the plot, divided by a black line that represents the hyperplane. There are two red lines either side of the black line, which intersects with several of the data points on each side - these are margins. There are no data points between the red lines. The data points that the red lines intersect with are labeled as 'support vectors'.](../media/24-svm-01.png)

Data points on the margin are called support vectors (hence, the model is called a support vector machine). SVMs can perform well with large, non-linear, complex data sets too.

![Scatter plot showing a non-linear support vector machine. The plot has two types of data points - green and blue data points. They are on opposite diagonal sides of the plot, divided by a non-linear black line that represents the hyperplane. There are two red lines either side of the black line, which intersects with several of the data points on each side - these are margins. There are no data points between the red lines.](../media/24-svm-02.png)

New examples introduced to an SVM model are labeled with a category based on which side of the margin they fall upon. If desired, the number of hyperplanes can be increased, allowing many different types of labels. This is useful in text and image classification. SVMs have been widely applied in biology in areas such as accurately classifying proteins and DNA sequences.

### Error

It is important to understand that all data has variability, which means that a models accuracy cannot usually reach 100%.

![Scatter plot showing a logistic regression classification. The Y-axis represents independent variable 2, and the X-axis represents independent variable 1. The plot is roughly divided in two diagonally, with blue data points on one side, and green data points on the other side. There is a black line of best fit, splitting the two categories diagonally. There are several blue data points within the group of green data points, and vice-versa. These data points are highlighted, as it is impossible to categorize them correctly.](../media/33-e.png)

Note the outlier data points (indicated by the red dashes around them.) These outliers are examples of data that the model cannot possibly predict accurately. This error is known as “irreducible error” or “Bayes error”.
