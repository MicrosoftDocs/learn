Prompts are conversational cues you give to large language models (LLMs), shaping responses based on your queries or instructions. For example, you can prompt LLMs to convert a sentence from English to French, or to generate a summary of a text. 

In the previous unit, you created the prompt as the input string:

```c#
    string input = @"I'm a vegan in search of new recipes. I love spicy food! 
    Can you give me a list of breakfast recipes that are vegan friendly?";
```

In this prompt, you provide content to the language model along with the instructions. The content helps the model generate results that are more relevant to the user.

Prompting involves crafting clear, context rich instructions to guide the model to generate a desired response. To craft an effective prompt, precision and clarity are key. You may need to experiment and adjust your prompts for accurate results. 

## Use examples to guide the model

You can include examples in your prompts to help guide the response. The examples can come before or after the instructions. Prompt examples are classified as zero-shot learning or few-shot learning based on whether they contain verbatim completions. A verbatim completion is a specific, predefined example of a response that is included in the prompt. It demonstrates exactly what kind of answer is expected from the AI, word for word. These examples make it easier for the AI to mimic the structure, style, or tone of the provided completions.

### Zero-shot learning

With zero-shot learning, you include the instructions but exclude verbatim completions. Zero-shot prompts rely on the model's existing knowledge to generate a response. Zero-shot prompts are useful when you want a general answer or when the task is straightforward and doesn't require much guidance. Zero-shot prompting is also less resource-intensive since it relies on existing knowledge.

Here's an example of a zero-shot prompt that tells the model to evaluate user input, determine the user's intent, and preface the output with "Intent: ".

```c#
string prompt = $"""
Instructions: What is the intent of this request?
If you don't know the intent, don't guess; instead respond with "Unknown".
Choices: SendEmail, SendMessage, CompleteTask, CreateDocument, Unknown.
User Input: {request}
Intent: 
""";
```

### Few shot learning

With few-shot learning, you include verbatim completions in your prompt to help guide the model's response. Typically one to five examples are included. The examples demonstrate the structure, style, or type of response you want. Few-shot learning produces more tokens and also causes the model to update its knowledge. Few-shot prompting is especially valuable for reducing ambiguity and aligning results with the desired outcome.

Here's an example of a few-shot prompt that tells the model to evaluate user input, determine the user's intent, and preface the output with "Intent: ".

```c#
string prompt = $"""
Instructions: What is the intent of this request?
If you don't know the intent, don't guess; instead respond with "Unknown".
Choices: SendEmail, SendMessage, CompleteTask, CreateDocument, Unknown.

User Input: Can you send a very quick approval to the marketing team?
Intent: SendMessage

User Input: Can you send the full update to the marketing team?
Intent: SendEmail

User Input: {request}
Intent:
""";
```

## Use personas in prompts

Assigning personas in prompts is a technique used to guide the model to adopt a specific point of view, tone, or expertise when generating responses. Personas allow you to tailor the output to better suit the context or audience of the task. This is useful when you need the response to simulate a profession or reflect a tone of voice. To assign a persona, you should clearly describe the role definition in your prompt.

Here's an example of a prompt that assigns a persona:

```c#
string prompt = $"""
You are a highly experienced software engineer. Explain the concept of asynchronous programming to a beginner.
""";
```

## Chain of thought prompting

With chain of thought prompting, you prompt the model to perform a task step-by-step and to present each step and its result in order in the output. This can simplify prompt engineering by offloading some execution planning to the model, and makes it easier to isolate any problems to a specific step so you know where to focus further efforts. You can instruct the model to include its chain of thought, or you can use examples to show the model how to break down tasks.

Here's an example that instructs the model to describe the step-by-step reasoning:

```c#
string prompt = $"""
A farmer has 150 apples and wants to sell them in baskets. Each basket can hold 12 apples. If any apples remain after filling as many baskets as possible, the farmer will eat them. How many apples will the farmer eat?
Instructions: Explain your reasoning step by step before providing the answer.
""";
```

Here's an example that describes the steps to complete to the model:

```c#
prompt = $"""
Instructions: A farmer has 150 apples and wants to sell them in baskets. Each basket can hold 12 apples. If any apples remain after filling as many baskets as possible, the farmer will eat them. How many apples will the farmer eat?

First, calculate how many full baskets the farmer can make by dividing the total apples by the apples per basket:
1. 

Next, subtract the number of apples used in the baskets from the total number of apples to find the remainder: 
1.

"Finally, the farmer will eat the remaining apples:
1.
""";
```

The output of this prompt should resemble the following:

```output
Divide 150 by 12 to find the number of full baskets the farmer can make: 150 / 12 = 12.5 full baskets
The farmer can make 12 full baskets with 12 apples each.
Multiply 12 full baskets by 12 apples per basket to find the number of apples used in the baskets: 12 * 12 = 144 apples
Subtract the number of apples used in the baskets from the total number of apples: 150 - 144 = 6 apples
The farmer will eat 6 remaining apples.
```

## Tips for crafting prompts

- **Specific Inputs Yield Specific Outputs**: LLMs respond based on the input they receive. Crafting clear and specific prompts is crucial to get the desired output.

- **Experimentation is Key**: You may need to iterate and experiment with different prompts to understand how the model interprets and generates responses. Small tweaks can lead to significant changes in outcomes.

- **Context Matters**: LLMs consider the context provided in the prompt. You should ensure that the context is well-defined and relevant to obtain accurate and coherent responses.

- **Handle Ambiguity**: Bear in mind that LLMs may struggle with ambiguous queries. Provide context or structure to avoid vague or unexpected results.

- **Length of Prompts**: While LLMs can process both short and long prompts, you should consider the trade-off between brevity and clarity. Experimenting with prompt length can help you find the optimal balance.

Crafting effective prompts requires clarity, precision, and thoughtful design. Techniques like zero-shot and few-shot learning, persona assignments, and chain-of-thought prompting can enhance the quality and relevance of the responses. By providing clear instructions, well-defined context, and examples when needed, you can guide the model to generate finely tuned relevant responses. Remember to experiment and refine your prompts to achieve the best results.