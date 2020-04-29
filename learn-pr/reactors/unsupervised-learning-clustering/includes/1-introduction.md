
Up until now, we have only examined *supervised* machine learning (ML), in which we provide labeled training data for the algorithm. *k*-means clustering is the first *unsupervised* ML algorithm that we have dealt with: we provide the algorithm with a set of ![$n$](https://render.githubusercontent.com/render/math?math=n&mode=inline) data points and tell the algorithm that we want that data partitioned into ![$k$](https://render.githubusercontent.com/render/math?math=k&mode=inline) clusters that provide the best separation between clusters.

The *k*-means algorithm randomly assigns ![$k$](https://render.githubusercontent.com/render/math?math=k&mode=inline) *centroids* (or geometric centers of subsets of the dataset as measured through [Euclidean distance](http://mathworld.wolfram.com/Distance.html)) to the data and then iteratively moves those centroids around the feature space until it converges on an arrangement of the centroids the minimizes the variance within the clusters.

![SegmentLocal|20%](https://github.com/microsoft/Reactors/raw/e28b47d9c2c0df51294108612d78baccb8506dbb/Machine_Learning_2/Images/K-means_convergence.gif "segment")

(Image courtesy of [Wikimedia Commons](https://en.wikipedia.org/wiki/File:K-means_convergence.gif) and is distributed under the terms of the [GNU Free Documentation License](https://en.wikipedia.org/wiki/GNU_Free_Documentation_License).)

## Learning objectives

In this module, you will:

- Learn about the kinds of results obtained with the *k*-means algorithm
- Get basic knowledge about how to interpret those results

## Prerequisites

- TBD
