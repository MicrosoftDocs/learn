Recognizing emotion with the Emotion API involves sending an authorized web request to another subscription endpoint. The primary method used to detect faces in images is the Emotion **Recognize** method. The Recognize method supports either:

- Uploading an image (as a binary file), or
- Specifying a (publicly available) image URL.

> [!TIP]
> Just like the Face detect API, you can practice calling the Emotion API with the [Emotion API testing console](https://westus.dev.cognitive.microsoft.com/docs/services/5639d931ca73072154c1ce89/?azure-portal=true). The process is identical to what we did earlier.

## Calling the Emotion API

The Emotion API **Recognize** method endpoint is at <https://westus.api.cognitive.microsoft.com/emotion/v1.0/recognize>. Notice that the location ("westus") is part of the URL - you might need to adjust that based on where you place your service. You must supply an image payload to process as part of the `POST` request to the method. This can be: 

- A **binary file**, such as a stream or byte array, or
- A **JSON payload** that includes the value of a (publicly available) image URL, formatted as human-readable text.

> [!NOTE]
> The Azure Cognitive Services Emotion API is currently in **public preview**. The Recognize method may take additional parameters when it moves into production.

### Binary file payload

Creating and sending a binary file payload to the Recognize method uses standard, language-specific methods for creating and sending binary content. For example, in C#, a binary payload could come from an image (typically containing a human face) located on a local computer:

```csharp
string uri = "https://westus.api.cognitive.microsoft.com/emotion/v1.0/recognize";
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
> Notice the required use of the `application/octet-stream` content type in the request header which informs the endpoint that it will be receiving a binary payload.

### Return values

Information is returned from the Emotion API as a well-formatted **JSON object or array**. Here's an example response.

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
