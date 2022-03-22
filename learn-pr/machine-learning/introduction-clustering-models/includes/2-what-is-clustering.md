Clustering is a form of machine learning in which observations are grouped into clusters, based on similarities in their data values, or features. This kind of machine learning is considered *unsupervised* because it doesn't make use of previously known values (called *labels*) to train a model. In a clustering model, you can think of the label as the cluster to which the observation is assigned, based purely on its features. 

For example, suppose a botanist observes a sample of flowers, and records the number of petals and leaves on each flower. 

:::image type="content" source="../media/flower-clusters.png" alt-text="Illustration showing flower clusters." border="false":::

It might be useful to group these flowers into clusters, based on similarities between their features. There are many ways this could be done. For example, if most flowers have the same number of leaves, they could instead be grouped into those with many petals or few petals. Alternatively, if both petal and leaf counts vary considerably, there might be another pattern to discover, such as those with many leaves *and* petals.

The goal of the clustering algorithm is to find the optimal way to split the dataset into groups. What *optimal* means depends on both the algorithm used and the dataset that is provided. 

Although this flower example can be simple for a human to group with only a few samples, more complex examples can benefit from clustering algorithms. As the dataset grows to thousands of samples or to more than two features, clustering algorithms help you quickly dissect a dataset into groups. 