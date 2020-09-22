We'll begin by importing our usual libraries and using our `%matplotlib` inline magic command:

```python
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
%matplotlib inline 
import seaborn as sns
```

And now for our data. In this case, we'll use a newer housing dataset than the Boston Housing Dataset we used in the last section. This dataset stores data on individual houses across the United States.

```python
df = pd.read_csv('./Data/Housing_Dataset_Sample.csv')
df.head()
```

The output table looks like this:

```Output
----------------------------------------------------------------------------------------------------------------------------------------------------------
|    |  Avg. area     |  Avg. area  |  Avg. area  |  Avg. area #  |  Area          |                |                                                    |
|    |  income        |  house age  |  # of rooms |  of bedrooms  |  population    |  Price         |  Address                                           |
----------------------------------------------------------------------------------------------------------------------------------------------------------
| 0  |  79545.458574  |  5.682861   |  7.009188   |  4.09         |  23086.800503  |  1.059034e+06  |  208 Michael Ferry Apt. 674\nLaurabury, NE 3701... |
----------------------------------------------------------------------------------------------------------------------------------------------------------
| 1  |  79248.642455  |  6.002900   |  6.730821   |  3.09         |  40173.072174  |  1.505891e+06  |  188 Johnson Views Suite 079\nLake Kathleen, CA... |
----------------------------------------------------------------------------------------------------------------------------------------------------------
| 2  |  61287.067179  |  5.865890   |  8.512727   |  5.13         |  36882.159400  |  1.058988e+06  |  9127 Elizabeth Stravenue\nDanieltown, WI 06482... |
----------------------------------------------------------------------------------------------------------------------------------------------------------
| 3  |  63345.240046  |  7.188236   |  5.586729   |  3.26         |  34310.242831  |  1.260617e+06  |  USS Barnett\nFPO AP 44820                         |
----------------------------------------------------------------------------------------------------------------------------------------------------------
| 4  |  59982.197226  |  5.040555   |  7.839388   |  4.23         |  26354.109472  |  6.309435e+05  |  USNS Raymond\nFPO AE 09386                        |
----------------------------------------------------------------------------------------------------------------------------------------------------------
```

### Try it yourself

Do you remember the `DataFrames` method for looking at overall information about a `DataFrame`, such as number of columns and rows? Try it here.

<br />

<details> 

  <summary>Hint<i> (expand to reveal)</i></summary>

  Here's the input:

  ```python
  df.info()
  ```

  The output is:

  ```Output
  <class 'pandas.core.frame.DataFrame'>
  RangeIndex: 5000 entries, 0 to 4999
  Data columns (total 7 columns):
   #   Column                        Non-Null Count  Dtype  
  ---  ------                        --------------  -----  
   0   Avg. Area Income              5000 non-null   float64
   1   Avg. Area House Age           5000 non-null   float64
   2   Avg. Area Number of Rooms     5000 non-null   float64
   3   Avg. Area Number of Bedrooms  5000 non-null   float64
   4   Area Population               5000 non-null   float64
   5   Price                         5000 non-null   float64
   6   Address                       5000 non-null   object 
  dtypes: float64(6), object(1)
  memory usage: 254.0+ KB
  ```
  
</details>

<br /><br />

***

Let's also use the `describe` method to look at some of the vital statistics about the columns. When column names are long, it helps to view the transposition of the summary, like so:

```python
df.describe().T
```

Here's a version of the output table where the rows and columns are transposed:

