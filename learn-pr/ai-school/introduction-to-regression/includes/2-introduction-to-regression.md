Regression can be thought of as looking for a trend line in our data. When used in machine learning, that line allows us to predict a numeric value based on features. We could use regressions to predict things like:

* Are temperatures changing over time?
  In this case, the features are __temperature__ and __year__.
![Line graph describing the annual temperature. The Y-axis represents temperature abnormality and the X-axis represents the year. The graph shows temperature variation over the years, starting at -0.2-celsius abnormality at 1880. The data points vary between 0 celsius and -0.4 celsius until 1940, but with trend upwards to 1 celsius from 1940 to 2020](../media/2-1-a.png)
* Do tall people have bigger feet?
  In this case, the features are people’s __height__ and __shoe size__.
![Scatter plot graph showing height and shoe size. The Y-axis represents show size and the X-axis represents height in centimeters. The graph shows shoe size beginning at 6, with height at 120 centimeters. As height increases to 200 centimeters, shoe size increases, almost perfectly linearly, from 6 to 15.](../media/2-1-b.png)
   This is all a complicated way of saying that __regression fits a line through data__. For example:
   ![Previous scatter plot graph showing height and shoe size is shown again, but with a line of best fit showing a linear relationship between shoe size and height. The Y-axis represents show size and the X-axis represents height in centimeters. The graph shows shoe size beginning at 6, with height at 120 centimeters. As height increases to 200 centimeters, shoe size increases, almost perfectly linearly, from 6 to 15.](../media/2-1-d.png)

Using regression, we can visually see the trends in the previous charts. Seeing these trends is easy when we only are using one feature. The accuracy of predictions increases when we use more relevant features, but it's much harder to see the trends visually. Below we are using two features, car weight and horsepower to predict fuel efficiency.
![3D scatter plot showing Car fuel efficiency by car weight and horsepower. The Y-axis represents fuel efficiency (kilometers per liter), the X-axis represents car weight (tonne), and the Z-axis represents horsepower. Data points begin at 1 tonne, with a high efficiency around 11 kilometers per liter. All data points are between 100 horsepower and 600 horsepower. As car weight increases, the fuel efficiency decreases from 11 kilometers per liter to 6.](../media/2-1-c.png)

Even with one extra feature it is much more difficult to spot the trend in the previous chart. Regression models don't have the same limitation we have visually. We can identify trends and use them for predictions with hundreds or even thousands of features.

Because these __regression models__ let us understand relationships like height in relation to shoe size, we can also use them to predict future events or estimate features of things we haven’t seen before. From the three examples above we might be able to:

* predict the average temperature next year.
* estimate the shoe size of a person based on how tall they are.
* estimate the fuel efficiency of a car based on its weight and horsepower.

In this module, we will cover two kinds of simple regression. These work in a similar way, but fit differently shaped lines:

* __Linear regression__ fits *straight* lines.
* __Polynomial regression__ fits *curved* lines.

## Summary

That's the introduction done! In this, we covered:

* __Regression__ - looking for a trend in data, predicting a number.
* __Linear regression__ - fits straight-line relationships.
* __Polynomial regression__ - fits curved line relationships.

Next we'll look at simple linear regression - predicting a value using one feature.