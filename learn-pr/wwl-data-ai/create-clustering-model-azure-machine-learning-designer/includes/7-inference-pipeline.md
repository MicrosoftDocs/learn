After creating and running a pipeline to train the clustering model, you can create an *inference pipeline* that uses the model to assign new data observations to clusters. This will form the basis for a predictive service that you can publish for applications to use.

## Create an inference pipeline

1. In Azure Machine Learning Studio, click the **Designer** page to view all of the pipelines you have created. Then open the **Iris Training** pipeline you created previously.
2. In the **Create inference pipeline** drop-down list, click **Real-time inference pipeline**. After a few seconds, a new version of your pipeline named **Iris Training-real time inference** will be opened.
3. Rename the new pipeline to **Predict Iris Cluster**, and then review the new pipeline. It contains a web service input for new data to be submitted, and a web service output to return results. The clustering model is encapsulated in this pipeline based on the statistics from your training data, and will be used to score the new data.

    > [!NOTE]
    > If your new pipeline doesn't contains web service input and web service output modules, go back to the **Designer** page and then re-open the new inference pipeline.

    You are going to make the following changes to the inference pipeline:

    > [!div class="centered"]
    > ![An inference pipeline with changes indicated](../media/inference-changes.png)

    - Replace the **iris** dataset with an **Enter Data Manually** module that does not include the species column (**Column5**).
    - Remove the **Select Columns in Dataset** module, which is now redundant.
    - Connect the **web Service Input** and **Enter Data Manually** modules (which represent inputs for data to be clustered) to the **Assign Data to Clusters** module.
    - Remove the **Evaluate Model** module.

    Follow the remaining steps below, using the image and information above for reference as you modify the pipeline.

4. The inference pipeline assumes that new data will match the schema of the original training data, so the **iris** dataset from the training pipeline is included. However, this input data includes a column for the iris species, which the model does not use. Delete both the **iris** dataset and the **Select Columns in Dataset** modules, and replace them with an **Enter Data Manually** module from the **Data Input and Output** section of the **Modules** tab. Then modify the settings of the **Enter Data Manually** module to use the following CSV input, which includes feature values for three new iris observations:

    ```CSV
    Column1,Column2,Column3,Column4
    4.9,3.0,1.4,0.2
    6.4,3.2,4.5,1.5
    5.9,3.0,5.1,1.8
    ```

5. Connect the outputs from both the **Web Service Input** and **Enter Data Manually** modules to the Dataset (right) input of the **Assign Data to Clusters** module.
6. Delete the **Evaluate Model** module.
7. Verify that your pipeline looks similar to the following:

> [!div class="centered"]
> ![Inference pipeline for clustering](../media/inference-clusters.png)

8. Submit the pipeline as a new experiment named **predict-iris-cluster** on your compute cluster. This may take a while!

    > [!NOTE]
    > If an **invalid dataset(s)** error is displayed, refresh the browser page and resubmit the experiment.

9. When the pipeline has finished, visualize the **Results dataset** output of the **Assign Data to Clusters** module to see the predicted cluster assignments and metrics for the three iris observations in the input data.

Your inference pipeline assigns iris observations to clusters based on their features. Now you're ready to publish the pipeline so that client applications can use it.
