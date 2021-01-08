Now that our model is performing satisfactorily, let's deploy it! There are different ways to deploy the model depending on what you need. You can deploy to an endpoint, or you can export the model in different formats to deploy to different platforms. We'll discuss how to deploy to the endpoint and consume the model by using an app.

## Deploy to an endpoint

You can deploy to an endpoint by getting the prediction URL or by consuming the API in a Python app.

### Get the prediction URL

1. In the top menu bar in the Custom Vision portal, select **Performance**.

1. Select **Publish**.

1. In **Publish Model**, expand the **Prediction resource**. Under your subscription, select the name of the prediction for your Custom Vision project. Select **Publish**.

    :::image type="content" source="../media/deploy-model-publish-prediction-custom-vision.png" alt-text="Screenshot that shows how to publish a trained Custom Vision model."::: 
    After the model is published, the actions for the model are changed in the Custom Vision portal. 

1. Select  **Prediction URL**.

1. **How to use the prediction API** shows two options: one for if you have an image URL and another for if you have an image file.

1. To get the prediction URL, copy and save the value in the **If you have an image URL** box, and then select **Got it**.

    :::image type="content" source="../media/deploy-model-get-prediction-url.png" alt-text="Screenshot that shows how to get the prediction U R L for a published Custom Vision model.":::

### Consume the API in a Python app

When the model is trained and performing with a satisfactory accuracy, the model is ready for you to use in your app.

1. In the [Azure portal](https://portal.azure.com/?azure-portal=true), go to the resource group that contains your Custom Vision resource. On this page, you should see a resource named **<YourCustomVisionResourceName>-Prediction**.

    :::image type="content" source="../media/deploy-model-open-resource-group-prediction.png" alt-text="Screenshot that shows how to open the prediction resource.":::

1. Select the prediction name to open the **Quick start** page. This page has links for resources to learn more about how to call the API to get predictions from the model. 

1. Scroll to the section labeled **3** to _Make a web API call_. This section has links to code samples in multiple languages to help get you started.

   :::image type="content" source="../media/deploy-model-prediction-quickstart.png" alt-text="Screenshot that shows quick start resources to learn how to call the API to get predictions from the model.":::

1. In section **3**, select the link for the **Python Quickstart**. The corresponding [Azure Cognitive Services quickstart](https://docs.microsoft.com/azure/cognitive-services/Custom-Vision-Service/quickstarts/image-classification?tabs=visual-studio&pivots=programming-language-python&azure-portal=true) opens. Under the quickstart title, select the programming language you're using.

    Here's an example of the sample code for calling the prediction API in Python. For the complete code, see [Azure Cognitive Services quickstart](https://docs.microsoft.com/azure/cognitive-services/Custom-Vision-Service/quickstarts/image-classification?tabs=visual-studio&pivots=programming-language-python&azure-portal=true).

    ```python
    from azure.cognitiveservices.vision.customvision.prediction import CustomVisionPredictionClient
    
    # Create variables for your resource; replace with valid values.
    prediction_key = "<YourKey>"
    endpoint = "<YourEndpoint>"
    base_image_url = "<BasePathToImageFolder>"
    
    # An example of a default iteration name is "Iteration1".
    publish_iteration_name = "<PublishedIterationName>"
    
    # You can find the project ID in the settings of the Custom Vision project in the portal.
    project.id = "<CustomVisionProjectId>"
    
    # Now there's a trained endpoint you can use to make a prediction.
    prediction_credentials = ApiKeyCredentials(in_headers={"Prediction-key": prediction_key})
    
    predictor = CustomVisionPredictionClient(endpoint, prediction_credentials)
    
    with open(base_image_url + "images/Test/test_image.jpg", "rb") as image_contents:
        results = predictor.classify_image(
            project.id, publish_iteration_name, image_contents.read())
    
        # Display the results.
        for prediction in results.predictions:
            print("\t" + prediction.tag_name +
                  ": {0:.2f}%".format(prediction.probability * 100))
    ```

When you post to the published endpoint, you get a result that looks like the following example. The probability of each tag the Custom Vision model was trained on is shown, sorted by the highest score. The model recognizes only the type of birds it was trained to recognize. If you post an image of a bird that the model wasn't trained to recognize, the model predicts one of the bird species it was trained on as the species of the new bird.

```output
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

Now, you know how to use the model you created. You can better document bird habits to help conserve bird habitat and increase endangered bird populations. All with the help of Custom Vision from Azure!
