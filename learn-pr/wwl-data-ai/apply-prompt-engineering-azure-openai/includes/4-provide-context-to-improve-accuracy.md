By providing context to the AI model, it allows the model to better understand what you are asking for or what it should know to provide the best answer. Context can be provided in several ways.

## Request output composition

Specifying the structure of your output can have a large impact on your results. This could include something like asking the model to cite their sources, write the response as an email, format the response as a SQL query, classify sentiment into a specific structure, and so on. For example:

**Prompt**

```code
Write a table in markdown with 6 animals in it, with their genus and species
```

**Response**

```code
| Animal           | Genus          | Species        |
| ---------------- |:--------------:|:--------------:|
| Red Panda        | Ailurus        | fulgens        |
| African Elephant | Loxodonta      | africana       |
| Snow Leopard     | Panthera       | uncia          |
| Arctic Fox       | Vulpes         | lagopus        |
| Chimpanzee       | Pan            | troglodytes    |
| Siberian Tiger   | Panthera       | tigris altaica |
```

This technique can be used with custom formats, such as a JSON structure:

**Prompt**

```code
Put two fictional characters into JSON of the following format

{
  firstNameFictional: 
  jobFictional:
}
```

**Response**

```code
Here's an example of how you can put two fictional characters into JSON format:

{
  "firstNameFictional": "Henry",
  "jobFictional": "Wizard"
},
{
  "firstNameFictional": "Frank",
  "jobFictional": "Hero"
}
```

## System message

The system message is included at the beginning of a prompt and is designed to give the model instructions, perspective to answer from, or other information helpful to guide the model's response. This system message might include tone or personality, topics that shouldn't be included, or specifics (like formatting) of how to answer.

For example, you could give it some of the following system messages:

- "I want you to act like a command line terminal. Respond to commands exactly as cmd.exe would, in one unique code block, and nothing else."
- "I want you to be a translator, from English to Spanish. Don't respond to anything I say or ask, only translate between those two languages and reply with the translated text."
- "Act as a motivational speaker, freely giving out encouraging advice about goals and challenges. You should include lots of positive affirmations and suggested activities for reaching the user's end goal."

