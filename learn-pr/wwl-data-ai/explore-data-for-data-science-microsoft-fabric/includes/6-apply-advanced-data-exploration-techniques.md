Advanced data exploration techniques like correlation analysis and dimensionality reduction help uncover hidden patterns and relationships in the data, providing valuable insights that can guide decision-making.

## Correlation

Correlation is a statistical method used to evaluate the strength and direction of the linear relationship between two quantitative variables. The correlation coefficient ranges from -1 to 1.

| Correlation Coefficient | Description |
|-------------------------|-------------|
| **1**   | Indicates a perfect **positive linear correlation**. As one variable increases, the other variable also increases. |
| **-1**  | Indicates a perfect **negative linear correlation**. As one variable increases, the other variable decreases. |
| **0**   | Indicates **no linear correlation**. The two variables don't have a relationship with each other. |
```python
import seaborn as sns
import matplotlib.pyplot as plt

# Load the iris dataset
iris = sns.load_dataset('iris')

# Calculate the correlation matrix
corr = iris.corr()

# Create a heatmap
sns.heatmap(corr, annot=True)
plt.show()
```

:::image type="content" border="false" source="../media/6-correlation-analysis.png" alt-text="Screenshot of the correlation using heat maps in a notebook.":::

The strongest correlation in the dataset is between `petal_length` and `petal_width` variables, with a correlation coefficient of **0.96**. This suggests a strong positive linear relationship, that is, longer petals are typically also wider.

The identification and analysis of correlations are important for the following reasons.

- **Predictive analysis:** If two variables are highly correlated, we can predict one variable from the other.
- **Feature selection:** If two features are highly correlated, we might drop one as it doesn't provide unique information.
- **Understanding relationships:** Correlation helps in understanding the relationship between different variables in the data.

> [!Important]
> Fundamentally, correlation doesn't imply causation. Just because two variables are correlated doesn't mean that changes in one variable cause changes in the other.

## Principal Component Analysis (PCA)

[Principal Component Analysis (PCA)](https://en.wikipedia.org/wiki/Principal_component_analysis) can be used for both exploration and preprocessing of data. When used for exploration, PCA helps you to visualize high-dimensional data in two or three dimensions, making it easier to identify patterns and relationships between variables.

Suppose you’re working with the iris dataset, which includes measurements for 150 iris flowers from three different species. The `sepal_length`, `sepal_width`, `petal_length`, and `petal_width` variables describe each flower.

By applying PCA, you can reduce these four variables to two principal components that capture the most variance in your data. This transformation reduces the dimensionality of your data from four dimensions to two. You can then create a 2D scatter plot to visualize the data and identify clusters of flowers with similar characteristics.

To simplify our example, we're working with the iris dataset that contains only four variables. However, you would follow a similar approach when working with a larger dataset.

```python
import seaborn as sns
from sklearn.decomposition import PCA
import matplotlib.pyplot as plt

# Load the iris dataset
iris = sns.load_dataset('iris')

# Prepare the data and target
X = iris.drop('species', axis=1)
y = iris['species']

# Initialize and apply PCA
pca = PCA(n_components=2)
X_pca = pca.fit_transform(X)

# Plot the data
plt.figure(figsize=(8, 6))
for color, target in zip(['navy', 'turquoise', 'darkorange'], ['setosa', 'versicolor', 'virginica']):
    plt.scatter(X_pca[y == target, 0], X_pca[y == target, 1], color=color, alpha=.8, lw=2,
                label=target)
plt.legend(loc='best', shadow=False, scatterpoints=1)
plt.title('PCA of IRIS dataset')
plt.show()
```

:::image type="content" border="false" source="../media/7-pca-analysis.png" alt-text="Screenshot of how to apply the principal component analysis to reduce the dimensionality, and then plot the data points in a scatter plot.":::

Each point on the plot represents a flower from the dataset. The values for the first and second principal components (*x* and *y*) determine the position of a point.

These are new variables that PCA creates from linear combinations of the `sepal_length`, `sepal_width`, `petal_length`, and `petal_width` variables. The first principal component captures the most variance in the data, and each subsequent component captures less variance.

The results show a separation between flowers of different species. That is, points of the same color (species) are closer together and points of different colors are further apart. Differences in the feature distributions for different classes result in this separation, suggesting that we can distinguish these species based on their sepal and petal measurements.
