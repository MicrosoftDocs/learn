After you deploy a model to an endpoint, you can interact with the model to explore how it behaves. When you want the model to be customized to your use case, there are several optimization strategies you can apply to improve the model's performance. Let's explore the various strategies.

## Chat with a model in the playground

You can interact with your model's endpoint by making an API call to the endpoint using your preferred coding language, or by chatting with the model in the playground of the Azure AI Studio. The chat playground is a quick and easy way to experiment and improve your model performance.

:::image type="content" source="../media/chat-playground.png" alt-text="Screenshot showing the chat playground in the Azure AI Studio.":::

The quality of the questions you send to the language model, directly influences the quality of the responses you get back. You can carefully construct your question, or **prompt**, to receive better and more interesting responses. The process of designing and optimizing prompts to improve the model's performance is also known as **prompt engineering**. When an end-user provides relevant, specific, unambiguous, and well-structured prompts, the model can better understand the context and generate more accurate responses.

### Apply prompt engineering

When you're chatting with the model in the playground, you can apply several prompt engineering techniques to explore whether it improves the model's output.

:::image type="content" source="../media/chat-with-model.png" alt-text="Screenshot showing a question to a language model and a response.":::

Let's explore some techniques an end-user can use to apply prompt engineering:

- Provide clear instructions: Be specific about the output you want.
    :::image type="content" source="../media/clear-instructions.png" alt-text="Screenshot of a question with clear instructions, making the answer more specific to the use case.":::
- Format your instructions: Use headers and delineators to make your question easier to read.
    :::image type="content" source="../media/format-instructions.png" alt-text="Screenshot of a question formatted to make it clear what the translated text should be.":::
- Use cues: Define how the model should start its response.
    :::image type="content" source="../media/use-cues.png" alt-text="Screenshot of a question with a cue, which then assistant's answer starts with.":::

### Update the system message

In the chat playground, you can view the JSON of your current conversation by selecting **Show JSON**:

:::image type="content" source="../media/chat-json.png" alt-text="Screenshot showing the JSON output of a conversation in the chat playground.":::

The shown JSON is the input data to your model endpoint every time you send a new message. The **system message** is always part of the input data. While not being visible to end-users, the system message allows you as a developer to customize the model's behavior by providing instructions for its behavior.

Some common prompt engineering techniques to apply as a developer by updating the system message are:

- Use one or few shot(s): Provide one or more examples to help the model identify a desired pattern.
    :::image type="content" source="../media/use-shots.png" alt-text="Screenshot of a system message with examples.":::
- Use chain-of-thought: Guide the model to reason step-by-step by instructing it to think through the task.
    :::image type="content" source="../media/chain-of-thought.png" alt-text="Screenshot of chain-of-thought reasoning.":::
- Add context: Enhance the model's factuality by providing additional context or background information relevant to the task.
    :::image type="content" source="../media/add-context.png" alt-text="Screenshot of option to add data for context.":::

## Apply model optimization strategies

As a developer, you can also apply other optimization strategies to improve the model's performance, without having to ask the end-user to write specific prompts. Next to prompt engineering, the strategy you choose depends on your requirements:

:::image type="content" source="../media/model-optimization.png" alt-text="Diagram showing the various strategies to optimize the model's performance.":::

- **Optimize for context**: When the model lacks contextual knowledge and you want to **maximize responses accuracy**.
- **Optimize the model**: When you want to improve the response format, style, or speech by **maximizing consistency of behavior**.

To optimize for context, you can apply a **Retrieval Augmented Generation** (**RAG**) pattern. With RAG, you *ground* your data by first retrieving context from a data source before generating a response. For example, you want customers to ask questions about hotels that you're offering in your travel booking catalog.

When you want the model to respond in a specific style or format, you can instruct the model to do so by adding guidelines in the system message. When you notice the model's behavior is not consistent, you can further enforce this by **fine-tuning** a model. With fine-tuning you train a base language model on a dataset before integrating it in your application.

You can also use a combination of optimization strategies, like RAG *and* a fine-tuned model, to improve your language application.