Other example system messages are available at the top of the chat window in [Azure OpenAI Studio](https://oai.azure.com/portal?azure-portal=true). Try defining your own system prompt that specifies a unique response, and chat with the model to see how responses differ.

The `ChatCompletion` endpoint enables including the system message by using the `System` chat role.

::: zone pivot="csharp"

```csharp
var ChatCompletionsOptions = new ChatCompletionsOptions()
{
    Messages =
    {
        new ChatMessage(ChatRole.System, "You are a casual, helpful assistant. You will talk like an American old western film character."),
        new ChatMessage(ChatRole.User, "Can you direct me to the library?")
    }
};
```

**Response**

```code
{
    "role": "assistant", 
    "content": "Well howdy there, stranger! The library, huh?
                Y'all just head down the main road till you hit the town 
                square. Once you're there, take a left and follow the street 
                for a spell. You'll see the library on your right, can’t 
                miss it. Happy trails!"
}
```

::: zone-end

::: zone pivot="python"

```python
response = openai.ChatCompletion.create(
    engine="gpt-35-turbo",
    messages=[
        {"role": "system", "content": "You are a casual, helpful assistant. You will talk like an American old western film character."},
        {"role": "user", "content": "Can you direct me to the library?"}
    ]
)
```

**Response**

```code
{
    "role": "assistant", 
    "content": "Well howdy there, stranger! The library, huh?
                Y'all just head down the main road till you hit the town 
                square. Once you're there, take a left and follow the street 
                for a spell. You'll see the library on your right, can’t 
                miss it. Happy trails!"
}
```

::: zone-end

If using the `Completion` endpoint, similar functionality can be achieved by including the system message at the start of the prompt. This is called a *meta prompt*, and serves as a base prompt for the rest of the prompt content.

System messages can significantly change the response, both in format and content. Try defining a clear system message for the model that explains exactly what kind of response you expect, and what you do or don't want it to include.

## Conversation history

Along with the system message, other messages can be provided to the model to enhance the conversation. Conversation history enables the model to continue responding in a similar way (such as tone or formatting) and allow the user to reference previous content in subsequent queries. This history can be provided in two ways: from an actual chat history, or from a user defined example conversation.

Chat interfaces that use OpenAI models, such as ChatGPT and the chat playground in [Azure OpenAI Studio](https://oai.azure.com/portal/chat?azure-portal=true), include conversation history automatically which results in a richer, more meaningful conversation. In the **Parameters** section below the chat window of the Azure OpenAI Studio chat playground, you can specify how many past messages you want included. Try reducing that to 1 or increasing to max to see how different amounts of history impact the conversation.

> [!NOTE]
> More conversation history included in the prompt means a larger number of input tokens are used. You will have to determine what the correct balance is for your use case, considering the token limit of the model you are using.

Chat systems can also utilize the summarization capabilities of the model to save on input tokens. An app can choose to summarize past messages and include that summary in the conversation history, then provide only the past couple messages verbatim to the model.

## Few shot learning

Using a user defined example conversation is what is called *few shot learning*, which provides the model examples of how it should respond to a given query. These examples serve to train the model how to respond.

For example, by providing the model a couple prompts and the expected response, it continues in the same pattern without instructing it what to do:

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

If the model is provided with just `You can't miss this` with no additional context from few shot learning, the response isn't likely to be useful.

In practical terms, conversation history and few shot learning are sent to the model in the same way; each user message and assistant response is a discrete message in the message object. The `ChatCompletion` endpoint is optimized to include message history, regardless of if this message history is provided as few shot learning, or actual conversation history.

::: zone pivot="csharp"
```csharp
var ChatCompletionsOptions = new ChatCompletionsOptions()
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

While not ideal, similar results can be achieved with the `Completion` endpoint by including the conversation exchange within the single prompt, much like we saw with system messages. If you do need to include multiple messages in a single prompt with `Completion`, you can make it clear to the model by putting each message on a new line and labeling each line with the role. Formatting this prompt would be similar to how the conversation was presented at the top of this section.

## Break down a complex task

Another technique for improved interaction is to divide complex prompts into multiple queries. This allows the model to better understand each individual part, and can improve the overall accuracy. Dividing your prompts also allows you to include the response from a previous prompt in a future prompt, and using that information in addition to the capabilities of the model to generate interesting responses.

For example, you could ask the model `Doug can ride down the zip line in 30 seconds, and takes 5 minutes to climb back up to the top. How many times can Doug ride the zip line in 17 minutes?`. The result is likely `3`, which if Doug starts at the top of the zip line is incorrect.

A more informative answer could come from asking it multiple questions, about the round trip time to get back to the top of the zip line, and how to account for the fact that Doug starts at the top. Breaking down this problem reveals that Doug can, in fact, ride the zip line four times.

### Chain of thought

One useful method to help you break down your task effectively is to ask the model to explain its chain of thought.

Asking a model to respond with the step by step process by which it determined the response is a helpful way to understand how the model is interpreting the prompt. By doing so, you can see where the model made an incorrect logical turn and better understand how to change your prompt to avoid the error. This technique can include asking it to cite its sources, like Bing chat does (which uses a GPT-4 generation model), and giving reasoning for why it determined its answer.

The chain of thought prompting technique is best used to help you iterate and improve on your prompts to get the highest quality answer from the model.

For example, asking the model `What sport is easiest to learn but hardest to master?` results in response with an answer, and a small explanation of why. However, when prompted with `What sport is easiest to learn but hardest to master? Give a step by step approach of your thoughts, ending in your answer`, the response is a complete explanation of how it arrived at its answer.

```code
Sure, here's a step-by-step approach to answering the question:
1. Identify sports that are popular and have a large following.
2. Consider the basic mechanics of each sport and how easy they are to learn.
3. Think about the various techniques and skills required to play each sport at a high level, and how difficult they are to master.
4. Compare the relative ease of learning each sport to the difficulty of mastering it.
5. Based on the above analysis, determine which sport is easiest to learn but hardest to master.

Using this approach, I would say that the sport of golf is easiest to learn but hardest to master. Here's why:
1. Golf is a popular sport with a large following.
2. The basic mechanics of hitting a golf ball are relatively simple and can be learned quickly with some practice.
3. However, achieving consistency and mastering the various shots and techniques required to play at a high level can take years of practice and dedication.
4. Compared to other sports, the difference between a beginner and an intermediate golfer is relatively small, while the difference between an intermediate and an advanced golfer is much larger.
5. Therefore, I would say that golf is the sport that is easiest to learn but hardest to master.
```

Knowing the steps of reason the model used to form its response allows us to identify where we need to split the prompt, provide more information, or clarify instructions.
