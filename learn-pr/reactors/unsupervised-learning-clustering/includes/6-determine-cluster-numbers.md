<!--- Reviewers note: This unit uses LaTeX syntax to format mathematical content. A dollar sign $ starts and ends the LaTeX statement. -->

You might have noticed that we manually determined the number $k$, the number of clusters, earlier in this section. We assigned `n_clusters_ = 3` in the model. But is 3 the right number of clusters for this dataset?

In practice, determining the correct number of clusters can require a lot of domain knowledge and data interpretation. But we can use the elbow method as a rough heuristic for determining the number of clusters to use, even without any domain knowledge.

In the elbow method, we plot the within-cluster sum of squares (WCSS, a measure of the variability of the observations within each cluster) against different values of $k$. Similar to the scree graph we used with PCA, we're looking for the value of $k$ near where WCSS begins to flatten out and form an elbow.

```python
WCSS = []
for num in range(1, 12):
    kmeans = KMeans(n_clusters = num,  random_state = 50)
    kmeans.fit(X)
    WCSS.append(kmeans.inertia_)
```

```python
plt.figure(figsize=(13, 8))

plt.plot(range(1, 12), WCSS,'ro--',linewidth=2, markersize=12)
# plt.title('ELBOW METHOD')
plt.rcParams.update({'font.size': 14})
plt.xlabel('Number of clusters (k)')
plt.ylabel('WCSS')
plt.show()
```

The output is:

> [!div class="alert is-tip"]
> Output

:::image type="content" source="../media/elbow-method-plot.svg" alt-text="Two-dimensional graph that shows the elbow method results.":::
***

> [!div class="alert is-tip"]
>
> ### Takeaway
>
> Ideally, we would want to see a more pronounced elbow. You can make a case for the elbow being at $k=5$ - or at $k=8$ or $k=10$. Some datasets do produce a distinct elbow. However, real-world data is inherently messy. There is no perfect way to evaluate k-means models apart from domain expertise and rigorous analysis.
