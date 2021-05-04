To recognize emotion, the Emotion API sends an authorized web request to another subscription endpoint. The primary way to detect faces in images is the emotion *Recognize* method. The Recognize method can use either an uploaded an image (a binary file) or a publicly available image URL.

> [!TIP]
> You can practice calling the Emotion API by using the [Emotion API testing console](https://westus.dev.cognitive.microsoft.com/docs/services/563879b61984550e40cbbe8d/operations/563879b61984550f30395236/console). The process is identical to the one we followed for face detection.

## Call the Emotion API

The Emotion API Recognize method endpoint is at <https://westus.dev.cognitive.microsoft.com/docs/services/563879b61984550e40cbbe8d/operations/563879b61984550f30395236>. Notice that the location *westus* is part of this URL. You'll need to adjust this if your service is in a different location. 

You'll need to provide an image payload to process as part of the `POST` request to the method. The image can be in one of the following formats:

- A binary file, such as a stream or byte array
- A JSON payload that includes the value of a publicly available image URL, formatted as human-readable text

> [!NOTE]
> The Cognitive Services Emotion API is currently in public preview. The Recognize method might take additional parameters when it moves into production.

### Create and send a binary file payload

To create and send a binary file payload to the Recognize method, you'll use standard, language-specific methods. For example, in C#, a binary payload can come from an image (typically containing a human face) that's on a local computer:

```csharp
string uri = "https://westus.dev.cognitive.microsoft.com/docs/services/563879b61984550e40cbbe8d/operations/563879b61984550f30395236";
FileStream fileStream = new FileStream(@"c:\\Sample Images\image_01.jpg", FileMode.Open, FileAccess.Read);
BinaryReader binaryReader = new BinaryReader(fileStream);
var bytes = binaryReader.ReadBytes((int)fileStream.Length);

using (ByteArrayContent content = new ByteArrayContent(bytes))
{
    content.Headers.ContentType = new MediaTypeHeaderValue("application/octet-stream");
    //POST the binary content to the endpoint
    response = await client.PostAsync(uri, content);
    string contentString = await response.Content.ReadAsStringAsync();
}
```

> [!TIP]
> Notice the required use of the `application/octet-stream` content type in the request header which informs the endpoint that it will receive a binary payload.

### Return values

Information is returned from the Emotion API as a well-formatted JSON object or array. Here's an example response:

```json
[{
    "faceRectangle": {
    "height": 126,
    "left": 495,
    "top": 0,
    "width": 140
    },
    "scores": {
    "anger": 4.17920228E-06,
    "contempt": 2.282148E-06,
    "disgust": 5.69215263E-05,
    "fear": 9.129213E-09,
    "happiness": 0.9999153,
    "neutral": 1.8466184E-05,
    "sadness": 2.74187551E-06,
    "surprise": 1.23331162E-07
    }
}]
```
