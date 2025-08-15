**Magentic orchestration** is a flexible, general-purpose multi-agent pattern designed for complex, open-ended tasks that require dynamic collaboration.This pattern uses a dedicated Magentic manager to coordinate a team of specialized agents. The manager decides which agent should act next based on the evolving context, task progress, and agent capabilities.

![Diagram of Magentic orchestration flow.](../media/multi-agent-magnetic.png)

The Magentic manager maintains a shared context, tracks progress, and adapts the workflow in real time. This allows the system to break down complex problems, assign subtasks, and iteratively refine solutions. The process focuses as much on building and documenting the approach as it does on delivering the final solution. A dynamic task ledger is built and refined as the workflow progresses, recording goals, subgoals, and execution plans. 

## When to use Magentic orchestration

Consider using the Magentic orchestration pattern in these scenarios:

- The problem is complex or open-ended with no predetermined solution path.  
- Input and feedback from multiple specialized agents are needed to shape a valid solution.  
- The system must generate a documented plan of approach for human review.  
- Agents have tools that can directly interact with external systems and resources.  
- A step-by-step, dynamically built execution plan adds value before running the tasks.  

## When to avoid Magentic orchestration

You may want to avoid this pattern when:

- The solution path is fixed or deterministic.  
- There's no need to produce a ledger or plan of approach.  
- The task is simple enough for a more lightweight orchestration pattern.  
- Speed is the priority, as this method emphasizes planning over fast execution.  
- You expect frequent stalls or loops without a clear resolution path.  

## Implementing Magentic orchestration

Implement the Magentic orchestration pattern with the Semantic Kernel SDK:

1. **Define specialized agents**  
   Create agent instances (for example, `ChatCompletionAgent`) with specific instructions and AI services. Each agent should have a specialized role.

1. **Set up the Magentic manager**  
   The `StandardMagenticManager` coordinates agent collaboration, plans workflows, and tracks progress.

1. **Add optional response observation**  
   Define a callback to monitor and log agent messages in real time.

1. **Create the orchestration**  
   Combine agents and the manager in a `MagenticOrchestration` object.

1. **Start the runtime**  
   Use `InProcessRuntime` to manage execution.

1. **Invoke the orchestration**  
   Invoke the orchestration with your complex task. The manager plans, delegates, and coordinates the agents to solve the problem.

1. **Collect and process results**  
   Wait for orchestration completion, then output the final report.

1. **Stop the runtime (optional)**  
   Cleanly shut down to free resources.

Magentic orchestration excels at solving complex, evolving problems that require real-time coordination between specialized agents. It's ideal for tasks where the plan can't be defined in advance and must adapt as new information emerges. Using the Semantic Kernel Python SDK, you can build systems that dynamically design, refine, and execute solution paths.