<!--- Reviewers note: This unit uses LaTeX syntax to format mathematical content. A dollar sign $ starts and ends the LaTeX statement. -->

What if we went with $k=5$ instead of $k=3$? Would the contents of our clusters align with the components that we identified in section 1.2 (PCA)? We did, after all, divide the National Nutrient Database into five components in that section by using PCA.

It's a seductive idea, but an incorrect one. Let's examine *why* it's incorrect. We'll start by refitting our k-means model on five clusters. (Remember that we defined earlier in this section `X = StandardScaler().fit_transform(nutr_df)`.)

```python
km = KMeans(n_clusters=5, random_state=1)
km.fit(X)
nutr_df['Cluster'] = km.labels_
nutr_df.head()
```

The output is:

> [!div class="alert is-tip"]
> Output

|  | Water_(g) | Energ_Kcal | Protein_(g) | Lipid_Tot_(g) | Ash_(g) | Carbohydrt_(g) | Fiber_TD_(g) | Sugar_Tot_(g) | Calcium_(mg) | Iron_(mg) | ... | Lycopene_(Âµg) | Lut+Zea_ (Âµg) | Vit_E_(mg) | Vit_D_Âµg | Vit_K_(Âµg) | FA_Sat_(g) | FA_Mono_(g) | FA_Poly_(g) | Cholestrl_(mg) | Cluster |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| **NDB_No** |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |
| **1001** | 15.87 | 717.0 | 0.85 | 81.11 | 2.11 | 0.06 | 0.0 | 0.06 | 24.0 | 0.02 | ... | 0.0 | 0.0 | 2.32 | 0.0 | 7.0 | 51.368 | 21.021 | 3.043 | 215.0 | 4 |
| **1002** | 16.72 | 718.0 | 0.49 | 78.30 | 1.62 | 2.87 | 0.0 | 0.06 | 23.0 | 0.05 | ... | 0.0 | 13.0 | 1.37 | 0.0 | 4.6 | 45.390 | 19.874 | 3.331 | 225.0 | 4 |
| **1003** | 0.24 | 876.0 | 0.28 | 99.48 | 0.00 | 0.00 | 0.0 | 0.00 | 4.0 | 0.00 | ... | 0.0 | 0.0 | 2.80 | 0.0 | 8.6 | 61.924 | 28.732 | 3.694 | 256.0 | 4 |
| **1004** | 42.41 | 353.0 | 21.40 | 28.74 | 5.11 | 2.34 | 0.0 | 0.50 | 528.0 | 0.31 | ... | 0.0 | 0.0 | 0.25 | 0.5 | 2.4 | 18.669 | 7.778 | 0.800 | 75.0 | 3 |
| **1005** | 41.11 | 371.0 | 23.24 | 29.68 | 3.18 | 2.79 | 0.0 | 0.51 | 674.0 | 0.43 | ... | 0.0 | 0.0 | 0.26 | 0.5 | 2.5 | 18.764 | 8.598 | 0.784 | 94.0 | 3 |

5 rows × 44 columns
***

With this code:

```python
dists = km.fit_transform(X)
merged_df = nutr_df.join(desc_df)
merged_df['Distance'] = np.min(dists, axis=1)
merged_df.head()

```

The output is:

> [!div class="alert is-tip"]
> Output

|  | Water_(g) | Energ_Kcal | Protein_(g) | Lipid_Tot_(g) | Ash_(g) | Carbohydrt_(g) | Fiber_TD_(g) | Sugar_Tot_(g) | Calcium_(mg) | Iron_(mg) | ... | FA_Poly_(g) | Cholestrl_(mg) | Cluster | FoodGroup | Shrt_Desc | GmWt_Desc1 | GmWt_2 | GmWt_Desc2 | Refuse_Pct | Distance |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| **NDB_No** |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |
| **1001** | 15.87 | 717.0 | 0.85 | 81.11 | 2.11 | 0.06 | 0.0 | 0.06 | 24.0 | 0.02 | ... | 3.043 | 215.0 | 4 | Dairy and Egg Products | BUTTER,WITH SALT | 1 pat, (1" sq, 1/3" high) | 14.2 | 1 tbsp | 0.0 | 11.350736 |
| **1002** | 16.72 | 718.0 | 0.49 | 78.30 | 1.62 | 2.87 | 0.0 | 0.06 | 23.0 | 0.05 | ... | 3.331 | 225.0 | 4 | Dairy and Egg Products | BUTTER,WHIPPED,W/ SALT | 1 pat, (1" sq, 1/3" high) | 9.4 | 1 tbsp | 0.0 | 10.414916 |
| **1003** | 0.24 | 876.0 | 0.28 | 99.48 | 0.00 | 0.00 | 0.0 | 0.00 | 4.0 | 0.00 | ... | 3.694 | 256.0 | 4 | Dairy and Egg Products | BUTTER OIL,ANHYDROUS | 1 tbsp | 205.0 | 1 cup | 0.0 | 14.141192 |
| **1004** | 42.41 | 353.0 | 21.40 | 28.74 | 5.11 | 2.34 | 0.0 | 0.50 | 528.0 | 0.31 | ... | 0.800 | 75.0 | 3 | Dairy and Egg Products | CHEESE,BLUE | 1 oz | 17.0 | 1 cubic inch | 0.0 | 4.360586 |
| **1005** | 41.11 | 371.0 | 23.24 | 29.68 | 3.18 | 2.79 | 0.0 | 0.51 | 674.0 | 0.43 | ... | 0.784 | 94.0 | 3 | Dairy and Egg Products | CHEESE,BRICK | 1 cup, diced | 113.0 | 1 cup, shredded | 0.0 | 4.690336 |

