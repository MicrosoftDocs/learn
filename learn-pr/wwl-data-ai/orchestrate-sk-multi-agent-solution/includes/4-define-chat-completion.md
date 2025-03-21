Multi-turn conversations have responses returned asynchronously, so the conversation can develop naturally. However, the agents need to know when to stop a conversation, which is determined by the **termination strategy**

This unit uses the example multi-agent solution where we have two agents:

- A copywriter agent who writes online content, called _CopywriterAgent_.
- A creative director only reviewing the proposals, called _ReviewingDirectorAgent_.

## Termination strategy

A termination strategy ensures that conversations or tasks conclude appropriately. This strategy prevents unnecessary messages to the user, limits resource usage, and improves the overall user experience.

For example, once the _ReviewingDirectorAgent_ reviews and approves our scrubbing brush slogan from the _CopywriterAgent_, us humans know the conversation should be over. However, if we don't define when to terminate the conversation, the _CopywriterAgent_ is going to keep submitting slogans unnecessarily.

### Why use a termination strategy?

- **Efficiency**: It prevents endless loops or prolonged interactions, saving computational resources.
- **User satisfaction**: Users receive concise and relevant responses, avoiding frustration from overly long conversations.
- **Goal completion**: The use of an agent is to complete a task. By terminating appropriately. it confirms when a task or conversation has achieved its intended purpose.

### How does the framework implement termination strategies?

Similar to how the selection strategy is specified, developers can specify a termination strategy or use one of the predefined strategies. Termination strategies can also define a maximum number of iterations a conversation should be limited to.

Termination strategies can be created using a prompt, such as:

```python
prompt="""
    Determine if the copy has been approved.  If so, respond with a single word: yes

    History:
    {{$history}}
    """
```

You can also specify which agent should determine that termination, which in our case would be _ReviewingDirectorAgent_. The agents to determine termination are also defined in the `AgentGroupChat`.

If it makes more sense for a given scenario, developers can also define termination functions explicitly in code. For example, we could define a termination function that checks the most recent history entry for just the word "yes". There are other use-case specific considerations if that route is chosen, such as explicit agent instructions for approval, but it's an option.

### Conversation state

Whether you use `AgentGroupChat` for a single-turn or multi-turn conversation, the state is updated to _completed_ once it meets the termination criteria. However, you may want to use the group chat instance again. To keep using the same chat instance, you'll need to reset the completion state to `False`. Without a state reset, the `AgentGroupChat` can't accept new interactions.

When a conversation hits the maximum number of iterations allowed, the conversation will end but won't be marked as _completed_. In this case, you can extend the conversation without resetting the conversation state.

By understanding these components, you can better utilize the Semantic Kernel Agent Framework to build intelligent multi-agent systems.