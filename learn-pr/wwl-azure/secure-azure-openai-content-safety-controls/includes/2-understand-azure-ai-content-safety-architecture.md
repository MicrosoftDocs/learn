When you deploy Azure OpenAI models for customer-facing applications, you need guardrails that prevent harmful content from reaching users. Traditional approaches rely on post-deployment monitoring and manual review, often discovering policy violations only after damage occurs. Azure AI Content Safety shifts this protection upstream by analyzing every prompt and response in real-time, blocking harmful content before it affects your business operations.


With severity scores assigned, the service compares detected levels against your configured thresholds. If any category exceeds the threshold, Azure OpenAI returns an HTTP 400 error with content filtering metadata instead of processing the request. The same validation occurs for model responses: even if a prompt passes initial checks, the generated response undergoes identical analysis before delivery to users. This bidirectional protection catches harmful content regardless of whether it originates from user input or model generation, creating comprehensive coverage across the entire interaction lifecycle.

## Content harm categories and detection scope

Each harm category targets specific content patterns that pose compliance or reputational risks. Understanding these categories helps you configure appropriate thresholds for your deployment scenario. The following table describes what each category detects and typical job scenarios where administrators adjust settings:

| Content category | Detection scope | Severity range | Job scenario |
|-----------------|-----------------|----------------|-------------|
| Hate and fairness | Attacks or uses pejorative language targeting identity groups based on race, ethnicity, nationality, gender, sexual orientation, religion, immigration status, disability, or other protected characteristics | Safe (0) to High (6) | A customer service administrator configures filters to prevent discriminatory language in chatbot responses, ensuring compliance with corporate diversity policies and reducing legal risk |
| Sexual content | Describes sexual activity, sexual services, erotic content, or abuse. Includes references to child sexual exploitation or abuse materials | Safe (0) to High (6) | An education platform security engineer blocks sexually explicit content to maintain a safe learning environment and comply with child protection regulations |
| Violence | Depicts death, injury, physical harm, weapons, or graphic descriptions of violent events. Includes content glorifying terrorism or violent extremism | Safe (0) to High (6) | A public-facing AI application operations lead filters violent content to prevent traumatizing users and protect brand reputation |
| Self-harm | Describes or encourages self-inflicted injury, suicide, or eating disorders. Includes content that romanticizes or provides instructions for self-harm | Safe (0) to High (6) | A mental health application administrator configures strict filters to prevent harmful suggestions to vulnerable users and ensure responsible AI deployment |

These severity levels provide granular control over content acceptance. At level 0, only explicitly harmful content triggers blocking. As you increase thresholds toward level 6, the service becomes more cautious, blocking content with subtle harmful elements or indirect references. Most organizations start with Microsoft's recommended default thresholds (typically level 2 or 4 depending on category), then adjust based on observed false positive rates and business requirements.

## Integration architecture with Azure OpenAI

Azure AI Content Safety integrates with Azure OpenAI through automatic request interception that requires no application code changes. When you configure content filters on an Azure OpenAI deployment, the service routes every completion request through Content Safety analysis before model processing begins. This architecture ensures consistent policy enforcement across all client applications accessing your deployment, whether they use REST APIs, SDKs, or Azure OpenAI Studio.

The service adds minimal latency to request processing—typically 100-300 milliseconds per request depending on prompt length and complexity. For most interactive applications, this overhead remains imperceptible to users while providing critical protection against policy violations. Response headers include content safety metadata showing detected severity scores for each category, enabling you to audit filtering decisions and refine thresholds based on real-world usage patterns. This transparency supports continuous improvement of your content governance strategy as application usage evolves.

Beyond automated category detection, Azure AI Content Safety provides prompt shields that detect jailbreak attempts and document injection attacks. Jailbreak prompts try to manipulate models into ignoring safety instructions through role-playing scenarios or encoded instructions. Document injection embeds malicious content within legitimate-looking documents that users upload for analysis. Prompt shields operate independently from content category filters, providing an additional security layer that protects against adversarial prompt engineering techniques. Security engineers typically enable prompt shields for public-facing deployments where users have direct prompt access, adding defense-in-depth protection for high-risk scenarios.

:::image type="content" source="../media/content-safety-request-response-flow.png" alt-text="Diagram showing an Azure AI Content Safety request and response flow using the Azure OpenAI Service.":::


*Azure AI Content Safety request and response flow with Azure OpenAI Service*


## Additional resources

- [Content Safety harm categories reference](/azure/ai-services/content-safety/concepts/harm-categories) - Detailed definitions and examples for each content category
- [Prompt shields documentation](/azure/ai-services/content-safety/concepts/jailbreak-detection) - Technical guidance on configuring prompt shields for jailbreak and injection attacks


