Azure AI Content Safety helps you assess harmful user-generated and AI-generated content in applications and services. In this module, you use the following capabilities to add guardrails to the Contoso Camping Store platform:

- **Analyze text API**: Scans text for the four built-in moderation categories: Hate, Sexual, Violence, and SelfHarm.
- **Analyze image API**: Scans images against the same four moderation categories.
- **Prompt Shields**: Detects prompt attacks in user prompts and in documents that you send to an LLM as grounding data.
- **Groundedness detection (preview)**: Checks whether an LLM response is supported by the source material you provide.
- **Protected material text detection**: Scans AI-generated text for matches to known protected text such as song lyrics, articles, recipes, and selected web content.

The APIs return analysis results; they don't decide your application's final policy action. Your app still needs clear thresholds and behaviors, such as allowing, blocking, redacting, asking the user to revise, or routing content to human review.

Text and image moderation share the same harm categories, but feature availability varies by region. In addition, groundedness detection and protected material text detection currently work with English content only. Content Safety also isn't a replacement for every specialized safety workflow; for example, the service overview notes that it can't be used to detect illegal child exploitation images. For the latest limits, language support, and region support, see [What is Azure AI Content Safety?](/azure/ai-services/content-safety/overview).
