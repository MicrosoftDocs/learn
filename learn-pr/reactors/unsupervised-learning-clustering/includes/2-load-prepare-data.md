To illustrate k-means clustering in action, we'll use the familiar [U.S. Department of Agriculture National Nutrient Database for Standard Reference](https://www.ars.usda.gov/northeast-area/beltsville-md-bhnrc/beltsville-human-nutrition-research-center/nutrient-data-laboratory/docs/usda-national-nutrient-database-for-standard-reference/?azure-portal=true) dataset that you used in sections 1.1 through 1.3. Note that the path name is case sensitive.

```python
import pandas as pd
df = pd.read_csv('Data/USDA-nndb-combined.csv', encoding='latin1')
```

```python
df.head()
```

The output is:

> [!div class="alert is-tip"]
> Output

|  | NDB_No | FoodGroup | Shrt_Desc | Water_(g) | Energ_Kcal | Protein_(g) | Lipid_Tot_(g) | Ash_(g) | Carbohydrt_(g) | Fiber_TD_(g) | ... | Vit_K_(Âµg) | FA_Sat_(g) | FA_Mono_(g) | FA_Poly_(g) | Cholestrl_(mg) | GmWt_1 | GmWt_Desc1 | GmWt_2 | GmWt_Desc2 | Refuse_Pct |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| **0** | 1001 | Dairy and Egg Products | BUTTER,WITH SALT | 15.87 | 717.0 | 0.85 | 81.11 | 2.11 | 0.06 | 0.0 | ... | 7.0 | 51.368 | 21.021 | 3.043 | 215.0 | 5.00 | 1 pat, (1" sq, 1/3" high) | 14.2 | 1 tbsp | 0.0 |
| **1** | 1002 | Dairy and Egg Products | BUTTER,WHIPPED,W/ SALT | 16.72 | 718.0 | 0.49 | 78.30 | 1.62 | 2.87 | 0.0 | ... | 4.6 | 45.390 | 19.874 | 3.331 | 225.0 | 3.80 | 1 pat, (1" sq, 1/3" high) | 9.4 | 1 tbsp | 0.0 |
| **2** | 1003 | Dairy and Egg Products | BUTTER OIL,ANHYDROUS | 0.24 | 876.0 | 0.28 | 99.48 | 0.00 | 0.00 | 0.0 | ... | 8.6 | 61.924 | 28.732 | 3.694 | 256.0 | 12.80 | 1 tbsp | 205.0 | 1 cup | 0.0 |
| **3** | 1004 | Dairy and Egg Products | CHEESE,BLUE | 42.41 | 353.0 | 21.40 | 28.74 | 5.11 | 2.34 | 0.0 | ... | 2.4 | 18.669 | 7.778 | 0.800 | 75.0 | 28.35 | 1 oz | 17.0 | 1 cubic inch | 0.0 |
| **4** | 1005 | Dairy and Egg Products | CHEESE,BRICK | 41.11 | 371.0 | 23.24 | 29.68 | 3.18 | 2.79 | 0.0 | ... | 2.5 | 18.764 | 8.598 | 0.784 | 94.0 | 132.00 | 1 cup, diced | 113.0 | 1 cup, shredded | 0.0 |

5 rows × 54 columns
***

The k-means algorithm works with the Euclidean distance between data points. So, we need to once again separate descriptive features from numeric features (while saving the descriptive features for later use).

```python
desc_df = df.iloc[:, [0, 1, 2]+[i for i in range(50,54)]]
desc_df.set_index('NDB_No', inplace=True)
desc_df.head()
```

The output is:

> [!div class="alert is-tip"]
> Output

|  | FoodGroup | Shrt_Desc | GmWt_Desc1 | GmWt_2 | GmWt_Desc2 | Refuse_Pct |
| --- | --- | --- | --- | --- | --- | --- |
| **NDB_No** |  |  |  |  |  |  |
| **1001** | Dairy and Egg Products | BUTTER,WITH SALT | 1 pat, (1" sq, 1/3" high) | 14.2 | 1 tbsp | 0.0 |
| **1002** | Dairy and Egg Products | BUTTER,WHIPPED,W/ SALT | 1 pat, (1" sq, 1/3" high) | 9.4 | 1 tbsp | 0.0 |
| **1003** | Dairy and Egg Products | BUTTER OIL,ANHYDROUS | 1 tbsp | 205.0 | 1 cup | 0.0 |
| **1004** | Dairy and Egg Products | CHEESE,BLUE | 1 oz | 17.0 | 1 cubic inch | 0.0 |
| **1005** | Dairy and Egg Products | CHEESE,BRICK | 1 cup, diced | 113.0 | 1 cup, shredded | 0.0 |

