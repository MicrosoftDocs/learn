To analyze an image, you can use the **Analyze Image** REST method or the equivalent method in the SDK for your preferred programming language, specifying the visual features you want to include in the analysis (and if you select categories, whether or not to include details of celebrities or landmarks). This method returns a JSON document containing the requested information.

> [!NOTE]
> Detection of celebrities will require getting approved through a [Limited Access policy](https://aka.ms/cog-services-limited-access). You can read more about the [addition of this policy](https://azure.microsoft.com/blog/responsible-ai-investments-and-safeguards-for-facial-recognition/) to our Responsible AI standard. Celebrity recognition is seen in some screenshots, however is not included in the lab.

**C#**

```csharp
using Azure.AI.Vision.Common;
using Azure.AI.Vision.ImageAnalysis;

var serviceOptions = new VisionServiceOptions(
    Environment.GetEnvironmentVariable("VISION_ENDPOINT"),
    new AzureKeyCredential(Environment.GetEnvironmentVariable("VISION_KEY")));

using var imageSource = VisionSource.FromUrl(new Uri("<url>"));

var options = new ImageAnalysisOptions()
{
    Features = ImageAnalysisFeature.Caption | ImageAnalysisFeature.Text,
    Language = "en",
    GenderNeutralCaption = true
};

using var analyzer = new ImageAnalyzer(serviceOptions, imageSource, options);

var result = analyzer.Analyze();
```

**Python**

```python
import azure.ai.vision as vision

service_options = sdk.VisionServiceOptions(os.environ["VISION_ENDPOINT"],
                                           os.environ["VISION_KEY"])

image_source = sdk.VisionSource(url="<url>")

options = sdk.ImageAnalysisOptions()

options.features = (
    sdk.ImageAnalysisFeature.CAPTION |
    sdk.ImageAnalysisFeature.TEXT
)

options.language = "en"
options.gender_neutral_caption = True

image_analyzer = sdk.ImageAnalyzer(service_options, image_source, options)

result = image_analyzer.analyze()
```

You can also use scoped functions to retrieve specific subsets of the image features, including the image description, tags, and objects in the image.

The JSON response for image analysis looks similar to this example:

```JSON
{
  "categories": [
   {
     "name": "_outdoor_mountain",
     "confidence": "0.9"}
  ],
  "adult": {"isAdultContent": "false", …},
  "tags": [
    {"name": "outdoor", "confidence": 0.9},
    {"name": "mountain", " confidence ": 0.9}],
  "description": {
    "tags":["outdoor", "mountain"],
    "captions": [
      {"name": "A mountain with snow",
       "confidence": 0.9
      }
    ]
  },
  "metadata":
    {"width":60,"height":30, format:"Jpeg"},
  "faces": [],
  "brands": [],
  "color": {"dominantColorForeground": "Brown",…},
  "imageType": {"clipArtType": 0, …},
  "objects" : [
    {
     "rectangle": {x:20, y:25, w:10, h:20},
     "object": "mountain",
     "confidence": 0.9
    }
  ]
}
```
