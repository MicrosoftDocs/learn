After you've created and tested an inference pipeline for real-time inferencing, you can publish it as a service for client applications to use.

> **Note**: In this exercise, you'll deploy the web service to to an Azure Container Instance (ACI). This type of compute is created dynamically, and is useful for development and testing. For production, you should create an *inference cluster*, which provide an Azure Kubernetes Service (AKS) cluster that provides better scalability and security.

## Deploy a service

1. View the **Predict Penguin Clusters** inference pipeline you created in the previous unit.
2. Select **Job detail** on the left hand pane. This will open up another window. 
    ![Screenshot of job details next to the completed job. ](../media/completed-job-inference.png)
3. In the new window, select **Deploy**.
    ![Screenshot of the deploy button for your Predict Auto Price inference pipeline.](../media/deploy-screenshot.png)
4. At the top right, select **Deploy**, and deploy a new real-time endpoint, using the following settings:
    -  **Name**: predict-penguin-clusters
    -  **Description**: Cluster penguins.
    - **Compute type**: Azure Container Instance
5. Wait for the web service to be deployed - this can take several minutes. The deployment status is shown at the top left of the designer interface.


## Test the service

1. On the **Endpoints** page, open the **predict-penguin-clusters** real-time endpoint.
    ![Screenshot of the location of the Endpoints option on the left-hand pane.](../media/endpoints-screenshot.png)
2. When the **predict-penguin-clusters** endpoint opens, select the **Test** tab. We will use it to test our model with new data. Delete the current data under **Input data to test real-time endpoint**. Copy and paste the below data into the data section: 

    ```JSON
    {
        "Inputs": {
            "WebServiceInput0": [
                {
                    "CulmenLength": 49.1,
                    "CulmenDepth": 4.8,
                    "FlipperLength": 1220,
                    "BodyMass": 5150
                }
            ]
        },
        "GlobalParameters":  {}
    }
    ```

    > [!NOTE]
    > The JSON above defines features for a penguin, and uses the **predict-penguin-clusters** service you created to predict a cluster assignment.

3. Select **Test**. On the right hand of the screen, you should see the output **'assignments'**. Notice how the assigned cluster is the one with the shortest distance to cluster center. 

    ![Screenshot of the Test pane.](../media/test-interface.png)

You have just tested a service that is ready to be connected to a client application using the credentials in the **Consume** tab. We will end the lab here. You are welcome to continue to experiment with the service you just deployed.