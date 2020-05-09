``` {.python}
from datascience import *
import matplotlib
path_data = '../../../data/'
matplotlib.use('Agg', warn=False)
%matplotlib inline
import matplotlib.pyplot as plots
plots.style.use('fivethirtyeight')
import numpy as np
```

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

``` {.python}
# Galton's data on heights of parents and their adult children
galton = Table.read_table(path_data + 'galton.csv')
heights = Table().with_columns(
    'MidParent', galton.column('midparentHeight'),
    'Child', galton.column('childHeight')
    )
```

``` {.python}
heights
```

<table border="1" class="dataframe">
<thead>
<tr>
<th>
MidParent
</th>
<th>
Child
</th>
</tr>
</thead>
<tbody>
<tr>
<td>
75.43
</td>
<td>
73.2
</td>
</tr>
<tr>
<td>
75.43
</td>
<td>
69.2
</td>
</tr>
<tr>
<td>
75.43
</td>
<td>
69
</td>
</tr>
<tr>
<td>
75.43
</td>
<td>
69
</td>
</tr>
<tr>
<td>
73.66
</td>
<td>
73.5
</td>
</tr>
<tr>
<td>
73.66
</td>
<td>
72.5
</td>
</tr>
<tr>
<td>
73.66
</td>
<td>
65.5
</td>
</tr>
<tr>
<td>
73.66
</td>
<td>
65.5
</td>
</tr>
<tr>
<td>
72.06
</td>
<td>
71
</td>
</tr>
<tr>
<td>
72.06
</td>
<td>
68
</td>
</tr>
</tbody>
</table>
<p>
... (924 rows omitted)
</p>
``` {.python}
heights.scatter('MidParent')
```

![png](../media/75-prediction-5-0.png)

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

``` {.python}
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

``` {.python}
# Apply predict_child to all the midparent heights

heights_with_predictions = heights.with_column(
    'Prediction', heights.apply(predict_child, 'MidParent')
    )
```

``` {.python}
# Draw the original scatter plot along with the predicted values

heights_with_predictions.scatter('MidParent')
```

![png](../media/75-prediction-10-0.png)

The prediction at a given midparent height lies roughly at the center of
the vertical strip of points at the given height. This method of
prediction is called *regression.* Later in this chapter we will see
where this term came from. We will also see whether we can avoid our
arbitrary definitions of "closeness" being "within 0.5 inches". But
first we will develop a measure that can be used in many settings to
decide how good one variable will be as a predictor of another.

``` {.python}
from datascience import *
%matplotlib inline
path_data = '../../../../data/'
import matplotlib.pyplot as plots
plots.style.use('fivethirtyeight')
import math
import numpy as np
from scipy import stats
```

``` {.python}
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

``` {.python}
hybrid = Table.read_table(path_data + 'hybrid.csv')
```

``` {.python}
hybrid
```

