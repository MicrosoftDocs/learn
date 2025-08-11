A key feature of the Semantic Kernel Agent Framework is its ability to facilitate interactions between multiple agents. Using `AgentGroupChat`, developers can create dynamic, multi-agent conversations where different types of agents collaborate to generate responses. 

The `AgentGroupChat` class extends the AgentChat framework, providing a structured way to manage multi-agent collaboration. It offers built-in mechanisms to control conversation flow, define collaboration strategies, and support both single-turn and multi-turn interactions.

To create the `AgentGroupChat`, you can initialize the chat object with a predefined set of agents. For example:

```python
# Define agents
agent_writer = AzureAIAgent(...)
agent_reviewer = AzureAIAgent(...)

# Create chat with participating agents
chat = AgentGroupChat(agents=[agent_writer, agent_reviewer])
```

Or you can start with an empty chat and add agents dynamically. For example:

```python
# Create an empty chat
chat = AgentGroupChat()

# Add agents to an existing chat
chat.add_agent(agent=agent_writer)
chat.add_agent(agent=agent_reviewer)
```

## Add messages to the chat

Once your chat is created, you can create a `ChatMessageContent` object and add it to the chat thread. The `ChatMessageContent` object takes a role parameter in addition to the content. For example:

```python
chat_message = ChatMessageContent(role=AuthorRole.USER, content="This is the message content.")
await chat.add_chat_message(message=chat_message)
```

### Conversation Modes in AgentGroupChat

Agent group chats can operate in two distinct modes, depending on the conversation requirements:

In **single-turn conversations**, a designated agent provides a response based on user input. 

- You can invoke a response from a single-turn chat by using `AgentGroupChat.invoke` and specifying the agent that should respond. For example:

        ```python
        async for message in chat.invoke(agent)
            # process message response(s)
        ```

In **multi-turn conversations**, multiple agents take turns responding, continuing the conversation until a termination condition is met.

- Agent responses are returned asynchronously as they are generated, allowing the conversation to unfold in real-time.

- You can invoke a response from a multi-turn chat by using `AgentGroupChat.invoke`. For example:

        ```python
        async for message in chat.invoke()
            # process message response(s)
        ```

Both modes allow agents to collaborate by building on each other's responses, resulting in dynamic, intelligent interactions.