One of the most common uses of PCA is to prepare data for categorization. PCA provides meaningful dimensions which are non-correlated, so our cluster will typically provide better results. This is why we started with PCA to before we attempted to cluster our foods together.

To perform the categorization, we're going to use [k-means clustering](https://wikipedia.org/wiki/K-means_clustering?azure-portal=true). In a nutshell, *k*-means will look to identify groups (or clusters) in our data.

We're going to start by loading the library, creating our model, and then fitting our PCA results into the model. We are arbitrarily using 3 clusters; in TBD--link to k-means unit in LP 3--TBD there is a deeper conversation of *k*-means and how to determine the best number of clusters. We're using just the first 5 components as we determined it will provide the best return on investment.

```python
from sklearn.cluster import KMeans
kmeansmodel = KMeans(n_clusters=3, random_state=13)
kmeansmodel.fit(pca[:, :5])
kmeansmodel.labels_
```

Here's the output:

```Output
TBD
```

Let's recreate our DataFrame with the PCA values, a new column named Cluster which will hold the label_ or cluster number for each food item, and add back in the text descriptions.

```python
Create a new data frame
pca_df = pd.DataFrame(pca[:, :5], index=desc_df.index)

Add in the cluster number
pca_df['Cluster'] = kmeansmodel.labels_

Add in the text descriptions
pca_df = pca_df.join(desc_df)
pca_df.head()
```

## Explore our clusters

Let's see the products which wound up in the first cluster.

```python
pca_df.loc[pca_df['Cluster'] == 0]['Shrt_Desc'][:500]
```

Here's the output:

```Output
TBD
```

### Try it yourself

Display the first 500 rows for the remaining two clusters.

<br />

<details>

  <summary>Hint <i>(expand to reveal)</i></summary>

  ```python
  Display cluster two (remember indexing starts at 0)
  ```

  The output is:

  ```Output
 TBD
  ```

  ```python
  Display cluster three (remember indexing starts at 0)
  ```

  The output is:

  ```Output
 TBD
  ```

</details>

<br /><br />

***


Reducing dimensions to allow us to focus on what's important can be a bit of a a challenge. And, frankly, PCA can be a bit confusing at first. PCA's main goal is to provide us with a better signal to noise ratio. It helps us weed out the dimensions which aren't as important, and provide more meaningful insights into the relationships between our data. It's commonly used before categorization algorithms, such as k-means.