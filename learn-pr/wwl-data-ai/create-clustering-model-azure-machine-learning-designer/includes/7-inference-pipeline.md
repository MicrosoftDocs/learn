After creating and running a pipeline to train the clustering model, you can create an *inference pipeline* that uses the model to assign new data observations to clusters. This will form the basis for a predictive service that you can publish for applications to use.

## Create an inference pipeline

1. In Azure Machine Learning Studio, click the **Designer** page to view all of the pipelines you have created. Then open the **Iris Training** pipeline you created previously.
2. In the **Create inference pipeline** drop-down list, click **Real-time inference pipeline**. After a few seconds, a new version of your pipeline named **Iris Training-real time inference** will be opened.
3. Rename the new pipeline to **Predict Iris Cluster**, and then review the new pipeline. Note that the trained model been encapsulated as a transformation in this pipeline, which you can use to assign new data to clusters.
4. The inference pipeline includes a **Score Model** module, which is used to infer predicted values from supervised models, such as *regression* or *classification* models. However, the iris model is an unsupervised clustering model, you need to use a different kind of module. Select the **Score Model** module and delete it, and then replace it with an **Assign Data to Clusters** module from the **Model Scoring and Evaluation** section of the pane on the left, like this:

    <p style='text-align:center'><img src='media/assign-clusters.jpg' alt="Replace Score Model with Assign Data to Clusters"/></p>

5. Select the new **Assign Data to Clusters** module, and in its settings pane, clear the **Check for append or uncheck for result only** checkbox so that the module outputs only the predicted cluster information, and not the original feature columns.
4. The inference pipeline assumes that new data will match the schema of the original training data, so the **iris** dataset from the training pipeline is included. However, this input data includes a column for the iris species, which the model does not use. Delete the dataset and replace it with an **Enter Data Manually** module from the **Data Input and Output** section, connected to the same **Dataset** input of the **Assign Data to Clusters** module as the **Web Service Input**. Then modify the settings of the **Enter Data Manually** module to use the following CSV input, which includes feature values for three new iris observations:

    ```CSV
    Column1,Column2,Column3,Column4
    4.9,3.0,1.4,0.2
    6.4,3.2,4.5,1.5
    5.9,3.0,5.1,1.8
    ```
7. Verify that your pipeline looks similar to the following:

    <p style='text-align:center'><img src='media/inference-clusters.jpg' alt="Inference pipeline for clustering"/></p>

8. Submit the pipeline as a new experiment named **predict-iris-cluster** on the **aml-compute** compute target you used for training. This may take a while!
9. When the pipeline has finished, visualize the **Results dataset** output of the **Assign Data to Clusters** module to see the predicted cluster assignments and metrics for the three iris observations in the input data.

Your inference pipeline assigns iris observations to clusters based on their features. Now you're ready to publish the pipeline so that client applications can use it.
