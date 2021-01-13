### Prediction

An important aspect of data science is to find out what data can tell us
about the future. What do data about climate and pollution say about
temperatures a few decades from now? Based on a person's internet
profile, which websites are likely to interest them? How can a patient's
medical history be used to judge how well he or she will respond to a
treatment?

To answer such questions, data scientists have developed methods for
making *predictions*. In this chapter, we will study one of the most
commonly used ways of predicting the value of one variable based on the
value of another.

The foundations of the method were laid by [Sir Francis
Galton](https://en.wikipedia.org/wiki/Francis_Galton). As we saw in
Section 7.1, Galton studied how physical characteristics are passed down
from one generation to the next. Among his best known work is the
prediction of the heights of adults based on the heights of their
parents. We have studied the dataset that Galton collected for this. The
table `heights` contains his data on the midparent height and child's
height (all in inches) for a population of 934 adult "children".

``` python
# Galton's data on heights of parents and their adult children
galton = Table.read_table(path_data + 'galton.csv')
heights = Table().with_columns(
    'MidParent', galton.column('midparentHeight'),
    'Child', galton.column('childHeight')
    )
```

``` python
heights
```

``` output 
| MidParent | Child |
|-----------|-------|
| 75.43     | 73.2  |
| 75.43     | 69.2  |
| 75.43     | 69    |
| 75.43     | 69    |
| 73.66     | 73.5  |
| 73.66     | 72.5  |
| 73.66     | 65.5  |
| 73.66     | 65.5  |
| 72.06     | 71    |
| 72.06     | 68    |  

... (924 rows omitted)

```

``` python
heights.scatter('MidParent')
```

![Scatterplot of midparent height.](../media/75-prediction-5-0.png)

The primary reason for collecting the data was to be able to predict the
adult height of a child born to parents similar to those in the dataset.
We made these predictions in Section 7.1, after noticing the positive
association between the two variables.

Our approach was to base the prediction on all the points that
correspond to a midparent height of around the midparent height of the
new person. To do this, we wrote a function called `predict_child` that
takes a midparent height as its argument and returns the average height
of all the children who had midparent heights within half an inch of the
argument.

``` python
def predict_child(mpht):
    """Return a prediction of the height of a child
    whose parents have a midparent height of mpht.

    The prediction is the average height of the children
    whose midparent height is in the range mpht plus or minus 0.5 inches.
    """

    close_points = heights.where('MidParent', are.between(mpht-0.5, mpht + 0.5))
    return close_points.column('Child').mean()                       
```

We applied the function to the column of `Midparent` heights, visualized
our results.

``` python
# Apply predict_child to all the midparent heights

heights_with_predictions = heights.with_column(
    'Prediction', heights.apply(predict_child, 'MidParent')
    )
```

``` python
# Draw the original scatter plot along with the predicted values

heights_with_predictions.scatter('MidParent')
```

![Scatterplot of midparent height predictions.](../media/75-prediction-10-0.png)

The prediction at a given midparent height lies roughly at the center of
the vertical strip of points at the given height. This method of
prediction is called *regression.* Later in this chapter we will see
where this term came from. We will also see whether we can avoid our
arbitrary definitions of "closeness" being "within 0.5 inches". But
first we will develop a measure that can be used in many settings to
decide how good one variable will be as a predictor of another.

``` python
from datascience import *
%matplotlib inline
path_data = '../../../../data/'
import matplotlib.pyplot as plots
plots.style.use('fivethirtyeight')
import math
import numpy as np
from scipy import stats
```

``` python
def r_scatter(r):
    plots.figure(figsize=(5,5))
    "Generate a scatter plot with a correlation approximately r"
    x = np.random.normal(0, 1, 1000)
    z = np.random.normal(0, 1, 1000)
    y = r*x + (np.sqrt(1-r**2))*z
    plots.scatter(x, y)
    plots.xlim(-4, 4)
    plots.ylim(-4, 4)
```

### Correlation

In this section, we will develop a measure of how tightly clustered a
scatter diagram is about a straight-line. Formally, this is called
measuring *linear association*.

The table `hybrid` contains data on hybrid passenger cars sold in the
United States from 1997 to 2013. The data were adapted from the online
data archive of [Prof. Larry Winner](http://www.stat.ufl.edu/%7Ewinner/)
of the University of Florida. The columns:

-   `vehicle`: model of the car
-   `year`: year of manufacture
-   `msrp`: manufacturer's suggested retail price in 2013 dollars
-   `acceleration`: acceleration rate in km per hour per second
-   `mpg`: fuel economy in miles per gallon
-   `class`: the model's class.

``` python
hybrid = Table.read_table(path_data + 'hybrid.csv')
```

``` python
hybrid
```

``` output
| vehicle         | year | msrp    | acceleration | mpg   | class      |
|-----------------|------|---------|--------------|-------|------------|
| Prius (1st Gen) | 1997 | 24509.7 | 7.46         | 41.26 | Compact    |
| Tino            | 2000 | 35355   | 8.2          | 54.1  | Compact    |
| Prius (2nd Gen) | 2000 | 26832.2 | 7.97         | 45.23 | Compact    |
| Insight         | 2000 | 18936.4 | 9.52         | 53    | Two Seater |
| Civic (1st Gen) | 2001 | 25833.4 | 7.04         | 47.04 | Compact    |
| Insight         | 2001 | 19036.7 | 9.52         | 53    | Two Seater |
| Insight         | 2002 | 19137   | 9.71         | 53    | Two Seater |
| Alphard         | 2003 | 38084.8 | 8.33         | 40.46 | Minivan    |
| Insight         | 2003 | 19137   | 9.52         | 53    | Two Seater |
| Civic           | 2003 | 14071.9 | 8.62         | 41    | Compact    |  

... (143 rows omitted)
```

The graph below is a scatter plot of `msrp` *versus* `acceleration`.
That means `msrp` is plotted on the vertical axis and `acceleration` on
the horizontal.

``` python
hybrid.scatter('acceleration', 'msrp')
```

![Scatterplot of acceleration and msrp.](../media/76-correlation-7-0.png)

Notice the positive association. The scatter of points is sloping
upwards, indicating that cars with greater acceleration tended to cost
more, on average; conversely, the cars that cost more tended to have
greater acceleration on average.

The scatter diagram of MSRP versus mileage shows a negative association.
Hybrid cars with higher mileage tended to cost less, on average. This
seems surprising until you consider that cars that accelerate fast tend
to be less fuel efficient and have lower mileage. As the previous
scatter plot showed, those were also the cars that tended to cost more.

``` python
hybrid.scatter('mpg', 'msrp')
```

![Scatterplot of mpg and msrp.](../media/76-correlation-9-0.png)

Along with the negative association, the scatter diagram of price versus
efficiency shows a non-linear relation between the two variables. The
points appear to be clustered around a curve, not around a straight-line.

If we restrict the data just to the SUV class, however, the association
between price and efficiency is still negative but the relation appears
to be more linear. The relation between the price and acceleration of
SUVs also shows a linear trend, but with a positive slope.

``` python
suv = hybrid.where('class', 'SUV')
suv.scatter('mpg', 'msrp')
```

![Scatterplto of mpg and msrp.](../media/76-correlation-11-0.png)

``` python
suv.scatter('acceleration', 'msrp')
```

![Scatterplot of acceleration and msrp.](../media/76-correlation-12-0.png)

You will have noticed that we can derive useful information from the
general orientation and shape of a scatter diagram even without paying
attention to the units in which the variables were measured.

Indeed, we could plot all the variables in standard units and the plots
would look the same. This gives us a way to compare the degree of
linearity in two scatter diagrams.

Recall that in an earlier section we defined the function
`standard_units` to convert an array of numbers to standard units.

``` python
def standard_units(any_numbers):
    "Convert any array of numbers to standard units."
    return (any_numbers - np.mean(any_numbers))/np.std(any_numbers)  
```

We can use this function to redraw the two scatter diagrams for SUVs,
with all the variables measured in standard units.

``` python
Table().with_columns(
    'mpg (standard units)',  standard_units(suv.column('mpg')),
    'msrp (standard units)', standard_units(suv.column('msrp'))
).scatter(0, 1)
plots.xlim(-3, 3)
plots.ylim(-3, 3);
```

![Correlation example.](../media/76-correlation-16-0.png)

``` python
Table().with_columns(
    'acceleration (standard units)', standard_units(suv.column('acceleration')),
    'msrp (standard units)',         standard_units(suv.column('msrp'))
).scatter(0, 1)
plots.xlim(-3, 3)
plots.ylim(-3, 3);
```

![Correlation example.](../media/76-correlation-17-0.png)

The associations that we see in these figures are the same as those we
saw before. Also, because the two scatter diagrams are now drawn on
exactly the same scale, we can see that the linear relation in the
second diagram is a little more fuzzy than in the first.

We will now define a measure that uses standard units to quantify the
kinds of association that we have seen.

### The correlation coefficient

The *correlation coefficient* measures the strength of the linear
relationship between two variables. Graphically, it measures how
clustered the scatter diagram is around a straight-line.

The term *correlation coefficient* isn't easy to say, so it is
shortened to *correlation* and denoted by $r$.

Here are some mathematical facts about $r$ that we will just observe by
simulation.

-   The correlation coefficient $r$ is a number between $-1$ and 1.
-   $r$ measures the extent to which the scatter plot clusters around a
    straight-line.
-   $r = 1$ if the scatter diagram is a perfect straight-line sloping
    upwards, and $r = -1$ if the scatter diagram is a perfect straight-line sloping downwards.

The function `r_scatter` takes a value of $r$ as its argument and
simulates a scatter plot with a correlation close to $r$. Because
of randomness in the simulation, the correlation is not expected to be
exactly equal to $r$.

Call `r_scatter` a few times, with different values of $r$ as the
argument, and see how the scatter plot changes.

When $r=1$ the scatter plot is perfectly linear and slopes upward. When
$r=-1$, the scatter plot is perfectly linear and slopes downward. When
$r=0$, the scatter plot is a formless cloud around the horizontal axis,
and the variables are said to be *uncorrelated*.

``` python
r_scatter(0.9)
```

![scatterplot when r is 0.9](../media/76-correlation-21-0.png)

``` python
r_scatter(0.25)
```

![scatterplot when r is 0.25](../media/76-correlation-22-0.png)

``` python
r_scatter(0)
```

![scatterplot when r is 0](../media/76-correlation-23-0.png)

``` python
r_scatter(-0.55)
```

![scatterplot when r is -0.55](../media/76-correlation-24-0.png)

### Calculating $r$

The formula for $r$ is not apparent from our observations so far. It has
a mathematical basis that is outside the scope of this class. However,
as you will see, the calculation is straightforward and helps us
understand several of the properties of $r$.

**Formula for $r$**:

**$r$ is the average of the products of the two variables, when both
variables are measured in standard units.**

Here are the steps in the calculation. We will apply the steps to a
simple table of values of $x$ and $y$.

``` python
x = np.arange(1, 7, 1)
y = make_array(2, 3, 1, 5, 2, 7)
t = Table().with_columns(
        'x', x,
        'y', y
    )
t
```

``` output
| x | y |
|---|---|
| 1 | 2 |
| 2 | 3 |
| 3 | 1 |
| 4 | 5 |
| 5 | 2 |
| 6 | 7 |

```

Based on the scatter diagram, we expect that $r$ will be positive but
not equal to 1.

``` python
t.scatter(0, 1, s=30, color='red')
```

![scatterplot example.](../media/76-correlation-28-0.png)

**Step 1.** Convert each variable to standard units.

``` python
t_su = t.with_columns(
        'x (standard units)', standard_units(x),
        'y (standard units)', standard_units(y)
    )
t_su
```

``` code
| x | y | x (standard units) | y (standard units) |
|---|---|--------------------|--------------------|
| 1 | 2 | -1.46385           | -0.648886          |
| 2 | 3 | -0.87831           | -0.162221          |
| 3 | 1 | -0.29277           | -1.13555           |
| 4 | 5 | 0.29277            | 0.811107           |
| 5 | 2 | 0.87831            | -0.648886          |
| 6 | 7 | 1.46385            | 1.78444            |  
```

**Step 2.** Multiply each pair of standard units.

``` python
t_product = t_su.with_column('product of standard units', t_su.column(2) * t_su.column(3))
t_product
```

``` output
| x | y | x (standard units) | y (standard units) | product of standard units |
|---|---|--------------------|--------------------|---------------------------|
| 1 | 2 | -1.46385           | -0.648886          | 0.949871                  |
| 2 | 3 | -0.87831           | -0.162221          | 0.142481                  |
| 3 | 1 | -0.29277           | -1.13555           | 0.332455                  |
| 4 | 5 | 0.29277            | 0.811107           | 0.237468                  |
| 5 | 2 | 0.87831            | -0.648886          | -0.569923                 |
| 6 | 7 | 1.46385            | 1.78444            | 2.61215                   |

```

**Step 3.** $r$ is the average of the products computed in Step 2.

``` python
# r is the average of the products of standard units

r = np.mean(t_product.column(4))
r
```

``` output
0.6174163971897709
```

As expected, $r$ is positive but not equal to 1.

### Properties of $r$

The calculation shows that:

-   $r$ is a pure number. It has no units. This is because $r$ is based
    on standard units.
-   $r$ is unaffected by changing the units on either axis. This too is
    because $r$ is based on standard units.
-   $r$ is unaffected by switching the axes. Algebraically, this is
    because the product of standard units does not depend on which
    variable is called $x$ and which $y$. Geometrically, switching axes
    reflects the scatter plot about the line $y=x$, but does not change
    the amount of clustering nor the sign of the association.

``` python
t.scatter('y', 'x', s=30, color='red')
```

![scatterplot of y and x.](../media/76-correlation-37-0.png)

### The `correlation` function

We are going to be calculating correlations repeatedly, so it will help
to define a function that computes it by performing all the steps
described above. Let's define a function `correlation` that takes a
table and the labels of two columns in the table. The function returns
$r$, the mean of the products of those column values in standard units.

``` python
def correlation(t, x, y):
    return np.mean(standard_units(t.column(x))*standard_units(t.column(y)))
```

Let's call the function on the `x` and `y` columns of `t`. The function
returns the same answer to the correlation between $x$ and $y$ as we got
by direct application of the formula for $r$.

``` python
correlation(t, 'x', 'y')
```

``` output
0.6174163971897709
```

As we noticed, the order in which the variables are specified doesn't
matter.

``` python
correlation(t, 'y', 'x')
```

``` output
0.6174163971897709
```

Calling `correlation` on columns of the table `suv` gives us the
correlation between price and mileage as well as the correlation between
price and acceleration.

``` python
correlation(suv, 'mpg', 'msrp')
```

``` output
-0.6667143635709919
```

``` python
correlation(suv, 'acceleration', 'msrp')
```

``` output
0.48699799279959155
```

These values confirm what we had observed:

-   There is a negative association between price and efficiency,
    whereas the association between price and acceleration is positive.
-   The linear relation between price and acceleration is a little
    weaker (correlation about 0.5) than between price and mileage
    (correlation about -0.67).

Correlation is a simple and powerful concept, but it is sometimes
misused. Before using $r$, it is important to be aware of what
correlation does and does not measure.

### Association is not causation

Correlation only measures association. Correlation does not imply
causation. Though the correlation between the weight and the math
ability of children in a school district may be positive, that does not
mean that doing math makes children heavier or that putting on weight
improves the children's math skills. Age is a confounding variable:
older children are both heavier and better at math than younger
children, on average.

### Correlation measures *linear* association

Correlation measures only one kind of association--linear. Variables
that have strong non-linear association might have low correlation.
Here is an example of variables that have a perfect quadratic relation
$y = x^2$ but have correlation equal to 0.

``` python
new_x = np.arange(-4, 4.1, 0.5)
nonlinear = Table().with_columns(
        'x', new_x,
        'y', new_x**2
    )
nonlinear.scatter('x', 'y', s=30, color='r')
```

![nonlinear scatterplot example.](../media/76-correlation-51-0.png)

``` python
correlation(nonlinear, 'x', 'y')
```

0.0

### Correlation is affected by outliers

Outliers can have a significant effect on correlation. Here is an example where
a scatter plot for which $r$ is equal to 1 is turned into a plot for
which $r$ is equal to 0, by the addition of just one outlying point.

``` python
line = Table().with_columns(
        'x', make_array(1, 2, 3, 4),
        'y', make_array(1, 2, 3, 4)
    )
line.scatter('x', 'y', s=30, color='r')
```

![outliers.](../media/76-correlation-54-0.png)

``` python
correlation(line, 'x', 'y')
```

``` output
1.0

```

``` python
outlier = Table().with_columns(
        'x', make_array(1, 2, 3, 4, 5),
        'y', make_array(1, 2, 3, 4, 0)
    )
outlier.scatter('x', 'y', s=30, color='r')
```

![outlier examples.](../media/76-correlation-56-0.png)

``` python
correlation(outlier, 'x', 'y')
```

``` output
0.0
```

### Ecological correlations should be interpreted with care

Correlations based on aggregated data can be misleading. As an example,
here are data on the Critical Reading and Math SAT scores in 2014. There
is one point for each of the 50 states and one for Washington, D.C. The
column `Participation Rate` contains the percent of high school seniors
who took the test. The next three columns show the average score in the
state on each portion of the test, and the final column is the average
of the total scores on the test.

``` python
sat2014 = Table.read_table(path_data + 'sat2014.csv').sort('State')
sat2014
```

``` output 
| State                | Participation Rate | Critical Reading | Math | Writing | Combined |
|----------------------|--------------------|------------------|------|---------|----------|
| Alabama              | 6.7                | 547              | 538  | 532     | 1617     |
| Alaska               | 54.2               | 507              | 503  | 475     | 1485     |
| Arizona              | 36.4               | 522              | 525  | 500     | 1547     |
| Arkansas             | 4.2                | 573              | 571  | 554     | 1698     |
| California           | 60.3               | 498              | 510  | 496     | 1504     |
| Colorado             | 14.3               | 582              | 586  | 567     | 1735     |
| Connecticut          | 88.4               | 507              | 510  | 508     | 1525     |
| Delaware             | 100                | 456              | 459  | 444     | 1359     |
| District of Columbia | 100                | 440              | 438  | 431     | 1309     |
| Florida              | 72.2               | 491              | 485  | 472     | 1448     |  

... (41 rows omitted)
```

The scatter diagram of Math scores versus Critical Reading scores is
tightly clustered around a straight-line; the correlation is close
to 0.985.

``` python
sat2014.scatter('Critical Reading', 'Math')
```

![2014 SAT scores scatterplot.](../media/76-correlation-61-0.png)

``` python
correlation(sat2014, 'Critical Reading', 'Math')
```

``` output
0.9847558411067434
```

That's a high correlation. But it's important to note that
this does not reflect the strength of the relation between the Math and
Critical Reading scores of *students*.

The data consist of average scores in each state. But states don't take
tests--students do. The data in the table have been created by lumping
all the students in each state into a single point at the average values
of the two variables in that state. But not all students in the state
will be at that point, as students vary in their performance. If you
plot a point for each student instead of just one for each state, there
will be a cloud of points around each point in the figure above. The
overall picture will be more fuzzy. The correlation between the Math and
Critical Reading scores of the students will be *lower* than the value
calculated based on state averages.

Correlations based on aggregates and averages are called *ecological
correlations* and are frequently reported. As we have seen, they
must be interpreted with care.

### Serious or tongue-in-cheek?

In 2012, a
[paper](http://www.biostat.jhsph.edu/courses/bio621/misc/Chocolate%20consumption%20cognitive%20function%20and%20nobel%20laurates%20%28NEJM%29.pdf)
in the respected New England Journal of Medicine examined the relation
between chocolate consumption and Nobel Prizes in a group of countries.
The [Scientific
American](http://blogs.scientificamerican.com/the-curious-wavefunction/chocolate-consumption-and-nobel-prizes-a-bizarre-juxtaposition-if-there-ever-was-one/)
responded seriously whereas
[others](https://www.reuters.com/article/us-eat-chocolate-win-the-nobel-prize-idUSBRE8991MS20121010)
were more relaxed. You are welcome to make your own decision! The
following graph, provided in the paper, should motivate you to take a look.

``` python

from IPython.display import Image
Image("../../../images/chocoNobel.png")
```

![choconobel](../media/76-correlation-65-0.png)

``` python
from IPython.display import Image
Image("../media/choco-nobel.png")
```

![choconobel](../media/76-correlation-65-0.png)

## Learning objectives

- Learn about Correlation as a measure of linear association and the correlation coefficient.
- Understand the Regression line, Regression Effect, and the equation of the regression line.
- Motivate The Method of Least Squares, Least Square Regression, & Nonlinear Regression
- Understand Residuals and residual diagnostics through residual plots.

## Check your knowledge
