By providing context to the AI model, it allows the model to better understand what you are asking for or what it should know to provide the best answer. Context can be provided in several ways.

## Conversation history

Conversation history enables the model to continue responding in a similar way (such as tone or formatting) as well as allow the user to reference previous content in subsequent queries. This history can be provided in two ways: from an actual chat history, or from a user defined example conversation.

Chat interfaces that use OpenAI models, such as ChatGPT and the chat playground in [Azure OpenAI Studio](https://oai.azure.com/portal/chat?azure-portal=true), include conversation history automatically which results in a richer, more meaningful conversation. In the **Parameters** section below the chat window of the Azure OpenAI Studio chat playground, you can specify how many past messages you want included. Try reducing that to 1 or increasing to max to see how different amounts of history impact the conversation.

> [!NOTE]
> More conversation history included in the prompt means a larger the number of input tokens are used. You will have to determine what the correct balance is for your use case, considering the token limit of the model you are using.

Chat systems can also utilize the summarization capabilities of the model to save on input tokens. An app can choose to summarize past messages and include that summary in the conversation history, then provide only the past couple messages verbatim to the model.

Using a user defined example conversation is what is called *few shot learning*, which provides the model examples of how it should respond to a given query.

For example, by providing the model a couple prompts and the expected response, it will continue in the same pattern without instructing it what to do:

```code
User: That was an awesome experience
Assistant: positive
User: I won't do that again
Assistant: negative
User: That was not worth my time
Assistant: negative
User: You can't miss this
Assistant:
```

The `ChatCompletions` endpoint is optimized to include chat history. As part of defining the prompt, you can include as much conversation as you want.

::: zone pivot="csharp"
```csharp
var chatCompletionsOptions = new ChatCompletionsOptions()
{
    Messages =
    {
        new ChatMessage(ChatRole.System, "You are a helpful assistant."),
        new ChatMessage(ChatRole.User, "That was an awesome experience"),
        new ChatMessage(ChatRole.Assistant, "positive"),
        new ChatMessage(ChatRole.User, "I won't do that again"),
        new ChatMessage(ChatRole.Assistant, "negative"),
        new ChatMessage(ChatRole.User, "That was not worth my time"),
        new ChatMessage(ChatRole.Assistant, "negative"),
        new ChatMessage(ChatRole.User, "You can't miss this")
    }
};
```

::: zone-end
::: zone pivot="python"
```python
response = openai.ChatCompletion.create(
    engine="gpt-35-turbo",
    messages=[
        {"role": "system", "content": "You are a helpful assistant."},
        {"role": "user", "content": "That was an awesome experience"},
        {"role": "assistant", "content": "positive"},
        {"role": "user", "content": "I won't do that again"},
        {"role": "assistant", "content": "negative"},
        {"role": "user", "content": "That was not worth my time"},
        {"role": "assistant", "content": "negative"},
        {"role": "user", "content": "You can't miss this"}
    ]
)
```
::: zone-end

While not ideal, similar results can be achieved with the `Completions` endpoint by including the conversation exchange within the single prompt, much like we saw with system messages in the previous unit.

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
