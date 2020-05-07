Now that our model is performing "good enough", let's deploy it! There are different ways to deploy the model based on what you need. There's an option to deploy to an endpoint, or you can export the model to different formats to deploy to different platforms. We'll discuss how to deploy to the endpoint and consume the model by using an app.

## Deploy to an endpoint

You can deploy to an endpoint by getting the prediction URL or by consuming the API in a Python app.

### Get the prediction URL

To get the prediction URL:

1. In the top navigation in the Custom Vision portal, select **Performance**.
1. Select **Publish**.
1. Select **Prediction Url**. This is the URL you use to post images to get predictions.

### Consume the API in a Python app

When the model is trained and returns a satisfactory accuracy, it's ready to be used in your app.

1. Go to the resource group that contains the Custom Vision resource. You should see a resource named **YourCustomVisionResourceName_Prediction**.
1. Select **Quick Start**.
1. Select **API Reference** from the list of helpful links. 

A page that has documents about how to call the API to get predictions from the model opens. At the bottom of the page is a list of code samples in multiple languages to get you started. 

Here's the example code for calling the prediction API in Python:

```python
from azure.cognitiveservices.vision.customvision.prediction import CustomVisionPredictionClient

# Now, there's a trained endpoint that can be used to make a prediction
prediction_key = "<YourKey>"
endpoint = "<YourEndpoint>"
base_image_url = "<BasePathToImageFolder>"
# An example of a default iteration name is "Iteration1"
publish_iteration_name = "<PublishedIterationName>"
# You can find the project ID in the settings of the Custom Vision project in the portal.
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

When you post to the published endpoint, you get a result that looks like the following text. The text shows the probability of each tag the Custom Vision model was trained on, sorted by the highest score. The model knows only the type of birds it was trained to recognize. If you posted an image of a new bird that the model wasn't trained on, the model would predict one of the birds it was trained on to identify the species of the new bird.

```
	American Crow: 99.18%
	Common Grackle: 25.34%
	Red-tailed Hawk (Dark morph): 4.09%
	Mourning Dove: 1.74%
	American Robin (Adult): 0.92%
	House Sparrow (Female): 0.40%
	American Robin (Juvenile): 0.31%
	Northern Cardinal (Adult Male): 0.24%
	Tufted Titmouse: 0.04%
	Blue Jay: 0.04%
	House Sparrow (Male): 0.04%
	Northern Cardinal (Female): 0.04%
	Red-tailed Hawk (Light morph immature): 0.02%
	American Goldfinch (Male): 0.02%
	House Wren: 0.01%
	American Goldfinch (Female): 0.01%
```

Now, you know how to use the model you created. You can start better documenting the birds habits to help conserve their habitat and increase endangered bird populations. All with the help of Custom Vision!
