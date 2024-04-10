To use the Read OCR feature, call the **ImageAnalysis** function (REST API or equivalent SDK method), passing the image URL or binary data, and optionally specifying a gender neutral caption or the language the text is written in (with a default value of **en** for English).

To make an OCR request to **ImageAnalysis**, specify the visual feature as `READ`.

**C#**

```csharp
ImageAnalysisResult result = client.Analyze(
    <image-to-analyze>,
    VisualFeatures.Read);
```

**Python**

```python
result = client.analyze(
    image_url=<image_to_analyze>,
    visual_features=[VisualFeatures.READ]
)
```

If using the REST API, specify the feature as `read`.

```rest
https://<endpoint>/computervision/imageanalysis:analyze?features=read&...
```

The results of the Read OCR function are returned synchronously, either as JSON or the language specific object of a similar structure. These results are broken down in *blocks* (with the current service only using one block), then *lines*, and then *words*. Additionally, the text values are included at both the *line* and *word* levels, making it easier to read entire lines of text if you don't need to extract text at the individual *word* level.

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
