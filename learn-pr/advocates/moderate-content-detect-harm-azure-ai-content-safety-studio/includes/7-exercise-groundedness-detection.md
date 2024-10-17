Implementing an AI-powered customer support agent is a welcome change for Contoso Camping Store. Customers can ask the support agent for product recommendations and guidance on how to use products.

You want to ensure that the model provides responses that are grounded in the source material that's passed in to the model. You can test prompts with the model and determine the *groundedness* of the output.

## Detect grounded output

You can provide a grounding source, submit a prompt, and provide a completion to test the model's ability to detect a grounded output. Try this test with the cost of a tent:

1. On the **Content Safety** page, select **Groundedness detection**.
1. In the **Choose a task** section, select **Q&A**.
1. In the **Test** section, enter the following values:

    - **Grounding sources**: *The tent costs $250*

    - **Prompt**: *Tent cost?*

    - **Completion**: *$250*

    :::image type="content" source="../media/groundedness-prompts.png" alt-text="Screenshot of the inputs for groundedness, including a grounding source, prompt, and completion.":::

1. Select **Run test**.

Because the **Grounding sources** value and the **Completion** output are aligned, the output is grounded. The model detects that the output is grounded.

:::image type="content" source="../media/no-ungroundedness-results.png" alt-text="Screenshot of groundedness results. The results show that no ungroundedness is detected."  lightbox="../media/no-ungroundedness-results.png":::

## Detect ungrounded output

Because models can sometimes provide incorrect information, you want to ensure that the model can detect whether an output is ungrounded. You can test for an ungrounded output by providing a **Completion** value that either contradicts or lacks alignment with **Grounding sources**:

1. In the **Test** section, enter the following values:

    - **Grounding sources**: *The tent costs $250*

    - **Prompt**: *Tent cost?*

    - **Completion**: *$350*

    :::image type="content" source="../media/ungrounded-prompts.png" alt-text="Screenshot of inputs for ungroundedness, including a grounding source, prompt, and completion."  lightbox="../media/ungrounded-prompts.png":::

1. Select **Run test**.

Because the **Completion** value provides the incorrect cost of a tent, the output is ungrounded. The model detects that the output is ungrounded.

:::image type="content" source="../media/ungrounded-detected.png" alt-text="Screenshot of groundedness results. The results show that ungroundedness is detected. An annotation indicates the ungrounded content.":::

## Generate summarized output

You want to ensure that the model can generate summarized output for a customer support agent. For example, if a customer provides a lengthy account of the issues that they experienced with a product, you want to ensure that the model accurately synthesizes the context within the customer's inquiry and provides grounded summarized output.

You can test for groundedness by passing the customer's inquiry as the **Grounding sources** value and providing a **Completion** value based on the context of the inquiry:

1. In the **Choose a task** section, select **Summarization**.
1. In the **Test** section, enter the following values:

    - **Grounding sources**: *I recently purchased three TrailMaster X4 Tents for a family camping trip. While overall they performed well, I noticed a couple of minor issues. The zippers on one of the tents seemed a bit sticky, and there was a small tear in the storage bag. These are small concerns, but I thought I should bring them to your attention.*

    - **Completion**: *I purchased 4 tents which performed well with no issues.*

    :::image type="content" source="../media/groundedness-summarization-inputs.png" alt-text="Screenshot of groundedness inputs for the summarization task."  lightbox="../media/groundedness-summarization-inputs.png":::

1. Select **Run test**.

Because the customer purchased three tents and had a couple of minor problems with the tents, the **Completion** output isn't grounded. The model detects that the summarized output is ungrounded.

:::image type="content" source="../media/ungroundedness-results-summarization.png" alt-text="Screenshot of groundedness results for the summarization task. The results show that ungroundedness is detected. An annotation indicates the ungrounded content."  lightbox="../media/ungroundedness-results-summarization.png":::
