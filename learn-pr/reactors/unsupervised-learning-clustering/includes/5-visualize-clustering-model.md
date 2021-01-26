Similar to the situation with PCA, we can create visualizations of our clusters. But visualization is crude at best when it has been projected down through so many dimensions. Even when we're trying to project from 43 dimensions down to 3 dimensions, noticeable patterns persist. To perform this visualization, we'll first need to import the Axes3D module.

```python
import matplotlib as mpl
from mpl_toolkits.mplot3d import Axes3D

mpl.rcParams['legend.fontsize'] = 10
fig = plt.figure(figsize=(6,6))
ax = Axes3D(fig)
C = kmeansmodel.cluster_centers_
ax.scatter(X[:, 0], X[:, 1], X[:, 2], c=kmeansmodel.labels_, alpha=0.3)

plt.show()
```

The output is:

> [!div class="alert is-tip"]
> Output

:::image type="content" source="../media/matplotlib-scatter-3.svg" alt-text="Axes3D ax.scatter plot output":::
***

> [!div class="alert is-tip"]
>
> ### Takeaway
>
> Two observations:
>
> - No hard boundary is visible between the purple and yellow clusters. The boundary is there, but because it's a higher-dimensional hyperplane, it gets smeared across three-dimensional space.
> - Points from the light blue cluster are scattered across the plot. This is also an artifact of the cluster's projection down from 43 dimensions to 3.
