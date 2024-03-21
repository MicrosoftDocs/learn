To detect and analyze faces with the Azure AI Vision service, call the **Analyze Image** function (SDK or equivalent REST method), specifying **People** as one of the visual features to be returned.

In images that contain one or more people, the response includes details of their location in the image and the attributes of the detected person, like this:

```JSON
{ 
  "modelVersion": "2023-10-01",
  "metadata": {
    "width": 400,
    "height": 600
  },
  "peopleResult": {
    "values": [
      {
        "boundingBox": {
          "x": 0,
          "y": 56,
          "w": 101,
          "h": 189
        },
        "confidence": 0.9474349617958069
      },
      {
        "boundingBox": {
          "x": 402,
          "y": 96,
          "w": 124,
          "h": 156
        },
        "confidence": 0.9310565276194865
      },
    ...
    ]
  }
}
```

For more information on Azure AI Vision people detection, see the [People detection concept page](/azure/ai-services/computer-vision/concept-people-detection?azure-portal=true)

> [!NOTE]
> Azure AI Vision previously included age and gender prediction, however that has been removed as a safeguard for responsible use. You can read more about our [Responsible AI Investments here](https://azure.microsoft.com/blog/responsible-ai-investments-and-safeguards-for-facial-recognition/).
