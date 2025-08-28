Orchestrations in the Semantic Kernel SDK run within a managed environment that handles their entire lifecycle. The runtime is the central component that enables orchestrations to execute, communicate, and interact with agents in a reliable and scalable way. By understanding how the runtime works, and how features like timeouts, callbacks, structured data, and cancellation behave, you can build orchestration workflows that are both predictable and adaptable.

## The role of the runtime

The runtime acts as the execution engine for orchestrations, providing a space where agents can send and receive messages, run tasks, and manage resources. It is responsible for:

- **Message routing** – Delivering messages between agents and orchestration-specific actors, using either direct or pub-sub style messaging depending on the orchestration design.
- **Actor lifecycle management** – Creating, registering, and managing all participating agents and orchestration actors, ensuring that each one operates independently and securely.
- **Execution context** – Allowing multiple orchestrations to run at the same time, each with its own state and resources, without interfering with each other.

You can think of the orchestration as the plan or "map," and the runtime as the engine that runs it—controlling timing, message flow, and execution order.

## Handling timeouts

When you invoke an orchestration, it immediately returns a handler you can use to retrieve results later. This asynchronous approach makes it possible to start long-running processes without blocking the rest of your application.

If a timeout is reached when waiting for results, the orchestration is not stopped—it continues running in the background until completion. You can check for results later, or set a timeout for the retrieval process itself to avoid waiting indefinitely.

## Human-in-the-loop interactions

Some orchestrations benefit from direct human participation. The SDK provides two main ways to integrate people into orchestration lifecycles:

- **Agent response callbacks** – A function that is called whenever an agent produces output, enabling you to observe results in real time and update user interfaces, logs, or analytics dashboards.
- **Human response functions** – A mechanism for requesting and capturing user input during an orchestration, which is useful for decision points, approvals, or collaborative workflows.

## Working with structured data

The Semantic Kernel SDK supports passing and returning structured data between orchestrations and agents.

- **Structured inputs** – By defining your inputs as structured data models, you can enforce type safety, make orchestrations more reusable, and simplify complex data handling.
- **Structured outputs** – Orchestrations can return structured results that your application can consume directly, making it easier to integrate with other systems or perform additional processing.

Internally, orchestrations still exchange messages in a common format, but structured data layers add clarity, maintainability, and developer efficiency.

## Cancelling orchestrations

You can cancel an orchestration while it’s running. This stops any new messages from being processed by agents, although agents already handling tasks will finish them. Cancelling does not shut down the runtime itself, which means other orchestrations can continue running without disruption.

Managing orchestration lifecycles in the Semantic Kernel SDK is about more than simply starting and stopping workflows. The runtime provides a controlled environment for executing orchestrations, routing messages, and handling resources. Features like asynchronous execution, human-in-the-loop callbacks, structured data handling, and cancellation give you the flexibility to design reliable, adaptive processes. By mastering these capabilities, you can build orchestration workflows that are efficient, maintainable, and ready for real-world complexity.