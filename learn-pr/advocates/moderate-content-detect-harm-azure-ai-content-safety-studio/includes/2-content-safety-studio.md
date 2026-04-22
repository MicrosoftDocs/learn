Azure AI Content Safety detects harmful user-generated and AI-generated content in applications and services. The features in Azure AI Content Safety help Contoso Camping Store moderate reviews, uploaded images, and AI-generated responses before they reach customers.

Azure AI Content Safety offers several capabilities that work well together:

- **Text moderation**: Detects harmful text across the hate and fairness, sexual, violence, and self-harm categories.
- **Image moderation**: Analyzes images for the same categories by using image-specific severity scores.
- **Multimodal content analysis (preview)**: Evaluates images together with embedded or accompanying text when both modalities affect the moderation decision.
- **Groundedness detection (preview)**: Checks whether a model completion is supported by the grounding sources you provide. Your app can then decide whether to allow, warn on, revise, or block the response.
- **Prompt Shields**: Analyzes user prompts and supporting documents for direct and indirect prompt attacks before the model generates a response.
- **Protected material detection**: Scans AI-generated text for known protected content such as lyrics, articles, recipes, and selected web content.

This module focuses on the Content Safety **Try it out** experience in Azure AI Foundry, specifically text moderation, image moderation, groundedness detection, Prompt Shields, and code export. For details about the portal experience used in these exercises, see [Content Safety in the Microsoft Foundry portal (classic)](/azure/foundry-classic/ai-services/content-safety-overview). If you want to explore protected material detection separately, use the official [quickstart for protected material detection](/azure/ai-services/content-safety/quickstart-protected-material) and the broader [Azure AI Content Safety overview](/azure/ai-services/content-safety/overview).
