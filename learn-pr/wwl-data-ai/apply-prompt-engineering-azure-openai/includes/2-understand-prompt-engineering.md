The quality of the input prompts we send to LLMs, like those available in Azure OpenAI, directly influences the quality of what we get back. By carefully constructing the prompts we send to the model, the model can provide better and more interesting responses.

## What is prompt engineering

LLMs are single models trained on huge amounts of data and can generate text, images, code, and creative content based on the most likely continuation of the prompt.

Prompt engineering is the process of designing and optimizing prompts to better utilize LLMs. Designing effective prompts is critical to the success of prompt engineering, and it can significantly improve the AI model's performance on specific tasks. Providing relevant, specific, unambiguous, and well structured prompts can help the model better understand the context and generate more accurate responses.

For example, if we want an OpenAI model to generate product descriptions, we can provide it with a detailed description that describes the features and benefits of the product. By providing this context, the model can generate more accurate and relevant product descriptions.

Prompt engineering can also help mitigate bias and improve fairness in AI models. By designing prompts that are diverse and inclusive, we can ensure that the model isn't biased towards a particular group or perspective.

> [!IMPORTANT]
> No matter how good of a prompt you can design, responses from AI models should never be taken as fact or completely free from bias. Always use AI responsibly. For more information, see Microsoft's [transparency note](/legal/cognitive-services/openai/transparency-note) on Azure OpenAI and [Microsoft's AI principles](https://www.microsoft.com/ai/responsible-ai).

In addition, prompt engineering can help us understand which references the model uses to generate its response. LLMs have a ton of parameters and the logic it follows is largely unknown to users, so it can be confusing how it arrives at the response it gives. By designing prompts that are easy to understand and interpret, we can help humans better understand how the model is generating its responses. This can be particularly important in domains such as healthcare, where it's critical to understand how the model is making decisions.

There are different methods to utilize when engineering your own prompts, many of which are covered in upcoming units of this module. These include providing instructions, contextual content, cues or few-shot examples, and correctly ordering content in your prompt. The methods covered here aren't exhaustive as this area is a nuanced and fluid topic.

## Considerations for API endpoints

Before exploring how prompt engineering can improve the output of Azure OpenAI models, it's important to consider how the different endpoints can utilize the methods discussed in this module. While both `Completion` and `ChatCompletion` can both achieve similar results, `ChatCompletion` provides the most flexibility in building your prompts, and is optimized for chat scenarios.

Functionally, `ChatCompletion` has the option of defining a system message for the AI model, in addition to built-in structure to provide previous messages in the prompt. If using `Completion`, this functionality can be achieved with what's called a *meta prompt*. These topics are covered in more detail in a later unit.

In terms of model availability, both endpoints can utilize similar models, including `gpt-35-turbo`, but only `ChatCompletion` can be used with `gpt-4` generation models.

The `Completion` endpoint can still achieve similar results, but more care must be taken to format the prompt clearly for the AI model to understand. Most of the examples given in this module clearly translate to `ChatCompletion`, however you can reformat it for use with `Completion`.

It's worth noting that `ChatCompletion` can also be used for non chat scenarios, where any instructions are included in the system message and user content is provided in the user role message.

## Adjusting model parameters

In addition to techniques discussed in this module, adjusting parameters of the model can have a significant impact on the response. In particular, `temperature` and `top_p` (top_probability) are the most likely to impact a model's response as they both control randomness in the model, but in different ways.

Higher values produce more creative and random responses, but will likely be less consistent or focused. Responses expected to be fictional or unique benefit from higher values for these parameters, whereas content desired to be more consistent and concrete should use lower values.

Try adjusting these parameters with the same prompt to see how they impact the response. It's recommended to change either `temperature` or `top_p` at a time, but not both.
