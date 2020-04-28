

We are now ready to import *k*-means clustering algorithm.

```python

```

The output is:

```Output
TBD
```

from sklearn.cluster import KMeans

While we can use any number of clusters that we wish, we will initially use three clusters as a convenient number for an initial exploration of k-means clustering.

```python

```

The output is:

```Output
TBD
```

kmeansmodel = KMeans(n_clusters=3, random_state=13)
kmeansmodel.fit(X)

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

```

The output is:

```Output
TBD
```

kmeansmodel.labels_

As expected, our labels for the different clusters are `0`, `1`, and `2`.

Let's examine the distribution of data points among the clusters.

```python

```

The output is:

```Output
TBD
```

pd.value_counts(kmeansmodel.labels_)

You might also check various cluster stats for comparison of the clusters.

We will want to access these labels later on, so let's add them to our `DataFrame`.

```python

```

The output is:

```Output
TBD
```

nutr_df['Cluster'] = kmeansmodel.labels_
nutr_df.head()

> [!div class="alert is-tip"]
> ### Takeaway
> 
> 
 Because data naturally clusters, we should not expect the clusters to be the same size.

TBD

### Try it yourself

TBD

<details>
  <summary>Hint <i>(expand to reveal)</i></summary>

  The input is:

  ```python
  ```

  The output is:

  The output is:

```Output
  ```

</details>

<br /><br />

***


> [!div class="alert is-tip"]
> ### Takeaway
>
>The performance of our naive Bayes model helps underscore the algorithm's popularity, particularly for spam detection. Even untuned, we got good performance, performance that would only continue to improve in production as users submitted more examples of spam messages.
>