<table border="1" class="dataframe">
<thead>
<tr>
<th>
vehicle
</th>
<th>
year
</th>
<th>
msrp
</th>
<th>
acceleration
</th>
<th>
mpg
</th>
<th>
class
</th>
</tr>
</thead>
<tbody>
<tr>
<td>
Prius (1st Gen)
</td>
<td>
1997
</td>
<td>
24509.7
</td>
<td>
7.46
</td>
<td>
41.26
</td>
<td>
Compact
</td>
</tr>
<tr>
<td>
Tino
</td>
<td>
2000
</td>
<td>
35355
</td>
<td>
8.2
</td>
<td>
54.1
</td>
<td>
Compact
</td>
</tr>
<tr>
<td>
Prius (2nd Gen)
</td>
<td>
2000
</td>
<td>
26832.2
</td>
<td>
7.97
</td>
<td>
45.23
</td>
<td>
Compact
</td>
</tr>
<tr>
<td>
Insight
</td>
<td>
2000
</td>
<td>
18936.4
</td>
<td>
9.52
</td>
<td>
53
</td>
<td>
Two Seater
</td>
</tr>
<tr>
<td>
Civic (1st Gen)
</td>
<td>
2001
</td>
<td>
25833.4
</td>
<td>
7.04
</td>
<td>
47.04
</td>
<td>
Compact
</td>
</tr>
<tr>
<td>
Insight
</td>
<td>
2001
</td>
<td>
19036.7
</td>
<td>
9.52
</td>
<td>
53
</td>
<td>
Two Seater
</td>
</tr>
<tr>
<td>
Insight
</td>
<td>
2002
</td>
<td>
19137
</td>
<td>
9.71
</td>
<td>
53
</td>
<td>
Two Seater
</td>
</tr>
<tr>
<td>
Alphard
</td>
<td>
2003
</td>
<td>
38084.8
</td>
<td>
8.33
</td>
<td>
40.46
</td>
<td>
Minivan
</td>
</tr>
<tr>
<td>
Insight
</td>
<td>
2003
</td>
<td>
19137
</td>
<td>
9.52
</td>
<td>
53
</td>
<td>
Two Seater
</td>
</tr>
<tr>
<td>
Civic
</td>
<td>
2003
</td>
<td>
14071.9
</td>
<td>
8.62
</td>
<td>
41
</td>
<td>
Compact
</td>
</tr>
</tbody>
</table>
<p>
... (143 rows omitted)
</p>
The graph below is a scatter plot of `msrp` *versus* `acceleration`.
That means `msrp` is plotted on the vertical axis and `acceleration` on
the horizontal.

``` {.python}
hybrid.scatter('acceleration', 'msrp')
```

![png](../media/76-correlation-7-0.png)

Notice the positive association. The scatter of points is sloping
upwards, indicating that cars with greater acceleration tended to cost
more, on average; conversely, the cars that cost more tended to have
greater acceleration on average.

The scatter diagram of MSRP versus mileage shows a negative association.
Hybrid cars with higher mileage tended to cost less, on average. This
seems surprising until you consider that cars that accelerate fast tend
to be less fuel efficient and have lower mileage. As the previous
scatter plot showed, those were also the cars that tended to cost more.

``` {.python}
hybrid.scatter('mpg', 'msrp')
```

![png](../media/76-correlation-9-0.png)

Along with the negative association, the scatter diagram of price versus
efficiency shows a non-linear relation between the two variables. The
points appear to be clustered around a curve, not around a straight-line.

If we restrict the data just to the SUV class, however, the association
between price and efficiency is still negative but the relation appears
to be more linear. The relation between the price and acceleration of
SUVs also shows a linear trend, but with a positive slope.

``` {.python}
suv = hybrid.where('class', 'SUV')
suv.scatter('mpg', 'msrp')
```

![png](../media/76-correlation-11-0.png)

``` {.python}
suv.scatter('acceleration', 'msrp')
```

![png](../media/76-correlation-12-0.png)

You will have noticed that we can derive useful information from the
general orientation and shape of a scatter diagram even without paying
attention to the units in which the variables were measured.

Indeed, we could plot all the variables in standard units and the plots
would look the same. This gives us a way to compare the degree of
linearity in two scatter diagrams.

Recall that in an earlier section we defined the function
`standard_units` to convert an array of numbers to standard units.

``` {.python}
def standard_units(any_numbers):
    "Convert any array of numbers to standard units."
    return (any_numbers - np.mean(any_numbers))/np.std(any_numbers)  
```

We can use this function to redraw the two scatter diagrams for SUVs,
with all the variables measured in standard units.

``` {.python}
Table().with_columns(
    'mpg (standard units)',  standard_units(suv.column('mpg')),
    'msrp (standard units)', standard_units(suv.column('msrp'))
).scatter(0, 1)
plots.xlim(-3, 3)
plots.ylim(-3, 3);
```

![png](../media/76-correlation-16-0.png)

``` {.python}
Table().with_columns(
    'acceleration (standard units)', standard_units(suv.column('acceleration')),
    'msrp (standard units)',         standard_units(suv.column('msrp'))
).scatter(0, 1)
plots.xlim(-3, 3)
plots.ylim(-3, 3);
```

