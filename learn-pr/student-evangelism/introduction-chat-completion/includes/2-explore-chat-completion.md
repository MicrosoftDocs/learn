If you've used an LLM, such as ChatGPT, you've seen how you can type a natural language sentence, a prompt, and get a text response, this action is called a text completion. That might be a good way in many cases to interact with an LLM. There are cases though where you want to have a conversation with the LLM. A conversation means there are two parties involved exchanging messages. The advantages of a *chat approach* is that you build a context, a conversation history which can help guid the LLM.

## Chat

We've mentioned some benefits to interact with an LLM using chat but how would this approach work? Well, there are two main approaches:

- **Carrying out a chat**. In this version you interact with an LLM chat interface, and you send prompts and get responses and the responses consider past prompts and responses.

- **Simulating a chat**. Here, the chat has already taken place and you're sending the whole chat history to the LLM. The benefit to a customer is that they might not have the time or the will to spend time with the LLM to build up chat history. Instead, by simulating a chat, a customer can have a *running start* and the LLM will answer as if the chat had already taken place.

### Chat roles, conversing with the LLM

We've mentioned a chat being a series of completions containing a prompt and a response. But how does the LLM knows who does what? Well, the LLM is trained to understand two roles:

- **System**, this is the LLM.

- **User**, this is the person interacting with the LLM.

For example, a conversation might look like so:

```text
- System: Hi, I'm a chatbot. What can I help you with today?
- User: I'm looking for a new pair of shoes.
- System: What kind of shoes are you looking for?
- User: I'm looking for a pair of running shoes.
```

Now that we know what a chat can look like, let's briefly discuss how to simulate a chat next.

### Chat history, simulate memory

Leveraging the roles (system and user) we were just taught about, we can simulate that a conversation has taken place.

Let's take the previous chat conversation example:

```text
- System: Hi, I'm a chatbot. What can I help you with today?
- User: I'm looking for a new pair of shoes.
- System: What kind of shoes are you looking for?
- User: I'm looking for a pair of running shoes.
```

For the LLM to understand the above conversation, we need to turn it into something it can understand, a "chat history". Here's what that could look like in JSON format:

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

If you feed the above chat conversation to the LLM, the LLM would understand that it should respond to the user's request for running shoes.

> [!NOTE]
> An AI model can't learn and has no memory of previous interactions if the user leaves and comes back but the application is using prompt engineering to add this memory.

### Chat in the Azure OpenAI Studio

You can use the Azure OpenAI Studio to test your model using chat and simulate a conversation using a chat history.

The Azure OpenAI Studio has a chat playground where you can interact with your model using chat.

:::image type="content" source="../media/chat-playground-preview.png" alt-text="Screenshot of the Azure OpenAI Studio with chat playground highlighted." lightbox="../media/chat-playground-preview.png":::

## Temperature: Create a more interesting chat

To make our chat more interesting, we can use a concept called *temperature*. The idea with temperature is that you can increase or decrease how creative the LLM is in its responses.

The higher the temperature value, the more creative responses you'll get. The lower the temperature value, the more predictable the responses will be.

What goes on *under the hood*, in the model, is that at low values of temperature, the model is more likely to respond with words that have higher weights, limiting the variability in the responses. At higher values of temperature, the model is more likely to respond with words that have lower weights, allowing for more creative but less precise responses.

## Temperature values

Lower temperature values tend to produce more predictable and straightforward values, while higher temperature values produce less predictable and creative responses.

Here are some general guides for how the temperature values can affect the responses:

- **Low temperature values (below 0.5)**: These values can be used when you need a single correct answer without leaving the space open for creativity. The responses are predictable and straightforward.

- **Medium temperature values (between 0.5 and 0.9)**: These values can be used when you need ideas or content that can be considered relatively creative but not fictitious.

- **High temperature values (above 0.9)**: These values can be used when you need creative answers. The responses are less predictable and open ended.

## Change the temperature

If you instruct the LLM with the following prompt:

"Write 3 sentences about football"

You arrive at the following output:

*Football is a popular sport played around the world. It involves two teams of eleven players each, who try to score goals by kicking a ball into the opposing team's net. The sport requires a combination of physical fitness, skill, and strategy.*

### Medium temperature

Let's try the same prompt again, but this time setting the temperature to a medium value:

"Write 3 sentences about football"

*Football, also known as soccer in some countries, is the most popular sport in the world. It is played between two teams of eleven players each, with the objective of scoring more goals than the opposing team. The game is played on a rectangular field with a goal at each end, and the ball can be touched with any part of the body except the hands and arms (except for the goalkeeper).*

Notice how the output is similar, but not identical. In the latter example, the LLM has generated a more creative response, but it still contains the same information as the previous example.

### High temperature

Let's change the temperature to a high value and see what happens:

 "Write 3 sentences about football"

*Football, also known as soccer in some countries, is a popular sport played all around the world. The objective of the game is to score goals by kicking the ball into the opposing team's net using only your feet and/or head. Football is known for its passionate fans, who often support their favorite teams with great enthusiasm.*

What you get now is a response similar to your last attempt but with a lot more creativity.

## Change the temperature via Azure Open AI Studio

Azure Open AI Studio is a tool, a playground we can use to test our models. In this tool, you're able to not only type in prompts but also change the temperature value.

If you interact with your model via programming language and a Web API, you can also change the temperature value in your code.

In below image, you can change the temperature via the **Configuration** section and moving the slider in the **Temperature** section.

:::image type="content" source="../media/change-temperature.png" alt-text="Screenshot showing how to change temperate in Azure Open AI Studio.":::
