You can use a REST API to consume DALL-E models from applications. Alternatively, you can use a language-specific SDK (for example, the OpenAI Python SDK or the Azure OpenAI .NET SDK) to abstract the REST methods.

You initiate the image generation process by submitting a request to the service endpoint with the authorization key in the header. The request contains parameters describing the image-generation requirements. For example, parameters for a DALL-E model include:

- **prompt**: The description of the image to be generated.
- **n**: The number of images to be generated. DALL-E 3 only supports n=1.
- **size**: The resolution of the image(s) to be generated (*1024x1024*, *1792x1024*, or *1024x1792* for DALL-E 3)
- **quality** *Optional*: The quality of the image (*standard* or *hd*). Defaults to *standard*.
- **style** *Optional*: The visual style of the image (*natural* or *vivid*). Defaults to *vivid*.

For example, the following JSON could be submitted via the REST API to a DALL-E model, prompting it to generate an 1024 x 1024 image of a badger wearing a tuxedo:

```json
{
    "prompt": "A badger wearing a tuxedo",
    "n": 1,
    "size": "1024x1024",
    "quality": "hd", 
    "style": "vivid"
}
```

With DALL-E 3, the result from the request is processed synchronously with the response containing the URL for the generated image. The response is similar to the following JSON:

```json
{
    "created": 1686780744,
    "data": [
        {
            "url": "<URL of generated image>",
            "revised_prompt": "<prompt that was used>"
        }
    ]
}
```

The **data** element includes the **url** value, which references a PNG image file generated from the prompt that you can then view or download. The response also contains a **revised prompt** that was used to generate the image, which was updated by the system to achieve the most desirable results. In this example, the image might look similar to the following image:

![A picture of a badger wearing a tuxedo.](../media/badger-wearing-tuxedo.png)
