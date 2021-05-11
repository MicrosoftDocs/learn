
To use the OCR API, call the **OCR** REST function (or the equivalent SDK method) passing the image URL or binary image data, and specifying the language of the text to be detected (with a default value of **en** for English), and optionally the **detectOrientation** parameter to return information about orientation of the text in the image.

The resulting JSON describes the text detected, broken down into *regions* of the image, and then further down into *lines*, and then individual *words*; like this:

```JSON
{
  "language": "en",
  "textAngle": 0.00000,
  "orientation": "Up",
  "regions": [
    {
      "boundingBox": "462,379,497,75",
      "lines": [
        {
          "boundingBox": "462,379,497,74",
          "words": [
            {
              "boundingBox": "462,379,41,73",
              "text": "Hello"
            },
            {
              "boundingBox": "523,379,153,73",
              "text": "World!"
            }
          ]
        }
      ]
    }
  ]
}
```
