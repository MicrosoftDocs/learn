Our model is performing at a satisfactory level, so let's deploy it! 

You have different options for deployment. The option you choose depends on how you want to use your machine learning model. You can deploy to an endpoint or you can export the model to deploy to different platforms.

We'll discuss how to deploy to the endpoint and consume the model by using an app.

## Deploy to an endpoint

You can deploy to an endpoint by getting the prediction URL or by consuming the API in a Python app.

### Get the prediction URL

1. In the [Custom Vision portal](https://www.customvision.ai/?azure-portal=true) top menu bar, select **Performance**.

1. Select **Publish**.

1. In **Publish Model**, select **Prediction resource**, and then select the name of the prediction for your Custom Vision project. Select **Publish**.

    :::image type="content" source="../media/custom-vision-publish-prediction.png" alt-text="Screenshot that shows how to publish a trained Custom Vision model.":::
 
    After the model is published, the actions for the model are changed in the Custom Vision portal. 

1. Select  the **Prediction URL** tab.

1. In **How to use the prediction API**, in the text box under **If you have an image URL**, copy and save the value, and then select **Got it**.

    :::image type="content" source="../media/custom-vision-get-prediction-url.png" alt-text="Screenshot that highlights the prediction U R L for a published Custom Vision model.":::

### Consume the API in a Python app

When the model is trained and performing with satisfactory accuracy, the model is ready for you to use in your app.

1. In the [Azure portal](https://portal.azure.com/?azure-portal=true), go to the resource group that contains your Custom Vision resource. A resource named **\<YourCustomVisionResourceName\>-Prediction** is shown with the original resource group.

    :::image type="content" source="../media/azure-portal-open-resource-group-prediction.png" alt-text="Screenshot that shows how to open the prediction resource in the Azure portal.":::

1. Select the prediction name to open the **Overview** page. This page has links to resources that can help you learn more about how to call the API to get predictions from the model. 

1. Under **Get Started**, in section **3**, select the link for the **Python Quickstart**. The [Azure AI services image classification quickstart](/azure/ai-services/Custom-Vision-Service/quickstarts/image-classification?azure-portal=true&pivots=programming-language-python&tabs=visual-studio) for Python opens in your web browser. 

   :::image type="content" source="../media/azure-portal-prediction-quickstart.png" alt-text="Screenshot that shows quickstart resources that describe how to call the A P I to get predictions from the model.":::

   Here's an example of the sample code for calling the prediction API in Python. For the complete code, see the [quickstart](/azure/ai-services/Custom-Vision-Service/quickstarts/image-classification?azure-portal=true&pivots=programming-language-python&tabs=visual-studio).

   ```python
   from azure.cognitiveservices.vision.customvision.prediction import CustomVisionPredictionClient
    
   # Create variables for your resource; replace variables with valid values.
   prediction_key = "<YourKey>"
   endpoint = "<YourEndpoint>"
   base_image_url = "<BasePathToImageFolder>"
    
   # An example of a default iteration name is "Iteration1".
   publish_iteration_name = "<PublishedIterationName>"
    
   # You can find the project ID in the settings of the Custom Vision project in the portal.
   project.id = "<CustomVisionProjectId>"
    
   # Now, you have a trained endpoint that you can use to make a prediction.
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

Now, you have experience using the machine learning model you created. With new data to analyze, you can better document bird habits to help conserve bird habitat and increase endangered bird populations. All with the help of Azure AI Custom Vision!
