*Masking* is manipulating, counting, or extracting values in an array based on a criterion. For example, counting all the values in an array that are greater than a certain value. Boolean masking is often the most efficient way to accomplish these types of tasks in NumPy. It plays a large part in cleaning and otherwise preparing data for analysis. (See Section 5.)

## Example: Counting rainy days

Let's see masking in practice by examining the monthly rainfall statistics for Seattle. The data is in a CSV file from data.gov. To load the data, we'll use pandas, which we'll formally introduce in Section 4.

```python
import numpy as np
import pandas as pd
```

Use pandas to extract rainfall as a NumPy array. Make sure you've cloned the [Reactor repository](https://github.com/microsoft/Reactors?azure-portal=true) and opened the [Learn/Intro-python-data-science folder](https://github.com/microsoft/Reactors/blob/main/microsoft-learn-resources/Intro-python-data-science/README.md) in VS Code, as described in the [environment setup unit](../../python-data-science/1-introduction.yml?azure-portal=true). In this folder, you'll find a data folder with the required CSV files.

```python
rainfall_2003 = pd.read_csv('Data/Observed_Monthly_Rain_Gauge_Accumulations_-_Oct_2002_to_May_2017.csv')['RG01'][ 2:14].values
rainfall_2003
```

The output is:

```Output
array([6.55, 1.61, 5.01, 2.27, 0.91, 0.49, 0.12, 0.33, 0.97, 6.32, 2.54,
       3.19])
```

Let's break down what we just did in the preceding code cell. The rainfall data contains monthly rainfall totals from several rain gauges around the city of Seattle. We selected the first one. From that gauge, we then selected the relevant months for the first full calendar year in the dataset, 2003. That range of months started at the third row of the CSV file (remember, Python zero-indexes!) and ran through the thirteenth row, hence `2:14]`.

You now have an array that contains 12 values, each of which records the monthly rainfall in inches from January to December 2003.

In data science, you'll commonly want to take a quick first exploratory look at the data. In this case, a bar chart is a good way to do so. To generate this bar chart, we'll use Matplotlib, another important data-science tool that we'll introduce formally later in the course. (This example also brings up another widely used Python convention that you should adopt: `import matplotlib.pyplot as plt`.)

```python
%matplotlib inline
import matplotlib.pyplot as plt
```

```python
plt.bar(np.arange(1, len(rainfall_2003) + 1), rainfall_2003)
```

The output is:

>[!div class="alert is-tip"]
> Output

\<BarContainer object of 12 artists\>

![BarContainer object](..\media\bar-container-object-12-artists.png)

Let's look at the preceding code snippet. We passed two parameters to the bar function in pyplot. The first defines the index for the x-axis, and the second defines the data to use for the bars (the y-axis). To create the index, we use the NumPy function `arange` to create a sequence of numbers. (This is the same `arange` we came across earlier in this section.) We know that the length of our array is 12. But it's a good habit to pass the length of an array programmatically in case it changes or you don't know it with specificity. We also added 1 to both the start and the end of the `arange` to accommodate for Python zero-indexing (because there's no "month zero" in the calendar).

Based on the chart above (and as residents can attest), Seattle can have lovely, sunny summers. But this is only a first glimpse of the data. There are still several questions we'd like to answer. For example, in how many months did it rain, and what was the average precipitation in those months? We would use masking to answer those questions. (We'll also return to this example dataset to demonstrate concepts throughout the rest of this section.) Before we dig deeper in explaining what masking is, we should briefly touch on comparison operators in NumPy.

## Comparison operators as ufuncs

In addition to the computational operators as ufuncs that we've already discussed, NumPy also implements comparison operators like `<` (less than) and `>` (greater than) as element-wise ufuncs. All the standard Python comparison operations are available:

```python
simple_array = np.array([1, 2, 3, 4, 5])
```

Less than:

```python
simple_array < 2 
```

The output is:

```Output
array([ True, False, False, False, False])
```

Greater than or equal to:

```python
simple_array >= 4
```

The output is:

```Output
array([False, False, False,  True,  True])
```

Equals:

```python
simple_array == 2
```

The output is:

```Output
array([False,  True, False, False, False])
```

It's also possible to do an element-wise comparison of two arrays, and to include compound expressions:

```python
(2 * simple_array) == (simple_array ** 2)
```

The output is:

```Output
array([False,  True, False, False, False])
```

As with the arithmetic operators, these comparison operators are wrappers for the NumPy ufuncs. When you write `x < 3`, NumPy actually uses `np.less(x, 3)`. Here's a summary of the comparison operators and their equivalent ufuncs:

| Operator | Equivalent ufunc |  
| --- | --- | --- | --- | --- |
| `==` | `np.equal` |  
| `<` | `np.less` |  
| `>` | `np.greater` | 
| `!=` | `np.not_equal` |
| `<=` | `np.less_equal` |
 | `>=` | `np.greater_equal` |

Just like the arithmetic ufuncs, the comparison ufuncs work on arrays of any size and shape.

```python
rand = np.random.RandomState(0)
two_dim_array = rand.randint(10, size=(3, 4))
two_dim_array
```

The output is:

```Output
array([[5, 0, 3, 3],
       [7, 9, 3, 5],
       [2, 4, 7, 6]])
```

So for:

```python
two_dim_array < 6
```

The output is:

```Output
array([[ True,  True,  True,  True],
       [False, False,  True,  True],
       [ True,  True, False, False]])
```

The result is a Boolean array, and NumPy provides a number of straightforward patterns for working with these Boolean results.
