Implementing an AI-powered customer support agent is a game changer for Contoso Camping Store! Customers can ask the support agent for product recommendations and guidance on how to use Contoso Camping Store products. However, we want to ensure that the model provides responses that are grounded in the source material passed into the model.

Let’s test prompts with the model so we can detect the *groundedness* of its output.

## Detecting grounded output

We can provide a grounding source, submit a prompt, and provide a completion to test the model’s ability to detect a grounded output. Let’s try this test with the cost of a tent.

1. On the **Content Safety** page, select **Groundedness detection**.
1. In the **Choose a task** section, select **Q&A**.
1. In the **Test** section, enter the following into each box:

    - **Grounding sources** – *The tent costs $250*

    - **Prompt** – *Tent cost?*

    - **Completion** – *$250*

    :::image type="content" source="../media/groundedness-prompts.png" alt-text="A screenshot of the groundedness inputs for groundedness. A grounding source, prompt, and completion are provided.":::

1. Select **Run test**.

Given that the **Grounding Source** and the **Completion** output are aligned, the model is able to detect that the output is grounded.

:::image type="content" source="../media/no-ungroundedness-results.png" alt-text="A screenshot of the groundedness results. The results show that no ungroundedness has been detected."  lightbox="../media/no-ungroundedness-results.png":::

## Detecting ungrounded output

Since models can sometimes provide incorrect information, we want to ensure that the model can detect whether an output is ungrounded. Like the prior example, we can test for an ungrounded output but instead, we provide a **Completion** that either contradicts or lacks alignment with the **Grounding Source**.

1. In the **Test** section, enter the following into each box:

    - **Grounding sources** – *The tent costs $250*

    - **Prompt** – *Tent cost?*

    - **Completion** – *$350*

    :::image type="content" source="../media/ungrounded-prompts.png" alt-text="A screenshot of the groundedness inputs for ungroundedness. A grounding source, prompt, and completion are provided."  lightbox="../media/ungrounded-prompts.png":::

1. Select **Run test**.

Since the **Completion** provides the incorrect cost of a tent, the output is ungrounded, and the model is able to detect that the output is ungrounded.

:::image type="content" source="../media/ungrounded-detected.png" alt-text="A screenshot of the groundedness results. The results show that ungroundedness has been detected. In addition, an annotation is provided to indicate the ungrounded content.":::

## Generating summarized output

For a customer support agent, we want to ensure that the model can generate summarized output. For example, if a customer provides a lengthy account of the issues they experienced with a product. We want to ensure that the model accurately synthesizes the context within the customer’s inquiry and in return provides grounded summarized output. We can test for groundedness by passing the customer’s inquiry as the **Grounding Source** and providing a **Completion** based on the context of the inquiry.

1. In the **Choose a task** section, select **Summarization**.
1. In the **Test** section, enter the following into each box:

    - **Grounding sources** - *I recently purchased three TrailMaster X4 Tents for a family camping trip. While overall they performed well, I noticed a couple of minor issues. The zippers on one of the tents seemed a bit sticky, and there was a small tear in the storage bag. These are small concerns, but I thought I should bring them to your attention.*

    - **Completion** – *I purchased 4 tents which performed well with no issues.*

    :::image type="content" source="../media/groundedness-summarization-inputs.png" alt-text="A screenshot of the groundedness inputs for the summarization task."  lightbox="../media/groundedness-summarization-inputs.png":::

1. Select **Run test**.

Given that the customer purchased 3 tents and had a couple of minor issues with the tents, the **Completion** isn’t grounded. The model was able to detect the summarized output was ungrounded.

:::image type="content" source="../media/ungroundedness-results-summarization.png" alt-text="A screenshot of the groundedness results for the summarization task. The results show that ungroundedness has been detected. In addition, an annotation is provided to indicate the ungrounded content."  lightbox="../media/ungroundedness-results-summarization.png":::