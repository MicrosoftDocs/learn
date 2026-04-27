The text and image moderation APIs return one or more harm categories and a severity level. Both APIs use the same four built-in moderation categories.

## Harm categories

| **Category** | **What it covers** | **API term** |
|---|---|---|
| **Hate and Fairness** | Attacks or discriminatory language about a person or identity group, including harassment and bullying. | `Hate` |
| **Sexual** | Sexual anatomy, romantic or sexual acts, nudity, pornography, abuse, and related content. | `Sexual` |
| **Violence** | Physical injury, weapons, intimidation, terrorism, stalking, and other violent acts. | `Violence` |
| **Self-harm** | Suicide, self-injury, and other forms of deliberate harm to oneself. | `SelfHarm` |

Classification can be multi-labeled. For example, a single text sample can be classified as both **Sexual** and **Violence**.

## Severity levels

The severity level indicates how serious the flagged content is for that category.

- **Text moderation** supports the full **0-7** scale when the caller requests `EightSeverityLevels`. If no output type is set, the API defaults to `FourSeverityLevels` and returns the trimmed **0, 2, 4, 6** scale. The workshop notebook doesn't set an output type, so expect the trimmed values in the exercises.
- **Image moderation** returns the trimmed **0, 2, 4, 6** scale.
- Higher scores usually call for stronger moderation action, but the right threshold depends on the scenario. A support workflow might review some nonzero results, while a public review system might block them immediately.

For the official severity definitions and examples, see [Harm categories in Azure AI Content Safety](/azure/ai-services/content-safety/concepts/harm-categories?tabs=definitions#severity-levels).
