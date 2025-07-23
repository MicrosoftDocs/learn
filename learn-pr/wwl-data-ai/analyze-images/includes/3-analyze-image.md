After connecting to your Azure AI Vision resource endpoint, your client application can use the service to perform image analysis tasks.

Note the following requirements for image analysis:

- The image must be presented in JPEG, PNG, GIF, or BMP format.
- The file size of the image must be less than 4 megabytes (MB).
- The dimensions of the image must be greater than 50 x 50 pixels.

## Submitting an image for analysis

To analyze an image, you can use the **[Analyze Image](/rest/api/computervision/image-analysis/analyze-image?azure-portal=true)** REST method or the equivalent method in the SDK for your preferred programming language, specifying the visual features you want to include in the analysis.

::: zone pivot="python"

```python
from azure.ai.vision.imageanalysis import ImageAnalysisClient
from azure.ai.vision.imageanalysis.models import VisualFeatures
from azure.core.credentials import AzureKeyCredential

client = ImageAnalysisClient(
    endpoint="<YOUR_RESOURCE_ENDPOINT>",
    credential=AzureKeyCredential("<YOUR_AUTHORIZATION_KEY>")
)

result = client.analyze(
    image_data=<IMAGE_DATA_BYTES>, # Binary data from your image file
    visual_features=[VisualFeatures.CAPTION, VisualFeatures.TAGS],
    gender_neutral_caption=True,
)
```

> [!NOTE]
> In this code example, the client app uses key-based authentication. To use Microsoft Entra ID authentication, you can use a **TokenCredential** instead of an **AzureKeyCredential**.
>
> The code example submits the image data as a binary object (which would typically be read from an image file). You can also analyze an image based on a URL by using the **analyze_from_url** method.

Available visual features are contained in the `VisualFeatures` enumeration:

- VisualFeatures.TAGS: Identifies tags about the image, including objects, scenery, setting, and actions
- VisualFeatures.OBJECTS: Returns the bounding box for each detected object
- VisualFeatures.CAPTION: Generates a caption of the image in natural language
- VisualFeatures.DENSE_CAPTIONS: Generates more detailed captions for the objects detected
- VisualFeatures.PEOPLE: Returns the bounding box for detected people
- VisualFeatures.SMART_CROPS: Returns the bounding box of the specified aspect ratio for the area of interest
- VisualFeatures.READ: Extracts readable text

::: zone-end

::: zone pivot="csharp"

```csharp
using Azure.AI.Vision.ImageAnalysis;

ImageAnalysisClient client = new ImageAnalysisClient(
    "<YOUR_RESOURCE_ENDPOINT>",
    new AzureKeyCredential("<YOUR_AUTHORIZATION_KEY>"));

ImageAnalysisResult result = client.Analyze(
    <IMAGE_DATA_BYTES>, // Binary data from your image file
    VisualFeatures.Caption | VisualFeatures.Tags,
    new ImageAnalysisOptions { GenderNeutralCaption = true });
```

> [!NOTE]
> In this code example, the client app uses key-based authentication. To use Microsoft Entra ID authentication, you can use a **TokenCredential** instead of an **AzureKeyCredential**.
>
> The code example submits the image data as a binary object (which would typically be read from an image file). You can also analyze an image based on a URL.

Available visual features are contained in the `VisualFeatures` enumeration:

- VisualFeatures.Tags: Identifies tags about the image, including objects, scenery, setting, and actions
- VisualFeatures.Objects: Returns the bounding box for each detected object
- VisualFeatures.Caption: Generates a caption of the image in natural language
- VisualFeatures.DenseCaptions: Generates more detailed captions for the objects detected
- VisualFeatures.People: Returns the bounding box for detected people
- VisualFeatures.SmartCrops: Returns the bounding box of the specified aspect ratio for the area of interest
- VisualFeatures.Read: Extracts readable text

::: zone-end

Specifying the visual features you want analyzed in the image determines what information the response will contain. Most responses will contain a bounding box (if a location in the image is reasonable) or a confidence score (for features such as tags or captions).

## Processing the response

This method returns a JSON document containing the requested information. The JSON response for image analysis looks similar to this example, depending on your requested features:

```JSON
{
  "apim-request-id": "abcde-1234-5678-9012-f1g2h3i4j5k6",
  "modelVersion": "<version>",
  "denseCaptionsResult": {
    "values": [
      {
        "text": "a house in the woods",
        "confidence": 0.7055229544639587,
        "boundingBox": {
          "x": 0,
          "y": 0,
          "w": 640,
          "h": 640
        }
      },
      {
        "text": "a trailer with a door and windows",
        "confidence": 0.6675070524215698,
        "boundingBox": {
          "x": 214,
          "y": 434,
          "w": 154,
          "h": 108
        }
      }
    ]
  },
  "metadata": {
    "width": 640,
    "height": 640
  }
}
```
