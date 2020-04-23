> [!Note]
> **Sarah: Action items**
> 
> - Need output cell content. Search on TBD.
>

This is the important part. After your model is deployed as a web service, it can be accessed from anywhere. This means that rather than refit a model every time you need a new prediction for a business or humanitarian use case, you can send the data to the pre-fitted model and get back a prediction.

First, deploy the model as a predictive web service. To do so, create a wrapper function that takes input data as an argument and calls `predict()` with your trained model and this input data, returning the results.

```python
from azureml import services

@services.publish(workspace_id, authorization_token)
@services.types(wind=float, rain=float, month=int, RH=float)
@services.returns(float)

# The name of your web service is set to this function's name
def forest_fire_predictor(wind, rain, month, RH):
    return regressor.predict([wind, rain, month, RH])

# Hold onto information about your web service so 
# you can call it within the notebook later
service_url = forest_fire_predictor.service.url 
api_key = forest_fire_predictor.service.api_key
help_url = forest_fire_predictor.service.help_url
service_id = forest_fire_predictor.service.service_id
```

Here's the output:

```Output
TBD
```

You can also go to the **Web Services** section of your Azure ML Studio workspace to see the predictive web service running there.
