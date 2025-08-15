**Concurrent orchestration** lets multiple agents work on the same task at the same time. Each agent handles the task independently, and then their outputs are gathered and combined. This method works especially well when you want diverse approaches or solutions, like during brainstorming, group decision-making, or voting.

![Diagram of concurrent orchestration flow.](../media/multi-agent-concurrent.png)

This pattern is useful when you need different approaches or ideas to solve the same problem. Instead of having agents work one after another, they all work at the same time. This speeds up the process and covers the problem from many angles. 

Usually, the results from each agent are combined to create a final answer, but this isn’t always necessary. Each agent can also produce its own separate result, like calling tools to complete tasks or updating different data stores independently.

Agents work on their own and don't share results with each other. However, an agent can call other AI agents by running its own orchestration as part of its process. Agents need to know which other agents are available to work on tasks. This pattern allows you to either call all registered agents every time or choose which agents to run based on the specific task.

## When to use concurrent orchestration

You may want to consider using the concurrent orchestration pattern in these situations:

- When tasks can run at the same time, either by using a fixed group of agents or by selecting AI agents dynamically based on what the task needs.
- When the task benefits from different specialized skills or approaches (for example, technical, business, or creative) that all work independently but contribute to solving the same problem.

This kind of teamwork is common in multi-agent decision-making methods such as:

- Brainstorming ideas
- Combining different reasoning methods (ensemble reasoning)
- Making decisions based on voting or consensus (quorum)
- Handling tasks where speed matters and running agents in parallel cuts down wait time

## When to avoid concurrent orchestration

You may want to avoid using the concurrent orchestration pattern in the following scenarios:

- Agents need to build on each other's work or depend on shared context in a specific order.
- The task requires a strict sequence of steps or predictable, repeatable results.
- Resource limits, like model usage quotas, make running agents in parallel inefficient or impossible.
- Agents cannot reliably coordinate changes to shared data or external systems while running at the same time.
- There's no clear way to resolve conflicts or contradictions between results from different agents.
- Combining results is too complicated or ends up lowering the overall quality.

## Implement concurrent orchestration 

Implement the concurrent orchestration pattern with the Semantic Kernel Python SDK:

1. **Define your agents**  
   Create agent instances (for example, `ChatCompletionAgent`) with specific instructions and AI services. Each agent specializes in a particular domain or skill set.

1. **Set up the concurrent orchestration**  
   Use the `ConcurrentOrchestration` class to create an orchestration that can run multiple agents in parallel. Pass your agent instances as members to this orchestration.

1. **Start the runtime**  
   Initialize and start an `InProcessRuntime` object to manage agent execution and coordination.

1. **Invoke the orchestration**  
   Call the orchestration's `invoke` method with the task or input you want the agents to work on. The orchestration runs all agents concurrently.

1. **Collect the results**  
   Gather the output asynchronously from all agents. The results are typically returned as a list, but the order of responses is not guaranteed.

1. **Stop the runtime (optional)**  
   After processing, cleanly stop the runtime to release resources.

Concurrent orchestration is a powerful pattern for leveraging multiple AI agents simultaneously, enabling faster and more diverse problem-solving. By running agents in parallel, you can explore different approaches at once, improve efficiency, and gain richer insights. However, it's important to choose this pattern when tasks can truly run independently and to be mindful of resource constraints and coordination challenges. When implemented thoughtfully with the Semantic Kernel Python SDK, concurrent orchestration can greatly enhance your AI workflows and decision-making processes.
