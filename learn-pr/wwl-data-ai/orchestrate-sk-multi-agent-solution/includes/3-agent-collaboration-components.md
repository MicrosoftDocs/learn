NOTES: After thinking on this longer, I wonder if we split out each section here into its own unit and expand a bit - give examples of the prebuilt selection and termination strategies. Then we can drop the code heavy unit (currently 4) and save the coding for the lab


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

Multi-turn conversations have responses returned asynchronously, so the conversation can develop naturally. However, the agents need to know when to stop a conversation, which is determined by the **termination strategy**

## Termination strategy

A termination strategy ensures that conversations or tasks conclude appropriately, preventing unnecessary messages to the user, limiting resource usage, and improving user experience.

For example, once the _ReviewingDirectorAgent_ has reviewed and approved our scrubbing brush slogan from the _CopywriterAgent_, us humans know the conversation should be over. However, if we don't define when to terminate the conversation, the _CopywriterAgent_ is going to keep submitting slogans unnecessarily.

### Why use a termination strategy?

- **Efficiency**: It prevents endless loops or prolonged interactions, saving computational resources.
- **User satisfaction**: Users receive concise and relevant responses, avoiding frustration from overly long conversations.
- **Goal completion**: The use of an agent is to complete a task. By terminating appropriately. it confirms when a task or conversation has achieved its intended purpose.

### How does the framework implement termination strategies?

Similar to how the selection strategy is specified, developers can specify a termination strategy or use one of the predefined strategies. Termination strategies can also define a maximum number of iterations a conversation should be limited to.

Termination strategies can be created by a prompt, such as:

```python
prompt="""
    Determine if the copy has been approved.  If so, respond with a single word: yes

    History:
    {{$history}}
    """
```

You can also specify which agent should determine that termination, which in our case would be _ReviewingDirectorAgent_. The agents to determine termination are also defined in the `AgentGroupChat`.

If it makes more sense for a given scenario, developers can also define termination functions explicitly in code. For example, we could define a termination function that checks the most recent history entry for just the word "yes". There are other use-case specific considerations if that route is chosen, such as very explicit agent instructions for approval, but it is an option.

### Conversation state

When a conversation is considered complete and terminates, the `AgentGroupChat` state is updated to _completed_. However, you may want to use the group chat instance again, in which you will need to reset the completion state to `False`.

In the case of a conversation hitting the maximum number of iterations allowed, the conversation will end but will not be marked as _completed_. In this case, you are able to extend the conversation without resetting the conversation state.

By understanding these components, you can better utilize the Semantic Kernel Agent Framework to build intelligent multi-agent systems.
