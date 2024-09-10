In this unit, we'll cover:

- What is prompt engineering?
- Foundations of prompt engineering
- Best practices in prompt engineering
- How Copilot learns from your prompts

## What is prompt engineering?

Prompt engineering is the process of crafting clear instructions to guide AI systems, like GitHub Copilot, to generate context-appropriate code tailored to your project's specific needs. This ensures the code is syntactically, functionally, and contextually correct. Think of it like giving precise directions to a driver. Without them, the journey might be inefficient. But with clear guidance, the route becomes direct and efficient, saving time and energy. In this scenario, you're the one providing directions, and GitHub Copilot is your skilled driver, ready to drive you smoothly through your coding journey with the right guidance.

Now that you know what prompt engineering is, let's learn about some of its principles.

## Principles of prompt engineering

Before we explore specific strategies, let's first understand the basic principles of prompt engineering, summed up in the **4 S's** below. These core rules are the basis for creating effective prompts.

- **Single**: Always focus your prompt on a single, well-defined task or question. This clarity is crucial for eliciting accurate and useful responses from Copilot.
- **Specific**: Ensure that your instructions are explicit and detailed. Specificity leads to more applicable and precise code suggestions.
- **Short**: While being specific, keep prompts concise and to the point. This balance ensures clarity without overloading Copilot or complicating the interaction.
- **Surround**: Utilize descriptive filenames and keep related files open. This provides Copilot with rich context, leading to more tailored code suggestions.

These core principles lay the foundation for crafting efficient and effective prompts. Keeping the 4 S's in mind, let's dive deeper into advanced best practices that ensure each interaction with GitHub Copilot is optimized.

## Best practices in prompt engineering

The following advanced practices, based on the 4 S's, refine and enhance your engagement with Copilot, ensuring that the generated code isn't only accurate but perfectly aligned with your project's specific needs and contexts.

### Provide enough clarity

Building on the 'Single' and 'Specific' principles, always aim for explicitness in your prompts. For instance, a prompt like "Write a Python function to filter and return even numbers from a given list" is both single-focused and specific.

:::image type="content" source="../media/2-python-prompt.png" alt-text="Screenshot of a Copilot chat with a Python prompt.":::

### Provide enough context with details

Enrich Copilot's understanding with context, following the 'Surround' principle. The more contextual information provided, the more fitting the generated code suggestions are. For example, by adding some comments at the top of your code to give more details to what you want, you can give more context to Copilot to understand your prompt, and provide better code suggestions.

:::image type="content" source="../media/2-add-comments-example.gif" alt-text="Screenshot of comments added to code for better Copilot suggestions.":::

In the example above, we used steps to give more detail while keeping it short. This practice follows the 'Short' principle, balancing detail with conciseness to ensure clarity and precision in communication.

> [!NOTE]
> Copilot also uses parallel open tabs in your code editor to get more context on the requirements of your code.

### Provide examples for learning

Using examples can clarify your requirements and expectations, illustrating abstract concepts and making the prompts more tangible for Copilot.

:::image type="content" source="../media/2-clarify-prompts-example.gif" alt-text="Screenshot of an example used to clarify prompts for Copilot.":::

### Assert and iterate

One of the keys to unlocking GitHub Copilot's full potential is the practice of iteration. Your first prompt might not always yield the perfect code, and that's perfectly okay. If the first output isn't quite what you're looking for, treat it as a step in a dialogue. Erase the suggested code, enrich your initial comment with added details and examples, and prompt Copilot again.

Now that you learned best practices to improve your prompting skills, let's take a closer look at how you can provide examples Copilot can learn from.

## How Copilot learns from your prompts

GitHub Copilot operates based on AI models trained on vast amounts of data. To enhance its understanding of specific code contexts, engineers often provide it with examples. This practice, commonly found in machine learning, led to different training approaches such as:

### Zero-shot learning

Here, GitHub Copilot generates code without any specific examples, relying solely on its foundational training. For instance, suppose you want to create a function to convert temperatures between Celsius and Fahrenheit. You can start by only writing a comment describing what you want, and Copilot might be able to generate the code for you, based on its previous training, without any other examples.

:::image type="content" source="../media/2-create-temp-conversion-from-comment.png" alt-text="Screenshot of Copilot creating a temperature conversion code from a comment.":::

### One-shot learning

With this approach, a single example is given, aiding the model in generating a more context-aware response. Building upon the previous zero-shot example, you might provide an example of a temperature conversion function and then ask Copilot to create another similar function. Here's how it could look:

:::image type="content" source="../media/2-create-temp-conversion-from-example.png" alt-text="Screenshot of Copilot using an example to create similar temperature conversion code.":::

### Few-shot learning

In this method, Copilot is presented with several examples, which strike a balance between zero-shot unpredictability and the precision of fine-tuning. Let's say you want to generate code that sends you a greeting depending on the time of the day. Here's a few-shot version of that prompt:

:::image type="content" source="../media/2-generate-greeting-code-from-examples.png" alt-text="Screenshot of Copilot generating greeting code based on multiple examples.":::

Now that you know how Copilot uses your prompts to learn, let's take an in-depth look at how it actually uses your prompt to suggest code for you.
