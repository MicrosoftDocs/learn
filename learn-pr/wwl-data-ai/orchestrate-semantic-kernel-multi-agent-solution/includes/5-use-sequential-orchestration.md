In **sequential orchestration**, agents are arranged in a pipeline where each agent processes the task one after another. The output from one agent becomes the input for the next. This pattern is ideal for workflows where each step depends on the previous one, such as document review, data transformation pipelines, or multi-stage reasoning.

![Diagram that shows sequential orchestration where agents process tasks in a defined pipeline order. Output flows from one agent to the next.](../media/multi-agent-sequential.png)

Sequential orchestration works best for tasks that need to be done step-by-step, with each step improving on the last. The order in which agents run is fixed and decided beforehand, and agents don't decide what happens next.

## When to use sequential orchestration

Consider using the sequential orchestration pattern when your workflow has:

- Processes made up of multiple steps that must happen in a specific order, where each step relies on the one before it.  
- Data workflows where each stage adds something important that the next stage needs to work properly.  
- Tasks where stages can't be done at the same time and must run one after another.  
- Situations that require gradual improvements, like drafting, reviewing, and polishing content.  
- Systems where you know how each agent performs and can handle delays or failures in any step without stopping the whole process.

## When to avoid sequential orchestration

Avoid this pattern when:

- Stages can be run independently and in parallel without affecting quality.
- The entire task can be done effectively by a single agent.
- Early stages may fail or produce poor output, and there's no way to stop or correct downstream processing based on errors.
- Agents need to collaborate dynamically rather than hand off work sequentially.
- The workflow requires iteration, backtracking, or dynamic routing based on intermediate results.

## Implement sequential orchestration

Implement the sequential orchestration pattern with the Semantic Kernel Python SDK:

1. **Define your agents**  
    Create agent instances (for example, `ChatCompletionAgent`) with specific instructions and AI services. Each agent should have a clear responsibility.

1. **Set up the sequential orchestration**  
   Use the `SequentialOrchestration` class to create an orchestration pipeline that executes agents one after another, and pass your agent instances to the object. Optionally, add callbacks to observe agent outputs during the sequence.

1. **Start the runtime**  
   Initialize and start an `InProcessRuntime` object to manage agent execution.

1. **Invoke the orchestration**  
   Call the orchestration's `invoke` method with the task or input you want the agents to work on. The orchestration processes the task through all agents sequentially. 

1. **Collect the final result**  
   Await and retrieve the final output after all agents have completed their steps.

1. **Stop the runtime (optional)**  
   After processing, cleanly shut down the runtime to free resources.

Sequential orchestration is ideal when your task requires clear, ordered steps where each agent builds on the previous one's output. This pattern helps improve output quality through stepwise refinement and ensures predictable workflows. When applied thoughtfully with the Semantic Kernel SDK, it enables powerful multi-agent pipelines for complex tasks like content creation, data processing, and more.