A key part of the Semantic Kernel Agent Framework is a system designed to facilitate intelligent, multi-agent interactions. Agent collaboration, called `AgentGroupChat`, has critical components to consider that aren't necessary with single agents or non-agentic Semantic Kernel applications.

Each of these sections discusses an example multi-agent solution, where we have two agents:

- A copywriter agent who writes online content, called _CopywriterAgent_.
- A creative director only reviewing the proposals, called _ReviewingDirectorAgent_.

## Agent selection

Choosing the agent best suited to respond to a user's query is pivotal, especially in multi-agent systems where agents specialize in different domains.

For example, if you chat with the agents asking for a slogan for a new scrubbing brush, the _ReviewingDirectorAgent_ shouldn't be invoked to respond since they don't know how to write slogans. Instead, having the _CopywriterAgent_ respond would provide the user an accurate response.

### Why is agent selection important?

- Accuracy: Routing queries to the most relevant agent ensures precise responses.
- Efficiency: It reduces processing time by leveraging the expertise of specialized agents.
- Scalability: Proper selection allows the framework to handle diverse queries without overwhelming individual agents, and provides the best response to the user as the number of agents in the chat grows.

### How does the framework select agents?

**Single-turn conversations**

- Intent recognition: The framework analyzes the user's query to identify the intent and match it with the most relevant agent.
- Predefined rules: Developers can configure routing rules to direct specific queries to designated agents in their application.

**Multi-turn conversations**

- Context tracking: The framework maintains a record of the conversation history to understand the user's intent and select the appropriate agent.
- Dynamic switching: If the topic shifts, the framework dynamically switches to an agent specializing in the new domain in the middle of the conversation.

For multi-turn agents, agent selection is determined by a **selection strategy**. The selection strategy is defined within the framework, either by using one of the predefined selection strategies or by extending a base class to define custom selection behavior. The selection strategy is defined in the creation of the `AgentGroupChat`.

Defining your selection function is done by creating a kernel function from a prompt. In our writer and reviewer example, your selection strategy prompt might be:

```python
prompt=f"""
    Determine which participant takes the next turn in a conversation based on the the most recent participant.
    State only the name of the participant to take the next turn.
    No participant should take more than one turn in a row.

    Choose only from these participants:
    - ReviewingDirectorAgent
    - CopywriterAgent

    Always follow these rules when selecting the next participant:
    - After user input, it is CopywriterAgent's turn.
    - After CopywriterAgent replies, it is ReviewingDirectorAgent's turn.
    - After ReviewingDirectorAgent provides feedback, it is CopywriterAgent's turn.

    History:
    {{$history}}
"""
```

If your preferred interaction should always have a certain agent respond first, that can be specified in your selection strategy as seen in the prompt above.