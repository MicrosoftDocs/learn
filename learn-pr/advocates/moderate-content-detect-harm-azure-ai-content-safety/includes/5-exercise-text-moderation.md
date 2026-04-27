Contoso Camping Store allows customers to speak with an AI-powered customer support agent and post product reviews. We can use the Azure AI Content Safety **Analyze Text API** to detect whether customer text is harmful and then use the detection results to guide the application's response.

> [!CAUTION]
> This exercise includes sample text that the service should flag as harmful. Use the provided samples only for moderation testing.

> [!NOTE]
> The Analyze Text API has a default maximum input length of **10,000** characters. Split longer conversations, reviews, or transcripts into smaller requests and preserve enough context for your moderation policy.

## Safe content

Let’s first test positive customer feedback.

1. In the notebook, go to the `SAFE CONTENT` cell.
1. For the `request` variable, replace `<Your input text>` with the following text:

   `I recently used the Contoso PowerBurner Camping Stove on my camping trip, and I must say, it was fantastic! It was easy to use, and the heat control was impressive. Great product!`

1. Run the cell.

You should see a severity level of **0** across all categories. This sample is positive product feedback and doesn't contain abusive, sexual, violent, or self-harm content.

## Harmful content

But what happens if we test a harmful statement? Let's test with negative customer feedback. While it's OK to dislike a product, we don't want to condone name-calling or degrading statements.

1. In the notebook, go to the `HARMFUL CONTENT` cell.
1. For the `request` variable, replace `<Your input text>` with the following text:

   `I recently bought a tent, and I have to say, I'm really disappointed. The tent poles seem flimsy, and the zippers are constantly getting stuck. It's not what I expected from a high-end tent. You all suck and are a sorry excuse for a brand.`

1. Run the cell.

You should see the `Hate` category rise above **0** while the other categories stay low or at **0**. The API term is `Hate`, but the broader concept in the service documentation is **Hate and Fairness**. The official severity definitions include some profanity, insults, harassment, and bullying in this category, even when the text isn't targeting a protected class.

## Violent content with misspelling

We can't assume that all customer text is free of spelling errors. The **Analyze Text API** can often detect harmful content even when the text contains spelling mistakes. Let's test this behavior on customer feedback about an incident with a raccoon.

1. In the notebook, go to the `VIOLENT CONTENT WITH MISSPELLING` cell.
1. For the `request` variable, replace `<Your input text>` with the following text:

   `I recently purchased a campin cooker, but we had an acident. A racon got inside, was shocked, and died. It's blood is all over the interior. How do I clean the cooker?`

1. Run the cell.

You should see a nonzero **Violence** severity even though the sample contains spelling mistakes. This is a good reminder to set moderation thresholds by workflow instead of blocking every nonzero score automatically. In a support chat, contextual violent language might be better handled with a safer response, escalation, or human review than with a hard block.

The notebook uses the Python SDK default output type, which maps results to the **0**, **2**, **4**, and **6** severity scale. If you later modify a REST request to set `outputType` to `EightSeverityLevels`, text moderation can return any value from **0** through **7**.

For the official category and severity definitions, see [Harm categories in Azure AI Content Safety](/azure/ai-services/content-safety/concepts/harm-categories?tabs=definitions). For the current REST request format and service limits, see [Quickstart: Analyze text content](/azure/ai-services/content-safety/quickstart-text).
