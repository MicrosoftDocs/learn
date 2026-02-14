You explored what AI agents can do. Now consider how to design the system that makes them work. Regardless of the specific scenario, AI agents share a common architectural blueprint. This unit covers the foundational components—the AI model, tools, planner, memory, and guardrails—that every agent system requires. Understanding this blueprint helps you implement agents more effectively when you work with the GitHub Copilot SDK.

## Core components of an AI agent system

Every AI agent, whether it handles customer support or monitors IT infrastructure, is built from the same set of architectural building blocks.

### AI reasoning engine

At the heart of the agent is a large language model (LLM), such as GPT-5, that interprets instructions and generates responses. This LLM is the component that "reasons" and decides what to do next at each step. The LLM's broad training gives it language understanding and general knowledge, while the agent framework gives it the ability to act on that reasoning.

In the GitHub Copilot SDK, you select the model when you configure a session. Different models offer different tradeoffs between speed, cost, and reasoning capability, and the SDK supports switching models between sessions.

### Tools

Tools are external functions or APIs that the agent can invoke during its reasoning process. Each tool represents a specific action the agent can take—looking up a database record, calling a REST API, sending an email, or running a diagnostic command. Tools are how the agent moves beyond generating text and actually interacts with real systems.

Designing the right set of tools is a critical decision. You want to give the agent enough tools to be useful, but not so many that it becomes confused or overpowered. Each tool should do one thing well, with a clear name and description that helps the AI model understand when to use it.

### Planner and controller

The planner orchestrates the agent's reasoning and tool use. It decides when to invoke a tool, when to ask a clarifying question, and when to produce a final answer. Modern AI agents use techniques like the ReAct (Reason + Act) loop, where the agent alternates between thinking (the LLM proposes a step) and acting (calling a tool).

The GitHub Copilot SDK provides this planner as a built-in feature. The SDK's agent loop handles the orchestration—you configure the components and the SDK manages the execution cycle of plan, act, observe, and repeat.

### Memory and context

Unlike a stateless API call, agents maintain contextual memory throughout a session. The agent's *awareness* includes conversation history, tool outputs, and any data retrieved during previous steps. Memory is what enables coherence: when a user says "actually, it was the wrong color," the agent knows that "it" refers to the item discussed earlier.

The GitHub Copilot SDK manages short-term memory automatically by tracking conversation history within a session. For sessions that might exceed the model's context window, the SDK's infinite sessions feature compacts older context to prevent token overflow while preserving essential information.

### Policies and guardrails

Because AI agents take autonomous actions, you need constraints to ensure they operate safely and as intended. Guardrails fall into several categories:

- **Scope limits**: Define what the agent can and can't do. For example, allow the agent to process returns but require human approval for refunds above a specific amount.
- **Permission controls**: Use the SDK's `OnPreToolUse` hook to intercept tool calls before they execute. The hook returns a `PermissionDecision` value (`Allow`, `Deny`, or `Ask`) that controls whether the action proceeds, is blocked, or requires user confirmation.
- **Safety filters**: Instruct the agent (through the system prompt) to stay within its domain and avoid revealing internal information.
- **Fallback and escalation**: Design what happens when the agent can't resolve a request. This guardrail typically means handing off to a human with the context the agent gathered.

In the GitHub Copilot SDK, guardrails come from three sources: the tools you expose (which inherently limit what the agent can do), the system prompt (which guides behavior), and code-level controls in your tool handlers and session hooks.

## Agent workflow in practice

When an agent receives a request, it follows an iterative workflow:

1. **Receive input**: The user sends a message or an event triggers the agent.
1. **Reason and plan**: The LLM interprets the input, identifies the goal, and decides what action to take first.
1. **Act**: The agent calls a tool (for example, looking up an order in the database).
1. **Observe**: The tool returns a result, and the agent evaluates whether it has enough information to respond.
1. **Iterate or respond**: If more information or actions are needed, the agent loops back to step 2. Once the goal is met, it produces a final response.

This cycle can repeat multiple times within a single user request. The GitHub Copilot SDK manages this loop automatically through its agent execution engine.

### Example walkthrough

Consider how an e-commerce return agent handles a request:

1. **User input**: "I received the wrong item, order 12345. I want to return it."
1. **Plan**: The agent identifies two goals: verify the order and initiate a return.
1. **Tool call**: The agent calls `get_order_details(12345)` to retrieve order information.
1. **Observe**: The tool returns the order details, confirming the item and delivery date.
1. **Tool call**: The agent calls `process_return(12345)` to create a return request.
1. **Observe**: The tool returns a confirmation number.
1. **Respond**: The agent tells the user: "I've created return RMA-1001 for Order 12345 and scheduled a pickup for tomorrow. You'll receive your refund in 3-5 business days."

The agent used two tools and reasoned through multiple steps, but from the user's perspective, it was a single smooth interaction.

## Design decisions for the GitHub Copilot SDK

When designing an agent to build with the GitHub Copilot SDK, focus on three areas:

- **Context**: What information does the agent need at the start of each session? The context typically includes a system prompt that defines the agent's role and behavior guidelines, plus any user-specific data that enables personalized responses.
- **Tools**: What actions should the agent be able to take? Define each tool with a clear name, description, and parameter schema. Implement the business logic in the tool handler.
- **Policies**: What rules must the agent follow? Encode policies as system prompt instructions, tool handler validations, or session hook logic.

You also need to plan for failure modes. If a tool call fails, should the agent retry, try an alternative approach, or escalate? These decisions can be encoded in the system prompt ("if a tool returns an error, inform the user and offer alternatives") or handled programmatically in error-handling hooks.

## Summary

Designing an AI agent involves defining its reasoning capabilities, the tools it can use, how it maintains context, and the guardrails that ensure safe operation. The GitHub Copilot SDK provides a powerful framework for building agents with these components. By carefully designing the system prompt, selecting appropriate tools, and implementing policies, you can create agents that deliver real business value while operating within defined boundaries. In the next unit, you'll see how to apply these design principles in practice by building a sample agent with the GitHub Copilot SDK.
