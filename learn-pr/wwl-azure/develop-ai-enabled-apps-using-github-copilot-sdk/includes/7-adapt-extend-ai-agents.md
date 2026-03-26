The implementation patterns from the previous unit apply to every agent you build. Different scenarios, however, bring different requirements. A customer-facing agent needs conversational finesse and privacy controls, while an internal operations agent demands reliability and compliance. This unit explores how to adapt your agent's configuration and behavior for these two categories of deployment.

## Customer-facing agents

Agents that interact directly with end users—such as customer support or sales assistants—require extra attention to conversation quality, personalization, and privacy.

### Conversation quality

The system prompt is your primary tool for controlling how the agent communicates. Define the desired tone, style, and response length:

- **Tone and style**: Include guidelines like "Respond in a friendly and professional manner" or "Use simple language and avoid technical jargon." For a support agent, an empathetic tone works well. For a sales assistant, a more informative tone might be appropriate.
- **Clarifying questions**: Instruct the agent to ask for clarification when a request is ambiguous rather than guessing. For example: "If the user's request is unclear, ask a polite clarifying question before taking action."
- **Response length**: Guide the agent to keep responses concise: "Keep responses under three sentences unless the user asks for more detail."

These guidelines can be refined iteratively. Test conversation flows with the agent and adjust the system prompt based on the results.

### Personalization and data privacy

Customer-facing agents often access personal data like order history and account details. Balance personalization with privacy protection:

- **User context injection**: When a session starts, inject relevant user information through the system prompt or initial context. For example, include the user's name, account tier, and recent order history so the agent can provide personalized service.
- **Privacy instructions**: Add explicit rules to the system prompt: "Only discuss the account data of the logged-in user. Don't reveal internal reference codes or sensitive system information."
- **Data minimization in tools**: If a tool retrieves sensitive information (like a full address), filter the response in the tool handler to return only what the agent needs (like the shipping city).

### Knowledge integration

Support and sales agents often need access to product information, FAQs, or policy documents that go beyond the AI model's training data. The **Retrieval-Augmented Generation (RAG)** pattern addresses this requirement by giving the agent a search tool:

- Define a tool like `search_knowledge_base(query)` that queries your documentation or FAQ system.
- Instruct the agent (through the system prompt) to use this tool when answering product or policy questions.
- Keep the knowledge base current to avoid outdated responses.

This approach grounds the agent's answers in your actual documentation rather than relying on the model's training data, which reduces inaccurate responses.

### Human handoff

Even well-configured agents encounter situations they can't resolve. Build a clear escalation path:

- Provide an `escalate_to_human(reason)` tool that transfers the conversation to a human representative with all context the agent gathered.
- Instruct the agent to use this tool when it can't resolve a request or when the user explicitly asks for a human.
- During initial deployment, consider routing agent responses through a human review queue before they reach the customer, to build confidence in the agent's quality.

## Back-office and autonomous agents

Agents that operate behind the scenes—such as finance automation, supply chain management, or IT operations agents—prioritize reliability, accuracy, and integration with enterprise systems over conversational quality.

### Determinism and verification

In enterprise processes, predictable behavior is critical:

- **Structured outputs**: Design tool interfaces so the agent provides specific field values rather than free-form text for system inputs. For example, have the agent pass structured parameters to a `create_journal_entry(account, amount, description)` tool rather than generating the entire entry as text.
- **Calculations in code**: Use tools for any mathematical operations rather than relying on the AI model. A `calculate_tax(amount, rate)` tool produces reliable results, while the model might introduce arithmetic errors.
- **Historical validation**: Before deployment, run the agent against known historical data and compare its decisions to what humans did. Discrepancies help you tune thresholds and instructions.

### Scheduling and triggers

Unlike interactive agents, back-office agents are often started by events or schedules rather than user input:

- **Scheduled tasks**: A cron job or scheduled service creates a GitHub Copilot SDK session, provides context (like "perform the daily invoice reconciliation"), and lets the agent execute.
- **Event-driven**: A monitoring alert or webhook triggers session creation and sends the event details as input. Each event typically gets its own session to prevent context mixing.
- **Stateless execution**: Process each task or event in an independent session. This approach avoids carry-over confusion between unrelated operations.

### Enterprise system integration

Back-office agents interact heavily with APIs and databases. Build robustness into your tool handlers:

- **Retries and timeouts**: Implement retry logic with exponential backoff in tool handlers that call external systems.
- **Transaction safety**: If the agent performs multiple related writes, consider using a single tool that handles the full transaction atomically, rather than separate tools for each step.
- **Least-privilege access**: Use service accounts with minimal permissions for the agent's API calls. This approach limits the effect of unexpected behavior.
- **Audit logging**: Log every action the agent takes, including which tool was called, what parameters were passed, and what result was returned. Include an identifier that marks the action as agent-initiated.

### Human oversight

Autonomous agents should still have a human safety net:

- **Alerting**: Provide a `notify_manager(issue)` tool that the agent can use when it encounters situations outside its training or when an issue persists after multiple attempts.
- **Periodic review**: Have domain experts review the agent's decisions regularly, especially during early deployment.
- **Manual override**: Implement a feature flag or mode switch that can quickly change the agent from autonomous execution to advisory mode, where it logs recommendations but doesn't take action.

## Performance and cost considerations

When agents run frequently or process large volumes, consider:

- **Model selection**: Use a faster, less expensive model for routine tasks and reserve more capable models for complex reasoning. The SDK lets you configure the model per session.
- **Batch processing**: If an agent needs to process many items, frame the work within a single session rather than creating a separate session for each item.
- **Multi-agent patterns**: For complex workflows, consider splitting responsibilities across multiple sessions with different configurations and tool sets. One agent might handle analysis while another handles execution, with your application orchestrating between them.

## Summary

Adapting your AI agent for different deployment scenarios involves tailoring its conversation style, tool set, and operational patterns to fit the use case. Customer-facing agents prioritize conversational quality and personalization while maintaining privacy, whereas back-office agents focus on reliability, integration, and autonomous operation. By designing your agent with these considerations in mind, you can maximize its effectiveness and business value in any context. In the next unit, you'll see how to implement these adaptations in practice using the GitHub Copilot SDK.
