The most common task an application or script will do with the Custom Vision Service is to request image predictions through the **Prediction API**. This process involves sending an authorized web request to the subscription endpoint and processing the information returned from the call.

> [!TIP]
> For testing purposes, subscribers can practice using the Prediction API using the [Custom Vision Prediction API testing console](https://southcentralus.dev.cognitive.microsoft.com/docs/services/Custom_Vision_Prediction_3.0/operations/5c82db60bf6a2b11a8247c19 "Custom Vision Prediction API testing console"). Make sure to select the testing console associated with the region where the service is deployed.

### Calling the Prediction API

The Prediction API is accessed through a public web endpoint that's specific to your registered Custom Vision Service. There are two APIs available depending on the project type: image classification or object detection.

#### Image classification
Image classification analyzes a supplied image and returns a list of labels (tags) identified in the image. There are several endpoints supplied; the two most commonly used are:

- **ClassifyImage** accepts a binary payload (`"application/octet-stream"`) as a byte array which contains the image data.
- **ClassifyImageUrl** accepts a **JSON** payload (`"application/json"`) specifying a publicly available image URL.

#### Object detection
Object detection is similar but it also returns the coordinates (bounding box) where the tag was located within the image. As with classification, there are two commonly used endpoints available:

- **DetectImage** accepts a binary payload (`"application/octet-stream"`) as a byte array which contains the image data.
- **DetectImageUrl** accepts a **JSON** payload (`"application/ejson"`) specifying a publicly available image URL.

Both of these API endpoints use the same structure to form the URL.

```text
https://{endpoint}/customvision/v3.0/Prediction/{projectId}/{projectType}/iterations/{iterationName}/{imageType}
```

Where:

- `{endpoint}` is the location endpoint the service was created in, for example, **southcentralus.api.cognitive.microsoft.com**.
- `{projectId}` is a unique project identifier that is used to specify the Custom Vision Service.
- `{projectType}` is either **classify** for _image classification_ or **detect** for _object detection_.
- `{iterationName}` is the name of the trained model iteration being used.
- `{imageType}` is either **url** when the image is passed as a URL, or **image** when the image is passed as binary data in the body of the request.

> [!IMPORTANT]
> The API you call: **Detect** vs. **Classify** is based on the _type_ of project you create in the Custom Vision Service. If you don't call the proper API, the service will return `400 Bad Request - Invalid project type for operation.`.

### Locating the project URL

The specific endpoint details are available in the Custom Vision Service portal. Selecting the **View Endpoint** button on the **Predictions** tab, or the **Prediction URL** option on the **Performance** tab will display a dialog similar to the following image.

![Screenshot showing the two defined prediction endpoints for a Custom Vision Service](../media/4-image-url.png)

### Constructing the HTTP request

Once the proper URL is identified, you invoke it with an HTTP `PUT` request. Recall that you need to pass a **Prediction Key** with the request. This is provided as a request header with the name `Prediction-Key.`

As an example, the following C# code sends an image URL to the prediction API with the given endpoint and prediction key.

```csharp
public async Task<string> MakePredictionRequestAsync(string url, string predictionKey, string imageUrl)
{
    var client = new HttpClient();
    client.DefaultRequestHeaders.Add("Prediction-Key", predictionKey);
    using (var content = new StringContent("{\"Url\":\"" + imageUrl + "\"}", Encoding.UTF8, "application/json");)
    {
        var response = await client.PostAsync(url, content);
        return await response.Content.ReadAsStringAsync();
    }
}
```

The same code in Python 3 might look something like:

```python
import http.client, urllib.request, urllib.parse, urllib.error, base64

headers = {
    'Content-Type': 'application/json',
    'Prediction-Key': '{prediction key}',
}

body = "{'Url' : '" + url + "' }"

try:
    conn = http.client.HTTPSConnection('southcentralus.api.cognitive.microsoft.com')
    conn.request("POST", "/customvision/v3.0/Prediction/{projectId}/classify/iterations/{iterationName}/url", body, headers)
    response = conn.getresponse()
    data = response.read()
    print(data)
    conn.close()
except Exception as e:
    print("[Errno {0}] {1}".format(e.errno, e.strerror))
```

> [!NOTE]
> The Prediction API methods also accept an optional query string parameter named `application` to identify the app invoking the service. This value can be used to track the applications utilizing the Custom Vision Service.

### Passing image files directly

If the _binary file payload_ **ClassifyImage** or **DetectImage** is being used, the request body should contain the image data encoded into a byte array. Here's the same call using the **ClassifyImage** endpoint instead. In this case, the `Content-Type` header must be set to `"application/octet-stream."`

```csharp
public async Task<string> MakePredictionRequestAsync(string url, string predictionKey, string imageFile)
{
    var fileStream = new FileStream(imageFile, FileMode.Open, FileAccess.Read);
    var binaryReader = new BinaryReader(fileStream);
    var bytes = binaryReader.ReadBytes((int)fileStream.Length);

    var client = new HttpClient();
    client.DefaultRequestHeaders.Add("Prediction-Key", predictionKey);
    using (var content = new ByteArrayContent(bytes))
    {
        content.Headers.ContentType = new MediaTypeHeaderValue("application/octet-stream");
        var response = await client.PostAsync(url, content);
        return await response.Content.ReadAsStringAsync();
    }
}
```

### Processing the response

The Prediction API returns a JSON object that includes several pieces of information - the most important of which is an array of _predictions_ indicating the probability that the supplied image contained that trained element. For example, if the model were trained to recognize types of animals found in the Arctic Circle and we provided a picture of a Polar Bear, the **ClassifyImage** API might return something like:

```json
{
   "id":"71b145f7-8533-4cf4-9821-f31a4293508a",
   "project":"586008f5-2d8e-4e4a-abb4-66127e96a4f4",
   "iteration":"f118e60f-5e25-40ad-89a2-3b6b1cdd5dac",
   "created":"2019-06-19T20:55:10.240Z",
   "predictions":[
      {
         "probability":1.0,
         "tagId":"8b2ada4d-1d0f-4b07-af19-dfd643043e1f",
         "tagName":"Polar bear"
      },
      {
         "probability":3.3948698E-11,
         "tagId":"56fe8dca-2849-454a-8aa0-5897b1c30009",
         "tagName":"Arctic fox"
      },
      {
         "probability":1.96249064E-13,
         "tagId":"ae6f7ccb-46ac-44af-9b70-8d91f4951122",
         "tagName":"walrus"
      }
   ]
}
```

Each prediction contains a `tagId` which identifies the matched tag, a `tag` which provides a friendly name for the tag, and a `probability` value from [0-1] which indicates how confident the service was in identifying the given tag in the image.