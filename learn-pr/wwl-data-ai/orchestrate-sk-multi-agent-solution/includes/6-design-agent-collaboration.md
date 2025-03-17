The Semantic Kernel Agent Framework supports collaboration between multiple agents. Each agent can specialize in different functions, allowing for modular AI-driven workflows. By configuring multiple agents, you can create conversational AI systems where agents interact with each other to generate more comprehensive results.

## Create an agent group chat

An `AgetnGroupChat` object allows agents to work together. You can specify the participating agents or create an empty chant and add agent participants afterwards.

```python
# Initialize the group chat with participating agents
chat = AgentGroupChat(
    agents=[writer_agent, reviewer_agent]
)

# Add an agent to the chat
chat.add_agent(agent=publisher_agent)
```

## Invoke agent responses

The `AgentGroupChat` supports single-turn and multi-turn invokation. In single-turn, a specific agent is designated to provide a response. In multi-turn, all the agents will take turns responding until a termination criterion is met. In both modes, agents can collaborate by responding to one another to achieve a defined goal.

### Single-turn invocation

To invoke a response from a specific agent, you can use `chat.invoke(agent)`. In this example, a prompt is added to the chat history, and a response from the `writer_agent` is requested:

```python
# Initialize the group chat
chat = AgentGroupChat(
    agents=[writer_agent, reviewer_agent]
)

# Add a request for the agents to complete
chat.add_chat_message(request)

# Invoke a response from the specific agent
async for response in chat.invoke(writer_agent):
    # Process the response
    print(f"{response.content}")
```

### Multi-turn invocation

To invoke a response from all agents in a group chat, you can use `chat.invoke()`. In this example, both the writer and reviewer agents will take turns responding.

```python
# Initialize the group chat
chat = AgentGroupChat(
    agents=[writer_agent, reviewer_agent],
    termination_strategy=DefaultTerminationStrategy(maximum_iterations=5),
)

# Add a request for the agents to complete
chat.add_chat_message(request)

# Invoke a response from the agents
async for response in chat.invoke():
    # Process the response
    print(f"{response.content}")
```

There is a maximum of five iterations defined in the `termination_strategy` for the chat. This means that the group chat will end after five turns.

## Define chat completion

TODO explain termination strategies

Termination function prompt vs method override

## Define agent selection

TODO 
Selection function prompt vs method override

## Reset completion state

TODO is_complete vs reset

```python
chat = AgentGroupChat(
    agents=[writer_agent, reviewer_agent]
)

# Check if completion is met
if chat.is_compelte:
    # Reset completion state to continue using the agent chat
    chat.is_complete = False

# Clear the conversation
await chat.reset()
```

Using the Semantic Kernel to orchestrate multiple agents, you can create powerful and scalable AI solutions.