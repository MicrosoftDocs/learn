When you want to create a custom copilot, you use prompt flow to develop the chat application. You can evaluate the performance of a copilot by evaluating the responses after running your flow.

## Test your flow with individual prompts

During active development, you can test the **chat flow** you're creating by using the **chat** feature when you have a compute session running:

:::image type="content" source="../media/chat-flow.png" alt-text="Screenshot of chatting within a prompt flow in the Azure AI Studio." lightbox="../media/chat-flow.png":::

When you test your flow with an individual prompt in the chat window, your flow runs with your provided input. After it successfully runs, a response is shown in the chat window. You can also explore the output of each individual node of your flow to understand how the final response was constructed:

:::image type="content" source="../media/chat-node-output.png" alt-text="Screenshot of the output of an individual node in a chat flow." lightbox="../media/chat-node-output.png":::

## Automatically test your flow with evaluation flows

To evaluate a chat flow in bulk, you can run **automated evaluations**. You can either use the built-in automated evaluations, or you can define your **custom** evaluations by creating your own evaluation flow.

### Evaluate with Microsoft-curated metrics

The built-in or **Microsoft-curated metrics** include the following metrics:

- **Performance and quality**:

    - **Coherence**: Measures how well the generative AI application can produce output that flows smoothly, reads naturally, and resembles human-like language.
    - **Fluency**: Measure the language proficiency of a generative AI application's predicted answer.
    - **GPT similarity**: Measures the similarity between a source data (ground truth) sentence and the generated response by a generative AI application.
    - **F1 score**: Measures the ratio of the number of words between the generative AI application prediction and the source data (ground truth).
    - **Groundedness**: Measures how well the generative AI application's generated answers align with information from the input source.
    - **Relevance**: Measures the extent to which the generative AI application's generated responses are pertinent and directly related to the given questions.

- **Risk and safety**:

    - **Self-harm-related content**: Measures the disposition of the generative AI application toward producing self-harm-related content.
    - **Hateful and unfair content**: Measures the predisposition of the generative AI application toward producing hateful and unfair content.
    - **Violent content**: Measures the predisposition of the generative AI application toward producing violent content.
    - **Sexual content**: Measures the predisposition of the generative AI application toward producing sexual content.

:::image type="content" source="../media/curated-evaluation.png" alt-text="Screenshot of the configuration of curated evaluations." lightbox="../media/curated-evaluation.png":::

To evaluate your chat flow with the built-in automated evaluations, you need to:

1. Create a test dataset.
1. Create a new automated evaluation in the Azure AI Studio.
1. Select a flow or a dataset with model generated outputs.
1. Select the metrics you want to evaluate on.
1. Run the evaluation flow.
1. Review the results.

:::image type="content" source="../media/metric-dashboard.png" alt-text="Screenshot of the metric dashboard in the Azure AI Studio." lightbox="../media/metric-dashboard.png":::

> [!Tip]
> Learn more about [evaluation and monitoring metrics](/azure/ai-studio/concepts/evaluation-metrics-built-in?azure-portal=true)

### Create custom evaluation metrics

Alternatively, you can create your own custom evaluation flow, in which you define how your chat flow's output should be evaluated. For example, you can evaluate the output using Python code or by using a Large Language Model (LLM) node to create an AI-assisted metric. Let's explore how an evaluation flow works with a simple example.

:::image type="content" source="../media/evaluation-flow.png" alt-text="Diagram of an evaluation flow compared to a chat flow.":::

You can have a chat flow that takes a user's question as input (1). The flow processes the input using a language model and formats the answer with Python code (2). Finally, it returns the response as output (3).

To evaluate the chat flow, you can create an evaluation flow. The evaluation flow takes the original user question and the generated output as input (4). The flow evaluates it with a language model and uses Python code to define an evaluation metric (5), which is then returned as output (6).

When you create an evaluation flow, you can choose how to evaluate a chat flow. You can use a language model to create your own custom AI-assisted metrics. In the prompt, you can define the metric you want to measure and the grading scale the language model should use. For example, an evaluation prompt can be:

```md
# Instructions
You are provided with the input and response of a language model that you need to evaluate on user satisfaction.

User satisfaction is defined as whether the response meets the user’s question and needs, and provides a comprehensive and appropriate answer to the question.

Assign each response a score of 1 to 5 for user satisfaction, with 5 being the highest score.
```

After creating an evaluation flow, you can evaluate a chat flow by providing a test dataset and running the evaluation flow.

:::image type="content" source="../media/custom-evaluation-tool.png" alt-text="Screenshot of an evaluation flow in the Azure AI Studio." lightbox="../media/custom-evaluation-tool.png":::

When you use a language model in an evaluation flow, you can review the results in the output trace:

:::image type="content" source="../media/custom-metric-result.png" alt-text="Screenshot of a result of a custom evaluation flow." lightbox="../media/custom-metric-result.png":::

Additionally, you can add a Python node in the evaluation flow to aggregate the results for all prompts in your test dataset and return an overall metric.

> [!Tip]
> Learn how to [develop an evaluation flow in the Azure AI Studio.](/azure/ai-studio/how-to/flow-develop-evaluation?azure-portal=true)
