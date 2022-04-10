Regression works by establishing a relationship between variables in the data. Characteristics of the thing being observed are known as the *features*. The variable you're trying to predict is known as the *label*.

Recall that your company rents bicycles and wants to predict the expected number of rentals in a day. In this example, features include the day of the week and month. The label is the number of bicycle rentals.

To train the model, you'll start with a data sample that contains the features and known values for the label. In this case, you need historical data that includes dates, weather conditions, and the number of bicycle rentals.

You'll then split this data sample into two subsets:

- **A training dataset.** You'll apply an algorithm that determines a function that encapsulates the relationship between the feature values and the known label values.
- **A validation or test dataset.** You can use it to evaluate the model by using it to generate predictions for the label and comparing them to the actual known label values.

The use of historic data with known label values to train a model makes regression an example of supervised machine learning.

## A simple example

Let's use an example to see how the training and evaluation process works in principle. You'll simplify the scenario so that you use a single feature to predict the bicycle rentals label. This feature is the average daily temperature.

You start with some data that includes known values for the average daily temperature feature and the bicycle rentals label.

|Temperature      |Rentals      |
|-----------------|-------------|
|**56**           |115          |
|**61**           |126          |
|**67**           |137          |
|**72**           |140          |
|**76**           |152          |
|**82**           |156          |
|**54**           |114          |
|**62**           |129          |

Now you'll randomly select five of these observations and use them to train a regression model. When we talk about "training a model," what we mean is finding a function that's:

- A mathematical equation:

    - Called *f*

- That can use the temperature feature:

    - Called *x*

- To calculate the number of rentals:

    - Called *y*

In other words, you need to define the following function: *f(x) = y*.

Our training dataset looks like this table:

|x                |y              |
|-----------------|---------------|
|**56**           |115            |
|**61**           |126            |
|**67**           |137            |
|**72**           |140            |
|**76**           |152            |

To start, let's plot the training values for *x* and *y* on a chart:

:::image type="content" source="../media/rentals-temperature-graph.png" alt-text="Graph plotting the training values for x rentals and y temperature." border="false":::

Now you need to fit these values to a function and allow for some random variation. The plotted points form an almost straight diagonal line. In other words, there's an apparent linear relationship between *x* and *y*.

You need to find a linear function that's the best fit for the data sample. You can use various algorithms to determine this function. The function will ultimately find a straight line with minimal overall variance from the plotted points, like this example:

:::image type="content" source="../media/rentals-temperature-linear-function-graph.png" alt-text="Graph showing the linear function between x and y." border="false":::

The line represents a linear function that can be used with any value of *x* to apply the *slope* of the line and its *intercept* to calculate *y*. The intercept is where the line crosses the *y* axis when *x* is 0.

In this case, if you extend the line to the left, you find that when *x* is 0, *y* is around 20. The slope of the line is such that for each unit of *x* you move along to the right, *y* increases by around 1.7. Our *f* function can be calculated as 20 + 1.7 *x*.

You've defined your predictive function. Now you can use it to predict labels for the validation data you held back. You can compare the predicted values with the actual known *y* values. You typically indicate the predicted values with the symbol *ŷ*, or "y-hat."

|x         |y          |ŷ       |
|----------|-----------|--------|
|**82**    |156        |159.4   |
|**54**    |114        |111.8   |
|**62**    |129        |125.4   |

Let's see how the *y* and *ŷ* values compare in a plot:

:::image type="content" source="../media/linear-function-y-and-y-hat-graph.png" alt-text="Graph plotting the predicted y-hat values and the actual y values." border="false":::

The plotted points that are on the function line are the predicted *ŷ* values calculated by the function. The other plotted points are the actual *y* values.

You can measure the variance between the predicted and actual values in various ways. You can use these metrics to evaluate how well the model predicts.

> [!NOTE]
> Machine learning is based in statistics and math. Statisticians, mathematicians, and data scientists use specific terms.
>
> Think of the difference between a predicted label value and the actual label value as a measure of error. In practice, the "actual" values are based on sample observations. These observations might be subject to some random variance.
>
> To make it clear that we're comparing a predicted value (*ŷ*) with an observed value (*y*), we refer to the difference between them as a *residual*. You can summarize the residuals for all the validation data predictions to calculate the overall loss in the model as a measure of its predictive performance.

One of the most common ways to measure the loss is to square the individual residuals, sum the squares, and calculate the mean. Squaring the residuals has the effect of basing the calculation on absolute values (ignoring whether the difference is negative or positive) and giving more weight to larger differences. This metric is called the *mean squared error* (MSE).

For our validation data, the calculation looks like this example:

|x          |y         |ŷ       |(y - ŷ)2        |
|-----------|----------|--------|----------------|
|**156**    |159.4     |-3.4    | 11.56          |
|**114**    |111.8     |2.2     | 4.84           |
|**129**    |125.4     |3.6     | 12.96          |
|           |Sum       |∑       | 29.36          |
|           |Mean      |x¯      | 9.79           |

So the loss for your model based on the MSE metric is 9.79.

Is that any good? It's difficult to tell because the MSE value isn't expressed in a meaningful unit of measurement. We know that the lower the value is, the less loss there is in the model, so the better it is at predicting. This makes it a useful metric to compare two models and find the one that performs best.

Sometimes it's more useful to express the loss in the same unit of measurement as the predicted label value. In this case, it's the number of rentals. It's possible to calculate the square root of the MSE, which produces a metric known as the *root mean squared error* (RMSE):

√9.79 = *3.13*

Your model's RMSE indicates that the loss is just over 3. You can interpret this RMSE as meaning that on average, incorrect predictions are wrong by around three rentals.

Many other metrics can be used to measure loss in a regression. For example, *R<sup>2</sup>*, known as R squared and sometimes known as the *coefficient of determination*, is the correlation between *x* and *y* squared. This metric produces a value between 0 and 1 that measures the amount of variance that can be explained by the model. Generally, the closer this value is to 1, the better the model predicts.