![png](../media/76-correlation-17-0.png)

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

``` {.python}
r_scatter(0.9)
```

![png](../media/76-correlation-21-0.png)

``` {.python}
r_scatter(0.25)
```

![png](../media/76-correlation-22-0.png)

``` {.python}
r_scatter(0)
```

![png](../media/76-correlation-23-0.png)

``` {.python}
r_scatter(-0.55)
```

![png](../media/76-correlation-24-0.png)

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

``` {.python}
x = np.arange(1, 7, 1)
y = make_array(2, 3, 1, 5, 2, 7)
t = Table().with_columns(
        'x', x,
        'y', y
    )
t
```

<table border="1" class="dataframe">
<thead>
<tr>
<th>
x
</th>
<th>
y
</th>
</tr>
</thead>
<tbody>
<tr>
<td>
1
</td>
<td>
2
</td>
</tr>
<tr>
<td>
2
</td>
<td>
3
</td>
</tr>
<tr>
<td>
3
</td>
<td>
1
</td>
</tr>
<tr>
<td>
4
</td>
<td>
5
</td>
</tr>
<tr>
<td>
5
</td>
<td>
2
</td>
</tr>
<tr>
<td>
6
</td>
<td>
7
</td>
</tr>
</tbody>
</table>
Based on the scatter diagram, we expect that $r$ will be positive but
not equal to 1.

``` {.python}
t.scatter(0, 1, s=30, color='red')
```

![png](../media/76-correlation-28-0.png)

**Step 1.** Convert each variable to standard units.

``` {.python}
t_su = t.with_columns(
        'x (standard units)', standard_units(x),
        'y (standard units)', standard_units(y)
    )
t_su
```

<table border="1" class="dataframe">
<thead>
<tr>
<th>
x
</th>
<th>
y
</th>
<th>
x (standard units)
</th>
<th>
y (standard units)
</th>
</tr>
</thead>
<tbody>
<tr>
<td>
1
</td>
<td>
2
</td>
<td>
-1.46385
</td>
<td>
-0.648886
</td>
</tr>
<tr>
<td>
2
</td>
<td>
3
</td>
<td>
-0.87831
</td>
<td>
-0.162221
</td>
</tr>
<tr>
<td>
3
</td>
<td>
1
</td>
<td>
-0.29277
</td>
<td>
-1.13555
</td>
</tr>
<tr>
<td>
4
</td>
<td>
5
</td>
<td>
0.29277
</td>
<td>
0.811107
</td>
</tr>
<tr>
<td>
5
</td>
<td>
2
</td>
<td>
0.87831
</td>
<td>
-0.648886
</td>
</tr>
<tr>
<td>
6
</td>
<td>
7
</td>
<td>
1.46385
</td>
<td>
1.78444
</td>
</tr>
</tbody>
</table>
**Step 2.** Multiply each pair of standard units.

``` {.python}
t_product = t_su.with_column('product of standard units', t_su.column(2) * t_su.column(3))
t_product
```

<table border="1" class="dataframe">
<thead>
<tr>
<th>
x
</th>
<th>
y
</th>
<th>
x (standard units)
</th>
<th>
y (standard units)
</th>
<th>
product of standard units
</th>
</tr>
</thead>
<tbody>
<tr>
<td>
1
</td>
<td>
2
</td>
<td>
-1.46385
</td>
<td>
-0.648886
</td>
<td>
0.949871
</td>
</tr>
<tr>
<td>
2
</td>
<td>
3
</td>
<td>
-0.87831
</td>
<td>
-0.162221
</td>
<td>
0.142481
</td>
</tr>
<tr>
<td>
3
</td>
<td>
1
</td>
<td>
-0.29277
</td>
<td>
-1.13555
</td>
<td>
0.332455
</td>
</tr>
<tr>
<td>
4
</td>
<td>
5
</td>
<td>
0.29277
</td>
<td>
0.811107
</td>
<td>
0.237468
</td>
</tr>
<tr>
<td>
5
</td>
<td>
2
</td>
<td>
0.87831
</td>
<td>
-0.648886
</td>
<td>
-0.569923
</td>
</tr>
<tr>
<td>
6
</td>
<td>
7
</td>
<td>
1.46385
</td>
<td>
1.78444
</td>
<td>
2.61215
</td>
</tr>
</tbody>
</table>
**Step 3.** $r$ is the average of the products computed in Step 2.

