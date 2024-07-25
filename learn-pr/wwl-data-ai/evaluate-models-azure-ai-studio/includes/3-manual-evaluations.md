Manual evaluations are a crucial part of assessing the performance and quality of your AI models. They provide insights that automated metrics might miss, such as context relevance and user satisfaction. This unit will guide you through the process of manually evaluating your models using the Chat Playground and the Manual Evaluations feature in Azure AI Studio.

## Evaluate with individual prompts

When you are just starting with prompt engineering or working with small datasets, you can use the **chat playground** in Azure AI Studio for manual evaluations. Here's how you can use it:

- **Access the chat playground**: Open Azure AI Studio and navigate to the chat playground. This is where you can experiment with different prompts and inputs to see how your model responds.
- **Generate manual Evaluation Results**: In the Chat Playground, select the Manual Evaluation option to begin the process of manually reviewing the model responses based on your test data and prompt. Your prompt is automatically transitioned to your Manual Evaluation, and you can add test data to evaluate the prompt against. This can be done manually using the text boxes in the Input column or by importing a dataset in CSV or JSONL format1.

Rate Model Responses: Once you have generated the responses, you can manually rate them based on various criteria such as relevance, coherence, and fluency. This helps you understand how well your prompt is performing and allows you to iterate on your prompt to improve its effectiveness1.

Iterate and Reevaluate: Use the insights gained from your manual evaluations to refine your prompts and model configurations. You can save and compare results to track your progress over time2.

## Evaluate larger datasets of prompts

For larger datasets and more comprehensive evaluations, the **manual evaluations** feature in Azure AI Studio allows you to work more efficiently and in bulk. Here's how you can leverage this feature:

- **Access Manual Evaluations in Azure AI Studio**: Navigate to the Manual Evaluations section in Azure AI Studio. This feature is designed to help you evaluate your model's performance on a larger scale.
- **Import and Map Data**: You can import your datasets in CSV or JSONL format and map the columns appropriately. This allows you to evaluate a larger number of inputs simultaneously, making the process more efficient3.
- **Evaluate and Rate in Bulk**: With the data imported, you can manually review and rate the model's responses in bulk. This is particularly useful for spot-checking small datasets and tracking progress on specific issues3.

Automated Evaluations: While manual evaluations are essential for detailed assessments, Azure AI Studio also supports automated evaluations for measuring quality and safety at scale. This includes traditional machine learning metrics and AI-assisted evaluations, which can provide more comprehensive results and ongoing monitoring.

:::image type="content" source="../media/manual-evaluations.png" alt-text="Screenshot of manual evaluations in the Azure AI Studio.":::

By combining manual evaluations with automated tools, you can ensure a thorough and efficient evaluation process for your AI models. This approach helps you maintain high standards of quality and safety while continuously improving your models' performance.