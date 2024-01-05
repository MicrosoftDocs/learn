You can use the Azure OpenAI service REST API to consume DALL-E models from applications.

To make a REST call to the service, you need the endpoint and authorization key for the Azure OpenAI Service resource you have provisioned in Azure. You initiate the image generation process by submitting a POST request to the service endpoint with the authorization key in the header. The request must contain the following parameters in a JSON body:

- **prompt**: The description of the image to be generated.
- **n**: The number of images to be generated.
- **size**: The resolution of the image(s) to be generated (*256x256*, *512x512*, or *1024x1024*).

For example, the following JSON could be used to generate an 512 x 512 image of a badger wearing a tuxedo:

```json
{
    "prompt": "A badger wearing a tuxedo",
    "n": 1,
    "size": "512x512"
}
```

The result from the initial request does not immediately return the results of the image generation process. Instead, the response includes an **operation-location** header with a URL for a callback service that your application code can poll until the results of image generation are ready.

When the operation has succeeded, a response similar to the following JSON is returned:

```json
{
    "created": 1686780744,
    "expires": 1686867152,
    "id": "6d765598-eeee-4f49-885d-03ee1c8f9b02",
    "result": {
        "created": 1686780744,
        "data": [
            {
                "url": "https://dalleproduse.....png"
            }
        ]
    },
    "status": "succeeded"
}
```

The **result** element includes a collection of **url** elements, each of which references a PNG image file generated from the prompt. In this example, the file might look similar to the following image:

![A picture of a badger wearing a tuxedo.](../media/badger-in-a-tuxedo.png)
