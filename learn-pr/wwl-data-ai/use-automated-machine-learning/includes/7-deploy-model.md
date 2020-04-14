After you've used automated machine learning to train some models, you can deploy the best performing model as a service for client applications to use.

## Deploy a predictive service
In Azure Machine Learning, you can deploy a service as an Azure Container Instances (ACI) or to an Azure Kubernetes Service (AKS) cluster. For production scenarios, an AKS deployment is recommended, for which you must create an *inference cluster* compute target. In this exercise, you'll use an ACI service, which is a suitable deployment target for testing, and does not require you to create an inference cluster.

1. In [Azure Machine Learning studio](https://ml.azure.com), on the **Automated ML** page, select the run for your automated machine learning experiment and view the **Details** tab.
2. Select **Deploy best model**. Then deploy the model with the following settings:
    - **Name**: predict-rentals
    - **Description**: Predict cycle rentals
    - **Compute type**: ACI
    - **Enable authentication**: Selected
3. Wait for the deployment to start - this may take a few seconds.
4. In Azure Machine Learning studio, view the **Endpoints** page and find the **predict-rentals** real-time endpoint.
5. Select the **predict-rentals** endpoint and note the **Deployment state**. If it is *Transitioning*, wait a few minutes and refresh the page until it is *Healthy*.
6. When the deployment state is healthy, select the **Consume** tab and note the following information there. You need this to connect to your deployed service from a client application.
    - The REST endpoint for your service
    - the Primary Key for your service
7. Note that you can use the &#10697; link next to these values to copy them to the clipboard.

## Test the deployed service

Now that you've deployed a service, you can test it using some simple code.

1. With the **Consume** page for the **predict-rentals** service page open in your browser, open a new browser tab and open a second instance of [Azure Machine Learning studio](https://ml.azure.com). Then in the new tab, view the **Notebooks** page.
On the **Notebooks** page, create a new file with the following settings:
    - **File name**: bike_test.ipynb
    - **File type**: Python Notebooks
    - **Overwrite if already exists**: Selected
    - **Select target directory**: *Select the folder with your user name under **User files***
2. When the new notebook has been created, ensure that the compute instance you created previously is selected in the **Compute** box, and that it has a status of **Running**.
3. If the notebook is not editable, in the **Edit** menu,  select **Edit inline**. Then in the **[ ]** cell that is created in the notebook, paste the following code:

    ```Python
    endpoint = 'YOUR_ENDPOINT' #Replace with your endpoint
    key = 'YOUR_KEY' #Replace with your key

    import json
    import requests

    #An array of features based on five-day weather forecast
    x = [[1,1,2022,1,0,6,0,2,0.344167,0.363625,0.805833,0.160446],
        [2,1,2022,1,0,0,0,2,0.363478,0.353739,0.696087,0.248539],
        [3,1,2022,1,0,1,1,1,0.196364,0.189405,0.437273,0.248309],
        [4,1,2022,1,0,2,1,1,0.2,0.212122,0.590435,0.160296],
        [5,1,2022,1,0,3,1,1,0.226957,0.22927,0.436957,0.1869]]

    #Convert the array to JSON format
    input_json = json.dumps({"data": x})

    #Set the content type and authentication for the request
    headers = {"Content-Type":"application/json",
            "Authorization":"Bearer " + key}

    #Send the request
    response = requests.post(endpoint, input_json, headers=headers)

    #If we got a valid response, display the predictions
    if response.status_code == 200:
        y = json.loads(response.json())
        print("Predictions:")
        for i in range(len(x)):
            print (" Day: {}. Predicted rentals: {}".format(i+1, max(0, round(y["result"][i]))))
    else:
        print(response)
    ```

    > [!NOTE]
    > Don't worry too much about the details of the code. It just defines features for a five day period using hypothetical weather forecast data, and uses the **predict-rentals** service you created to predict cycle rentals for those five days.

4. Switch to the browser tab containing the **Consume** page for the **predict-rentals** service, and copy the REST endpoint for your service. The switch back to the tab containing the notebook and paste the key into the code, replacing YOUR_ENDPOINT.
5. Switch to the browser tab containing the **Consume** page for the **predict-rentals** service, and copy the Primary Key for your service. The switch back to the tab containing the notebook and paste the key into the code, replacing YOUR_KEY.
6. Save the notebook, Then select **&#9655; Run All** to run the code (depending on the width of your screen, you may need to open the **...** menu to see this).
7. Verify that predicted rentals for the five day period are returned.
