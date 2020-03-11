Evaluating a clustering model is made difficult by the fact that there are no previously known *true* values for the cluster assignments. A successful clustering model is one that achieves a good level of separation between the items in each cluster, so we need metrics to help us measure that separation.

## Add an Evaluate Model module

1. Open the **Iris Training** pipeline you created in the previous unit if it's not already open.
2. In the pane on the left, in the **Model Scoring & Evaluation** section, drag an **Evaluate Model** module to the canvas, under the **Train Clustering Model** module, and connect the **Results dataset** (right) output of the **Train Clustering Model** module to the **Scored dataset** (left) input of the **Evaluate Model** module.
3. Ensure your pipeline looks like this:

<p style='text-align:center'><img src='media/evaluate-cluster.jpg' alt='Evaluate Model module added to Score Model module'/></p>

4. Select **Submit**, and run the pipeline using the existing experiment named **iris-training**.
5. Wait for the experiment run to complete.
6. When the experiment run has completed, select the **Evaluate Model** module and in the settings pane, on the **Outputs + Logs** tab, under **Port outputs** in the **Evaluation results** section, use the **Visualize** icon to view the performance metrics. These metrics can help data scientists assess how well the model separates the clusters. They include a row of metrics for each cluster, and a summary row for a combined evaluation. The metrics in each row are:
    - **Average Distance to Other Center**: This indicates how close, on average, each point in the cluster is to the centroids of all other clusters.
    - **Average Distance to Cluster Center**: This indicates how close, on average, each point in the cluster is to the centroid of the cluster.
    - **Number of Points**: The number of points assigned to the cluster.
    - **Maximal Distance to Cluster Center**: The sum of the distances between each point and the centroid of that point’s cluster. If this number is high, the cluster may be widely dispersed. This statistic in combination with the **Average Distance to Cluster Center** helps you determine the cluster’s *spread*.

7. Close the **Evaluate Model result visualization** window.

Now that you have a working clustering model, you can use it to assign new data to clusters in an *inference pipeline*.
