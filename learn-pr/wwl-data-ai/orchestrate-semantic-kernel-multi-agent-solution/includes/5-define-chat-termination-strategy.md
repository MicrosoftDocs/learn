Multi-turn conversations have responses returned asynchronously, so the conversation can develop naturally. However, the agents need to know when to stop a conversation, which is determined by the **termination strategy**.

## Termination strategy

A termination strategy ensures that conversations or tasks conclude appropriately. This strategy prevents unnecessary messages to the user, limits resource usage, and improves the overall user experience.

For example, in the writer-reviewer agent scenario, once the _ReviewingDirectorAgent_ reviews and approves our scrubbing brush slogan from the _CopywriterAgent_, us humans know the conversation should be over. However, if we don't define when to terminate the conversation, the _CopywriterAgent_ is going to keep submitting slogans unnecessarily.

### Why use a termination strategy?

- **Efficiency**: It prevents endless loops or prolonged interactions, saving computational resources.
- **User satisfaction**: Users receive concise and relevant responses, avoiding frustration from overly long conversations.
- **Goal completion**: The use of an agent is to complete a task. By terminating appropriately. It confirms when a task or conversation has achieved its intended purpose.

### How does the framework implement termination strategies?

Similar to how the selection strategy is specified, developers can define a termination strategy or use a predefined strategy. Each termination strategy supports a `maximum_iterations` parameter that will end the chat after a maximum number of iterations. The default value is 99 iterations. Each termination strategy also requires the agents which should run the strategy. In the writer-reviewer agent scenario, the _ReviewingDirectorAgent_ should determine when the chat should terminate.

**DefaultTerminationStrategy**

- The `DefaultTerminationStrategy` class will only terminate after the specified number of maximum iterations.

**KernelFunctionTerminationStrategy** 

- The `KernelFunctionTerminationStrategy` class allows you to define your termination strategy by creating a kernel function from a prompt. In our writer and reviewer example, your selection strategy prompt might be:

    ```python
    prompt="""
        Determine if the copy has been approved.  If so, respond with a single word: yes

        History:
        {{$history}}
        """
    ```

- This class requires a `result_parser` parameter. The `result_parser` is a function that processes the output of your prompt function to determine whether the termination condition has been met. It takes the output of the prompt function and processes it to return `True` or `False`.

**TerminationStrategy base class**

- The `TerminationStrategy` base class contains an overridable `should_agent_terminate` method where you can define custom logic for concluding the agent group chat. The return value must be a Boolean. For example, you could define a termination function that checks the most recent history entry for just the word "yes", however you would need to provide explicit instructions to your agent to return the termination keyword.

Once you've decided on your termination strategy, you can assign it to the `termination_strategy` parameter of the `AgentGroupChat` object.

### Truncating chat history

Since the termination strategy will typically rely on the last message in the chat to determine whether the chat should terminate, you can truncate the chat history to reduce token usage and help improve performance. The `KernelFunctionTerminationStrategy` accepts a `history_reducer` parameter which you can specify as:

```python
history_reducer = ChatHistoryTruncationReducer(target_count=1)
```

### Conversation state

Whether you use `AgentGroupChat` for a single-turn or multi-turn conversation, the state updates to _completed_ once it meets the termination criteria. However, you may want to use the group chat instance again. To keep using the same chat instance, you'll need to reset the completion state to `False`. Without a state reset, the `AgentGroupChat` can't accept new interactions.

When a conversation hits the maximum number of iterations allowed, the conversation will end but won't be marked as _completed_. In this case, you can extend the conversation without resetting the conversation state.

By understanding these components, you can better utilize the Semantic Kernel Agent Framework to build intelligent multi-agent systems.