5 rows × 51 columns
***

We have now defined `merged_df` for $k=5$. Let's extract the two features we'll want to combine with our PCA results: `Cluster` and `FoodGroup`.

```python
cluster_df = merged_df[['Cluster', 'FoodGroup']]
cluster_df.head()
```

The output is:

> [!div class="alert is-tip"]
> Output

|  | Cluster | FoodGroup |
| --- | --- | --- |
| **NDB_No** |  |  |
| **1001** | 4 | Dairy and Egg Products |
| **1002** | 4 | Dairy and Egg Products |
| **1003** | 4 | Dairy and Egg Products |
| **1004** | 3 | Dairy and Egg Products |
| **1005** | 3 | Dairy and Egg Products |

***

Let's now run PCA on this dataset and join `Cluster` and `FoodGroup` to the results.

```python
from sklearn.decomposition import PCA

fit = PCA()
pca = fit.fit_transform(X)
pca_df = pd.DataFrame(pca[:, :5], index=nutr_df.index)
pca_df = pca_df.join(cluster_df)
pca_df.rename(columns={0:'c1', 1:'c2', 2:'c3', 3:'c4', 4:'c5'},
              inplace=True)
pca_df.head()
```

The output is:

> [!div class="alert is-tip"]
> Output

|  | c1 | c2 | c3 | c4 | c5 | Cluster | FoodGroup |
| --- | --- | --- | --- | --- | --- | --- | --- |
| **NDB_No** |  |  |  |  |  |  |  |
| **1001** | 1.210730 | -7.749161 | 0.011221 | 2.814936 | -3.573719 | 4 | Dairy and Egg Products |
| **1002** | 1.054329 | -7.239046 | 0.016543 | 2.610281 | -3.424977 | 4 | Dairy and Egg Products |
| **1003** | 1.920274 | -9.822701 | 0.020957 | 3.601209 | -5.035544 | 4 | Dairy and Egg Products |
| **1004** | 0.859770 | -2.428186 | -0.621847 | 0.928657 | 0.951062 | 3 | Dairy and Egg Products |
| **1005** | 0.602773 | -2.724407 | -0.610201 | 1.134215 | 0.780761 | 3 | Dairy and Egg Products |

***

Now that we have the PCA results in a DataFrame, let's sort them by $c_1$ and see how the cluster labels break down among the top 500 results.

```python
pca_df.sort_values(by='c1')['Cluster'][:500].value_counts()
```

The output is:

```Output
2    496
1      4
Name: Cluster, dtype: int64
```

$c_1$ proved to have pretty close overlap with cluster 2. What about $c_2$?

```python
pca_df.sort_values(by='c2')['Cluster'][:500].value_counts()
```

The output is:

```Output
4    342
3    153
2      5
Name: Cluster, dtype: int64
```

Here, the results are more mixed. But you can get a sense of how k-means clusters and PCA components do (and don't) overlap by changing the number of entries in the slice.

### Try it yourself

Evaluate the extent to which k-means clusters overlap with PCA components for $c_3$, $c_4$, and $c_5$. You might also want to adjust the size of slices that you take (more or less than 500) and see what effect that has on your results.

<br />

<details>
  <summary>Hint <i>(expand to reveal)</i></summary>

  Possible solutions:

  ```python
  pca_df.sort_values(by='c3')['Cluster'][:500].value_counts()
  ```

  The output is:

  ```Output
  3    486
  0     13
  4      1
  Name: Cluster, dtype: int64
  ```

  And:

  ```python
  pca_df.sort_values(by='c4')['Cluster'][:500].value_counts()
  ```

  The output is:

  ```Output
  4    335
  2    123
  0     42
  Name: Cluster, dtype: int64
  ```

  And:

  ```python
  pca_df.sort_values(by='c5')['Cluster'][:500].value_counts()
  ```

  The output is:

  ```Output
  4    318
  2     51
  3     47
  0     45
  1     39
  Name: Cluster, dtype: int64
  ```

</details>

<br /><br />

***

> [!div class="alert is-tip"]
>
> ### Takeaway
>
> Although some overlap can happen between PCA and *k*-means, you should never conflate the two analytical techniques in your mind. The k-means technique partitions a dataset into discrete clusters. PCA identifies components of the feature space of a dataset that convey the most information about the structure of the dataset.
