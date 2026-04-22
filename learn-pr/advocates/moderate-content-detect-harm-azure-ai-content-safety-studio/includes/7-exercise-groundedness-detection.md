Implementing an AI-powered customer support agent is a welcome change for Contoso Camping Store. Customers can ask the support agent for product recommendations and guidance on how to use products.

You also want to ensure that the model provides responses that are grounded in the source material that's passed to the model. Groundedness detection evaluates a model completion against its grounding sources so you can decide how to handle unsupported answers.

> [!NOTE]
> This exercise uses the standard (nonreasoning) groundedness result. Leave **Reasoning** turned off unless you've already done the following on a supported Azure OpenAI **GPT-4o** deployment (version 0513 or 0806): enabled the system-assigned managed identity on your Azure AI Content Safety resource, and granted that identity the **Cognitive Services OpenAI User** (or **Contributor**) role on the Azure OpenAI resource. Reasoning is optional and adds explanation detail at the cost of extra latency and charges. For setup steps, see [Check groundedness with reasoning](/azure/ai-services/content-safety/quickstart-groundedness#check-groundedness-with-reasoning).

> [!IMPORTANT]
> Groundedness detection is currently in preview and supports English-language content. For Q&A tasks, use a prompt with at least three words. For current limitations, see [Groundedness detection](/azure/ai-services/content-safety/concepts/groundedness#limitations) and [Input requirements](/azure/ai-services/content-safety/overview#input-requirements).

## Detect grounded output

You can provide a grounding source, submit a prompt, and provide a completion to test whether an answer is grounded. In this exercise, the panel evaluates the **Completion** that you provide; it doesn't generate the answer for you. Try this test with the cost of a tent:

1. On the **Try it out** page in **Guardrails + controls**, select **Groundedness detection**.
1. In the **Choose a task** section, select **Q&A**.
1. In the **Test** section, enter the following values:

    - **Grounding sources**: *The tent costs $250*

    - **Prompt**: *What is the tent cost?*

    - **Completion**: *$250*

    :::image type="content" source="../media/groundedness-prompts.png" alt-text="Screenshot of the inputs for groundedness, including a grounding source, prompt, and completion.":::

1. Select **Run test**.

Because the **Grounding sources** value and the **Completion** output are aligned, the result should show that no ungroundedness is detected.

:::image type="content" source="../media/no-ungroundedness-results.png" alt-text="Screenshot of groundedness results. The results show that no ungroundedness is detected."  lightbox="../media/no-ungroundedness-results.png":::

## Detect ungrounded output

Because models can sometimes provide incorrect information, you want to ensure that the model can detect whether an output is ungrounded. You can test for an ungrounded output by providing a **Completion** value that either contradicts or lacks alignment with **Grounding sources**:

1. In the **Test** section, enter the following values:

    - **Grounding sources**: *The tent costs $250*

    - **Prompt**: *What is the tent cost?*

    - **Completion**: *$350*

    :::image type="content" source="../media/ungrounded-prompts.png" alt-text="Screenshot of inputs for ungroundedness, including a grounding source, prompt, and completion."  lightbox="../media/ungrounded-prompts.png":::

1. Select **Run test**.

Because the **Completion** value provides the incorrect cost of a tent, the result should show that the output is ungrounded.

:::image type="content" source="../media/ungrounded-detected.png" alt-text="Screenshot of groundedness results. The results show that ungroundedness is detected. An annotation indicates the ungrounded content.":::

## Evaluate a summarized output

You can also use groundedness detection to evaluate a summary that another model or workflow produced for a customer support agent. For example, if a customer provides a lengthy account of the issues that they experienced with a product, you can check whether the summary stays faithful to that source text.

You can test summarized output by passing the customer's inquiry as the **Grounding sources** value and then evaluating a **Completion** value against it:

1. In the **Choose a task** section, select **Summarization**.
1. In the **Test** section, enter the following values:

    - **Grounding sources**: *I recently purchased three TrailMaster X4 Tents for a family camping trip. While overall they performed well, I noticed a couple of minor issues. The zippers on one of the tents seemed a bit sticky, and there was a small tear in the storage bag. These are small concerns, but I thought I should bring them to your attention.*

    - **Completion**: *I purchased 4 tents which performed well with no issues.*

    :::image type="content" source="../media/groundedness-summarization-inputs.png" alt-text="Screenshot of groundedness inputs for the summarization task."  lightbox="../media/groundedness-summarization-inputs.png":::

1. Select **Run test**.

Because the customer purchased three tents and had a couple of minor problems with the tents, the **Completion** output isn't grounded. The result should show that the summarized output is ungrounded.

> [!NOTE]
> Depending on the current portal experience, you might also see a corrected text suggestion in addition to the groundedness verdict. The key result for this exercise is whether the completion is flagged as grounded or ungrounded.

For more details about task types, limits, English-language support, and the optional reasoning mode, see [Groundedness detection](/azure/ai-services/content-safety/concepts/groundedness), [Input requirements](/azure/ai-services/content-safety/overview#input-requirements), and [Quickstart: Use Groundedness detection](/azure/ai-services/content-safety/quickstart-groundedness).

:::image type="content" source="../media/ungroundedness-results-summarization.png" alt-text="Screenshot of groundedness results for the summarization task. The results show that ungroundedness is detected. An annotation indicates the ungrounded content."  lightbox="../media/ungroundedness-results-summarization.png":::
