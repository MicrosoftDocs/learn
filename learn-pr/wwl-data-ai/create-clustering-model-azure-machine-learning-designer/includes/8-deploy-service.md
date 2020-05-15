After you've created and tested an inference pipeline for real-time inferencing, you can publish it as a service for client applications to use.

To publish a real-time inference pipeline as a service, you must deploy it to an Azure Kubernetes Service (AKS) cluster. In this exercise, you'll use the AKS inference cluster you created previously in this module.

## Deploy a service

1. View the **Predict Iris Cluster** inference pipeline you created in the previous unit.
2. At the top right, select **Deploy**, and set up a new real-time endpoint named **predict-iris-cluster** on the **aks-cluster** compute target you created.
3. Wait for the web service to be deployed - this can take several minutes. The deployment status is shown at the top left of the designer interface.

## Test the service

Now you can test your deployed service from a client application - in this case, you'll use the code in the cell below to simulate a client application.

1. On the **Endpoints** page, open the **predict-iris-cluster** real-time endpoint.
2. When the **predict-iris-cluster** endpoint opens, view the **Consume** tab and note the following information there. You need this to connect to your deployed service from a client application.
    - The REST endpoint for your service
    - the Primary Key for your service
3. Note that you can use the &#10697; link next to these values to copy them to the clipboard.
4. With the **Consume** page for the **predict-iris-cluster** service page open in your browser, open a new browser tab and open a second instance of [Azure Machine Learning studio](https://ml.azure.com?azure-portal=true). Then in the new tab, view the **Notebooks** page.
5. On the **Notebooks** page, create a new file with the following settings:
    - **File name**: iris_test.ipynb
    - **File type**: Python Notebooks
    - **Overwrite if already exists**: Selected
    - **Select target directory**: *Select the folder with your user name under **User files***
6. When the new notebook has been created, ensure that the compute instance you created previously is selected in the **Compute** box, and that it has a status of **Running**.
7. In the **Edit** menu, select **Edit inline**. Then in the cell that is created in the notebook, paste the following code:

    ```Python
    endpoint = 'YOUR_ENDPOINT' #Replace with your endpoint
    key = 'YOUR_KEY' #Replace with your key

    import urllib.request
    import json
    import os

    data = {
        "Inputs": {
            "WebServiceInput0":
            [
                {
                        'Column1': 4.9,
                        'Column2': 3.0,
                        'Column3': 1.4,
                        'Column4': 0.2,
                },
            ],
        },
        "GlobalParameters":  {
        }
    }

    body = str.encode(json.dumps(data))


    headers = {'Content-Type':'application/json', 'Authorization':('Bearer '+ key)}

    req = urllib.request.Request(endpoint, body, headers)

    try:
        response = urllib.request.urlopen(req)
        result = response.read()
        json_result = json.loads(result)
        output = json_result["Results"]["WebServiceOutput0"][0]
        print('Cluster: {}'.format(output["Assignments"]))

    except urllib.error.HTTPError as error:
        print("The request failed with status code: " + str(error.code))

        # Print the headers to help debug
        print(error.info())
        print(json.loads(error.read().decode("utf8", 'ignore')))
    ```

    > [!NOTE]
    > Don't worry too much about the details of the code. It just defines features for an iris, and uses the **predict-iris-cluster** service you created to predict a cluster assignment.

8. Switch to the browser tab containing the **Consume** page for the **predict-iris-cluster** service, and copy the REST endpoint for your service. The switch back to the tab containing the notebook and paste the key into the code, replacing YOUR_ENDPOINT.
9. Switch to the browser tab containing the **Consume** page for the **predict-iris-cluster** service, and copy the Primary Key for your service. The switch back to the tab containing the notebook and paste the key into the code, replacing YOUR_KEY.
10. Save the notebook, Then use the **&#9655;** button next to the cell to run the code.
11. Verify that predicted cluster is returned.
