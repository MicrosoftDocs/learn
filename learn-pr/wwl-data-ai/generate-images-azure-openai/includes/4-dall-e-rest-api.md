You can use a language-specific SDK (for example, the OpenAI Python SDK or the Azure OpenAI .NET SDK) to develop client applications that use models to generate images.

For example, the following Python code uses the OpenAI *Images* API to submit a request to a model to generate image of a robot eating a cheeseburger:

```python
# Generate an image
img_results = client.images.generate(
    model="FLUX.1-Kontext-pro",
    prompt="A robot eating a cheeseburger.",
    n=1,
    size="1024x1024",
)

# Save the generated image
image_data = base64.b64decode(img_results.data[0].b64_json)
with open("image.png", "wb") as image_file:
    image_file.write(image_data)
```

The result is a binary stream containing the requested image:

![A picture of a robot eating a cheeseburger.](../media/robot-eating-cheeseburger.png)
