Recognizing emotion with the Emotion API involves sending an authorized web request to another subscription endpoint. The primary method used to detect faces in images is the Emotion **Recognize** method. The Recognize method supports either:

- Uploading an image (as a binary file), or
- Specifying a (publicly available) image URL.

> [!TIP]
> For testing purposes, subscribers can practice using the Emotion API through the [Emotion API testing console](https://westus.dev.cognitive.microsoft.com/docs/services/5639d931ca73072154c1ce89/?azure-portal=true).

Since no parameters are passed to the Emotion API **Recognize** method, a straight HTTP call to the service endpoint does the job:

```text
https://westus.api.cognitive.microsoft.com/emotion/v1.0/recognize
```

> [!NOTE]
> The Microsoft Cognitive Services Emotion API is currently in **public preview**. The Recognize method may take additional parameters when it moves into production.

## Sending an Image Payload

To send an image payload to the Emotion Recognize method, one of the following needs to be including in the web request, and then **sent via a standard HTTP POST method**:

- A **binary file**, such as a stream or byte array, or
- A **JSON payload** that includes the value of a (publicly available) image URL, formatted as human-readable text.

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