```Output
--------------------------------------------------------------------------------------------------------------------------------------------------
|             |  count    |  mean          |  std           |  min           |  25%           |  50%           |  75%           |  max           |
--------------------------------------------------------------------------------------------------------------------------------------------------
| Avg. area   |           |                |                |                |                |                |                |                |
| income      |  5000.0   |  6.858311e+04  |  10657.991214  |  17796.631190  |  61480.562388  |  6.880429e+04  |  7.578334e+04  |  1.077017e+05  |
--------------------------------------------------------------------------------------------------------------------------------------------------
| Avg. area   |           |                |                |                |                |                |                |                |
| house age   |  5000.0   |  5.977222e+00  |  0.991456      |  2.644304      |  5.322283      |  5.970429e+00  |  6.650808e+00  |  9.519088e+00  |
--------------------------------------------------------------------------------------------------------------------------------------------------
| Avg. area   |           |                |                |                |                |                |                |                |
| # of rooms  |  5000.0   |  6.987792e+00  |  1.005833      |  3.236194      |  6.299250      |  7.002902e+00  |  7.665871e+00  |  1.075959e+01  |
--------------------------------------------------------------------------------------------------------------------------------------------------
| Avg. area # |           |                |                |                |                |                |                |                |
| of bedrooms |  5000.0   |  3.981330e+00  |  1.234137      |  2.000000      |  3.140000      |  4.050000e+00  |  4.490000e+00  |  6.500000e+00  |
--------------------------------------------------------------------------------------------------------------------------------------------------
| Area        |           |                |                |                |                |                |                |                |
| population  |  5000.0   |  3.616352e+04  |  9925.650114   |  172.610686    |  29403.928702  |  3.619941e+04  |  4.286129e+04  |  6.962171e+04  |
--------------------------------------------------------------------------------------------------------------------------------------------------
|             |           |                |                |                |                |                |                |                |
| Price       |  5000.0   |  1.232073e+06  |  353117.626581 |  15938.657923  |  997577.135049 |  1.232669e+06  |  1.471210e+0   |  2.469066e+06  |
--------------------------------------------------------------------------------------------------------------------------------------------------
```

Let's look at the data in the **Price** column:

```python
sns.distplot(df['Price'])
```

If the `distplot` command produces a deprecation warning, disregard the message:

```Output
/home/nbuser/anaconda3_420/lib/python3.5/site-packages/scipy/stats/stats.py:1713: FutureWarning: Using a non-tuple sequence for multidimensional indexing is deprecated; use `arr[tuple(seq)]` instead of `arr[seq]`. In the future this will be interpreted as an array index, `arr[np.array(seq)]`, which will result either in an error or a different result.
  return np.add.reduce(sorted[indexer] * weights, axis=axis) / sumval
```

As we would hope with this much data, our prices form a nice bell-shaped, normally distributed curve:

```Output
<matplotlib.axes._subplots.AxesSubplot at 0x7f58fd3f7dd8>
```

:::image type="content" alt-text="A bell-shaped curve graph showing the dist plot output for data in the Price column." source="../media/output-dist-plot-1.png" loc-scope="azure":::

Now, let's look at a simple relationship like that between house prices and the average income in a geographic area:

```python
sns.jointplot(df['Avg. Area Income'],df['Price'])
```

If the `jointplot` command produces a deprecation warning, disregard the message:

```Output
/home/nbuser/anaconda3_420/lib/python3.5/site-packages/scipy/stats/stats.py:1713: FutureWarning: Using a non-tuple sequence for multidimensional indexing is deprecated; use `arr[tuple(seq)]` instead of `arr[seq]`. In the future this will be interpreted as an array index, `arr[np.array(seq)]`, which will result either in an error or a different result.
  return np.add.reduce(sorted[indexer] * weights, axis=axis) / sumval
```

As we would expect, there's an intuitive, linear relationship between them:

```Output
<seaborn.axisgrid.JointGrid at 0x7f58fcf839e8>
```

:::image type="content" alt-text="A distribution graph showing the joint plot output for data in the Average area income column and the Price column." source="../media/output-joint-plot-1.png" loc-scope="azure":::

Because the pair plot shows that the data in both columns is normally distributed, we don't have to worry about somehow transforming the data for meaningful analysis.

Let's take a quick look at all of the columns:

```python
sns.pairplot(df)
```

```Output
<seaborn.axisgrid.PairGrid at 0x7f5902189c88>
```

:::image type="content" alt-text="36 small graphs of various presentation formats showing the pair plot output for data in all columns." source="../media/output-pair-plot-1.png" loc-scope="azure":::

Some observations:

- Not all of the combinations of columns provide strong linear relationships. Some just look like blobs. That's nothing to worry about for our analysis.
- Do you see the visualizations that look like lanes rather than organic groups? That's the result of the average number of bedrooms in houses being measured in discrete values rather than continuous ones (because no one has 0.3 bedrooms in their house). The number of bathrooms is also the one column whose data isn't normally distributed. This distortion might be caused by the default bin size of the pair plot histogram functionality.

Now it's time to make a prediction.
