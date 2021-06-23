To use the Read API, call the **Read** REST function (or equivalent SDK method), passing the image URL or binary data, and optionally specifying the language the text is written in (with a default value of **en** for English).

The Read function returns an operation ID, which you can use in a subsequent call to the **Get Read Results** function in order to retrieve details of the text that has been read. Depending on the volume of text, you may need to poll the **Get Read Results** function multiple times before the operation is complete.

The results of from the Read API are similar to the OCR API, except that the text is broken down by *page*, then *line*, and then *word*. Additionally, the text values are included at both the *line* and *word* levels, making it easier to read entire lines of text if you don't need to extract text at the individual *word* level.

```JSON
{
  "status": "succeeded",
  "createdDateTime": "2019-10-03T14:32:04Z",
  "lastUpdatedDateTime": "2019-10-03T14:38:14Z",
  "analyzeResult": {
    "version": "v3.0",
    "readResults": [
      {
        "page": 1,
        "language": "en",
        "angle": 49.59, "width": 600,
        "height": 400, "unit": "pixel",
        "lines": [
          {
            "boundingBox": [
              20,61,204,64,204,84,20,81],
            "text": "Hello world!",
            "words": [
              {
                "boundingBox": [
                  20,62,48,62,48,83,20,82],
                "text": "Hello",
                "confidence": 0.91
              },
              {
                "boundingBox": [
                  51,62,105,63,105,83,51,83],
                "text": "world!",
                "confidence": 0.164
              }
            ]
          }
        ]
      }
    ]
  }
}
```
