After you've trained an object detection model, you can use the Azure AI Custom Vision SDK to develop a client application that submits new images to be analyzed.

::: zone pivot="python"

```python
from msrest.authentication import ApiKeyCredentials
from azure.cognitiveservices.vision.customvision.prediction import CustomVisionPredictionClient


 # Authenticate a client for the prediction API
credentials = ApiKeyCredentials(in_headers={"Prediction-key": "<YOUR_PREDICTION_RESOURCE_KEY>"})
prediction_client = CustomVisionPredictionClient(endpoint="<YOUR_PREDICTION_RESOURCE_ENDPOINT>",
                                                 credentials=credentials)

# Get classification predictions for an image
image_data = open("<PATH_TO_IMAGE_FILE>"), "rb").read()
results = prediction_client.detect_image("<YOUR_PROJECT_ID>",
                                           "<YOUR_PUBLISHED_MODEL_NAME>",
                                           image_data)

# Process predictions
for prediction in results.predictions:
    if prediction.probability > 0.5:
        left = prediction.bounding_box.left
        top = prediction.bounding_box.top 
        height = prediction.bounding_box.height
        width =  prediction.bounding_box.width
        print(f"{prediction.tag_name} ({prediction.probability})")
        print(f"  Left:{left}, Top:{top}, Height:{height}, Width:{width}")

    
```

::: zone-end

::: zone pivot="csharp"

```csharp
using System;
using System.IO;
using Microsoft.Azure.CognitiveServices.Vision.CustomVision.Prediction;

// Authenticate a client for the prediction API
CustomVisionPredictionClient prediction_client = new CustomVisionPredictionClient(new ApiKeyServiceClientCredentials("<YOUR_PREDICTION_RESOURCE_KEY>"))
{
    Endpoint = "<YOUR_PREDICTION_RESOURCE_ENDPOINT>"
};

// Get classification predictions for an image
MemoryStream image_data = new MemoryStream(File.ReadAllBytes("<PATH_TO_IMAGE_FILE>"));
var result = prediction_client.DetectImage("<YOUR_PROJECT_ID>",
                                             "<YOUR_PUBLISHED_MODEL_NAME>",
                                             image_data);

// Process predictions
foreach (var prediction in result.Predictions)
{
    if (prediction.Probability > 0.5)
    {
        int left = prediction.BoundingBox.Left;
        int top = prediction.BoundingBox.Top;
        int height = prediction.BoundingBox.Height;
        int width =  prediction.BoundingBox.Width;
        Console.WriteLine($"{prediction.TagName} ({prediction.Probability})");
        Console.WriteLine($"  Left:{left}, Top:{top}, Height:{height}, Width:{width}");
    }
}

```

::: zone-end