The **Custom Vision Service API** uses built-in algorithms that provide the service with "intelligence." You can use these algorithms to create and customize your own state-of-the-art computer vision models with just a few lines of code.

The Custom Vision API algorithms are exposed as simple REST-based service calls. Developers can use the REST calls to create projects (classifiers), upload and tag images, perform training, manage model iterations, and even make predictions.

![The Custom Vision Service API](../media/2-api-introduction.png)

> [!TIP]
> This module focuses on the REST services which can be used by any language. Microsoft also publishes open-source SDKs for .NET, Python, Java, Node.js, and Go that wrap the underlying REST APIs into framework-specific objects and methods. Check out the documentation for more information on the available SDKs.

## The Custom Vision API

The Custom Vision API is a perfect way to leverage the power of artificial intelligence to:

- Create state-of-the-art computer vision models
- Upload and tag training images
- Train classifiers for active learning
- Image prediction to identify probable matches to a trained model
- Object detection to locate elements _within_ an image and return a bounding box

In general, the methods provided by the Custom Vision API fall into the following categories:

- **Training**: Manage projects (classifiers) and upload, tag, and manage training images
- **Prediction**: Make predictions based on classification models

Just like the related Computer Vision API, calling the Custom Vision APIs is the simple process of making a secure web request. For example, here's a simplified version of what a call to the Custom Vision API might look like in Python:

```python
conn = httplib.HTTPSConnection('southcentralus.api.cognitive.microsoft.com')
conn.request("POST", serviceEndpointUrl, body)
response = conn.getresponse()

data = response.read()
```

Making the same API call in C# is simply a change in language-specific syntax:

```csharp
HttpClient client = new HttpClient();
StringContent content = new StringContent(body);
response = await client.PostAsync(serviceEndpointUrl, content);

string data = await response.Content.ReadAsStringAsync();
```

<!-- Custom vision service is GA: https://docs.microsoft.com/en-us/azure/cognitive-services/custom-vision-service/release-notes -->