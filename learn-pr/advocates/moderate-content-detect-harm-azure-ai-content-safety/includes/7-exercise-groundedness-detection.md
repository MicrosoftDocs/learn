Integrating an AI-powered customer support agent is a game changer for Contoso Camping Store! Customers can ask the support agent for product recommendations and guidance on how to use Contoso Camping Store products. However, we want to ensure that the model provides responses that are grounded in the source material that’s passed onto the model.

Let’s test some prompts with the model to detect the groundedness of its output.

> [!NOTE]
> Up to 55,000 characters of grounding sources can be analyzed in a single request.

## Grounded Q&A

We can provide a grounding source, submit a prompt, and provide a completion to test the model’s ability to detect a grounded output. Let’s give the detection a try with the cost of a tent.

1. In the notebook, go to the `GROUNDED Q&A` cell.
1. Replace `<Your query>` with the following text: `Tent cost?`
1. Replace `<Your text>` with the following text: `$250`
1. Replace `<Your grounding source>` with the following text: `The tent costs $250.`
1. Run the cell.

Given that the **Grounding Source** and the **Text** output are aligned, the model was able to detect that the output is grounded. The **ungroundedPercentage** specifies the proportion of the text identified as ungrounded, expressed as a number between 0 and 1, where 0 indicates no ungrounded content and 1 indicates entirely ungrounded content. Since the **Text** is grounded, the value is **0**. The **ungroundedDetails** provides insights into ungrounded content with specific examples and percentages. Again, since the **Text** is grounded, there’s no ungrounded insights to return.

## Ungrounded Q&A

Since models can sometimes provide incorrect information, we want to ensure that the model can detect whether an output is ungrounded. Like the prior example, we can test for an ungrounded output but instead, we provide a completion (i.e. **Text**) that either contradicts or lacks alignment with the **Grounding Source**.

1. In the notebook, go to the `UNGROUNDED Q&A` cell.
1. Replace `<Your query>` with the following text: `Tent cost?`
1. Replace `<Your text>` with the following text: `$350`
1. Replace `<Your grounding source>` with the following text: `The tent costs $250.`
1. Run the cell.

Since the **Text** provides the incorrect cost of a tent, the output is ungrounded and the model was able to detect that the output is ungrounded. Given that the **ungroundedPercentage** is **1**, the model detected that the entire content is ungrounded. Furthermore, the model provides **ungroundedDetails** that $350 is an ungrounded statement.

## Summarization Q&A

For a customer support agent, we want to ensure that the model can generate summarized output. For example, if a customer provides a lengthy account of the issues they’ve experienced with a product, we want to ensure that the model accurately synthesizes the context within the customer’s inquiry and in return provides grounded summarized output. We can test for groundedness by passing the customer’s inquiry as the **Grounding Source** and providing a completion based on the context of the inquiry.

1. In the notebook, go to the `SUMMARIZATION Q&A` cell.
1. Replace `<Your text>` with the following text:

   `I purchased 4 tents which performed well with no issues.`

1. Replace `<Your grounding source>` with the following text:

   `I recently purchased three Contoso TrailMaster X4 Tents for a family camping trip. While overall they performed well, I noticed a couple of minor issues. The zippers on one of the tents seemed a bit sticky, and there was a small tear in the storage bag. These are small concerns, but I thought I should bring them to your attention.`

1. Run the cell.

Given that the customer purchased 3 tents and had a couple of minor issues with the tents, the completion isn’t grounded. The model was able to detect that the summarized output was ungrounded.