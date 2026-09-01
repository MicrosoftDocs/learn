Caldova's assistant must choose the right capability for each request and behave reliably when planners use it. How do you shape those decisions, run the configured agent, and check that it behaves as intended?

## Shape the agent's behavior

**Instructions** define the agent's role, goals, boundaries, and response style. The **model** provides the reasoning and tool-use capabilities needed for the task. **Tools** connect the agent to knowledge, live data, computation, or actions. **Controls** determine how the agent handles unsafe content and accesses protected resources.

These choices work together for every request. Caldova's instructions tell the assistant to answer from company evidence rather than guess. When a planner asks about approved partners, the agent selects File search because the answer comes from policy. When the planner asks whether a material is available, it selects `check_stock` because the answer requires live inventory. Clear tool descriptions help the agent make that choice.

:::image type="content" source="../media/capability-tools.png" alt-text="Two message paths show an agent selecting File search for a policy question and returning an answer tagged Grounded and Citation, or selecting check_stock for an inventory question and returning an answer tagged Live data." lightbox="../media/capability-tools.png":::

Security controls apply across those interactions. Content filters block harmful content, Prompt Shields detect attacks in prompts and retrieved documents, and managed identity authenticates the agent without stored credentials. Least-privilege access limits what each tool can do.

:::image type="content" source="../media/capability-security.png" alt-text="Three risk messages map to security controls: a request to write a threat maps to content filters, an instruction to ignore policy maps to Prompt Shields, and a request to use a stored API key maps to managed identity.":::

## Run and manage the agent in Microsoft Foundry

Once you've configured the agent, how does Foundry run and manage it? **Microsoft Foundry Agent Service** hosts and scales the agent. When a planner sends a request, the agent runtime applies your configuration, manages the conversation, and coordinates the model and any tool calls needed to produce a response.

Foundry also helps you check what happens during and after each run. **Tracing** records inputs, outputs, tool calls, and latency so you can investigate the agent's decisions. **Evaluations** measure qualities such as response accuracy, safety, and tool use before you release a change. **Monitoring** then tracks the deployed agent's performance and reliability.

:::image type="content" source="../media/foundry-agent-service.png" alt-text="A request enters Microsoft Foundry Agent Service, where the runtime applies the agent configuration and coordinates the model and tools to produce a response. Evidence from the run then supports tracing, evaluation, and deployment monitoring." lightbox="../media/foundry-agent-service.png":::

You define how the agent should behave. Foundry runs that configuration and gives you evidence that it behaves as intended.
