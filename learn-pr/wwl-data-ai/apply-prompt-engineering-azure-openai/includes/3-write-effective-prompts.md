Azure OpenAI models are capable of generating responses to natural language queries with remarkable accuracy. However, the quality of the responses depends largely on how well the prompt is written. Developers can optimize the performance of Azure OpenAI models by using different techniques in their prompts, resulting in more accurate and relevant responses.

## Provide clear instructions

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

## Format of instructions

How instructions are formatted can impact how the model interprets the prompt. Recency bias can affect models, where information located towards the end of the prompt can have more influence on the output than information at the beginning. You may get better responses by repeating the instructions at the end of the prompt and assessing how that affects the generated response.

This recency bias can also come into play when using `ChatCompletion` in a chat scenario, where more recent messages in the conversation included in the prompt have a greater impact on the response. The next unit goes more in depth on using conversations to improve response quality, but putting important information closer to the end of the prompt may result in a better response.

### Use section markers

A specific technique for formatting instructions is to split the instructions at the beginning or end of the prompt, and have the user content contained within `---` or `###` blocks. These tags allow the model to more clearly differentiate between instructions and content. For example:

```code
Translate the text into French

---
What's the weather going to be like today?
---
```

> [!NOTE]
> Best practices for section markers may change with future versions.

## Primary, supporting, and grounding content

Including content for the model to use to respond with allows it to answer with greater accuracy. This content can be thought of in two ways: primary and supporting content.

Primary content refers to content that is the subject of the query, such a sentence to translate or an article to summarize. This content is often included at the beginning or end of the prompt (as an instruction and differentiated by `---` blocks), with instructions explaining what to do with it.

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

Grounding content allows the model to provide reliable answers by providing content for the model to draw answer from. Grounding content could be an essay or article that you then ask questions about, a company FAQ document, or information that is more recent than the data the model was trained on. If you need more reliable and current responses, or you need to reference unpublished or specific information, grounding content is highly recommended.

Grounding content differs from primary content as it's the source of information to answer the prompt query, instead of the content being operated on for things like summarization or translation. For example, when provided an unpublished research paper on the history of AI, it can then answer questions using that grounding content.

```code
---
<insert unpublished paper on the history of AI here, as grounding content>
---

Where and when did the field of AI start?
```

This grounding data allows the model to give more accurate and informed answers that may not be part of the dataset it was trained on.

## Cues

Cues are leading words for the model to build upon, and often help shape the response in the right direction. They often are used with instructions, but don't always. Cues are particularly helpful if prompting the model for code generation. Current Azure OpenAI models can generate some interesting code snippets, however code generation will be covered in more depth in a future module.

For example, if you're wanting help creating a SQL query, provide instructions of what you need along with the beginning of the query:

```code
Write a join query to get customer names with purchases in the past 30 days between tables named orders and customer on customer ID. 

SELECT
```

The model response picks up where the prompt left off, continuing in SQL, even though we never asked for a specific language. Other examples could be to help with python code, by giving code comments about the desired app and including `import` as a leading word at the end of the prompt, or similar in your desired language.

Another example, given a large collection of customer reviews in a prompt, and ending with:

```code
Summarize the reviews above:
Most common complaints:
- 
```

The model then knows to complete the statements based off the context provided in the reviews.
