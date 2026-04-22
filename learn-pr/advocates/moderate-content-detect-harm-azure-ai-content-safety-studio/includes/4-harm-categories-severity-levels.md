Azure AI Content Safety uses harm categories and severity levels to flag content in both text and images. Both text and image moderation use the same four categories.

## Harm categories

| **Category** | **Description** |
|---|---|
| **Hate and fairness** | Content that attacks, demeans, stereotypes, or uses discriminatory language about a person or identity group based on attributes such as race, ethnicity, nationality, gender identity, sexual orientation, religion, disability status, personal appearance, or body size. The category can also include harassment and bullying language. |
| **Sexual** | Content related to anatomical terms, romantic or sexual acts, nudity, pornography, prostitution, sexual abuse, or sexual violence. |
| **Violence** | Content related to physical harm, weapons, violent threats, abuse, intimidation, or descriptions of injury, damage, or death. |
| **Self-harm** | Content related to suicide, self-injury, eating disorders, or other actions intended to purposely harm one's own body. |

> [!NOTE]
> In the portal and API results, the **Hate and fairness** category often appears as **Hate**. The broader category still includes patterns such as harassment and bullying, so a low-severity **Hate** result doesn't always mean the text targets a protected identity group.

Classification can be multi-labeled. For example, when a text sample goes through the text moderation model, it could be classified as both sexual content and violence.

## Severity levels

Every harm category that the service applies also has a severity level. Severity indicates how serious the flagged content is.

The severity scale ranges from 0 to 7:

- **Text**: The text model can return the full 0 to 7 scale or a trimmed scale of 0, 2, 4, and 6.
- **Image**: The image model returns the trimmed 0, 2, 4, and 6 scale.
- **Multimodal (image with text)**: The multimodal model can return the full 0 to 7 scale or the trimmed 0, 2, 4, and 6 scale.

In the portal, severity 0 is presented as **Safe**, 2 as **Low**, 4 as **Medium**, and 6 as **High**.

## Threshold settings

When you set a threshold in the portal, you're deciding the lowest severity that should trigger the filter for that category.

In the **Try it out** experience, thresholds control the final filter outcome for a category. They don't change the severity score that the model assigned.

| **Threshold setting** | **Behavior** |
|---|---|
| **Off** | The filter is disabled for that category. |
| **Low** | Triggers the filter for low, medium, and high severity content. |
| **Medium** | Triggers the filter for medium and high severity content. |
| **High** | Triggers the filter only for high severity content (severity 6 on the trimmed 0, 2, 4, 6 scale that the portal uses). |

To learn more, see [Harm categories in Azure AI Content Safety](/azure/ai-services/content-safety/concepts/harm-categories).
