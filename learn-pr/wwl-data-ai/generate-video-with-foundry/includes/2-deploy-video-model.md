To generate videos from text prompts, you need to deploy a video generation model. **Sora 2** is an AI model from OpenAI that creates realistic and imaginative video scenes from text instructions, input images, or existing videos. Sora 2 is available in Microsoft Foundry and provides an all-in-one creative platform with superior video quality and intuitive controls.

## Prerequisites

Before deploying a Sora 2 model, ensure you have:

- An Azure subscription
- Access to the Microsoft Foundry portal
- A Foundry project where you have permissions to deploy models

## Deploy the Sora 2 model

To deploy a Sora 2 video generation model in Microsoft Foundry:

1. Go to the [Microsoft Foundry portal](https://ai.azure.com) and sign in with your credentials.
1. From the Foundry landing page, create or select a project.
1. Select **Build** from the navigation pane on the right.
1. Select **Models** from the left-hand menu to view the model catalog.
1. Use the search bar or filter options to find the **Sora-2** video generation model.
1. Select the **Sora-2** model then select **Deploy** and choose the appropriate deployment settings.

> [!TIP]
> To learn more about available models in Microsoft Foundry, see the **[Model catalog and collections in Microsoft Foundry portal](/azure/ai-foundry/how-to/model-catalog-overview)** article in the Microsoft Foundry documentation.

## Sora 2 capabilities

Sora 2 offers several powerful capabilities for video generation:

| Feature | Description |
|---------|-------------|
| **Text to video** | Generate videos from natural language text prompts |
| **Image to video** | Transform existing images into video content |
| **Video remix** | Make targeted adjustments to existing videos without regenerating from scratch |
| **Audio generation** | Supports audio generation in output videos |
| **Multiple resolutions** | Supports portrait (720×1280) and landscape (1280×720) formats |
| **Variable duration** | Generate videos of 4, 8, or 12 seconds |

Sora 2 enables you to create realistic and imaginative video content from text prompts, reference images, or by remixing existing videos. After deploying the model through the Foundry portal, you can use it to generate videos in various resolutions and durations. The model's versatility and ease of use make it a powerful tool for video creation, whether you're starting from scratch or enhancing existing media.