***

And with:

```python
nutr_df = df.iloc[:, :-5]
nutr_df = nutr_df.drop(['FoodGroup', 'Shrt_Desc'], axis=1)
nutr_df.set_index('NDB_No', inplace=True)
nutr_df.head()
```

The output is:

> [!div class="alert is-tip"]
> Output

|  | Water_(g) | Energ_Kcal | Protein_(g) | Lipid_Tot_(g) | Ash_(g) | Carbohydrt_(g) | Fiber_TD_(g) | Sugar_Tot_(g) | Calcium_(mg) | Iron_(mg) | ... | Lycopene_(Âµg) | Lut+Zea_ (Âµg) | Vit_E_(mg) | Vit_D_Âµg | Vit_D_IU | Vit_K_(Âµg) | FA_Sat_(g) | FA_Mono_(g) | FA_Poly_(g) | Cholestrl_(mg) |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| **NDB_No** |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |
| **1001** | 15.87 | 717.0 | 0.85 | 81.11 | 2.11 | 0.06 | 0.0 | 0.06 | 24.0 | 0.02 | ... | 0.0 | 0.0 | 2.32 | 0.0 | 0.0 | 7.0 | 51.368 | 21.021 | 3.043 | 215.0 |
| **1002** | 16.72 | 718.0 | 0.49 | 78.30 | 1.62 | 2.87 | 0.0 | 0.06 | 23.0 | 0.05 | ... | 0.0 | 13.0 | 1.37 | 0.0 | 0.0 | 4.6 | 45.390 | 19.874 | 3.331 | 225.0 |
| **1003** | 0.24 | 876.0 | 0.28 | 99.48 | 0.00 | 0.00 | 0.0 | 0.00 | 4.0 | 0.00 | ... | 0.0 | 0.0 | 2.80 | 0.0 | 0.0 | 8.6 | 61.924 | 28.732 | 3.694 | 256.0 |
| **1004** | 42.41 | 353.0 | 21.40 | 28.74 | 5.11 | 2.34 | 0.0 | 0.50 | 528.0 | 0.31 | ... | 0.0 | 0.0 | 0.25 | 0.5 | 21.0 | 2.4 | 18.669 | 7.778 | 0.800 | 75.0 |
| **1005** | 41.11 | 371.0 | 23.24 | 29.68 | 3.18 | 2.79 | 0.0 | 0.51 | 674.0 | 0.43 | ... | 0.0 | 0.0 | 0.26 | 0.5 | 22.0 | 2.5 | 18.764 | 8.598 | 0.784 | 94.0 |

5 rows × 46 columns
***

The correlations that we've seen before in this dataset are still a problem here.

|  | column | row | corr |
| --- | --- | --- | --- |
| 0 | Folate_Tot_(µg) | Folate_DFE_(µg) | 0.98 |
| 1 | Folic_Acid_(µg) | Folate_DFE_(µg) | 0.95 |
| 2 | Folate_DFE_(µg) | Folate_Tot_(µg) | 0.98 |
| 3 | Vit_A_RAE | Retinol_(µg) | 0.99 |
| 4 | Retinol_(µg) | Vit_A_RAE | 0.99 |
| 5 | Vit_D_µg | Vit_D_IU | 1 |
| 6 | Vit_D_IU | Vit_D_µg | 1 |

Before we drop anything from the `df` DataFrame, let's take a quick look at these correlations visually. Let's start with `Folate_Tot_(µg)` and `Folate_DFE_(µg)`.

```python
from matplotlib import pyplot as plt
%matplotlib inline
plt.scatter(df['Folate_Tot_(Âµg)'], df['Folate_DFE_(µg)'])
```

The output is:

> [!div class="alert is-tip"]
> Output

`<matplotlib.collections.PathCollection at 0x1f42612a888>`
:::image type="content" source="../media/matplotlib-scatter-1.svg" alt-text="Scatter plot output":::
***

This is a dramatic correlation!

> [!NOTE]
> Despite specifying latin1 encoding when we read in the dataset from the CSV file, character corruption can still happen. If the preceding `plt.scatter` call fails, try this code instead: `plt.scatter(df['Folate_Tot_(Âµg)'], df['Folate_DFE_(Âµg)'])`


