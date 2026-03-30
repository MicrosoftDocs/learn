::: zone pivot="video"

>[!VIDEO https://learn-video.azurefd.net/vod/player?id=31a6ef3f-c017-47bc-907c-c8306e6a0e57]

> [!NOTE]
> See the **Text and images** tab for more details!

::: zone-end

::: zone pivot="text"

Vision capable models often match visual information in an image to appropriate corresponding text. Some models are designed to perform this process in reverse, generating images that correspond to text descriptions. 

## Using image generation models from Foundry 

Microsoft Foundry includes models that support text-to-image inferencing, which you can use to generate visual output. 

For most new projects, Microsoft recommends starting with the **GPT‑Image‑1 family**, especially GPT‑Image‑1.5, due to its improved quality, editing support, and enterprise readiness.

Common examples of image generation models in Foundry include: 

- **GPT‑Image‑1.5**: GPT‑Image‑1.5 is the latest and most advanced image generation model available in Microsoft Foundry. It's designed for high‑fidelity, enterprise‑grade image creation and editing, with strong prompt alignment and improved consistency across iterations. The model supports *text‑to‑image*, *image‑to‑image*, and precise image editing, making it well suited for branding, marketing, and design workflows where visual accuracy matters.

- **GPT‑Image‑1**: GPT‑Image‑1 is a powerful, general‑purpose image generation model that builds on the capabilities of earlier DALL-E models. It supports *text‑to‑image generation*, image variations, and precise image editing. It's commonly used for creative applications, prototyping, and visual content generation. GPT‑Image‑1 is widely supported across Foundry tools and APIs, including the Responses API and agent tools. 

- **GPT‑Image‑1‑Mini**: GPT‑Image‑1‑Mini is a lighter‑weight and more cost‑efficient version of GPT‑Image‑1. It supports the same core image generation tasks but is optimized for scenarios where lower latency or reduced cost is more important than maximum visual fidelity. This model is a good choice for experimentation, internal tools, or high‑volume image generation.

All of these image generation models can be:

- Deployed in a **Foundry (Azure OpenAI) resource**
- Tested in the **Foundry Playground**
- Accessed programmatically using the **OpenAI Responses API** or image generation APIs

>[!NOTE]
>You can also access third-party image generation models in Foundry. For example, *FLUX* is a family of open‑source image generation models created by Black Forest Labs. They're designed to produce high‑quality, photorealistic, and stylistically flexible images from text prompts. 

#### Image generation in the Foundry playground 

You can deploy a vision-enabled model and test it in the Foundry portal playground. To test the model, you can describe the image that you want to create. And after a few minutes, an image matching your description is generated. 

![Screenshot of image generation in the Foundry playground.](../media/image-generation-playground.png)

:::image type="content" source="../media/image-generation-playground-code.png" alt-text="Screenshot of code example in the Foundry playground." lightbox="../media/image-generation-playground-code.png":::

## Using the OpenAI Python SDK for image generation

You can write code to build an application that uses an image generation model using Azure OpenAI API's images class. The OpenAI images class in the **OpenAI Python SDK** lets you generate new images and edit existing images. You can use the OpenAI Python SDK by calling the OpenAI Images API endpoint through a Python interface.

The ability to dynamically generate original images from descriptions can be immensely valuable in scenarios that include media, publishing, and content creation. 

To generate images with the OpenAI Python SDK, you need: 

- **A Foundry resource**
- A **vision‑capable model deployed** (the deployment name is what you pass as `MODEL_NAME`) 
- **Authentication** via **API key** or **Microsoft Entra ID** 
- **OpenAI Responses API** calls that include *image input* (URL or base64 data URL)

>[!NOTE]
>**Base64** refers to files like images are binary (raw bytes). JSON and URLs are text‑only. Base64 encoding converts binary data into safe ASCII text, allows binary files to be embedded inside JSON or URLs.

For example, consider the following Python code: 

```python
import os
import base64
from openai import OpenAI

# Required environment variables (example names)
FOUNDRY_KEY="..."
ENDPOINT="https://YOUR-RESOURCE-NAME.openai.azure.com/openai/v1/"
MODEL_NAME="your-gpt-image-deployment-name"  # e.g., "gpt-image-1"

client = OpenAI(
    api_key=os.environ["FOUNDRY_KEY"],
    base_url=os.environ["ENDPOINT"],
)

prompt = "A modern flat illustration of a robot holding a potted plant, clean vector style, pastel colors."

response = client.responses.create(
    model=os.environ["MODEL_NAME"],  # your deployment name in Foundry
    input=prompt,
    tools=[{"type": "image_generation"}],
)

image_base64 = next(
    item.result for item in response.output
    if item.type == "image_generation_call"
)

with open("foundry_generated.png", "wb") as f:
    f.write(base64.b64decode(image_base64))

print("Saved: foundry_generated.png")
```

Next, learn how to use video generation models from Foundry.

::: zone-end