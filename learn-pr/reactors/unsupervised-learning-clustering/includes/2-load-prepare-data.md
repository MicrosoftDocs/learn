
To illustrate *k*-means clustering in action, we'll use the familiar [U.S. Department of Agriculture National Nutrient Database for Standard Reference](https://www.ars.usda.gov/northeast-area/beltsville-md-bhnrc/beltsville-human-nutrition-research-center/nutrient-data-laboratory/docs/usda-national-nutrient-database-for-standard-reference/?azure-portal=true) dataset that you used in Sections 1.1 through 1.3. (Note that the path name is case sensitive.)

```python
import pandas as pd
df = pd.read_csv('Data/USDA-nndb-combined.csv', encoding='latin_1')

```

```python
df.head()
```

The output is:

```Output
TBD
```

Because the *k*-means algorithm works with the Euclidean distance between data points, we need to once again separate out our descriptive from our numeric features (while saving the descriptive features for later use).

```python
desc_df = df.iloc[:, [0, 1, 2]+[i for i in range(50,54)]]
desc_df.set_index('NDB_No', inplace=True)
desc_df.head()
```

The output is:

```Output
TBD
```

And with:

```python
nutr_df = df.iloc[:, :-5]
nutr_df = nutr_df.drop(['FoodGroup', 'Shrt_Desc'], axis=1)
nutr_df.set_index('NDB_No', inplace=True)
nutr_df.head()
```

The output is:

```Output
TBD
```

The correlations that we have seen before in this dataset are still an issue here.

|  | column | row | corr |
| --- | --- | --- | --- |
| 0 | Folate_Tot_(µg) | Folate_DFE_(µg) | 0.98 |
| 1 | Folic_Acid_(µg) | Folate_DFE_(µg) | 0.95 |
| 2 | Folate_DFE_(µg) | Folate_Tot_(µg) | 0.98 |
| 3 | Vit_A_RAE | Retinol_(µg) | 0.99 |
| 4 | Retinol_(µg) | Vit_A_RAE | 0.99 |
| 5 | Vit_D_µg | Vit_D_IU | 1 |
| 6 | Vit_D_IU | Vit_D_µg | 1 |

Before dropping anything from the `df` `DataFrame`, however, let's take a quick look at these correlations visually. Let's start with `Folate_Tot_(µg)` and `Folate_DFE_(µg)`.

```python
from matplotlib import pyplot as plt
%matplotlib inline
plt.scatter(df['Folate_Tot_(µg)'], df['Folate_DFE_(µg)'])
```

The output is:

```Output
TBD
```

This is a dramatic correlation!

> [!NOTE]
> Despite specifying Latin_1 encoding when we read in the dataset from the CSV file, character corruption can still occur. If the plt.scatter call above fails, try this code instead: `plt.scatter(df['Folate\_Tot\_(Âµg)'], df['Folate\_DFE\_(Âµg)'])`

### Try it yourself

In the code cell below, run a scatterplot of another correlative pair of features from this dataset. 

<br />

<details>

  <summary>Hint <i>(expand to reveal)</i></summary>

  You only need to run the `plt.scatter` function with new parameters.)
  
  The input is:

  ```python
  TBA
  ```

  The output is:

  ```Output

  ```

</details>

<br /><br />

***

Let's drop `Folate_DFE_(µg)`, `Vit_A_RAE`, and `Vit_D_IU` from `df` in order to eliminate these problematic correlations. The *k*-means algorithm also doesn't work with `NaN` values, so we will also have to drop those.

```python
nutr_df.drop(['Folate_DFE_(µg)', 'Vit_A_RAE', 'Vit_D_IU'],
        inplace=True, axis=1)
nutr_df = nutr_df.dropna()
nutr_df.head()
```

The output is:

```Output
TBD
```

> [!NOTE]
> Again, if the read_csv() function did not read in the µ (mu) symbol correctly and the drop() method call above fails, try this code instead: `nutr_df.drop(['Folate\_DFE\_(Âµg)', 'Vit\_A\_RAE', 'Vit\_D\_IU'], inplace=True, axis=1)`

Because the *k*-means algorithm will be calculating the Euclidean distances between data points and centroids, we need to ensure that all of the numeric features in our dataset use compatible units; we don't want to try and calculate distances between units of mass like grams and units of energy like kilocalories. Just as we did with principal component analysis (PCA) in Section 1.2, we will use scikit-learn's [`StandardScaler()` function](https://scikit-learn.org/stable/modules/generated/sklearn.preprocessing.StandardScaler.html?azure-portal=true) to center the data around each feature's mean and transform each feature to have a standard deviation of 1.

```python
from sklearn.preprocessing import StandardScaler

X = StandardScaler().fit_transform(nutr_df)
```

The output is:

```Output
TBD
```
