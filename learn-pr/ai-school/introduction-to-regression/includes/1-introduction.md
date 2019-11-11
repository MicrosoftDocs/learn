Regression can be thought of as looking for a trend line in our data. When used in machine learning, that line allows us to predict a numeric value based on features. We could use regression to predict things like:

* How much money something will cost
* What's the expected temperature tomorrow
* How many days until you need to replace your car battery

For example, if we had a data set with just two features, year and temperature, we could plot those features on a chart and create a trend line that would help us predict the temperature of future years.

![Line graph describing the annual temperature. The Y-axis represents temperature abnormality and the X-axis represents the year. The graph shows temperature variation over the years, starting at -0.2-celsius abnormality at 1880. The data points vary between 0 celsius and -0.4 celsius until 1940, but with trend upwards to 1 celsius from 1940 to 2020](../media/2-1-a.png)

**Regression fits a line through data**. Here the features we are using are people’s height and shoe size, which allow us to answer if tall people have bigger feet.

![Scatter plot graph showing height and shoe size with a line of best fit showing a linear relationship between shoe size and height. The Y-axis represents show size and the X-axis represents height in centimeters. The graph shows shoe size beginning at 6, with height at 120 centimeters. As height increases to 200 centimeters, shoe size increases, almost perfectly linearly, from 6 to 15.](../media/2-1-d.png)

Because these regression algorithms let us understand relationships like shoe size in relation to height, we can use them to predict a label (someones shoe size) if we have a relevant feature (their height). If we have enough examples, the trend line can be very accurate.

Seeing these trend lines is relatively easy when we only are using one feature to predict another. The accuracy of predictions goes up when we have more relevant features, but it's much harder to see the trends visually. Below we are charting three features, **car weight**, **horsepower**, and **fuel efficiency**.

![3D scatter plot showing Car fuel efficiency by car weight and horsepower. The Y-axis represents fuel efficiency (kilometers per liter), the X-axis represents car weight (tonne), and the Z-axis represents horsepower. Data points begin at 1 tonne, with a high efficiency around 11 kilometers per liter. All data points are between 100 horsepower and 600 horsepower. As car weight increases, the fuel efficiency decreases from 11 kilometers per liter to 6.](../media/2-1-c.png)

Even with three features it is much more difficult to spot the trend in the previous chart. Regression algorithms don't have the same limitation we have visually. Trends can be identified and used for predictions with hundreds or even thousands of features.

From the three examples above, if we have enough data points to plot, we might be able to accurately predict:

* The average temperature next year
* The shoe size of a person based on how tall they are
* The fuel efficiency of a car based on its weight and horsepower

**In this module, you will learn to:**

* Define regression.
* Make predictive models with variations of linear regression.
* Make predictions on non-linear data with regression.