``` {.python}
# r is the average of the products of standard units

r = np.mean(t_product.column(4))
r
```

0.6174163971897709

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

``` {.python}
t.scatter('y', 'x', s=30, color='red')
```

![png](../media/76-correlation-37-0.png)

### The `correlation` function

We are going to be calculating correlations repeatedly, so it will help
to define a function that computes it by performing all the steps
described above. Let's define a function `correlation` that takes a
table and the labels of two columns in the table. The function returns
$r$, the mean of the products of those column values in standard units.

``` {.python}
def correlation(t, x, y):
    return np.mean(standard_units(t.column(x))*standard_units(t.column(y)))
```

Let's call the function on the `x` and `y` columns of `t`. The function
returns the same answer to the correlation between $x$ and $y$ as we got
by direct application of the formula for $r$.

``` {.python}
correlation(t, 'x', 'y')
```

0.6174163971897709

As we noticed, the order in which the variables are specified doesn't
matter.

``` {.python}
correlation(t, 'y', 'x')
```

0.6174163971897709

Calling `correlation` on columns of the table `suv` gives us the
correlation between price and mileage as well as the correlation between
price and acceleration.

``` {.python}
correlation(suv, 'mpg', 'msrp')
```

-0.6667143635709919

``` {.python}
correlation(suv, 'acceleration', 'msrp')
```

0.48699799279959155

These values confirm what we had observed:

-   There is a negative association between price and efficiency,
    whereas the association between price and acceleration is positive.
-   The linear relation between price and acceleration is a little
    weaker (correlation about 0.5) than between price and mileage
    (correlation about -0.67).

Correlation is a simple and powerful concept, but it is sometimes
misused. Before using $r$, it is important to be aware of what
correlation does and does not measure.

### Association is not Causation

Correlation only measures association. Correlation does not imply
causation. Though the correlation between the weight and the math
ability of children in a school district may be positive, that does not
mean that doing math makes children heavier or that putting on weight
improves the children's math skills. Age is a confounding variable:
older children are both heavier and better at math than younger
children, on average.

### Correlation Measures *Linear* Association

Correlation measures only one kind of association--linear. Variables
that have strong non-linear association might have low correlation.
Here is an example of variables that have a perfect quadratic relation
$y = x^2$ but have correlation equal to 0.

``` {.python}
new_x = np.arange(-4, 4.1, 0.5)
nonlinear = Table().with_columns(
        'x', new_x,
        'y', new_x**2
    )
nonlinear.scatter('x', 'y', s=30, color='r')
```

![png](../media/76-correlation-51-0.png)

``` {.python}
correlation(nonlinear, 'x', 'y')
```

0.0

### Correlation is Affected by Outliers

Outliers can have a significant effect on correlation. Here is an example where
a scatter plot for which $r$ is equal to 1 is turned into a plot for
which $r$ is equal to 0, by the addition of just one outlying point.

``` {.python}
line = Table().with_columns(
        'x', make_array(1, 2, 3, 4),
        'y', make_array(1, 2, 3, 4)
    )
line.scatter('x', 'y', s=30, color='r')
```

![png](../media/76-correlation-54-0.png)

``` {.python}
correlation(line, 'x', 'y')
```

1.0

``` {.python}
outlier = Table().with_columns(
        'x', make_array(1, 2, 3, 4, 5),
        'y', make_array(1, 2, 3, 4, 0)
    )
outlier.scatter('x', 'y', s=30, color='r')
```

![png](../media/76-correlation-56-0.png)

``` {.python}
correlation(outlier, 'x', 'y')
```

0.0

### Ecological Correlations Should be Interpreted with Care

