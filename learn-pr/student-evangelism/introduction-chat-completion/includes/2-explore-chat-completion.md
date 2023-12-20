When you use an LLM, such as ChatGPT, you type a natural language sentence, like a prompt, and get a text response. This action is called a text completion. Text completions are one way to interact with an LLM. However, you might want to have a conversation with the LLM. A conversation means there are two parties who exchange messages. The advantage of a *chat approach* is that you build a context, or a conversation history, which can help guide the LLM.

## Chat

We mentioned some benefits to interacting with an LLM by using the chat approach, but what does this approach look like? There are two main approaches: you can carry out a chat or you can simulate a chat.

- **Carry out a chat.** In this approach, you interact with an LLM chat interface. You send prompts and get responses, and the responses consider past prompts and responses.

- **Simulate a chat.** In this approach, the chat already took place, and you're sending the whole chat history to the LLM. Simulating a chat is beneficial because the customer doesn't have to spend time with the LLM to build up chat history. The LLM answers as if the chat already took place.

### Chat roles and conversing with the LLM

We mentioned that a chat is a series of completions that contain a prompt and a response. How does the LLM know who does what? Well, the LLM is trained to understand two roles:

- **System**: The LLM.

- **User**: The person interacting with the LLM.

For example, a conversation might look like:

```text
- System: Hi, I'm a chatbot. What can I help you with today?
- User: I'm looking for a new pair of shoes.
- System: What kind of shoes are you looking for?
- User: I'm looking for a pair of running shoes.
```

Now that we know what a chat can look like, let's briefly discuss how to simulate a chat.

### Chat history simulates memory

By using the system and user roles that we just learned about, we can simulate that a conversation already happened.

Let's take the previous chat conversation example:

```text
- System: Hi, I'm a chatbot. What can I help you with today?
- User: I'm looking for a new pair of shoes.
- System: What kind of shoes are you looking for?
- User: I'm looking for a pair of running shoes.
```

For the LLM to understand this conversation, we need to turn it into a "chat history." Here's what that looks like in JSON format:

```json
[
    {
        "system": "Hi, I'm a chatbot. What can I help you with today?"
    }, 
    {
        "user": "I'm looking for a new pair of shoes.",
    },
    {
        "system": "What kind of shoes are you looking for?" 
    },
    {
        "user": "I'm looking for a pair of running shoes."
    }
]
```

When you feed this chat conversation to the LLM, the LLM understands that it should respond to the user's request for running shoes.

> [!NOTE]
> An AI model can't learn and has no memory of previous interactions if the user leaves and comes back, but the application is using prompt engineering to add this memory.

### Chat in the Azure AI Studio

Test your model by using the Azure AI Studio chat playground to simulate a conversation by using a chat history.

:::image type="content" source="../media/chat-playground-preview.png" alt-text="Screenshot of the Azure AI Studio with the chat playground highlighted." lightbox="../media/chat-playground-preview.png":::

## Temperature: Create a more interesting chat

To make our chat more interesting, we can use a concept called *temperature*. Temperature refers to your ability to increase or decrease how creative the LLM is in its responses.

The higher the temperature value, the more creative the responses are. The lower the temperature value, the more predictable the responses are.

At low temperature values, the model is more likely to respond with words that have higher weights, which limits the variability in the responses. At higher temperature values, the model is more likely to respond with words that have lower weights, which allows for more creative but less precise responses.

### Temperature values

Lower temperature values tend to produce more predictable and straightforward values, while higher temperature values produce more creative responses.

Here are some general guides for how the temperature values can affect the responses:

- **Low temperature values (below 0.5):** These values are used when you need a single correct answer without leaving space for creativity. The responses are predictable and straightforward.

- **Medium temperature values (between 0.5 and 0.9):** These values are used when you need ideas or content that can be considered relatively creative but not fictitious.

- **High temperature values (above 0.9):** These values are used when you need creative answers. The responses are open ended.

### Change the temperature

If you instruct the LLM with the following prompt:

   "Write 3 sentences about football."

The LLM might give you the following output:

   *Football is a popular sport played around the world. It involves two teams of eleven players each, who try to score goals by kicking a ball into the opposing team's net. The sport requires a combination of physical fitness, skill, and strategy.*

#### Medium temperature

Let's try the same prompt again, but this time, set the temperature to a medium value:

   "Write 3 sentences about football."

   *Football, also known as soccer in some countries, is the most popular sport in the world. It is played between two teams of eleven players each, with the objective of scoring more goals than the opposing team. The game is played on a rectangular field with a goal at each end, and the ball can be touched with any part of the body except the hands and arms (except for the goalkeeper).*

Notice how the output is similar, but not identical. In the latter example, the LLM generated a more creative response, but it still contains the same information as the previous example.

#### High temperature

Let's change the temperature to a high value and see what happens:

   "Write 3 sentences about football"

   *Football, also known as soccer in some countries, is a popular sport played all around the world. The objective of the game is to score goals by kicking the ball into the opposing team's net using only your feet and/or head. Football is known for its passionate fans, who often support their favorite teams with great enthusiasm.*

What you get now is a response similar to your last attempt but with a lot more creativity.

### Change the temperature in Azure AI Studio

Azure AI Studio is a tool that we can use to test our models. In the playground, you can type in prompts and change the temperature value.

If you interact with your model via a programming language and a Web API, you can also change the temperature value in your code.

The following image shows where you can change the temperature in the **Configuration** section by moving the slider in the **Temperature** section.

:::image type="content" source="../media/change-temperature.png" alt-text="Screenshot showing how to change temperate in Azure AI Studio.":::