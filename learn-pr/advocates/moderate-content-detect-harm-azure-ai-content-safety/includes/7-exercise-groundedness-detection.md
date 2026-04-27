Contoso Camping Store uses an AI-powered customer support agent to answer product questions and summarize customer issues. To make those responses trustworthy, we need to verify that model outputs are grounded in the source material we provide.

Let's test some model-style outputs to see how the API detects grounded and ungrounded responses.

> [!NOTE]
> Groundedness detection is currently a preview capability and supports English content only. Grounding sources can contain a total of up to **55,000** characters per request, while the query and generated text are each limited to **7,500** characters. For QnA tasks, use a query of at least three words.

> [!NOTE]
> This notebook uses the non-reasoning REST path (`reasoning: false`), so it only requires your Azure AI Content Safety resource. If you later enable reasoning, the official quickstart requires an Azure OpenAI GPT-4o deployment plus managed identity configuration.
>
> The sample notebook still uses the older `2024-02-15-preview` API version in the groundedness cells. Update those cells to `api-version=2024-09-15-preview` before you run them. The request body used in these non-reasoning examples still matches the current quickstart: QnA requests include `domain`, `task`, `qna`, `text`, `groundingSources`, and `reasoning`, while the summarization request omits `qna` and sets `task` to `Summarization`.

> [!NOTE]
> In production RAG systems, clearly identify the source material that you send to the model, and pass the same authoritative source text in `groundingSources` when you call groundedness detection. For guidance on marking retrieved documents in model prompts, see [Document embedding in prompts](/azure/ai-foundry/openai/concepts/content-filter-document-embedding#embedding-documents-in-your-prompt).

## Update the Groundedness detection cells

Before you run any groundedness cell, update the `url` assignment in the `GROUNDED Q&A`, `UNGROUNDED Q&A`, and `SUMMARIZATION Q&A` cells:

`url = f'{endpoint}/contentsafety/text:detectGroundedness?api-version=2024-09-15-preview'`

Leave `reasoning` set to `False` for this workshop. Setting `reasoning` to `True` requires the extra `llmResource` configuration, an Azure OpenAI GPT-4o deployment, and managed identity permissions described in the official quickstart.

## Grounded Q&A

We can provide a grounding source, submit a query, and provide a model-style completion to test whether the API treats the completion as grounded. Let's give the detection a try with the cost of a tent.

1. In the notebook, go to the `GROUNDED Q&A` cell.
1. Replace `<Your query>` with the following text: `How much does the tent cost?`
1. Replace `<Your text>` with the following text: `$250`
1. Replace `<Your grounding source>` with the following text: `The tent costs $250.`
1. Run the cell.

Because the **Text** matches the **Grounding Source**, the response should indicate that the output isn't ungrounded. In practice, `ungroundedDetected` should be `false`, and `ungroundedPercentage` should be **0**. The API isn't checking whether `$250` is generally true in the abstract; it's checking whether the output is supported by the grounding source you supplied. `ungroundedPercentage` isn't a confidence score; it represents how much of the generated text was identified as unsupported by the grounding source.

## Ungrounded Q&A

Because models can sometimes provide incorrect information, we want to ensure that the API can detect whether an output is ungrounded. Like the prior example, we can test for an ungrounded output but instead, we provide a completion (i.e. **Text**) that either contradicts or lacks alignment with the **Grounding Source**.

1. In the notebook, go to the `UNGROUNDED Q&A` cell.
1. Replace `<Your query>` with the following text: `How much does the tent cost?`
1. Replace `<Your text>` with the following text: `$350`
1. Replace `<Your grounding source>` with the following text: `The tent costs $250.`
1. Run the cell.

Because the **Text** contradicts the **Grounding Source**, the response should indicate ungrounded content. In this case, `ungroundedDetected` should be `true`, and `ungroundedPercentage` can reach **1** when the entire answer is unsupported. The `ungroundedDetails` array identifies the specific text segment that was flagged.

## Summarization Q&A

For a customer-support agent, we want to ensure that the model can generate summarized output. For example, if a customer provides a lengthy account of the issues they've experienced with a product, we want to ensure that the model accurately synthesizes the context within the customer's inquiry and returns a grounded summary. We can test for groundedness by passing the customer's inquiry as the **Grounding Source** and providing a completion based on the context of the inquiry.

1. In the notebook, go to the `SUMMARIZATION Q&A` cell.
1. Replace `<Your text>` with the following text:

   `I purchased 4 tents which performed well with no issues.`

1. Replace `<Your grounding source>` with the following text:

   `I recently purchased three Contoso TrailMaster X4 Tents for a family camping trip. While overall they performed well, I noticed a couple of minor issues. The zippers on one of the tents seemed a bit sticky, and there was a small tear in the storage bag. These are small concerns, but I thought I should bring them to your attention.`

1. Run the cell.

Given that the customer purchased three tents and had a couple of minor issues with the tents, the completion isn't grounded. The API flags the summarized output as ungrounded.

Although the notebook cell label includes **Q&A**, the request body for this example uses `task: "Summarization"` and doesn't include a `qna` object. For the latest setup guidance and request format, see [Quickstart: Use Groundedness detection (preview)](/azure/ai-services/content-safety/quickstart-groundedness) and [Groundedness detection concepts](/azure/ai-services/content-safety/concepts/groundedness).
