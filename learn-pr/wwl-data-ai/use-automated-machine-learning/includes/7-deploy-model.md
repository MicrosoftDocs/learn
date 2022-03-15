After you've used automated machine learning to train some models, you can deploy the best performing model as a service for client applications to use.

## Deploy a predictive service
In Azure Machine Learning, you can deploy a service as an Azure Container Instances (ACI) or to an Azure Kubernetes Service (AKS) cluster. For production scenarios, an AKS deployment is recommended, for which you must create an *inference cluster* compute target. In this exercise, you'll use an ACI service, which is a suitable deployment target for testing, and does not require you to create an inference cluster.

1. In [Azure Machine Learning studio](https://ml.azure.com?azure-portal=true), on the **Automated ML** page, select the run for your automated machine learning experiment.

2. On the **Details** tab, select the algorithm name for the best model. 
   
    > [!div class="centered"]
    > ![Select run.](../media/deploy-detail-tab.png)

3. on the **Model** tab, select the **Deploy** button and use the **Deploy to web service** option to deploy the model with the following settings:
    - **Name**: predict-rentals
    - **Description**: Predict cycle rentals
    - **Compute type**: Azure Container Instance
    - **Enable authentication**: Selected

4. Wait for the deployment to start - this may take a few seconds. Then, in the **Model summary** section, observe the **Deploy status** for the **predict-rentals** service, which should be **Running**. Wait for this status to change to **Successful**. You may need to select **&#8635; Refresh** periodically.
5. In Azure Machine Learning studio, view the **Endpoints** page and select the **predict-rentals** real-time endpoint. Then select the **Consume** tab and note the following information there. If you do not see the **Consume** tab, the deployment is not completely finished, you will need to wait and refresh the page. You need the information from the **Consume** tab to connect to your deployed service from a client application.
  
    - The REST endpoint for your service
    - the Primary Key for your service

    > [!div class="centered"]
    > ![Review the REST endpoint and Primary Key.](../media/endpoints-2.png)

6. Note that you can use the &#10697; link next to these values to copy them to the clipboard.

## Test the deployed service

Now you can test your deployed service. 

1. On the **Endpoints** page, open the **predict-auto-price** real-time endpoint.
2. When the **predict-auto-price** endpoint opens, view the **Test** tab. 
3. Under *Select editor type*, select **JSON editor**. Then delete the template JSON and paste in the following input data: 

    ```JSON
    {
      "Inputs": { 
        "data": [
          {
            "day": 1,
            "mnth": 1,   
            "year": 2022,
            "season": 2,
            "holiday": 0,
            "weekday": 1,
            "workingday": 1,
            "weathersit": 2, 
            "temp": 0.3, 
            "atemp": 0.3,
            "hum": 0.3,
            "windspeed": 0.3 
          }
        ]    
      },   
      "GlobalParameters": 1.0
    }
    ```
4. Click on the **Test** button. On the right hand side of the screen, the *Test results* have two options. Select **raw**.   

    > [!div class="centered"]
    > ![Example of the results of testing the model.](../media/workaround-test.png)

5. You should see results with a returned prediction of 416 rentals given the input features. The test pane took the input data and used the model you trained to return the predicted number of rentals. 

Let's review what you have done. You used a dataset of historical bicycle rental data to train a model. The model predicts the number of bicycle rentals expected on a given day, based on seasonal and meteorological _features_. In this case, the _labels_ are number of bicycle rentals.  