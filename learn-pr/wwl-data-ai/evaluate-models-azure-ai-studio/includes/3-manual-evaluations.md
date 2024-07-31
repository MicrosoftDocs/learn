During the early phases of the development of your custom copilot, you want to experiment and iterate quickly. To easily assess whether your selected language model and custom copilot, created with prompt flow, meet your requirements, you can manually evaluate models and flows in the Azure AI Studio.

Even when your model and copilot are already in production, manual evaluations are a crucial part of assessing performance. As manual evaluations are done by humans, they can provide insights that automated metrics might miss.

Let's explore how you can manually evaluate your selected models and custom copilots in the Azure AI Studio.

## Prepare your test prompts

To begin the manual evaluation process, it's essential to prepare a diverse set of test prompts that reflect the range of queries and tasks your copilot is expected to handle. These prompts should cover various scenarios, including common user questions, edge cases, and potential failure points. By doing so, you can comprehensively assess the copilot's performance and identify areas for improvement.

## Test the selected model in the chat playground

When you develop a custom copilot, you use a language model to generate a response. You create a custom copilot by developing a prompt flow that encapsulates your chat application's logic, which can use multiple language models to ultimately generate a response to a user question.

Before you test your custom copilot's response, you can test the selected language model's response to verify the individual model works as expected. You can test a model you deployed in the Azure AI Studio by interacting with it in the **chat playground**.

:::image type="content" source="../media/chat-playground.png" alt-text="Screenshot of the chat playground in the Azure AI Studio." lightbox="../media/chat-playground.png":::

The chat playground is ideal for early development. You can enter a prompt, see how the model responds, and tweak the prompt or system message to make improvements. After applying the changes, you can test a prompt again to evaluate whether the model's performance indeed improved.

## Evaluate multiple prompts with manual evaluations

The chat playground is an easy way to get started. When you want to manually evaluate multiple prompts more quickly, you can use the **manual evaluations** feature. This feature allows you to upload a dataset with multiple questions, and optionally add an expected response, to evaluate the model's performance on a larger test dataset.

:::image type="content" source="../media/manual-evaluations.png" alt-text="Screenshot of manual evaluations in the Azure AI Studio." lightbox="../media/manual-evaluations.png":::

You can rate the model's responses with the thumbs up or down feature. Based on the overall rating, you can try to improve your model by changing input prompt, the system message, the model, or the model's parameters.

When you use manual evaluations, you can more quickly evaluate the model's performance based on a diverse test dataset and improve the model based on the test results.

After manually evaluating an individual model, you can integrate the model into a chat application with prompt flow. Any flow you create with prompt flow can also be evaluated manually or automatically. Next, let's explore the evaluation of flows.
