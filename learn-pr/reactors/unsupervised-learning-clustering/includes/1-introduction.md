<!--- Reviewers note: This unit uses LaTeX syntax to format mathematical content. A dollar sign $ starts and ends the LaTeX statement. -->

Until now, we've examined only *supervised* machine learning, in which we provide labeled training data for the algorithm. The first *unsupervised* machine learning algorithm that we'll deal with is k-means clustering. We provide the algorithm with a set of $n$ data points and tell the algorithm that we want that data partitioned into $k$ clusters that provide the best separation between clusters.

The k-means algorithm randomly assigns $k$ *centroids* (or geometric centers of subsets of the dataset as measured through [Euclidean distance](http://mathworld.wolfram.com/Distance.html?azure-portal=true)) to the data. The algorithm then iteratively moves those centroids around the feature space until it converges on an arrangement of the centroids that minimizes the variance within the clusters.

:::image type="content" source="../media/K-means_convergence.gif" alt-text="Segment|20%":::

(Image courtesy of [Wikimedia Commons](https://en.wikipedia.org/wiki/File:K-means_convergence.gif?azure-portal=true) and is distributed under the terms of the [GNU Free Documentation License](https://en.wikipedia.org/wiki/GNU_Free_Documentation_License?azure-porta=true).)

## Learning objectives

In this module, you will:

- Learn about the kinds of results obtained with the k-means algorithm
- Get basic knowledge about how to interpret those results

## Prerequisites

- Introduction to Python
- Beginners Data Science for Python Developers
- Join and clean datasets: Deep dive
- Supervised learning: Regression
- Predict numeric values with regression
- Predict categories with machine learning classification

[!INCLUDE [Set up your environment](../../includes/set-up-environment.md)]
