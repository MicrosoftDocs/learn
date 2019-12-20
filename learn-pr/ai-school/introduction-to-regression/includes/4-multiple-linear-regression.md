Linear regression using multiple features is called **multiple linear regression**. Multiple linear regression is similar to simple linear regression, but rather than just using one feature to predict a label, it uses multiple features.

Consider a scenario where you work for a government regulatory agency. You're responsible for identifying diesel vehicles with highly toxic emissions. You want to create a model that will predict which vehicles are likely to produce more emissions. Those vehicles will be subject to expensive emissions testing.

A basic version of this predictive model could use two features, weight and horsepower to make the prediction. The graph below shows that we actually fit a plane instead of a line when working with two input features. We can think of a plane as a two-dimensional extrusion of a line, so we still think of this as "linear" regression.

![Three-dimensional plot showing multiple linear regression. The Y-axis represents CO2 emissions (grams per kilometer), the X-axis represents car weight (ton), and the Z-axis represents horsepower. A flat square begins at the bottom the Y-axis. The square then rises and adjusts its coordinates to cover the data points in the middle of the three-dimension plot as best it can.](../media/2-3-a.gif)

It's common to use hundreds or thousands of features, but it becomes nearly impossible to visualize as a graph above three dimensions.

## Choosing features for multiple linear regression

You can select which features to use to train your models, and using good features will allow your models to become more accurate. Usually, good features are things that are related to what you want to measure or predict. For example, if you're using a machine learning model to try to identify the breed of a dog, features such as tail curl, weight, height, and ear droop might be quite useful, whereas the dog’s age is not likely to be very useful.

For most kinds of machine learning, selecting features yourself is important in making accurate models.

Features should appear in the data set many times, as models need many examples in order to learn. If you gathered data about three species of flowers to predict their petal length, adding a single example of a new species would not be recommended.
