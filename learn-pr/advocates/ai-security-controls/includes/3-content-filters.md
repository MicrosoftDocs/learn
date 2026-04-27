AI content filters are systems designed to detect and prevent harmful or inappropriate content from being generated or processed by AI systems. They work by evaluating both input prompts and output completions, using classification models to identify specific categories of problematic content. Content filters are one of the most important frontline defenses in any AI deployment.

## How content filters work

Content filters operate at two points in the AI interaction pipeline:

- **Input filtering**: Analyzes user prompts before they reach the model. Input filters detect prompt injection attempts, jailbreak instructions, and requests for harmful content before the model processes them.
- **Output filtering**: Analyzes the model's response before it's delivered to the user. Output filters catch harmful, inappropriate, or policy-violating content that the model might generate despite input-level controls.

Most content filtering systems use a combination of rule-based pattern matching, trained classification models, and configurable severity thresholds. Administrators can typically adjust the sensitivity of filters for different content categories based on their application's requirements.

## Core content filter capabilities

When evaluating or implementing a content filtering solution for an AI system, look for these capabilities:

- **Text moderation**: Detects and filters harmful content in text, such as hate speech, violence, self-harm content, or inappropriate language, before it reaches users.
- **Image moderation**: Analyzes images to identify and block content that may be unsafe or offensive, including explicit material and violent imagery.
- **Multimodal analysis**: Evaluates content across multiple formats—text, images, and combinations—to ensure comprehensive coverage. This is especially important for models that accept and generate multiple content types.
- **Factual grounding verification**: Validates that AI-generated responses are grounded in the source materials provided, detecting and flagging claims that aren't supported by the referenced data. This capability helps reduce instances where the AI generates factually inaccurate content.
- **Input attack detection**: Analyzes incoming prompts to detect and block prompt injection attacks, jailbreak attempts, and malicious instructions embedded in referenced documents. This is a critical defense against the prompt-based attacks described in the previous module.
- **Copyright protection**: Scans model outputs for content that could potentially violate copyright by matching against known protected material, such as published text, lyrics, or news articles.
- **Agent action oversight**: Monitors AI agent tool use to detect when an agent's actions are misaligned, unintended, or premature in the context of a user interaction—ensuring the agent only performs actions the user authorized.
- **Usage monitoring and analytics**: Tracks moderation activity, flags trends in harmful content attempts, and provides dashboards to help security teams identify emerging risks.

## Configuring content filters effectively

Content filters need to be tuned for the specific context of each application:

- **Set appropriate severity thresholds**: A customer-facing chatbot for children requires stricter filtering than an internal research tool. Configure thresholds based on your audience and use case.
- **Balance safety and usability**: Overly aggressive filtering can block legitimate content and frustrate users. Monitor false positive rates and adjust settings to maintain usability.
- **Layer filters with other controls**: Content filters are most effective as part of a defense-in-depth approach. Combine them with system prompts (metaprompts), input validation, and output monitoring.
- **Review and update regularly**: New attack techniques emerge frequently. Update filter rules and retrain classification models to keep pace with evolving threats.

Most major AI platforms provide built-in content filtering capabilities. For example, Azure AI Content Safety implements many of these capabilities through features like Prompt Shields, Groundedness Detection, and Protected Material Detection. Other platforms offer similar functionality—the key is to evaluate the capabilities against your specific requirements regardless of the platform you choose.

:::image type="content" source="../media/content-filtering.png" alt-text="Screenshot of guardrail protection and failure modes showing content filtering in action.":::

:::image type="content" source="../media/content-filter-pipeline.png" alt-text="Diagram of the input and output content filtering pipeline for AI systems." lightbox="../media/content-filter-pipeline.png":::