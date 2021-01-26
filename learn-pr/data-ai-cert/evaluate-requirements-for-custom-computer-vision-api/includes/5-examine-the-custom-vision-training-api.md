

The Custom Vision service web portal is an easy way to train a model by uploading tagged images. This approach is the most common way to train, test, and publish a model. But sometimes a business need might require a model to be prepared (or retrained) based on incoming data available to the applications that are using the service. In these cases, the app can use the Training API to add and tag new images and publish a new iteration of the Custom Vision service.

Like the Prediction API, the Training API provides HTTP methods for adding   training images to a project and tagging them. The process of calling and consuming the response is identical to the Prediction API process. It just uses different endpoints.

The Custom Vision **CreateImages** method is the underlying method used to send tagged training images. Just like the Prediction API, the Custom Vision Training API provides separate methods for uploading binary files and for supplying publicly available image URLs:

- **CreateImagesFromFiles** includes one or more encoded image files, and optional tags, to create images. There's a limit of 64 images and 20 tags.
- **CreateImagesFromUrls** specifies one or more URLs, and optional tags, to create images. There's a limit of 64 images and 20 tags.

> [!NOTE]
> There are several additional methods available in the Training API that allow you to create and find projects, create and delete tags, train projects, and more. Everything you can do in the portal, you can generally do with the REST API.

The endpoints all have the same basic format as endpoints in the Prediction API:

```text
https://{endpoint}/customvision/v3.0/training/projects/{projectId}/images/{imageType}
```

In this URL:

- `{endpoint}` is the location endpoint the service was created in, for example, `southcentralus.api.cognitive.microsoft.com`.
- `{projectId}` is a unique project identifier that's used to specify the Custom Vision service.
- `{imageType}` is either `urls`, when the images are passed as URLs, or `files`, when the images are passed as encoded data in the body of the request.

### Building a request

The Training API endpoint is available in the **Settings** pane of your Custom Vision service project in the web portal. You can also find the *training key* on this page. You need the training key to authorize calls to the Training API services. After you have these two pieces of information, you're ready to use the **CreateImages** methods.

After you identify the proper URL, you invoke it with an HTTP PUT request, passing the request in the body and the training key as a request header with the name `Training-Key`.

You can use most available media types to structure the body of the request: `"application/json"`, `"application/xml"`, `"text/xml"`, or `"application/x-www-form-urlencoded"`. You can choose the one that's easiest to work with in your language or framework. The `Content-Type` header value will determine the content payload type you supply.

Each **CreateImages** request takes a list of images (or URLs) and an optional set of tags. Here's an example of a valid request body for **CreateImagesFromUrls** (in JSON):

```json
{
  "images": [
    {
      "url": "{url to image #1}",
      "tagIds": [ "{tag-id}" ]
    }
  ],
  "tagIds": [
     "{tag-id}"
  ]
}
```

The `tagIds` collections are optional. You can omit them if you're not using them. You can supply tags either per-image (if they're different for each image) or for the entire collection of images through the second tag collection. You must provide the unique identifier for the tag. You can retrieve this identifier from the web portal or by using HTTP GET to invoke the `{endpoint}/customvision/v3.0/training/projects/{projectId}/tags` method. Here's an example response:

```json
[
   {
      "id":"56fe8dca-2849-454a-8aa0-5897b1c30009",
      "name":"Arctic fox",
      "description":null,
      "type":"Regular",
      "imageCount":130
   },
   {
      "id":"ae6f7ccb-46ac-44af-9b70-8d91f4951122",
      "name":"Walrus",
      "description":null,
      "type":"Regular",
      "imageCount":138
   },
   {
      "id":"8b2ada4d-1d0f-4b07-af19-dfd643043e1f",
      "name":"Polar bear",
      "description":null,
      "type":"Regular",
      "imageCount":141
   }
]
```

### Calling the service

After you've built the request, you can use an HTTP PUT method to invoke the API. Here's an example in C#:

```csharp
public async Task<string> AddTrainingImageAsync(string url, string trainingKey, string[] imageUrls, string[] tags)
{
    string jsonData = ...; // Build the JSON request from imageUrls and tags.

    var client = new HttpClient();
    client.DefaultRequestHeaders.Add("Training-Key", trainingKey);
    using (var content = new StringContent(jsonData, Encoding.UTF8, "application/json");)
    {
        var response = await client.PostAsync(url, content);
        return await response.Content.ReadAsStringAsync();
    }
}
```

In Python, the code would look something like this example:

```python
import http.client, urllib.request, urllib.parse, urllib.error, base64

headers = {
    'Content-Type': 'application/json',
    'Training-Key': '{training key}',
}

body = "{json-data}"

try:
    conn = http.client.HTTPSConnection("{endpoint}")
    conn.request("POST", "/customvision/v3.0/training/projects/{projectId}/images/urls", body, headers)
    response = conn.getresponse()
    data = response.read()
    print(data)
    conn.close()
except Exception as e:
    print("[Errno {0}] {1}".format(e.errno, e.strerror))
```

### Processing the result

The response coming back from the service will be in the same format as the request. (You can influence this behavior by using the `Accepts` header value.) The returned object will have an overall result (`isBatchSuccessful`) and an entry for each passed image to indicate whether it was processed. Here's an example result for the `CreateImagesFromUrls` method:

```json
{
  "isBatchSuccessful": true,
  "images": [
    {
      "sourceUrl": "https://timedotcom.files.wordpress.com/2019/06/polar-bear-in-siberia.jpg",
      "status": "OK",
      "image": {
        "id": "955651c9-0ba3-40a0-b33f-a46d39feb3ee",
        "created": "2019-06-19T23:02:39.8757957",
        "width": 1555,
        "height": 900,
        "resizedImageUri": "https://irisscuprodstore.blob.core.windows.net/i-586008f52d8e4e4aabb466127e96a4f4/i-955651c90ba340a0b33fa46d39feb3ee?sv=2017-04-17&sr=b&sig=JfzNzS3%2B1qKKHLnfDK%2Fcuh5FDPFPxRSHZsSnz%2Bri4II%3D&se=2019-06-20T23%3A02%3A39Z&sp=r",
        "thumbnailUri": "https://irisscuprodstore.blob.core.windows.net/i-586008f52d8e4e4aabb466127e96a4f4/t-955651c90ba340a0b33fa46d39feb3ee?sv=2017-04-17&sr=b&sig=3udivyZu%2BGtgT5%2BqX6iCDTYT8TxvBiAzKk2WJV3dFzU%3D&se=2019-06-20T23%3A02%3A39Z&sp=r",
        "originalImageUri": "https://irisscuprodstore.blob.core.windows.net/i-586008f52d8e4e4aabb466127e96a4f4/o-955651c90ba340a0b33fa46d39feb3ee?sv=2017-04-17&sr=b&sig=bWJjIM5aBcAdx3LS5EsZGLdRmK5B%2BE%2BShzSbJD7LZLU%3D&se=2019-06-20T23%3A02%3A39Z&sp=r",
        "tags": [
          {
            "tagId": "8b2ada4d-1d0f-4b07-af19-dfd643043e1f",
            "tagName": null,
            "created": "2019-06-19T23:02:39.9019664"
          }
        ]
      }
    }
  ]
}
```