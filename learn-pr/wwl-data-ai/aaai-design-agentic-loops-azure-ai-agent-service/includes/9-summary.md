Production agent systems require architectural patterns that go beyond basic request-response loops. Stateful agentic loops manage complex run lifecycles, implement multi-pass reasoning through reflection cycles, architect persistent session state, and enable workflow branching through fork-based patterns. As Microsoft Foundry introduces the Agents v2 Responses API, understanding both generations—and the migration path between them—is essential for building durable production systems.

You explored how the run status taxonomy determines agent behavior in Agents v1—handling `requires_action` for tool submission, managing `failed` states with error-specific recovery strategies, and implementing loop termination conditions that keep costs predictable. You then learned how the Foundry Responses API simplifies this with a synchronous `responses.create()` model that returns output items directly, eliminating the polling loop entirely.

Reflection cycles transform single-pass generation into iterative refinement, with plan-then-act and act-then-reflect patterns providing structured approaches to complex reasoning tasks—in both v1 (thread message injection) and v2 (`previous_response_id` chaining).

Session state persistence moves beyond ephemeral threads to durable storage in Azure Cosmos DB, enabling resumable workflows that survive process restarts. In Agents v2, conversation-based history and `previous_response_id` chaining reduce the need for custom persistence, though cross-session memory and compliance scenarios still benefit from external storage.

Fork-based session patterns enable exploring alternative reasoning paths from shared checkpoints. In v2, `previous_response_id` forks eliminate serialization overhead entirely—multiple branches point to the same parent response ID and run independently, with background mode enabling true parallel execution.

The migration unit gives you a structured path from v1 to v2: update packages, split the client, migrate agent creation to named versioned assets, replace the polling loop with synchronous responses, and adapt tool handling from `requires_action` to output item iteration.

**Key architectural decisions from this module:**

- **Run status handling** determines production robustness in v1—handle all eight status values with specific recovery strategies; in v2, status handling is replaced by exception handling on synchronous response calls
- **Reflection depth** weighs quality improvement against cost—1-2 cycles for most scenarios, with confidence thresholds for early termination; `previous_response_id` chaining makes v2 reflection code simpler
- **Context management strategy** differs by generation—v1 requires external Cosmos DB for durability; v2 offers server-managed conversation history, stateless `previous_response_id` chains, and `store=False` for compliance
- **Fork branching** is cheaper in v2—`previous_response_id` forks require no serialization; use conversation duplication for long multi-turn branches
- **Migration planning** requires timeline consideration—Agents v1 retires March 31, 2027; tool availability changes (Azure Functions removed, Web Search and A2A added) may require architectural decisions beyond SDK changes

The patterns you implemented support Contoso Capital's production multi-agent platform. The same architectural principles apply to any production agent system requiring persistent state, complex reasoning, and workflow flexibility.

## Learn more

- [Microsoft Foundry Agent Service documentation](https://learn.microsoft.com/azure/foundry/agents/overview)
