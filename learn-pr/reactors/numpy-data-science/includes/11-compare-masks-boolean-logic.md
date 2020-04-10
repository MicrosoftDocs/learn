*Masking* is when you want to manipulate or count or extract values in an array based on a criterion. For example, counting all the values in an array greater than a certain value is an example of masking. Boolean masking is often the most efficient way to accomplish these types of tasks in NumPy and it plays a large part in cleaning and otherwise preparing data for analysis (see Section 5).

## Example: Counting Rainy Days

Let's see masking in practice by examining the monthly rainfall statistics for Seattle. The data is in a CSV file from data.gov. To load the data, we will use pandas, which we will formally introduce in Section 4.

```python
import numpy as np
import pandas as pd
```

Use pandas to extract rainfall as a NumPy array. You need to make sure you have cloned the [Reactor repository](https://github.com/microsoft/Reactors) and opened the [Learn/Intro-Python-Data-Science folder](https://github.com/microsoft/Reactors/tree/master/Learn/Intro-python-data-science/README.md) in VS Code as described in the [environment setup unit](../python-data-science/introduction). In this folder you will find a data folder with the required `csv` files.

```python
rainfall_2003 = pd.read_csv('Data/Observed_Monthly_Rain_Gauge_Accumulations_-_Oct_2002_to_May_2017.csv')['RG01'][ 2:14].values
rainfall_2003
```

```output
array([6.55, 1.61, 5.01, 2.27, 0.91, 0.49, 0.12, 0.33, 0.97, 6.32, 2.54,
       3.19])
```

Let's break down what we just did in the code cell above. The rainfall data contains monthly rainfall totals from several rain gauges around the city of Seattle; we selected the first one. From that gauge, we then selected the relevant months for the first full calendar year in the dataset, 2003. That range of months started at the third row of the CSV file (remember, Python zero-indexes!) and ran through the thirteenth row, hence `2:14]`.

You now have an array containing 12 values, each of which records the monthly rainfall in inches from January to December 2003.

Commonly in data science, you will want to take a quick first exploratory look at the data. In this case, a bar chart is a good way to do this. To generate this bar chart, we will use Matplotlib, another important data-science tool that we will introduce formally later in the course. (This also brings up another widely used Python convention you should adopt: `import matplotlib.pyplot as plt`.)

```python
%matplotlib inline
import matplotlib.pyplot as plt
```

```python
plt.bar(np.arange(1, len(rainfall_2003) + 1), rainfall_2003)
```

> output
>
> <BarContainer object of 12 artists>
> ![BarContainer object of 12 artist](..\media\bar-container-object-12-artists.svg)

To briefly interpret the code snippet above, we passed two parameters to the bar function in pyplot: the first defining the index for the x-axis and the second defining the data to use for the bars (the y-axis). To create the index, we use the NumPy function `arange` to create a sequence of numbers (this is the same `arange` we encountered earlier in this section). We know that the length of our array is 12, but it can be a good habit to get into to programmatically pass the length of an array in case it changes or you don't know it with specificity. We also added 1 to both the start and the end of the `arange` to accommodate for Python zero-indexing (because there is no "month-zero" in the calendar).

Looking at the chart above (and as residents can attest), Seattle can have lovely, sunny summers. However, this is only a first glimpse of the data. There are still several questions we would like to answer, such as in how many months did it rain, or what was the average precipitation in those months? We would use masking to answer those questions. (We will also return to this example dataset to demonstrate concepts throughout the rest of this section.) Before we dive deeper in explaining what masking is, we should briefly touch on comparison operators in NumPy.

## Comparison operators as ufuncs

In addition to the computational operators as ufuncs that we have already encountered, NumPy also implements comparison operators such as `<` (less than) and `>` (greater than) as element-wise ufuncs. All of the standard Python comparison operations are available:

```python
simple_array = np.array([1, 2, 3, 4, 5])
```

```python
simple_array < 2  # less than
```

```output
array([ True, False, False, False, False])
```

```python
simple_array >= 4  # greater than or equal
```

```output
array([False, False, False,  True,  True])
```

```python
simple_array == 2  # equal
```

```output
array([False,  True, False, False, False])
```

It is also possible to do an element-wise comparison of two arrays, and to include compound expressions:

```python
(2 * simple_array) == (simple_array ** 2)
```

```output
array([False,  True, False, False, False])
```

As with the arithmetic operators, these comparison operators are wrappers for the NumPy ufuncs: when you write `x < 3`, NumPy actually uses `np.less(x, 3)`. Here is a summary of the comparison operators and their equivalent ufuncs:

| Operator | Equivalent ufunc |  | Operator | Equivalent ufunc |
| --- | --- | --- | --- | --- |
| `==` | `np.equal` |  | `!=` | `np.not_equal` |
| `<` | `np.less` |  | `<=` | `np.less_equal` |
| `>` | `np.greater` |  | `>=` | `np.greater_equal` |

Just like the arithmetic ufuncs, the comparison ufuncs work on arrays of any size and shape.

```python
rand = np.random.RandomState(0)
two_dim_array = rand.randint(10, size=(3, 4))
two_dim_array
```

```output
array([[5, 0, 3, 3],
       [7, 9, 3, 5],
       [2, 4, 7, 6]])
```

```python
two_dim_array < 6
```

```output
array([[ True,  True,  True,  True],
       [False, False,  True,  True],
       [ True,  True, False, False]])
```

The result is a Boolean array, and NumPy provides a number of straightforward patterns for working with these Boolean results.