Correlations based on aggregated data can be misleading. As an example,
here are data on the Critical Reading and Math SAT scores in 2014. There
is one point for each of the 50 states and one for Washington, D.C. The
column `Participation Rate` contains the percent of high school seniors
who took the test. The next three columns show the average score in the
state on each portion of the test, and the final column is the average
of the total scores on the test.

``` {.python}
sat2014 = Table.read_table(path_data + 'sat2014.csv').sort('State')
sat2014
```

<table border="1" class="dataframe">
<thead>
<tr>
<th>
State
</th>
<th>
Participation Rate
</th>
<th>
Critical Reading
</th>
<th>
Math
</th>
<th>
Writing
</th>
<th>
Combined
</th>
</tr>
</thead>
<tbody>
<tr>
<td>
Alabama
</td>
<td>
6.7
</td>
<td>
547
</td>
<td>
538
</td>
<td>
532
</td>
<td>
1617
</td>
</tr>
<tr>
<td>
Alaska
</td>
<td>
54.2
</td>
<td>
507
</td>
<td>
503
</td>
<td>
475
</td>
<td>
1485
</td>
</tr>
<tr>
<td>
Arizona
</td>
<td>
36.4
</td>
<td>
522
</td>
<td>
525
</td>
<td>
500
</td>
<td>
1547
</td>
</tr>
<tr>
<td>
Arkansas
</td>
<td>
4.2
</td>
<td>
573
</td>
<td>
571
</td>
<td>
554
</td>
<td>
1698
</td>
</tr>
<tr>
<td>
California
</td>
<td>
60.3
</td>
<td>
498
</td>
<td>
510
</td>
<td>
496
</td>
<td>
1504
</td>
</tr>
<tr>
<td>
Colorado
</td>
<td>
14.3
</td>
<td>
582
</td>
<td>
586
</td>
<td>
567
</td>
<td>
1735
</td>
</tr>
<tr>
<td>
Connecticut
</td>
<td>
88.4
</td>
<td>
507
</td>
<td>
510
</td>
<td>
508
</td>
<td>
1525
</td>
</tr>
<tr>
<td>
Delaware
</td>
<td>
100
</td>
<td>
456
</td>
<td>
459
</td>
<td>
444
</td>
<td>
1359
</td>
</tr>
<tr>
<td>
District of Columbia
</td>
<td>
100
</td>
<td>
440
</td>
<td>
438
</td>
<td>
431
</td>
<td>
1309
</td>
</tr>
<tr>
<td>
Florida
</td>
<td>
72.2
</td>
<td>
491
</td>
<td>
485
</td>
<td>
472
</td>
<td>
1448
</td>
</tr>
</tbody>
</table>
<p>
... (41 rows omitted)
</p>
The scatter diagram of Math scores versus Critical Reading scores is
tightly clustered around a straight-line; the correlation is close
to 0.985.

``` {.python}
sat2014.scatter('Critical Reading', 'Math')
```

![png](../media/76-correlation-61-0.png)

``` {.python}
correlation(sat2014, 'Critical Reading', 'Math')
```

0.9847558411067434

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
[others](http://www.reuters.com/article/2012/10/10/us-eat-chocolate-win-the-nobel-prize-idUSBRE8991MS20121010#vFdfFkbPVlilSjsB.97)
were more relaxed. You are welcome to make your own decision! The
following graph, provided in the paper, should motivate you to take a look.

``` {.python}

from IPython.display import Image
Image("../../../images/chocoNobel.png")
```

![png](../media/76-correlation-65-0.png)

``` {.python}
```
d in the paper, should motivate you to take a look.

``` {.python}

from IPython.display import Image
Image("../media/choco-nobel.png")
```

![png](../media/76-correlation-65-0.png)

``` {.python}
```

## Learning Objectives

- Learn about Correlation as a measure of linear association and the correlation coefficient.
- Understand the Regression line, Regression Effect, and the equation of the regression line.
- Motivate The Method of Least Squares, Least Square Regression, & Nonlinear Regression
- Understand Residuals and residual diagnostics through residual plots.
