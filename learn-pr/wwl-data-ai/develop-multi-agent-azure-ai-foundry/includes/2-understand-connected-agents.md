As AI solutions become more advanced, managing complex workflows gets harder. A single agent can handle a wide range of tasks, but this approach can become unmanageable as the scope expands. That's why Azure AI Foundry Agent Service lets you connect multiple agents, each with a focused role, to work together in a cohesive system.

## What are connected agents?

Connected agents are a feature in the Azure AI Foundry Agent Service that allows you to break large tasks into smaller, specialized roles without building a custom orchestrator or hardcoding routing logic. Instead of relying on one agent to do everything, you can create multiple agents with clearly defined responsibilities that collaborate to accomplish tasks.

At the center of this system, there's a main agent that interprets user input and delegates tasks to connected sub-agents. Each sub-agent is designed to perform a specific function, such as to summarize a document, validate a policy, or retrieve data from a knowledge source.

This division of labor helps you:

- Simplify complex workflows
- Improve agent performance and accuracy
- Make systems easier to maintain and extend over time

## Why use connected agents?

Rather than scaling a single agent to handle every user request or data interaction, using connected agents lets you:

- Build modular solutions that are easier to develop and debug
- Assign specialized capabilities to agents that can be reused across solutions
- Scale your system in a way that aligns with real-world business logic

This approach is especially useful in scenarios where agents need to perform sensitive tasks independently, such has handling private data or generating personalized content.

Using connected agents to automate workflows offers many benefits, for example:

- **No custom orchestration required** - The main agent uses natural language to route tasks, eliminating the need for hardcoded logic.
- **Improved reliability and traceability** - The clear separation of responsibilities makes issues easier to debug since agents can be tested individually.
- **Flexible and extensible** - Add or swap agents without reworking the entire system or modifying the main agent.

Connected agents make it easier to build modular, collaborative systems without complex orchestration. By assigning focused roles and using natural language delegation, you can simplify workflows, improve reliability, and scale your solutions more effectively.