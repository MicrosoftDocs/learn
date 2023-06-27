

After deploying a real-time service, you can consume it from client applications to predict labels for new data cases.

## Use the Azure Machine Learning studio

You can list all endpoints in the Azure Machine Learning studio, by navigating to the **Endpoints** page. In the **Real-time endpoints** tab, all endpoints are shown. 

You can select an endpoint to review its details and deployment logs. 

Additionally, you can use the studio to test the endpoint.

:::image type="content" source="../media/test-studio.png" alt-text="Diagram showing different hyperparameter values resulting in different models by performing hyperparameter tuning.":::

## Use the Azure Machine Learning Python SDK

For testing, you can also use the Azure Machine Learning Python SDK to invoke an endpoint.

Typically, you send data to deployed model in JSON format with the following structure:

```JSON
{
  "data":[
      [0.1,2.3,4.1,2.0], // 1st case
      [0.2,1.8,3.9,2.1],  // 2nd case,
      ...
  ]
}
```

The response from the deployed model is a JSON collection with a prediction for each case that was submitted in the data. The following code sample invokes an endpoint and displays the response:

```python
# test the blue deployment with some sample data
response = ml_client.online_endpoints.invoke(
    endpoint_name=online_endpoint_name,
    deployment_name="blue",
    request_file="sample-data.json",
)

if response[1]=='1':
    print("Yes")
else:
    print ("No")
```
