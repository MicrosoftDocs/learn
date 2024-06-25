Every harm category the service applies also comes with a severity level rating. The severity level is meant to indicate the severity of the consequences of showing the flagged content. Both text and image content use the same set of flags.

## Harm categories

| **Category** | **Description** |
|---|---|
| **Hate and Fairness** | Hate and fairness-related harms refer to any content that attacks or uses pejorative or discriminatory language with reference to a person or identity group based on certain differentiating attributes of these groups including but not limited to race, ethnicity, nationality, gender identity and expression, sexual orientation, religion, immigration status, ability status, personal appearance, and body size. Fairness is concerned with ensuring that AI systems treat all groups of people equitably without contributing to existing societal inequities. Like hate speech, fairness-related harms hinge upon disparate treatment of identity groups. |
| **Sexual** | Sexual describes language related to anatomical organs and genitals, romantic relationships, acts portrayed in erotic or affectionate terms, pregnancy, physical sexual acts, including those portrayed as an assault or a forced sexual violent act against one's will, prostitution, pornography, and abuse. |
| **Violence** | Violence describes language related to physical actions intended to hurt, injure, damage, or kill someone or something; describes weapons, guns, and related entities, such as manufactures, associations, legislation, etc. |
| **Self-harm** | Self-harm describes language related to physical actions intended to purposely hurt, injure, damage one's body or kill oneself. |

Classification can be multi-labeled. For example, when a text sample goes through the text moderation model, it could be classified as both Sexual content and Violence.

## Severity levels

Every harm category the service applies also comes with a severity level rating. The severity level is meant to indicate the severity of the consequences of showing the flagged content. The severity scale ranges from 0-7. The text model supports both the full 0-7 and the trimmed scale of 0, 2, 4, and 6. The current version of the image model only supports the trimmed scale.

To learn more about Severity definitions, refer to [aka.ms/severity-levels](https://aka.ms/severity-levels).