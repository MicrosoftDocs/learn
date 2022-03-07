To detect and analyze faces with the Computer Vision service, call the **Analyze Image** REST function (or equivalent SDK method), specifying **Faces** as one of the visual features to be returned.

In images that contain one or more faces, the response includes details of their location in the image and the predicted age and gender of the detected person, like this:

```JSON
{
  "faces": [
      {
        "age": 32,
        "gender": "Female",
        "faceRectangle": {
          "top": 225,
          "left": 237,
          "width": 130,
          "height": 130
        }
      },
      {
        "age": 29,
        "gender": "Female",
        "faceRectangle": {
          "top": 309,
          "left": 534,
          "width": 119,
          "height": 119
      }
    }
  ]
}
```