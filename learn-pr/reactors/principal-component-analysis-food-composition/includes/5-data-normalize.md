Our numeric data comes in a variety of mass units (grams, milligrams, and micrograms) and one energy unit (kilocalories). In order to make an apples-to-apples comparison (pun intended) of the nutritional data, we need to first normalize the data and make it more normally distributed (that is, make the distribution of the data look more like a familiar bell curve). PCA needs relatively normalized data to perform its magic.

To help see why we need to normalize the data, let's look at a histogram of all of the columns.

```python
ax = nutr_df.hist(bins=50, xlabelsize=-1, ylabelsize=-1, figsize=(11,11))
```

Our first transformation - Box-Cox

Not a bell curve in sight. Worse, a lot of the data is clumped at or around 0. There are a number of ways we can massage the data into a a more useable state.

We're going to start by trying the Box-Cox Transformation on the data, a popular transformation. It does require a strictly positive input, so we will add 1 to every value in each column.

```python
nutr_df = nutr_df + 1
```

Now for the transformation. The Box-Cox Transformation performs the transformation $y(\lambda) = \dfrac{y^{\lambda}-1}{\lambda}$ for $\lambda \neq 0$ and $y(\lambda) = log y$ for $\lambda = 0$ for all values $y$ in a given column. SciPy has a particularly useful boxcox() function that can automatically calculate the $\lambda$ for each column that best normalizes the data in that column. (However, it is does not support NaN values; scikit-learn has a comparable boxcox() function that is NaN-safe, but it is not available on the version of scikit-learn that comes with Azure notebooks.)

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

A few of the columns now look about right, but unfortunately we really didn't see the results we were hoping for, which was bell curves for the bulk of our columns.

## Standard scaling

Our data units were incompatible to begin with, and the transformations haven't given us any real improvement. We can apply a different technique - centering the data around 0; that is, we will again transform the data, this time so that every column has a mean of 0 and a standard deviation of 1. Put another way, we're going to standardize our data around 0. Scikit-learn has a convenient function for this - StandardScaler. We're going to call fit_transform to perform the conversion. Please note fit_transform will return a numpy array rather than a DataFrame.

```python
nutr_df_TF = StandardScaler().fit_transform(nutr_df_TF)
```

You can satisfy your self that the data is now centered by using the mean() method on the array.

```python
print("mean: ", np.round(nutr_df_TF.mean(), 2))
```

Exercise

Find the standard deviation for the nutr_df_TF. (If you need a hint, you can always use tab in Jupyter notebooks)

```python