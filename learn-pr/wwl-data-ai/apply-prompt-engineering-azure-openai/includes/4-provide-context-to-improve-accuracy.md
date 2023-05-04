By providing context to the AI model, it allows the model to better understand what you are asking for or what it should know to provide the best answer. Context can be provided in several ways.

## Few shot examples

What are few shot examples
Examples including prompts and responses/formats
Include how Chat works in Azure OpenAI, including previous chats/summarizing chat history

## Primary, supporting, and grounding content

Including content for the model to use to respond with allows it to answer with greater accuracy. This content can be thought of in two ways: primary and supporting content.

Primary content refers to content that is the subject of the query, such a sentence to translate or an article to summarize. This content is often included at the beginning or end of the prompt (and can be differentiated by `---` blocks, as mentioned in the previous unit), with instructions explaining what to do with it.

For example, say I have a long article that I want to summarize. I could put it in a `---` block in my prompt, then end with `Summarize this article and identify three takeaways in a bulleted list`.

Supporting content is content that may alter the response, but isn't the focus or subject of the prompt. This could include things like names, preferences, future date to include in the response, and so on. Providing supporting content allows the model to respond more completely, accurately, and be more likely to include the desired information.

Grounding content allows the model to provide reliable answers by providing content for the model to draw answer from. This could be an essay or article that you then ask questions about, a company FAQ document, or information that is more recent than the data the model was trained on. If you need more reliable and current responses, grounding content is highly recommended.

## Cues

Cues are leading words for the model to build upon, and often help shape the response in the right direction. They often are used with instructions, but don't always. Cues are particularly helpful if prompting the model for code generation. Current Azure OpenAI models can generate some interesting code snippets, however code generation will be covered in more depth in a future module.

For example, if you're wanting help creating a SQL query, provide instructions of what you need along with the beginning of the query:

```code
Write a join query to get customer names with purchases in the past 30 days between tables named orders and customer on customer ID. 

SELECT
```

The model response picks up where the prompt left off, continuing in SQL, even though we never asked for a specific language. This can be done with python code, by giving code comments about the desired app and including `import` as a leading word at the end of the prompt, or similar in your desired language.

Another example, given a large collection of customer reviews in a prompt, and ending with:

```code
Summarize the reviews above:
Most common complaints:
- 
```

The model then knows to complete the statements based off the context provided in the reviews.
