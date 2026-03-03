The most accessible way to optimize a model's performance is through **prompt engineering**. Prompt engineering is the process of designing and refining prompts to improve the quality, accuracy, and relevance of the responses a language model generates. It requires no additional infrastructure or training data, and you can start experimenting immediately.

## Understand prompt components

When you interact with a language model, the quality of your question directly influences the quality of the response. A well-constructed prompt helps the model understand what you need and generate a more useful answer.

Prompts for chat completion models typically include the following components:

- **System message**: Instructions that define the model's behavior, role, and constraints.
- **User message**: The question or input from the user.
- **Assistant message**: Previous model responses, used in multi-turn conversations.
- **Examples**: Sample input/output pairs that demonstrate the expected response format.

How you structure and combine these components determines how effectively the model responds.

## Design effective system messages

A **system message** is a set of instructions you provide to the model to guide its responses. System messages typically appear first in the conversation and act as the highest-level set of instructions. You use them to:

- Define the assistant's role and boundaries.
- Set the tone and communication style.
- Specify output formats, such as JSON or bullet points.
- Add safety and quality constraints for your scenario.

A system message can be as simple as:

```text
You are a helpful AI assistant.
```

Or it can include detailed rules and formatting requirements. For example, the travel agency's chat application could use:

```text
You are a friendly travel advisor for Margie's Travel.
Answer only questions related to travel, hotels, and trip planning.
Use a warm, conversational tone.
If you don't have enough information to answer, ask a clarifying question.
Format hotel recommendations as a bulleted list with the hotel name, location, and price range.
```

> [!IMPORTANT]
> A system message influences the model but doesn't guarantee compliance. You should test and iterate on your system messages, and layer them with other mitigations like content filtering and evaluation.

When designing a system message, follow this checklist:

1. **Start with the assistant's role**: State the role and the expected outcome for a typical request.
1. **Define boundaries**: List the topics, actions, and content types the assistant should avoid.
1. **Specify the output format**: If you need a specific format, state it plainly and keep it consistent.
1. **Add a "when unsure" policy**: Tell the model what to do when the user's request is ambiguous, out of scope, or when the model lacks information.

## Apply prompt patterns

Effective prompts use patterns that help the model produce better responses. Here are some common patterns you can use:

### Persona pattern

Instruct the model to take on a specific perspective or role. For example, asking the model to respond as a seasoned marketing professional produces different results than using no persona at all.

| | No persona | With persona |
|---|---|---|
| **System message** | *None* | You're a seasoned marketing professional writing for technical customers. |
| **User prompt** | Write a one-sentence description of a CRM product. | Write a one-sentence description of a CRM product. |
| **Response** | A CRM product is a software tool designed to manage a company's interactions with customers. | Experience seamless customer relationship management with our CRM, designed to streamline operations and drive sales growth with robust analytics. |

### Format template pattern

Provide a template or structure in your prompt to get output in a specific format. For example, if you need a structured response about a hotel:

```text
Format the result to show:
- Hotel name
- Location
- Star rating
- Price range per night
```

This pattern ensures consistent, organized responses that are easy to parse in your application.

### Chain-of-thought pattern

Ask the model to explain its reasoning step by step. This technique, called **chain of thought**, reduces the chance of inaccurate results and makes it easier to verify the model's logic.

For example, instead of asking "Which hotel is best for a family of four?", you can prompt:

```text
Which hotel is best for a family of four? Take a step-by-step approach: 
consider room size, amenities for children, location, and price.
```

A related technique is to **break the task down** into explicit sub-steps *before* the model responds, rather than asking it to reason through everything at once. For example, you might first ask the model to extract key facts from a passage, and then in a follow-up prompt ask it to answer a question based on those facts. Decomposing the work this way reduces errors on complex, multi-part tasks.

> [!NOTE]
> Chain-of-thought prompting is a technique for non-reasoning models. Reasoning models like o-series models handle step-by-step logic internally.

### Few-shot learning pattern

Provide one or more examples of the desired input and output to help the model identify the pattern you want. This technique is called **few-shot learning** (or **one-shot** for a single example). When no examples are provided, it's called **zero-shot** learning.

For example, to classify customer inquiries:

```text
Classify the following customer messages:

Message: "I need to change my flight to Rome"
Category: Booking change

Message: "What's the weather like in Bali in March?"
Category: Travel information

Message: "Can I get a refund for my cancelled tour?"
Category:
```

The model learns the classification pattern from the examples and correctly completes the last entry.

### Use clear syntax and delimiters

When your prompt includes multiple sections — such as instructions, source text, and examples — use delimiters like `---`, Markdown headings, or XML tags to separate them. Clear boundaries help the model distinguish instructions from content and reduce the chance of misinterpretation.

> [!TIP]
> Models can be susceptible to **recency bias**, meaning text near the end of a prompt can have more influence than text at the beginning. If the model isn't following your instructions consistently, try repeating the key instruction at the end of the prompt.

## Configure model parameters

Beyond the text of your prompts, you can adjust model parameters that control how the model generates responses:

- **Temperature**: Controls the randomness of the output. A higher value (for example, 0.7) produces more creative and varied responses, while a lower value (for example, 0.2) produces more focused and deterministic responses. Use lower values for factual tasks and higher values for creative ones.
- **Top_p**: Also controls randomness, but in a different way. It limits the model to a subset of the most probable next tokens. For example, a `top_p` of 0.9 means the model considers only the top 90% of probable tokens.

> [!TIP]
> The general recommendation is to adjust either temperature or top_p, not both at the same time.

For the travel agency scenario, you might use a low temperature (0.2) when answering factual questions about hotel amenities, but a higher temperature (0.7) when generating creative travel itinerary suggestions.

## When prompt engineering is enough

Prompt engineering is the right starting point for any model optimization effort. It's effective when you need to:

- Guide the model's tone, format, and behavior.
- Provide specific instructions for a task.
- Quickly iterate on results without infrastructure changes.
- Keep costs low, as no additional training or data storage is required.

However, prompt engineering has limits. If the model doesn't have access to the information it needs (like your company's hotel catalog), or if it consistently fails to maintain a specific behavior despite detailed instructions, you need to consider additional strategies.
