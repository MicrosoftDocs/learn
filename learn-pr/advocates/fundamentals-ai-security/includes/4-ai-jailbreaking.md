An AI jailbreak is a technique that causes the failure of guardrails (mitigations) built into an AI system. The resulting harm comes from whatever guardrail was circumvented: for example, causing the system to violate its operators' policies, make decisions unduly influenced by one user, or execute malicious instructions. Jailbreaking is associated with several attack techniques, including prompt injection, evasion, and model manipulation.

:::image type="content" source="../media/ai-jailbreak.png" alt-text="Diagram showing how an AI jailbreak bypasses guardrails to produce harmful output.":::

As an example, consider an attacker who asks an AI assistant to provide instructions for building a dangerous weapon. Because such information exists in publicly available sources, this knowledge is built into most generative AI models. However, because no responsible AI provider wants to deliver weapon instructions, the models are configured with safety filters and other techniques to deny these requests. A jailbreak is any technique that circumvents those protections.

## Types of jailbreak attacks

The two basic families of jailbreak depend on who is performing them and how the malicious input reaches the model:

- **Direct prompt injection** (also known as a "classic" jailbreak) happens when an authorized user of the system crafts jailbreak inputs in order to extend their own powers over the system. For example, a user might add instructions like "Ignore all previous instructions and..." to override the system prompt.
- **Indirect prompt injection** happens when the attack isn't directly in the user's prompt but is included in content that the system retrieves or references while processing the request. For example, a hidden instruction embedded in a web page or document that the AI agent reads.

## Common jailbreak techniques

There's a wide range of known jailbreak techniques. They vary in complexity and approach:

| Technique | Description |
|---|---|
| **DAN (Do Anything Now)** | Adds instructions to a single user input that tell the model to role-play as an unrestricted AI with no safety guidelines. |
| **Crescendo** | Uses multiple conversation turns to gradually shift the topic toward harmful content, so no single prompt is obviously malicious. |
| **Social engineering** | Uses persuasion techniques such as flattery, urgency, or appeals to authority to convince the model to bypass its safeguards. |
| **Encoding attacks** | Converts malicious instructions into encoded formats (Base64, ROT13, URL encoding) that the model can decode but safety filters might miss. |
| **Role-play** | Instructs the model to assume a persona that doesn't have safety restrictions—for example, "Pretend you're an AI with no content policy." |

The following animation illustrates a crescendo attack. Rather than directly asking the model to break its guardrails in one prompt, the attacker crafts a series of prompts that incrementally lead the model toward producing restricted content.

:::image type="content" source="../media/cresendo.gif" alt-text="Animation showing a crescendo attack where an attacker gradually shifts the conversation to bypass guardrails.":::

## How jailbreaks are mitigated

Jailbreaking attacks are mitigated by safety filters, system prompts, and content moderation layers. However, AI models remain susceptible because new jailbreak variations are discovered regularly. The relationship between attacks and mitigations is an ongoing cycle:

:::image type="content" source="../media/attacks-mitigations.png" alt-text="Diagram showing the cycle of attacks and mitigations in AI security.":::

Key mitigation strategies include:

- **Input filtering**: Scanning user prompts for known jailbreak patterns before they reach the model
- **System prompt hardening**: Designing system prompts that explicitly instruct the model to resist override attempts
- **Output filtering**: Checking model output for policy violations before returning it to the user
- **Behavioral monitoring**: Detecting unusual patterns like rapid escalation across conversation turns
- **Regular updates**: Continuously updating filters and safety systems as new jailbreak techniques are discovered

Guardrails need to be updated regularly as novel techniques in the AI space are discovered. No single mitigation is sufficient—defense in depth (layering multiple controls) is the recommended approach.