### Try it yourself

In the following code cell, run a scatterplot of another correlative pair of features from this dataset. 

<br />

<details>

  <summary>Hint <i>(expand to reveal)</i></summary>

  You only need to run the `plt.scatter` function with new parameters.
  
  For example:
  
  ```python
  plt.scatter(df['Vit_D_IU'], df['Vit_A_RAE'])
  ```

  > [!div class="alert is-tip"]
  > Output

  `<matplotlib.collections.PathCollection at 0x1f4261a3688>`

  :::image type="content" source="../media/matplotlib-scatter-2.svg" alt-text="Scatter plot output":::
  ***

</details>

<br /><br />

***

Let's drop `Folate_DFE_(µg)`, `Vit_A_RAE`, and `Vit_D_IU` from `df` to eliminate these problematic correlations. The k-means algorithm also doesn't work with `NaN` values, so we'll also have to drop those.

```python
nutr_df.drop(['Folate_DFE_(µg)', 'Vit_A_RAE', 'Vit_D_IU'],
        inplace=True, axis=1)
nutr_df = nutr_df.dropna()
nutr_df.head()
```

The output is:

> [!div class="alert is-tip"]
> Output

|  | Water_(g) | Energ_Kcal | Protein_(g) | Lipid_Tot_(g) | Ash_(g) | Carbohydrt_(g) | Fiber_TD_(g) | Sugar_Tot_(g) | Calcium_(mg) | Iron_(mg) | ... | Beta_Crypt_(Âµg) | Lycopene_(Âµg) | Lut+Zea_ (Âµg) | Vit_E_(mg) | Vit_D_Âµg | Vit_K_(Âµg) | FA_Sat_(g) | FA_Mono_(g) | FA_Poly_(g) | Cholestrl_(mg) |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| **NDB_No** |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |
| **1001** | 15.87 | 717.0 | 0.85 | 81.11 | 2.11 | 0.06 | 0.0 | 0.06 | 24.0 | 0.02 | ... | 0.0 | 0.0 | 0.0 | 2.32 | 0.0 | 7.0 | 51.368 | 21.021 | 3.043 | 215.0 |
| **1002** | 16.72 | 718.0 | 0.49 | 78.30 | 1.62 | 2.87 | 0.0 | 0.06 | 23.0 | 0.05 | ... | 6.0 | 0.0 | 13.0 | 1.37 | 0.0 | 4.6 | 45.390 | 19.874 | 3.331 | 225.0 |
| **1003** | 0.24 | 876.0 | 0.28 | 99.48 | 0.00 | 0.00 | 0.0 | 0.00 | 4.0 | 0.00 | ... | 0.0 | 0.0 | 0.0 | 2.80 | 0.0 | 8.6 | 61.924 | 28.732 | 3.694 | 256.0 |
| **1004** | 42.41 | 353.0 | 21.40 | 28.74 | 5.11 | 2.34 | 0.0 | 0.50 | 528.0 | 0.31 | ... | 0.0 | 0.0 | 0.0 | 0.25 | 0.5 | 2.4 | 18.669 | 7.778 | 0.800 | 75.0 |
| **1005** | 41.11 | 371.0 | 23.24 | 29.68 | 3.18 | 2.79 | 0.0 | 0.51 | 674.0 | 0.43 | ... | 0.0 | 0.0 | 0.0 | 0.26 | 0.5 | 2.5 | 18.764 | 8.598 | 0.784 | 94.0 |

5 rows × 43 columns
***

> [!NOTE]
> If the `read_csv()` function didn't read in the µ (mu) symbol correctly and the preceding `drop()` method call fails, try this code instead: `nutr_df.drop(['Folate_DFE_(Âµg)', 'Vit_A_RAE', 'Vit_D_IU'], inplace=True, axis=1)`

Because the k-means algorithm will calculate the Euclidean distances between data points and centroids, we need to ensure that all of the numeric features in our dataset use compatible units. We don't want to try to calculate distances between units of mass like grams and units of energy like kilocalories. 

Just as we did with principal component analysis (PCA) in section 1.2, we'll use scikit-learn's [`StandardScaler()` function](https://scikit-learn.org/stable/modules/generated/sklearn.preprocessing.StandardScaler.html?azure-portal=true). That function will center the data around each feature's mean and transform each feature to have a standard deviation of 1.

```python
from sklearn.preprocessing import StandardScaler

X = StandardScaler().fit_transform(nutr_df)
```
