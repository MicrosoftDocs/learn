Before defining custom content filters or blocklists, first evaluate how Azure AI Foundry's **built-in guardrails** perform under different conditions.
The **Try it out** page in the **Guardrails + controls** workspace provides a safe environment to test moderation, Prompt Shields, groundedness detection, and protected-material detection before you apply them to live AI workloads.

:::image type="content" source="../media/try-it-out.png" alt-text="Screenshot showing the Try it out page in Azure AI Foundry with options to test moderation, groundedness, protected material, and Prompt Shields for text and image content." lightbox="../media/try-it-out.png":::

## Evaluate how protections respond to risk

The Try it out page lets you run built-in sample tests or enter your own text, code, or image examples.
Testing these guardrails helps you understand how Azure AI Foundry identifies and mitigates content-related risks so you can make informed decisions when designing custom controls.

You can:

- Review how harm categories like **violence**, **hate**, **sexual**, and **self-harm** are classified at different severity levels.
- Observe how **Prompt Shields** detect jailbreak or indirect prompt-injection attempts.
- Examine **groundedness** results to see when responses diverge from verified data sources.
- Test **protected-material detection** to surface reused or non-Microsoft text and code that could lead to data exposure.

Use these results to gauge the accuracy and strictness of each detection model.

## Explore built-in and custom test options

Each guardrail area includes sample content that demonstrates its safety model, and you can also add your own examples to explore different scenarios:

- **Moderate text content:** Evaluate how the system classifies and blocks text across harm categories.
- **Prompt Shields:** Test detection of jailbreak and indirect attack patterns.
- **Groundedness detection:** Identify ungrounded or fabricated model responses.
- **Protected-material detection:** Detect reused or non-original text or code.
- **Image and multimodal filters:** Assess how visual and combined inputs are moderated.
- **Custom categories:** Create and test organization-specific detection criteria.

Run a few tests in each area and observe how results change as you adjust thresholds or select different content types.

## Interpret the results

- Note which categories are triggered and how the system classifies them.
- Compare annotations and blocked outcomes to understand enforcement behavior.
- Keep in mind that custom blocklists and content filters aren't applied here; this page previews Microsoft's built-in safety models.
- Identify areas where refined rules, stricter thresholds, or tuned filters might be needed to align with organizational policies.

Testing built-in guardrails establishes a baseline for responsible model behavior.

By understanding this baseline first, you can design custom blocklists and content filters that extend Azure AI Foundry's protections and strengthen your organization's AI security posture.
