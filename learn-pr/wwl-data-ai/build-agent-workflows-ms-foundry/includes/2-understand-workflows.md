Workflows in Microsoft Foundry provide a way to orchestrate AI-driven actions using a visual, declarative approach. Rather than writing code, you define a sequence of steps that describe what should happen and when, allowing the platform to manage execution and state. This makes workflows well suited for business processes that combine AI reasoning, logic, and user interaction.

A workflow consists of connected nodes, where each node performs a specific function. Some nodes invoke agents, while others evaluate conditions, manage data, or communicate with users. Together, these nodes form an execution path that determines how requests move through the system. By arranging and configuring nodes, you control how information flows and how decisions are made.

:::image type="content" source="../media/group-chat-workflow.png" alt-text="A screenshot of a group chat workflow in Microsoft Foundry.":::

One of the key advantages of workflows is their ability to coordinate multiple agents. Single-agent solutions often struggle with complex or ambiguous tasks, but workflows allow you to combine agents with different responsibilities—such as classification, decision-making, and resolution—into a cohesive process. This orchestration enables more robust and scalable automation.

Workflows also support patterns that balance automation with oversight. In scenarios where confidence is low or additional context is required, workflows can pause execution, request human input, or escalate decisions. This flexibility makes workflows suitable for real-world systems where reliability and control are just as important as efficiency.

By understanding what workflows are and the problems they are designed to solve, you establish the conceptual foundation needed to build, extend, and reason about agent-driven systems in Microsoft Foundry.