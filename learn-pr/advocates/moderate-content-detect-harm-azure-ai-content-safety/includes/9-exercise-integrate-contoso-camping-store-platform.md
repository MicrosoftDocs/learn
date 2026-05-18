By using Azure AI Content Safety APIs, you can apply guardrails at multiple stages of the Contoso Camping Store experience instead of relying on a single check. A safer design combines the right API with app-side policy decisions.

For the final step of this workshop, think through how you would place each capability in the request and response flow:

1. Run **Prompt Shields** on incoming customer prompts and on retrieved manuals, emails, or support articles before you send them to an LLM.
1. Run **Analyze Text** and **Analyze Image** on user-generated reviews, chat messages, and uploaded images. Use thresholds that fit the workflow, and route borderline content to human review when needed.
1. Run **Groundedness detection** on completed model answers that rely on product manuals, knowledge base articles, or retrieved support content.
1. Run **Protected material text detection** on substantive AI-generated responses, marketing copy, or summaries before you show them to users. The feature is designed for AI-generated English text and has a default **110-character** minimum input length, so it isn't a replacement for user-input moderation. If your app generates code, evaluate the separate [protected material code detection](/azure/ai-services/content-safety/quickstart-protected-material-code) capability.

In production, the service results shouldn't act alone. Pair them with clear application behavior such as blocking, redacting, asking the user to revise content, or escalating to a reviewer. For more design guidance, see [Azure AI Content Safety overview](/azure/ai-services/content-safety/overview), [Prompt Shields](/azure/ai-services/content-safety/concepts/jailbreak-detection), [Groundedness detection](/azure/ai-services/content-safety/concepts/groundedness), and [Protected material detection](/azure/ai-services/content-safety/concepts/protected-material).
