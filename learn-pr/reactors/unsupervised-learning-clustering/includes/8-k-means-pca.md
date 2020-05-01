<!--- Reviewers note: This unit uses LaTeX syntax to format mathematical content. A dollar sign $ starts and ends the LaTeX statement. -->

What if we went with $k=5$ instead of $k=3$? Would the contents of our clusters align with the components we identified in Section 1.2 (PCA)? We did, after all, divide the National Nutrient Database into five components in that section using PCA.

It's a seductive idea, but an incorrect one. Let's examine *why* it's incorrect; we'll start by re-fitting our *k*-means model on five clusters. (Remember that we defined earlier in this section `X = StandardScaler().fit_transform(nutr_df)`.)

```python
km = KMeans(n_clusters=5, random_state=1)
km.fit(X)
nutr_df['Cluster'] = km.labels_
nutr_df.head()
```

The output is:

```Output
TBD
```

With this code:

```python
dists = km.fit_transform(X)
merged_df = nutr_df.join(desc_df)
merged_df['Distance'] = np.min(dists, axis=1)
merged_df.head()

```

The output is:

```Output
TBD
```

We have now defined `merged_df` for $k=5$. Let's now extract the two features we will want to combine with our PCA results: `Cluster` and `FoodGroup`.

```python
cluster_df = merged_df[['Cluster', 'FoodGroup']]
cluster_df.head()
```

The output is:

```Output
TBD
```

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

```Output
TBD
```

Now that we have the PCA results in a `DataFrame`, let's sort them by $c_1$ and see how the cluster labels break down among the top 500 results.

```python
pca_df.sort_values(by='c1')['Cluster'][:500].value_counts()
```

The output is:

```Output
TBD
```

$c_1$ proved to have pretty close overlap with cluster 2. What about $c_2$?

```python
pca_df.sort_values(by='c2')['Cluster'][:500].value_counts()
```

The output is:

```Output
TBD
```

Here, the results are decidedly more mixed. But you can get a sense of how *k*-means clusters and PCA components do (and don't) overlap by changing the number of entries in the slice.

### Try it yourself

Evaluate the extent to which *k*-means clusters overlap with PCA components for $c_3$, $c_4$, and $c_5$. You might also want to adjust the size of slices that you take (more or less than 500) in order to see what effect that has on your results.

<br />

<details>
  <summary>Hint <i>(expand to reveal)</i></summary>

  Possible solutions:

  ```python
  pca_df.sort_values(by='c3')['Cluster'][:500].value_counts()
  ```

  The output is:

  ```Output
  TBD
  ```

  And:

  ```python
  pca_df.sort_values(by='c4')['Cluster'][:500].value_counts()
  ```

  The output is:

  ```Output
  TBD
  ```

  And:

  ```python
  pca_df.sort_values(by='c5')['Cluster'][:500].value_counts()
  ```

  The output is:

  ```Output
  TBD
  ```

</details>

<br /><br />

***

> [!div class="alert is-tip"]
>
> ### Takeaway
>
> While there can be some overlap between PCA and *k*-means, you should never conflate the two analytical techniques in your mind. *k*-means partitions a dataset into discrete clusters while PCA identifies components of the feature space of a dataset that convey the most information about the structure of the dataset.
