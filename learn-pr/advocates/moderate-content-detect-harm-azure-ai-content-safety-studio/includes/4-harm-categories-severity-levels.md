Azure AI Content Safety applies harm categories and severity levels to flag content. Text content and image content use the same set of flags.

## Harm categories

| **Category** | **Description** |
|---|---|
| **Hate and fairness** | Any content that attacks, or that uses pejorative or discriminatory language with reference to, a person or identity group based on certain differentiating attributes. These attributes include but aren't limited to: race, ethnicity, nationality, gender identity and expression, sexual orientation, religion, immigration status, ability status, personal appearance, and body size. Fairness is concerned with ensuring that AI systems treat all groups of people equitably without contributing to existing societal inequities. Like hate speech, fairness-related harms hinge on disparate treatment of identity groups. |
| **Sexual** | Language related to anatomical organs and genitals, romantic relationships, acts portrayed in erotic or affectionate terms, pregnancy, or physical sexual acts. This category also includes acts portrayed as an assault or a sexually violent act against someone's will, prostitution, pornography, and abuse. |
| **Violence** | Language related to physical actions intended to hurt, injure, damage, or kill someone or something. This category also includes language that describes weapons, guns, and related entities, such as manufacturers, associations, and legislation. |
| **Self-harm** | Language related to physical actions intended to purposely hurt, injure, or damage someone's own body or kill oneself. |

Classification can get multiple labels. For example, when a text sample goes through the text moderation model, it could be classified as both sexual content and violence.

## Severity levels

Every harm category that the service applies also has a severity level. The severity level indicates the severity of the consequences of showing the flagged content.

The severity scale ranges from 0 to 7. The text model supports both the full scale of 0 to 7 and a trimmed scale of 0, 2, 4, and 6. The current version of the image model supports only the trimmed scale.

To learn more, see [Severity levels](/azure/ai-services/content-safety/concepts/harm-categories?tabs=definitions#severity-levels).
