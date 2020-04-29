
We are now ready to import *k*-means clustering algorithm.

```python
from sklearn.cluster import KMeans
```

While we can use any number of clusters that we wish, we will initially use three clusters as a convenient number for an initial exploration of k-means clustering.

```python
kmeansmodel = KMeans(n_clusters=3, random_state=13)
kmeansmodel.fit(X)
```

The output is:

```Output
TBD
```

> [!div class="alert is-tip"]
>
> ### Question
>
> Given what you have learned in this course thus far, what role does our declaration of the `random_state` above play in the `KMeans()` function?

Let's take a look at the labels for our clusters.

> [!div class="alert is-tip"]
>
> ### Question
>
> Given what you know about Python zero-indexing and the number of clusters we selected, what labels do you expect to see?

```python
kmeansmodel.labels_
```

The output is:

```Output
TBD
```

As expected, our labels for the different clusters are `0`, `1`, and `2`.

Let's examine the distribution of data points among the clusters.

```python
pd.value_counts(kmeansmodel.labels_)
```

The output is:

```Output
TBD
```

You might also check various cluster stats for comparison of the clusters.

We will want to access these labels later on, so let's add them to our `DataFrame`.

```python
nutr_df['Cluster'] = kmeansmodel.labels_
nutr_df.head()
```

The output is:

```Output
TBD
```

> [!div class="alert is-tip"]
> ### Takeaway
>
> Because data naturally clusters, we should not expect the clusters to be the same size.
