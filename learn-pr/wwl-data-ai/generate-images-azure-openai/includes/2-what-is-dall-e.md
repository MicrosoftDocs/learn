Microsoft Foundry supports multiple models that are capable of generating images, including (but not limited to):

- The OpenAI *gpt-image-1* series of models.
- The Black Forest Labs *FLUX* series of models.

> [!TIP]
> View the **[Model catalog](https://ai.azure.com/catalog/models?azure-portal=true)** for the full set of models available in Microsoft Foundry. In the Foundry portal you can filter by inference task to find *text to image* models.

Image generation models are generative AI model that can create graphical data from natural language input. Put more simply, you can provide the model with a description and it can generate an appropriate image.

For example, you might submit the following natural language prompt to an image generation model:

*A robot eating spaghetti*

This prompt could result in the generation of graphical output such as the following image:

![An illustration of a robot eating spaghetti.](../media/robot-eating-spaghetti.png)

The images generated are original; they aren't retrieved from a curated image catalog. In other words, the model isn't a search system for *finding* appropriate images - it is an artificial intelligence (AI) model that *generates* new images based on the data on which it was trained.
