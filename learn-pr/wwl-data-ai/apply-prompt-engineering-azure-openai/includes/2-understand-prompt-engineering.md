The quality of the input prompts we send to an AI model, like those available in Azure OpenAI, directly influences the quality of what we get back. By carefully constructing the prompts we send to the model, the model can provide better and more interesting responses.

## What is prompt engineering

Generative AI models trained on huge amounts of data and can generate text, images, code, and creative content based on the most likely continuation of the prompt.

Prompt engineering is the process of designing and optimizing prompts to better utilize AI models. Designing effective prompts is critical to the success of prompt engineering, and it can significantly improve the AI model's performance on specific tasks. Providing relevant, specific, unambiguous, and well structured prompts can help the model better understand the context and generate more accurate responses.

For example, if we want an OpenAI model to generate product descriptions, we can provide it with a detailed description that describes the features and benefits of the product. By providing this context, the model can generate more accurate and relevant product descriptions.

Prompt engineering can also help mitigate bias and improve fairness in AI models. By designing prompts that are diverse and inclusive, we can ensure that the model isn't biased towards a particular group or perspective.

> [!IMPORTANT]
> No matter how good of a prompt you can design, responses from AI models should never be taken as fact or completely free from bias. Always use AI responsibly. For more information, see Microsoft's [transparency note](/legal/cognitive-services/openai/transparency-note) on Azure OpenAI and [Microsoft's AI principles](https://www.microsoft.com/ai/responsible-ai).

In addition, prompt engineering can help us understand which references the model uses to generate its response. Generative AI models have a ton of parameters and the logic it follows is largely unknown to users, so it can be confusing how it arrives at the response it gives. By designing prompts that are easy to understand and interpret, we can help humans better understand how the model is generating its responses. This can be particularly important in domains such as healthcare, where it's critical to understand how the model is making decisions.

There are different methods to utilize when engineering your own prompts, many of which are covered in upcoming units of this module. These include providing instructions, contextual content, cues or few-shot examples, and correctly ordering content in your prompt. The methods covered here aren't exhaustive as this area is a nuanced and fluid topic.

## Considerations for API endpoints

The examples in the rest of this module will be focused on `ChatCompletion`. It's worth noting that `ChatCompletion` can also be used for non chat scenarios, where any instructions are included in the system message and user content is provided in the user role message. Most of these examples can be altered to use the `Completion` endpoint, if desired.

In terms of model availability, the `Completion` endpoint can be used with `gpt-3` and earlier, and `ChatCompletion` can be used with `gpt-35-turbo` and later models.

## Adjusting model parameters

In addition to techniques discussed in this module, adjusting parameters of the model can have a significant impact on the response. In particular, `temperature` and `top_p` (top_probability) are the most likely to impact a model's response as they both control randomness in the model, but in different ways.

Higher values produce more creative and random responses, but will likely be less consistent or focused. Responses expected to be fictional or unique benefit from higher values for these parameters, whereas content desired to be more consistent and concrete should use lower values.

Try adjusting these parameters with the same prompt to see how they impact the response. It's recommended to change either `temperature` or `top_p` at a time, but not both.
