
We're now ready to import the k-means clustering algorithm.

```python
from sklearn.cluster import KMeans
```

We can use any number of clusters that we want. We'll use three clusters as a convenient number for an initial exploration of k-means clustering.

```python
kmeansmodel = KMeans(n_clusters=3, random_state=13)
kmeansmodel.fit(X)
```

The output is:

```Output
KMeans(algorithm='auto', copy_x=True, init='k-means++', max_iter=300,
    n_clusters=3, n_init=10, n_jobs=None, precompute_distances='auto',
    random_state=13, tol=0.0001, verbose=0)
```

> [!div class="alert is-tip"]
>
> ### Question
>
> Based on what you've learned in this course so far, what role does our declaration of `random_state` play in the `KMeans()` function?

Let's take a look at the labels for our clusters.

> [!div class="alert is-tip"]
>
> ### Question
>
> Given what you know about Python zero-based indexing and the number of clusters we selected, what labels do you expect to see?

```python
kmeansmodel.labels_
```

The output is:

```Output
array([2, 2, 2, ..., 2, 0, 0])
```

As expected, our labels for the clusters are `0`, `1`, and `2`.

Let's examine the distribution of data points among the clusters.

```python
pd.value_counts(kmeansmodel.labels_)
```

The output is:

```Output
0    2432
2     806
1      79
dtype: int64
```

You might also check various cluster statistics for comparison of the clusters.

We'll want to access these labels later on, so let's add them to our DataFrame.

```python
nutr_df['Cluster'] = kmeansmodel.labels_
nutr_df.head()
```

The output is:

> [!div class="alert is-tip"]
> Output

|  | Water_(g) | Energ_Kcal | Protein_(g) | Lipid_Tot_(g) | Ash_(g) | Carbohydrt_(g) | Fiber_TD_(g) | Sugar_Tot_(g) | Calcium_(mg) | Iron_(mg) | ... | Lycopene_(Âµg) | Lut+Zea_ (Âµg) | Vit_E_(mg) | Vit_D_Âµg | Vit_K_(Âµg) | FA_Sat_(g) | FA_Mono_(g) | FA_Poly_(g) | Cholestrl_(mg) | Cluster |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| **NDB_No** |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |
| **1001** | 15.87 | 717.0 | 0.85 | 81.11 | 2.11 | 0.06 | 0.0 | 0.06 | 24.0 | 0.02 | ... | 0.0 | 0.0 | 2.32 | 0.0 | 7.0 | 51.368 | 21.021 | 3.043 | 215.0 | 2 |
| **1002** | 16.72 | 718.0 | 0.49 | 78.30 | 1.62 | 2.87 | 0.0 | 0.06 | 23.0 | 0.05 | ... | 0.0 | 13.0 | 1.37 | 0.0 | 4.6 | 45.390 | 19.874 | 3.331 | 225.0 | 2 |
| **1003** | 0.24 | 876.0 | 0.28 | 99.48 | 0.00 | 0.00 | 0.0 | 0.00 | 4.0 | 0.00 | ... | 0.0 | 0.0 | 2.80 | 0.0 | 8.6 | 61.924 | 28.732 | 3.694 | 256.0 | 2 |
| **1004** | 42.41 | 353.0 | 21.40 | 28.74 | 5.11 | 2.34 | 0.0 | 0.50 | 528.0 | 0.31 | ... | 0.0 | 0.0 | 0.25 | 0.5 | 2.4 | 18.669 | 7.778 | 0.800 | 75.0 | 2 |
| **1005** | 41.11 | 371.0 | 23.24 | 29.68 | 3.18 | 2.79 | 0.0 | 0.51 | 674.0 | 0.43 | ... | 0.0 | 0.0 | 0.26 | 0.5 | 2.5 | 18.764 | 8.598 | 0.784 | 94.0 | 2 |

5 rows × 44 columns
***

> [!div class="alert is-tip"]
> ### Takeaway
>
> Because data naturally clusters, we should not expect the clusters to be the same size.
