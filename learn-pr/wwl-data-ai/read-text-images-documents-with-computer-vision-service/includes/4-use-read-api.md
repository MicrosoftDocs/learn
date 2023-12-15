To use the Read OCR feature, call the **ImageAnalysis** function (REST API or equivalent SDK method), passing the image URL or binary data, and optionally specifying a gender neutral caption or the language the text is written in (with a default value of **en** for English).

To make an OCR request to **ImageAnalysis**, specify the analysis features as `TEXT`.

**C#**

```csharp
var analysisOptions = new ImageAnalysisOptions()
{
    Features = ImageAnalysisFeature.Text,
};
```

**Python**

```python
analysis_options.features = (
    sdk.ImageAnalysisFeature.TEXT
)
```

If using the REST API, specify the feature as `read`.

```rest
https://<endpoint>/computervision/imageanalysis:analyze?features=read&...
```

The results of the Read OCR function are returned synchronously, either as JSON or the language specific object of a similar structure. These results are provided as a complete result and broken down by *page*, then *words*, and then *lines*. Additionally, the text values are included at both the *line* and *word* levels, making it easier to read entire lines of text if you don't need to extract text at the individual *word* level.

```JSON
{
    "metadata":
    {
        "width": 500,
        "height": 430
    },
    "readResult":
    {
        "stringIndexType": "TextElements",
        "content": "Hello World!",
        "pages":
        [
            {
                "height": 430,
                "width": 500,
                "angle": -1.099,
                "pageNumber": 1,
                "words":
                [
                    {
                        "content": "Hello",
                        "boundingBox": [253,268,301,267,304,318,256,318],
                        "confidence": 0.998,
                        "span": {"offset":0,"length":3}
                    },
                    {
                        "content": "World!",
                        "boundingBox": [310,266,376,265,378,316,313,317],
                        "confidence": 0.988,
                        "span": {"offset":4,"length":4}
                    }
                ],
                "spans":
                [
                    {
                        "offset": 0,
                        "length": 26
                    }
                ],
                "lines":
                [
                    {
                        "content": "Hello World!",
                        "boundingBox": [253,267,670,262,671,307,254,318],
                        "spans": [{"offset":0,"length":26}]
                    }
                ]
            }
        ],
        "styles":
        [
            {
                "isHandwritten": true,
                "spans":
                [
                    {
                        "offset": 0,
                        "length": 26
                    }
                ],
                "confidence": 0.95
            }
        ]
    }
}
```
