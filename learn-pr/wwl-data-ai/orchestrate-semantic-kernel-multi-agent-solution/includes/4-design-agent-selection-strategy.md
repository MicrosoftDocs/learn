One key feature of the Semantic Kernel Agent Framework is its support for intelligent, multi-agent interactions. Agent collaboration cam be achieved using `AgentGroupChat`, which has some critical components to consider that aren't necessary with single agents or non-agentic Semantic Kernel applications.

The following units discuss an example multi-agent solution, where we have two agents in a writer-reviewer scenario:

- A copywriter agent who writes online content, called _CopywriterAgent_.
- A creative director only reviewing the proposals, called _ReviewingDirectorAgent_.

## Agent selection

It's important to choose the agent that's best suited to respond to a user's query, especially in multi-agent systems where the agents specialize in different domains.

For example, if you chat with the agents asking for a slogan for a new scrubbing brush, the _ReviewingDirectorAgent_ shouldn't be invoked to respond since they don't know how to write slogans. Instead, having the _CopywriterAgent_ respond would provide the user with an accurate response.

### Why is agent selection important?

- Accuracy: Routing queries to the most relevant agent ensures precise responses.
- Efficiency: It reduces processing time by using the expertise of specialized agents.
- Scalability: Proper selection allows the framework to handle diverse queries without overwhelming individual agents, and provides the best response to the user as the number of agents in the chat grows.

### How does the framework select agents?

**Single-turn conversations**

- Intent recognition: The framework analyzes the user's query to identify the intent and match it with the most relevant agent.
- Predefined rules: Developers can configure routing rules to direct specific queries to designated agents in their application.

**Multi-turn conversations**

- Context tracking: The framework maintains a record of the conversation history to understand the user's intent and select the appropriate agent.
- Dynamic switching: If the topic shifts, the framework dynamically switches to an agent specializing in the new domain in the middle of the conversation.

#### Agent selection strategy

For multi-turn agents, agent selection is determined by a **selection strategy**. The selection strategy is defined within the framework, either by using a predefined selection strategy or by extending a `SelectionStrategy` class to define custom selection behavior. You can define the selection strategy when you create the `AgentGroupChat` object.

**SequentialSelectionStrategy**

- The `SequentialSelectionStrategy` class offers a predefined selection strategy where the agent turn order is based on the order in which the agents were added to the chat. The option to specify an initial agent is also available.

**KernelFunctionSelectionStrategy**

- The `KernelFunctionSelectionStrategy` class allows you to define your selection strategy by creating a kernel function from a prompt. In our writer and reviewer example, your selection strategy prompt might be:

    ```python
    prompt=f"""
        Determine which participant takes the next turn in a conversation based on the most recent participant.
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

**SelectionStrategy base class**

- The `SelectionStrategy` base class contains an overridable `select_agent` method where you can define custom logic for selecting the next agent. The return value must be an agent that is present in the group chat.

Once you decide on your selection strategy, you can assign it to the `selection_strategy` parameter of the `AgentGroupChat` object.

### Truncating chat history

Since the selection strategy will typically rely on the last message in the chat to determine the next agent, you can truncate the chat history to reduce token usage and help improve performance. The `KernelFunctionSelectionStrategy` accepts a `history_reducer` parameter which you can specify as:

```python
history_reducer = ChatHistoryTruncationReducer(target_count=1)
```