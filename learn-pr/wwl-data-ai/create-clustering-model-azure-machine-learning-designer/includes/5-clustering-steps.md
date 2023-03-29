You can think of the steps to train and evaluate a clustering machine learning model as: 
1. **Prepare data**: Identify the features in a dataset. Pre-process, or clean and transform, the data as needed.   
2. **Train model**: Split the data into two groups, a training and a validation set. Train a machine learning model using the training data set. Test the machine learning model for performance using the validation data set. 
3. **Evaluate performance**: These metrics can help data scientists assess how well the model separates the clusters.
4. **Deploy a predictive service**: After you train a machine learning model, you need to convert the training pipeline into a real-time inference pipeline. Then you can deploy the model as an application on a server or device so that others can use it. 

Let's follow these four steps as they appear in Azure Designer. 

## Prepare data 

To train a clustering model, you need a dataset that includes multiple observations of the items you want to cluster, including numeric features that can be used to determine similarities between individual cases that will help separate them into clusters.

Azure Machine Learning designer has several pre-built components that can be used to prepare data for training. These components enable you to clean data, normalize features, join tables, and more. 
![Screenshot of designer components that can be used to prepare data.](../media/prepare-data-example.png)

## Train model 

To train a clustering model, you need to apply a clustering algorithm to the data, using only the features that you have selected for clustering. You'll train the model with a subset of the data, and use the rest to test the trained model.

The **K-Means Clustering** algorithm groups items into the number of clusters, or centroids, you specify - a value referred to as ***K***. 

The K-Means algorithm works by:
1. Initializing *K* coordinates as randomly selected points called *centroids* in  *n*-dimensional space (where *n* is the number of dimensions in the feature vectors).
2. Plotting the feature vectors as points in the same space, and assigning each point to its closest centroid.
3. Moving the centroids to the middle of the points allocated to it (based on the *mean* distance).
4. Reassigning the points to their closest centroid after the move.
5. Repeating steps 3 and 4 until the cluster allocations stabilize or the specified number of iterations has completed.

You will use *designer*'s **Assign Data to Clusters** component to group the data into clusters. Once you connect all the components, you will want to run an experiment, which will use the data asset on the canvas to train a model.  

![Screenshot of designer components that can be connected to train a classification model.](../media/train-model-example.png)

## Evaluate performance 

After training a model, it is important to evaluate its performance. There are many performance metrics and methodologies for evaluating how well a model makes predictions. You can review evaluation metrics on the completed job page by right-clicking on the **Evaluate model** component.  

![Screenshot of a right click on the evaluate model in completed jobs to see evaluation results.](../media/evaluate-model-example.png)

When the experiment run has finished, select **Job details**. Right click on the **Evaluate Model** module and select **Preview data**, then select **Evaluation results**. These metrics can help data scientists assess how well the model separates the clusters. They include a row of metrics for each cluster, and a summary row for a combined evaluation. The metrics in each row are:
* **Average Distance to Other Center**: This indicates how close, on average, each point in the cluster is to the centroids of all other clusters.
* **Average Distance to Cluster Center**: This indicates how close, on average, each point in the cluster is to the centroid of the cluster.
* **Number of Points**: The number of points assigned to the cluster.
* **Maximal Distance to Cluster Center**: The maximum of the distances between each point and the centroid of that point’s cluster. If this number is high, the cluster may be widely dispersed. This statistic in combination with the **Average Distance to Cluster Center** helps you determine the cluster’s *spread*.

## Deploy a predictive service  
You have the ability to deploy a service that can be used in real-time. In order to automate your model into a service that makes continuous predictions, you need to create and deploy an inference pipeline.  

#### Inference pipeline 
To deploy your pipeline, you must first convert the training pipeline into a real-time inference pipeline. This process removes training components and adds web service inputs and outputs to handle requests.

The inference pipeline performs the same data transformations as the first pipeline for *new* data. Then it uses the trained model to *infer*, or predict, clusters based on its features. This model will form the basis for a predictive service that you can publish for applications to use.

You can create an inference pipeline by selecting the menu above a completed job. 
![Screenshot of the inference pipeline options in the jobs pane.](../media/inference-pipeline-example.png)

#### Deployment 
After creating the inference pipeline, you can deploy it as an endpoint. In the endpoints page, you can view deployment details, test your pipeline service with sample data, and find credentials to connect your pipeline service to a client application. 

It will take a while for your endpoint to be deployed. The Deployment state on the **Details** tab will indicate *Healthy* when deployment is successful. 

![Screenshot of the endpoints page for a successfully deployed model.](../media/endpoints-example-1.png)

On the **Test** tab, you can test your deployed service with sample data in a JSON format. The test tab is a tool you can use to quickly check to see if your model is behaving as expected. Typically it is helpful to test the service before connecting it to an application.
 
![Screenshot of the test tab on the endpoints page.](../media/endpoints-example-3.png)

You can find credentials for your service on the **Consume** tab. These credentials are used to connect your trained machine learning model as a service to a client application.

![Screenshot of where to find the key and endpoint on the consume tab.](../media/endpoints-example-2.png)
