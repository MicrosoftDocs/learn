To use Azure AI Vision for image analysis, including optical character recognition, you must provision an Azure AI Vision resource in an Azure subscription. The resource can be:

- An **Azure AI Services** multi-service resource (either deployed as part of an Azure AI Foundry hub and project, or as a standalone resource).
- A **Computer Vision** resource.

To use your deployed resource in an application, you must connect to its *endpoint* using either key-based authentication or Microsoft Entra ID authentication. You can find the endpoint for your resource in the Azure portal, or if you're working in an Azure AI Foundry project, in the Azure AI Foundry portal. The endpoint is in the form of a URL, and typically looks something like this:

```
https://<resource_name>.cognitiveservices.azure.com/
```

After establishing a connection, you can use the OCR feature by calling the **ImageAnalysis** function (via the REST API or with an equivalent SDK method), passing the image URL or binary data, and optionally specifying the language the text is written in (with a default value of **en** for English).

```rest
https://<endpoint>/computervision/imageanalysis:analyze?features=read&...
```

::: zone pivot="python"

To use the Azure AI Vision Python SDK to extract text from an image, install the **azure-ai-vision-imageanalysis** package. Then, in your code, use either key-based authentication or Microsoft Entra ID authentication to connect an **ImageAnalysisClient** object to an Azure AI Vision resource. To find and read text in an image, call the **analyze** (or **analyze_from_url**) method, specifying the **VisualFeatures.READ** enumeration.

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
    visual_features=[VisualFeatures.READ],
    language="en",
)
```

::: zone-end

::: zone pivot="csharp"

To use the Azure AI Vision .NET SDK to extract text from an image, install the **Azure.AI.Vision.ImageAnalysis** package. Then, in your code, use either key-based authentication or Microsoft Entra ID authentication to connect an **ImageAnalysisClient** object to an Azure AI Vision resource. To find and read text in an image, call the **Analyze** method, specifying the **VisualFeatures.Read** enumeration.

```csharp
using Azure.AI.Vision.ImageAnalysis;

ImageAnalysisClient client = new ImageAnalysisClient(
    "<YOUR_RESOURCE_ENDPOINT>",
    new AzureKeyCredential("<YOUR_AUTHORIZATION_KEY>"));

ImageAnalysisResult result = client.Analyze(
    <IMAGE_DATA_BYTES>, // Binary data from your image file
    VisualFeatures.Read,
    new ImageAnalysisOptions { Language = t"en" });
```

::: zone-end

The results of the Read OCR function are returned synchronously, either as JSON or the language-specific object of a similar structure. These results are broken down in *blocks* (with the current service only using one block), then *lines*, and then *words*. Additionally, the text values are included at both the *line* and *word* levels, making it easier to read entire lines of text if you don't need to extract text at the individual *word* level.

```JSON
{
    "metadata":
    {
        "width": 500,
        "height": 430
    },
    "readResult":
    {
        "blocks":
        [
            {
                "lines":
                [
                    {
                        "text": "Hello World!",
                        "boundingPolygon":
                        [
                            {"x":251,"y":265},
                            {"x":673,"y":260},
                            {"x":674,"y":308},
                            {"x":252,"y":318}
                        ],
                        "words":
                        [
                            {
                                "text":"Hello",
                                "boundingPolygon":
                                [
                                    {"x":252,"y":267},
                                    {"x":307,"y":265},
                                    {"x":307,"y":318},
                                    {"x":253,"y":318}
                                ],
                            "confidence":0.996
                            },
                            {
                                "text":"World!",
                                "boundingPolygon":
                                [
                                    {"x":318,"y":264},
                                    {"x":386,"y":263},
                                    {"x":387,"y":316},
                                    {"x":319,"y":318}
                                ],
                                "confidence":0.99
                            }
                        ]
                    },
                ]
            }
        ]
    }
}
```
