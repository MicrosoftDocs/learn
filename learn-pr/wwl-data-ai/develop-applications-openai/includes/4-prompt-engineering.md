The quality of the input prompts we send to an AI model, like those available in Azure OpenAI, directly influences the quality of what we get back. By carefully constructing the prompts we send to the model, the model can provide better and more interesting responses.

## What is prompt engineering

Prompt engineering is the process of designing and optimizing prompts to better utilize AI models. Designing effective prompts is critical to the success of prompt engineering, and it can significantly improve the AI model's performance on specific tasks. Providing relevant, specific, unambiguous, and well structured prompts can help the model better understand the context and generate more accurate responses.

For example, if we want an OpenAI model to generate product descriptions, we can provide it with a detailed description that describes the features and benefits of the product. By providing this context, the model can generate more accurate and relevant product descriptions.

Prompt engineering can also help mitigate bias and improve fairness in AI models. By designing prompts that are diverse and inclusive, we can ensure that the model isn't biased towards a particular group or perspective.

> [!IMPORTANT]
> No matter how good of a prompt you can design, responses from AI models should never be taken as fact or completely free from bias. Always use AI responsibly. For more information, see Microsoft's [transparency note](/legal/cognitive-services/openai/transparency-note) on Azure OpenAI and [Microsoft's AI principles](https://www.microsoft.com/ai/responsible-ai).

In addition, prompt engineering can help us understand which references the model uses to generate its response. Generative AI models have a ton of parameters and the logic it follows is largely unknown to users, so it can be confusing how it arrives at the response it gives. By designing prompts that are easy to understand and interpret, we can help humans better understand how the model is generating its responses. This can be particularly important in domains such as healthcare, where it's critical to understand how the model is making decisions.

There are different methods to utilize when engineering your own prompts. These include providing instructions, contextual content, cues or few-shot examples, and correctly ordering content in your prompt. The methods covered here aren't exhaustive as this area is a nuanced and fluid topic.

### Considerations for API endpoints

The examples in the rest of this unit will be focused on `ChatCompletion`. It's worth noting that `ChatCompletion` can also be used for non chat scenarios, where any instructions are included in the system message and user content is provided in the user role message. Most of these examples can be altered to use the `Completion` endpoint, if desired.

In terms of model availability, the `Completion` endpoint can be used with `gpt-3` and earlier, and `ChatCompletion` can be used with `gpt-35-turbo` and later models.

### Adjusting model parameters

In addition to techniques discussed in this unit, adjusting parameters of the model can have a significant impact on the response. In particular, `temperature` and `top_p` (top_probability) are the most likely to impact a model's response as they both control randomness in the model, but in different ways.

Higher values produce more creative and random responses, but will likely be less consistent or focused. Responses expected to be fictional or unique benefit from higher values for these parameters, whereas content desired to be more consistent and concrete should use lower values.

Specifically, high `temperature` allows for more variation in sentence structure and high `top_p` allows for more variation in words that are used (using a variety of synonyms).

Try adjusting these parameters with the same prompt to see how they impact the response. It's recommended to change either `temperature` or `top_p` at a time, but not both.

## Write effective prompts

Azure OpenAI models are capable of generating responses to natural language queries with remarkable accuracy. However, the quality of the responses depends largely on how well the prompt is written. Developers can optimize the performance of Azure OpenAI models by using different techniques in their prompts, resulting in more accurate and relevant responses.

### Provide clear instructions

Asking the Azure OpenAI model clearly for what you want is one way to get desired results. By being as descriptive as possible, the model can generate a response that most closely matches what you're looking for.

For example, say you want to create a product description for a new water bottle. Consider the answer associated with each prompt:

**Prompt**

```code
Write a product description for a new water bottle
```

**Response**

```code
Introducing the latest addition to our product line - the innovative and eco-friendly water bottle.
Made from high-quality, BPA-free materials, this bottle is designed to keep your beverages at the
perfect temperature for hours. Its sleek and stylish design makes it the perfect accessory for any
outdoor activity or workout session. With its convenient carrying handle and leak-proof lid, you 
can take it with you wherever you go, without worrying about spills or leaks. Plus, its easy-to-clean
design ensures that you can use it again and again, making it the perfect choice for anyone looking 
for a reliable and sustainable water bottle.
```

Versus a similar prompt, with clear instructions.

**Prompt**

```code
Write a product description for a new water bottle that is 100% recycled. Be sure to include that
it comes in natural colors with no dyes, and each purchase removes 10 pounds of plastic from our 
oceans
```

**Response**

```code
Introducing our newest water bottle, the eco-friendly choice for the conscious consumer. Made from 
100% recycled materials and available in natural colors with no dyes, this bottle is not only 
stylish but also sustainable. Each purchase of this bottle removes 10 pounds of plastic from 
our oceans, making it a responsible choice for those who care about the environment. Its durable 
and leak-proof design makes it perfect for outdoor activities, while its easy-to-carry handle 
makes it convenient to take on the go. Join us in our mission to reduce plastic waste and choose 
this eco-friendly water bottle for your daily hydration needs.
```

Including specifics that need to be included lets the model know what information to add to the description, making it more accurate to the new product.

This method can be extrapolated to include complex instructions, such as a bulleted list of details to include, length of response, or desired formats to be included in the output. Try asking for exactly what you want to see in the result, and you may be surprised at how well the model satisfies your request.

### Format of instructions

How instructions are formatted can impact how the model interprets the prompt. Recency bias can affect models, where information located towards the end of the prompt can have more influence on the output than information at the beginning. You may get better responses by repeating the instructions at the end of the prompt and assessing how that affects the generated response.

This recency bias can also come into play when using `ChatCompletion` in a chat scenario, where more recent messages in the conversation included in the prompt have a greater impact on the response.

### Primary, supporting, and grounding content

Including content for the model to use in its response allows the model to answer with greater accuracy. This content can be thought of in two ways: primary and supporting content.

Primary content refers to content that is the subject of the query, such as a sentence to translate or an article to summarize. This content is often included at the beginning or end of the prompt (as an instruction and differentiated by `---` blocks), with instructions explaining what to do with it.

For example, say we have a long article that we want to summarize. We could put it in a `---` block in the prompt, then end with the instruction.

```code
---
<insert full article here, as primary content>
---

Summarize this article and identify three takeaways in a bulleted list
```

Supporting content is content that may alter the response, but isn't the focus or subject of the prompt. Examples of supporting content include things like names, preferences, future date to include in the response, and so on. Providing supporting content allows the model to respond more completely, accurately, and be more likely to include the desired information.

For example, given a very long promotional email, the model is able to extract key information. If you then add supporting content to the prompt specifying something specific you're looking for, the model can provide a more useful response. In this case the email is the primary content, with the specifics of what you're interested in as the supporting content

```code
---
<insert full email here, as primary content>
---
<the next line is the supporting content>
Topics I'm very interested in: AI, webinar dates, submission deadlines

Extract the key points from the above email, and put them in a bulleted list:
```

Grounding content allows the model to provide reliable answers by providing content for the model to draw answers from. Grounding content could be an essay or article that you then ask questions about, a company FAQ document, or information that is more recent than the data the model was trained on. If you need more reliable and current responses, or you need to reference unpublished or specific information, grounding content is highly recommended.

Grounding content differs from primary content as it's the source of information to answer the prompt query, instead of the content being operated on for things like summarization or translation. For example, when provided an unpublished research paper on the history of AI, it can then answer questions using that grounding content.

```code
---
<insert unpublished paper on the history of AI here, as grounding content>
---

Where and when did the field of AI start?
```

This grounding data allows the model to give more accurate and informed answers that may not be part of the dataset it was trained on.

### Cues

Cues are leading words for the model to build upon, and often help shape the response in the right direction. They are often used with instructions, but not always. Cues are particularly helpful if prompting the model for code generation. Code generation is covered in more depth in a subsequent unit.
