As a lead developer at Contoso Beverage Distribution, you're responsible for building and maintaining a line-of-business app that lets your frontline distributors scan and upload images of store shelves where they are restocking. 

You want to validate that any images posted by users respect the content rules set by your company. The company doesn't want inappropriate content posted to company sites. Given the advancements in Artificial Intelligence, you decide to use the Computer Vision API in your app. 

To get started, you create a Computer Vision account in your Azure subscription and start testing the **analyze** feature.

## Calling the Computer Vision API to analyze images

The `analyze` operation extracts a rich set of visual features based on the image content. The request URL has the following format:

`https://<region>.api.cognitive.microsoft.com/vision/v2.0/analyze?visualFeatures=<...>&details=<...>&language=<...>`

The parameters that are sent to the service are `visualFeatures`, `details`, and `languages`. Set the `details` parameter to `Landmarks` or `Celebrities` to help you identify landmarks or celebrities. `visualFeatures` identify what kind of information you want the service to return you. The `Categories` option will categorize the content of the images like trees, buildings, and more. `Faces` will identify people's faces and give you their gender and age.

All operations on the Computer Vision API have the following restrictions when it comes to the images you ask it to process:

- Supported image formats: JPEG, PNG, GIF, BMP. 
- Image file size must be less than  4 MB.
- Image dimensions must be at least 50 x 50.

[!INCLUDE [get-key-note](./get-key.md)]

## Identify landmarks in an image

Let's start with a call to find landmarks in an image. We'll use the following image for this example, but you're free to try the same command with URLs to other images. 

![Picture of a mountain range with blue skies above the snow-capped mountains.](../media/3-mountains.jpg)

Execute the following command in Azure Cloud Shell. Replace `<region>` in the command with the region of your cognitive services account.

```azurecli
curl "https://<region>.api.cognitive.microsoft.com/vision/v2.0/analyze?visualFeatures=Categories,Description&details=Landmarks" \
-H "Ocp-Apim-Subscription-Key: $key" \
-H "Content-Type: application/json" \
-d "{'url' : 'https://raw.githubusercontent.com/MicrosoftDocs/mslearn-process-images-with-the-computer-vision-service/master/images/mountains.jpg'}" \
| jq '.'
```

- This call looks for landmarks in the image specified by the image URL. The image we are analyzing is stored in a GitHub repo for this exercise. 
- The call also asks the service to return category information and a description of the image. The description is returned as a complete English sentence. 
- As you know, every call to the API needs an access key. This is set in the `Ocp-Apim-Subscription-Key` header of the request. 

> [!TIP]
> The result of the request is the raw JSON describing the picture in the `url`. We added ` | jq '.'` at the end of the command to prettify the JSON output.

The JSON response from this call returns the following:

- A `categories` array listing all image categories that were detected, along with a score between 0 and 1 of how confident the service is that the image belongs in the specified category.
- A `description` entry containing an array of tags or words that are related to the image.
- A `captions` entry with a text field that describes in English what is in the image. Observe that the text also has a certainty score. This score can help you decide what to do next with this analysis.


## Check for inappropriate content in an image

In this example, we'll analyze an image for adult content. The confidence score rates the likelihood that the image contains either adult or racy content. 

We'll use the following image for this example, but you're free to try the same command with URLs to other images. 

![Picture of a smiling family.](../media/3-people.png)

1. Execute the following command in Azure Cloud Shell, replacing `<region>` in the URL.

```azurecli
curl "https://<region>.api.cognitive.microsoft.com/vision/v2.0/analyze?visualFeatures=Adult,Description" \
-H "Ocp-Apim-Subscription-Key: $key" \
-H "Content-Type: application/json" \
-d "{'url' : 'https://raw.githubusercontent.com/MicrosoftDocs/mslearn-process-images-with-the-computer-vision-service/master/images/people.png'}" \
| jq '.'
```

In this example, we set the `visualFeatures` to `Adult,Description`. 

The response gives us two confidence scores, one for racy content and one for adult content. Using these scores plus the image description and other visual features, you can start to flag images posted to your server.

The examples we tried in this exercise give you an idea of the type of analysis that you can do with the `analyze` operation. Try out the analysis with different images and try different combinations of visualFeatures, details, and languages parameters.

For more information about the `analyze` operation, see the [Analyze Image](https://westus.dev.cognitive.microsoft.com/docs/services/5adf991815e1060e6355ad44/operations/56f91f2e778daf14a499e1fa) reference documentation.