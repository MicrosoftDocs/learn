
You might have noticed that we manually determined the number ![$k$](https://render.githubusercontent.com/render/math?math=k&mode=inline), the number of clusters, earlier in this section. We assigned `n_clusters_ = 3` in the model. But is 3 the right number of clusters for this dataset?

In practice, determining the correct number of clusters can require a lot on domain knowledge and data interpretation. However, we can use the elbow method as a rough heuristic for determining the number of clusters to use, even absent any domain knowledge.

In the elbow method, we plot the within-cluster sum of squares (WCSS, a measure of the variability of the observations within each cluster) against different values of ![$k$](https://render.githubusercontent.com/render/math?math=k&mode=inline). Similar to the scree graph we used with PCA, we are looking for the value of ![$k$](https://render.githubusercontent.com/render/math?math=k&mode=inline) near where WCSS begins to flatten out and form an elbow.

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

```Output
TBD
```

> [!div class="alert is-tip"]
>
> ### Takeaway
>
> Ideally, we would want to see a more pronounced elbow. One could make the case for the elbow being at ![$k=5$](https://render.githubusercontent.com/render/math?math=k%3D5&mode=inline) - or at ![$k=8$](https://render.githubusercontent.com/render/math?math=k%3D8&mode=inline) or ![$k=10$](https://render.githubusercontent.com/render/math?math=k%3D10&mode=inline). And some datasets do produce a distinct elbow. However, real-world data is inherently messy, and there is no perfect way to evaluate *k*-means models apart from domain expertise and rigorous analysis.
