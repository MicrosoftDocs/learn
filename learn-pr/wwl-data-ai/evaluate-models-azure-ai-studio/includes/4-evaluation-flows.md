When you want to create a custom copilot, you use prompt flow to develop the chat application. You can evaluate the performance of a copilot by evaluating the responses when running your flow.

## Test your flow with individual prompts

During active development, you can test the **chat flow** you're creating by using the **chat** feature when you have a compute session running:

:::image type="content" source="../media/chat-flow.png" alt-text="Screenshot of chatting within a prompt flow in the Azure AI Studio." lightbox="../media/chat-flow.png":::

When you test your flow with an individual prompt in the chat window, your flow runs with your provided input. After it successfully runs, a response is shown in the chat window. You can also explore the output of each individual node of your flow to understand how the final response was constructed:

:::image type="content" source="../media/chat-node-output.png" alt-text="Screenshot of the output of an individual node in a chat flow." lightbox="../media/chat-node-output.png":::

## Automatically test your flow with evaluation flows

To evaluate a chat flow in bulk, you can run **automated evaluations**. You can either use the built-in automated evaluations, or you can define your **custom** evaluations by creating your own evaluation flow. The built-in or Microsoft-curated metrics help you assess your flow's performance and quality, and risk and safety.

:::image type="content" source="../media/curated-evaluation.png" alt-text="Screenshot of the configuration of curated evaluations." lightbox="../media/curated-evaluation.png":::

To evaluate your chat flow with the built-in automated evaluations, you need to:

1. Create a test dataset.
1. Create a new automated evaluation in the Azure AI Studio.
1. Select a flow or a dataset with model generated outputs.
1. Select the metrics you want to evaluate on.
1. Run the evaluation flow.
1. Review the results.

> [!Tip]
> Learn more about [evaluation and monitoring metrics](/azure/ai-studio/concepts/evaluation-metrics-built-in?azure-portal=true)

Alternatively, you can create your own custom evaluation flow, in which you define how your chat flow's output should be evaluated. For example, you can evaluate the output using Python code or by using a Large Language Model (LLM) node to create an AI-assisted metric. After creating an evaluation flow, you can evaluate a chat flow by providing a test dataset and running the evaluation flow.

:::image type="content" source="../media/custom-evaluation-tool.png" alt-text="Screenshot of an evaluation flow in the Azure AI Studio." lightbox="../media/custom-evaluation-tool.png":::

> [!Tip]
> Learn how to [develop an evaluation flow in the Azure AI Studio.](/azure/ai-studio/how-to/flow-develop-evaluation?azure-portal=true)
