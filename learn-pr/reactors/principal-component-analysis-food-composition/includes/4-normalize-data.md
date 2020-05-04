<!--- Reviewers note: This unit uses LaTeX syntax to format mathematical content. A dollar sign $ starts and ends the LaTeX statement. -->

Our numeric data comes in a variety of mass units (grams, milligrams, and micrograms) and one energy unit (kilocalories). In order to make an apples-to-apples comparison (pun intended) of the nutritional data, we need to first normalize the data and make it more normally distributed (that is, make the distribution of the data look more like a familiar bell curve).

To help see why we need to normalize the data, let's look at a histogram of all of the columns.

```python
ax = nutr_df.hist(bins=50, xlabelsize=-1, ylabelsize=-1, figsize=(11,11))
```

The output is:

:::image type="content" alt-text="A screenshot that shows a histogram of all the columns." source="../media/normalize-1.png" loc-scope="Azure":::

Not a bell curve in sight. Worse, a lot of the data is clumped at or around 0. We will use the Box-Cox Transformation on the data, but it requires strictly positive input, so we will add 1 to every value in each column.

```python
nutr_df = nutr_df + 1
```

Now for the transformation. The [Box-Cox Transformation](https://www.statisticshowto.datasciencecentral.com/box-cox-transformation/?azure-portal=true) performs the transformation $y(\lambda) = \dfrac{y^{\lambda}-1}{\lambda}$ for $\lambda \neq 0$ and $y(\lambda) = log y$ for $\lambda = 0$ for all values $y$ in a given column. SciPy has a particularly useful `boxcox()` function that can automatically calculate the $\lambda$ for each column that best normalizes the data in that column. (However, it is does not support `NaN` values; scikit-learn has a comparable `boxcox()` function that is `NaN`-safe, but it is not available on the version of scikit-learn that comes with Azure notebooks.)

```python
from scipy.stats import boxcox

nutr_df_TF = pd.DataFrame(index=nutr_df.index)
for col in nutr_df.columns.values:
    nutr_df_TF['{}_TF'.format(col)] = boxcox(nutr_df.loc[:, col])[0]
```

Let's now take a look at the DataFrame containing the transformed data.

```python
ax = nutr_df_TF.hist(bins=50, xlabelsize=-1, ylabelsize=-1, figsize=(11,11))
```

The output is:

:::image type="content" alt-text="A screenshot that shows revised histogram of all the columns." source="../media/normalize-1.png" loc-scope="Azure":::

Few of these columns looks properly normal, but it is enough to now center the data.

Our data units were incompatible to begin with, and the transformations have not improved that. But we can address that by centering the data around 0; that is, we will again transform the data, this time so that every column has a mean of 0 and a standard deviation of 1. Scikit-learn has a convenient function for this.

```python
nutr_df_TF = StandardScaler().fit_transform(nutr_df_TF)
```

You can satisfy yourself that the data is now centered by using the mean() method on the array.

```python
print("mean: ", np.round(nutr_df_TF.mean(), 2))
```

The output is:

```Output
mean:  -0.0
```
### Try it yourself

<br />

<details>

  <summary>Hint <i>(expand to reveal)</i></summary>

  Find the standard deviation for the <code>nutr_df_TF</code>. (If you need a hint as to which method to use, see the [pandas documentation](https://pandas.pydata.org/pandas-docs/stable/reference/api/pandas.DataFrame.std.html?azure-portal=true).)
    
  The output is:

  ```Output
  s.d.:  1.0
  ```

</details>

<br /><br />

***
