After you've used data transformations to prepare the data, you can use it to train a machine learning model.

## Add training modules

To train a clustering model, you need to apply a clustering algorithm to the data, using only the features that you want to be used for clustering.

1. Open the **Iris Training** pipeline you created in the previous unit if it's not already open.
2. Expand the **Model Training** section in the pane on the left, and drag a **Train Clustering Model** module to the canvas, under the **iris** dataset. Then connect the output of the dataset to the *Dataset* (right) input of the **Train Clustering Model** module.
3. The clustering model should assign clusters to the data items by using only the four measurements - we're going to ignore the fact that we already know the species. Select the **Train Clustering Model** module and in its settings pane, on the **Parameters** tab, select **Edit Columns** and include only the column names **Column1**, **Column2**, **Column3**, and **Column4**; like this:

<p style='text-align:center'><img src='media/cluster-features.jpg' alt='include column names Column1, Column2, Column3, and Column4'/></p>

4. The model we're training will use the four feature columns to group the data into clusters, so we need to train the model using a *clustering* algorithm. Expand the **Machine Learning Algorithms** section, and under **Clustering**, drag a **K-Means Clustering** module to the canvas, to the left of the **iris** dataset and above the **Train Clustering Model** module. Then connect its output to the **Untrained model** (left) input of the **Train Clustering Model** module.
5. The *K-Means* algorithm groups items into the number of clusters you specify - a value referred to as ***K***. Select the **K-Means Clustering** module and in its settings pane, on the **Parameters** tab, set the **Number of centroids** parameter to **3**.

> [!NOTE] 
> You can think of data observations, like the iris measurements, as being multidimensional vectors. The K-Means algorithm works by:
> 1. initializing *K* coordinates as randomly selected points called *centroids* in  *n*-dimensional space (where *n* is the number of dimensions in the feature vectors).
> 2. Plotting the feature vectors as points in the same space, and assigning each point to its closest centroid.
> 3. Moving the centroids to the middle of the points allocated to it (based on the *mean* distance).
> 4. Reassigning the points to their closest centroid after the move.
> 5. Repeating steps 3 and 4 until the cluster allocations stabilize or the specified number of iterations has completed.

6. Ensure your pipeline looks like this:

<p style='text-align:center'><img src='media/k-means.jpg' alt='iris dataset, K-Means Clustering algorithm. and Train Clustering Model module'/></p>

## Run the training pipeline

Now you're ready to run the training pipeline and train the model.

1. Select **Submit**, and run the pipeline using a new experiment named **iris-training**.
2. Wait for the experiment run to complete. This may take 5 minutes or more.
3. When the experiment run has completed (indicated by a &#x2705; icon for each module), select the **Train Clustering Model** module and in its settings pane, on the **Outputs + Logs** tab, under **Port outputs** in the **Results dataset** section, use the **Visualize** icon to view the results.
4. Scroll to the right, and note the **Assignments** column, which contains the cluster (0, 1, or 2) to which each row is assigned. There are also new columns indicating the distance from the point representing this row to the centers of each of the clusters - the cluster to which the point is closest is the one to which it is assigned.
5. Close the **Train Clustering Model** visualization, and then close or resize the settings pane using the X or **<sub>&#8599;</sub><sup>&#8601;</sup>** icon.

The model is predicting clusters for the iris observations, but how reliable are its predictions? To assess that, you need to evaluate the model.
