

What sorts of foods populate the different clusters? We'll examine that question in greater depth later on, but we can get some sense of our clusters just by looking at the mean values for each of them.

```python

```

The output is:

```Output
TBD
```

nutr_df.groupby('Cluster').mean()

We can quickly see that cluter 2 encompasses fatty foods (high `Lipid_Tot_(g)` values). Clusters 0 and 1 have similar mean protein and lipid amounts; an easy-to-see differentiation between those clusters is their relative carbohydrate and sugar levels, with those in cluster 1 being significantly higher than those in cluster 0.

We can look at these high-level differences in a little more detail using the `describe()` method, though, honestly, given the size of the `DataFrame`, this is a little cumbersome.

```python

```

The output is:

```Output
TBD
```

nutr_df.groupby('Cluster').describe()

We can also predict the label for new or hypothetical observations. Let's provide the nutritional details for Gjetost cheese and see which cluster our model places it in. (Gjetost cheese is one of our discarded entries from the original `DataFrame` with `NaN` values imputed below.)

```python

```

The output is:

```Output
TBD
```

newcase = [[1021,
            13.44,
            466.0,
            9.65,
            29.51,
            4.75,
            42.65,
            0.0,
            1.50,
            400.0,
            0.52,
            70.0,
            444.0,
            1409.0,
            600.0,
            1.14,
            0.08,
            0.04,
            14.5,
            0.0,
            0.315,
            1.382,
            0.813,
            3.351,
            0.271,
            5.0,
            0.0,
            5.0,
            15.4,
            2.42,
            1113.0,
            334.0,
            0,
            20,
            0,
            0.5,
            22,
            2.4,
            19.16,
            7.879,
            0.938,
            94.0,
            28.35]]

```python

```

The output is:

```Output
TBD
```

kmeansmodel.predict(newcase)

The output indicates that Gjetost cheese falls under cluster 1.

### Try it yourself

>
> Now go back up and alter the values for Gjetost cheese in the `newcase` array above to see what it takes to get that array classified into cluster 0 or cluster 2.

We can also see the actual coordinate values for cluster centroids.

```python

```

The output is:

```Output
TBD
```

kmeansmodel.cluster_centers_

Remember that there is a method to this wall of numbers. Each coordinate is a point in 43-dimensional space, so each centroid is represented by an array of 43 values.

Let's now add back in our descriptive features so that we can see which food groups are in our clusters.

```python

```

The output is:

```Output
TBD
```

merged_df = nutr_df.join(desc_df)
merged_df.head()

Now we can look at the value counts for the different food groups in our clusters.

```python

```

The output is:

```Output
TBD
```

merged_df.loc[nutr_df['Cluster'] == 0]['FoodGroup'].value_counts()

> [!div class="alert is-tip"]
>
> ### Question
>
> Look back over the Python in the code cell above. Does the syntax make sense? If not, review the documentation for [`pandas.DataFrame.loc`](https://pandas.pydata.org/pandas-docs/stable/reference/api/pandas.DataFrame.loc.html) and [`pandas.Series.value_counts`](https://pandas.pydata.org/pandas-docs/stable/reference/api/pandas.Series.value_counts.html).
>
### Try it yourself

>
> Now find the `FoodGroup` value counts for clusters 1 and 2.

```python

```

The output is:

```Output
TBD
```

```python

```

The output is:

```Output
TBD
```

> **Exercise solutions**

```python

```

The output is:

```Output
TBD
```

merged_df.loc[nutr_df['Cluster'] == 1]['FoodGroup'].value_counts()

```python

```

The output is:

```Output
TBD
```

merged_df.loc[nutr_df['Cluster'] == 2]['FoodGroup'].value_counts()

Some of the entries in our clusters makes sense and others look kind of like the contents of a grab bag. Part of the reason for this is that the *k*-means algorithm has to draw rather arbitrary boundaries between clusters; there will be a lot of entries in all clusters that are right on the edge and could reasonably belong to two (or more) clusters. To reduce some of this noise, we can sort these by distance from centroid of the respective clusters and look at the entries closest to the centroids.

```python

```

The output is:

```Output
TBD
```

import numpy as np

distances = kmeansmodel.fit_transform(X)
merged_df['Distance'] = np.min(distances, axis=1)
merged_df.head()

> **Questions**
>
> 1.  Why is it only necessary to find the minimum distance to the three centroids for a given data point (`np.min`)?
> 2.  What role does the `axis=1` parameter play in the `np.min()` function?

We can now sort `FoodGroup` value counts by distance to the cluster's centroid, which can make the lists of principal food types in each cluster more intuitive.

```python

```

The output is:

```Output
TBD
```

merged_df.loc[nutr_df['Cluster'] == 0].sort_values(by='Distance')['FoodGroup'][:500].value_counts()

> [!div class="alert is-tip"]
>
> ### Question
>
> Look back over the Python in the code cell above. Does the syntax make sense? If not, review the documentation for [`pandas.DataFrame.sort_values`](https://pandas.pydata.org/pandas-docs/stable/reference/api/pandas.DataFrame.sort_values.html) and [slicing ranges in pandas](https://pandas.pydata.org/pandas-docs/stable/user_guide/indexing.html#slicing-ranges).
>
### Try it yourself

>
> Now find the sorted `FoodGroup` value counts for clusters 1 and 2. (> [!NOTE]
>  Due to the differing sizes of the clusters, try a variety of ranges for your slices.)

```python

```

The output is:

```Output
TBD
```

```python

```

The output is:

```Output
TBD
```

> **Possible exercise solutions**

```python

```

The output is:

```Output
TBD
```

merged_df.loc[nutr_df['Cluster'] == 1].sort_values(by='Distance')['FoodGroup'][:30].value_counts()

```python

```

The output is:

```Output
TBD
```

merged_df.loc[nutr_df['Cluster'] == 2].sort_values(by='Distance')['FoodGroup'][:200].value_counts()

> [!div class="alert is-tip"]
> ### Takeaway
> 
> 
 Even without subject-matter expertise, we can gain insights of varying depth about the clusters.

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

