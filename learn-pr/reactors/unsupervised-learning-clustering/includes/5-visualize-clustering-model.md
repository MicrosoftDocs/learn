
Similar to the situation with PCA, we can create visualizations of our clusters, but visualization is crude at best when it has been projected down through so many dimensions. That said, even trying to project from 43 dimensions down to 3 dimensions, noticeable patterns persist. To perform this visualization, we will first need to import the Axes3D module.

```python

```

The output is:

```Output
TBD
```

import matplotlib as mpl
from mpl_toolkits.mplot3d import Axes3D

mpl.rcParams['legend.fontsize'] = 10
fig = plt.figure(figsize=(6,6))
ax = Axes3D(fig)
C = kmeansmodel.cluster_centers_
ax.scatter(X[:, 0], X[:, 1], X[:, 2], c=kmeansmodel.labels_, alpha=0.3)

plt.show()

> [!div class="alert is-tip"]
> ### Takeaway
> 
> 
 Two observations:
>
> 1.  Notice that there is no hard boundary visible between the purple and yellow clusters. The boundary is there, but, because it's a higher-dimensional hyperplane, it gets smeared across three dimensional space.
> 2.  Note also that points from the light blue cluster are scattered across the plot. This is also an artifact of the clusters projection down from 43 dimensions to 3.

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

