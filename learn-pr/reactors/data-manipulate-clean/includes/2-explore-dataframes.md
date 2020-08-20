After you load your data into pandas, the data most likely will be in a `DataFrame`. However, if the dataset in your `DataFrame` has 60,000 rows and 400 columns, how do you even begin to get a sense of what you're working with? Fortunately, pandas provides some convenient tools to help you quickly look at overall information about a `DataFrame`, including the first few and last few rows of data.

To explore `DataFrames` in pandas, let's import the Python scikit-learn library and use an iconic dataset that every data scientist has seen hundreds of times: British biologist Ronald Fisher's Iris dataset. Fisher used the Iris dataset in his 1936 paper *The Use of Multiple Measurements in Taxonomic Problems*.

First, import pandas and import the Python scikit-learn dataset:

```python
import pandas as pd
from sklearn.datasets import load_iris

iris = load_iris()
iris_df = pd.DataFrame(data=iris['data'], columns=iris['feature_names'])
```

## `DataFrame.info`

To take a look at this dataset to see what you have, run:

```python
iris_df.info()
```

The output looks like this:

```Output
<class 'pandas.core.frame.DataFrame'>
RangeIndex: 150 entries, 0 to 149
Data columns (total 4 columns):
sepal length (cm)    150 non-null float64
sepal width (cm)     150 non-null float64
petal length (cm)    150 non-null float64
petal width (cm)     150 non-null float64
dtypes: float64(4)
memory usage: 4.8 KB
```

From the output, you know that the Iris dataset has 150 entries in four columns. All the data is stored as 64-bit floating-point numbers.

## `DataFrame.head`

Next, let's see what the first few rows of our `DataFrame` look like. To return the first five rows of data, run:

```python
iris_df.head()
```

This is what's in the first five rows of the Iris dataset:

```Output
|    | sepal length (cm) | sepal width (cm) | petal length (cm) | petal width (cm) |
------------------------------------------------------------------------------------
| 0  | 5.1               | 3.5              | 1.4               | 0.2              |
| 1  | 4.9               | 3.0              | 1.4               | 0.2              |
| 2  | 4.7               | 3.2              | 1.3               | 0.2              |
| 3  | 4.6               | 3.1              | 1.5               | 0.2              |
| 4  | 5.0               | 3.6              | 1.4               | 0.2              |
```

### Try it yourself

By default, `DataFrame.head` returns the first five rows in a `DataFrame`. In a new code cell, can you figure out how to get it to show more?

<br />

<details>

  <summary>Hint <i>(expand to reveal)</i></summary>

  Run `iris_df.head` to consult the documentation.

</details>

<br /><br />

***

## `DataFrame.tail`

The flip side of `DataFrame.head` is `DataFrame.tail`, which returns the *last* five rows:

```python
iris_df.tail()
```

This is what you'll find in the last five rows of the Iris dataset:

```Output
|     | sepal length (cm) | sepal width (cm) | petal length (cm) | petal width (cm) |
------------------------------------------------------------------------------------
| 145 | 6.7               | 3.0              | 5.2               | 2.3              |
| 147 | 6.3               | 2.5              | 5.0               | 1.9              |
| 148 | 6.5               | 3.0              | 5.2               | 2.0              |
| 149 | 6.2               | 3.4              | 5.4               | 2.3              |
| 150 | 6.9               | 3.0              | 5.1               | 1.8              |
```

In practice, it's useful to be able to easily examine the first few rows or the last few rows of a `DataFrame`, particularly when you're looking for outliers in ordered datasets.

> [!div class="alert is-tip"]
> ### Takeaway
>
> Even just by looking at the metadata about the information in a `DataFrame`, or the first and last few values in one, you can get an immediate idea about the size, shape, and content of the data you're dealing with.