## Unsupervised Learning

So far we have covered supervised learning algorithms - where we have labels for our examples. When a dataset doesn’t have labels we can use unsupervised learning to find some kind of structure in the data - discovering patterns or groupings.

Supervised learning is much more common than unsupervised learning, but unsupervised learning can help us quickly get some analysis on a dataset with little effort.

![7.1 ClusteringAnimated](../media/7.1_ClusteringAnimated.gif)

In the example above the model finds four groups in the unlabelled data - commonly referred to as clusters.

Unsupervised learning is commonly used in science and industry for cluster analysis and anomaly detection.

### Cluster analysis

Cluster analysis is a method of finding groupings, known as clusters, in datasets. As the datasets are unlabelled, cluster analysis tries to group similar examples using the examples features.

![7.1 cluster (1)](../media/7.1_cluster__1_.png)

In practice clustering tends to be used for social network analysis, computer clustering, scientific analysis in biology and astronomy, and customer analysis.

![7.1 ClusterNetwork](../media/7.1_ClusterNetwork.png)

There many types of cluster analysis, but AI practitioners tend to use k-means clustering for quick analysis. For in-depth unsupervised learning there are many tools - you can use support vector machines (support vector clustering), neural networks, and so on. Next we’ll look at k-means clustering.
