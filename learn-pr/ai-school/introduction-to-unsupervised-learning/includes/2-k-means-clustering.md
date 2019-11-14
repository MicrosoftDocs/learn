K-means clustering lives true to its name - it separates examples into k number of clusters (so if k is 5, it will divide the examples into 5 clusters) and it partitions the examples by the average (mean) of the clusters.

All k-means needs to run is the dataset and the number of clusters the user wants to map out.

It is very common for AI practitioners to decide the number of clusters by running k-means with several different numbers of clusters. The results are then visualized for the users decision. There is a cost function to determine an error rate but analyzing cost for k-means is often ambiguous as to the correct number of clusters.

![Animated scatter plot with the Y-axis labeled 'independent variable 2' and the X-axis labeled 'independent variable 1'. The plot has many data points, all grey. Initially the three squares, each a different color, appear on the plot with the title 'start'. After this, the title changes to 'assign points to data clusters' and the data points are assigned to the cluster they are closest to, and change to that color. Next, the title changes to 'update cluster centers' and the colored squares move to the center of their colored cluster. Again, the data points are assigned to the cluster they are closest to, and changing to that color. This process of updating cluster centers and assigning points to data clusters repeats several more times, until the cluster centers do not move much, and the title changes to 'finish'](../media/kmeans.gif)

The starting points of the clusters begin at random, then k-means has two steps:

1. Examples are assigned to the cluster that they are closest to.
2. The starting points of the clusters move to the average value of the examples grouped to that cluster.

These steps then repeat several times and the clustering is complete.

Next up we'll use k-means in Azure Notebooks.
