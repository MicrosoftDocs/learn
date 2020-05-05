Now our model is performing "good enough" - let's deploy it! There are different ways to deploy the model based on what you need. There is an option to deploy to an endpoint or you can export the model to different formats to deploy to different platforms. We will go over how to deploy to the endpoint and consume with an app.

## Deploy to an endpoint

### Get the prediction URL

- Select `Performance` from the top navigation in the Custom Vision portal
- Click `Publish`
- Select `Prediction Url`
- This is the Url you will use to post images to get predictions.

### Consume the API in a Python app

Once the model is trained and at a satisfactory accuracy it's ready to be used in your App

- Go to the Resource Group that contains the Custom Vision Resource
- There should be a resource named "YourCustomVisionResourceName_Prediction - Quick start"
- The Select "Api Reference" from the list of helpful links
- This will open a page with docs on how to call the api to get predictions from the model
- If you scroll all the way to the bottom, there are code samples in multiple languages to get you started
- Here is the example code for calling the prediction API in python:

```python
from azure.cognitiveservices.vision.customvision.prediction import CustomVisionPredictionClient

# Now there is a trained endpoint that can be used to make a prediction
prediction_key = "<YourKey>"
endpoint = "<YourEndpoint>"
base_image_url = "<BasePathToImageFolder>"
# Example of default iteration name would be "Iteration1"
publish_iteration_name = "<PublishedIterationName>"
# You can find the project id in the settings of the custom vision project in the portal.
project_id = "<CustomVisionProjectId>"

predictor = CustomVisionPredictionClient(prediction_key, endpoint=endpoint)

with open(base_image_url + "images/Test/test_image.jpg", "rb") as image_contents:
    results = predictor.classify_image(
        project_id, publish_iteration_name, image_contents.read())

    # Display the results.
    for prediction in results.predictions:
        print("\t" + prediction.tag_name +
              ": {0:.2f}%".format(prediction.probability * 100))
```

Now you know how to use the model you created and you can start better documenting the birds habits to help conserve their habitat and increase endangered bird populations all with the help of computer vision!
