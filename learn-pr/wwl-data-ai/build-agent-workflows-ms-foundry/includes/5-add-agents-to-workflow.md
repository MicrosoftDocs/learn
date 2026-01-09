Agents are the core reasoning components within a Microsoft Foundry workflow. By adding agents to a workflow, you enable AI-driven decision-making, classification, and response generation as part of a larger orchestration. Each agent can be configured with a specific purpose, model, prompt, and set of tools, allowing workflows to combine multiple specialized capabilities.

You add agents to a workflow by inserting an **Invoke agent** node. This node can reference an existing agent from your Foundry project, or you can create a new agent directly within the workflow designer. The **Invoke agent** editor allows you to configure tools, knowledge bases, memory, and guardrails for the agent, tailoring its behavior to the workflow's needs. When you invoke an agent, the workflow passes context—such as user input or previously set variables—to the agent and receives a response that can be used in subsequent steps.

Agents can be reused across multiple workflows, which encourages modular design. For example, a single categorization agent might be invoked in many workflows to classify incoming requests, while different resolution agents handle follow-up actions. This separation of concerns makes workflows easier to maintain and evolve over time.

In addition to generating natural language responses, agents can be configured to return structured output. By defining a response format such as a JSON schema, you ensure that agent output follows a predictable shape. Structured outputs are especially useful when agent responses drive control flow, such as routing logic or variable assignment in later nodes. You can define an agent's output schema in the parameters of the **Details** tab of the **Invoke agent** editor.

:::image type="content" source="../media/agent-parameters.png" alt-text="Screenshot of the Invoke agent node parameters showing the response schema configuration.":::

Once an agent is added to a workflow, its output can be stored in a variable and referenced throughout the workflow. Using variables allows agents to influence decisions, trigger conditional branches, or provide input to other agents. You can configure variable storage in the **Action settings** of the **Invoke agent** node.

:::image type="content" source="../media/agent-action-settings.png" alt-text="Screenshot showing how to store agent output in a variable for later use in the workflow.":::

By thoughtfully adding and configuring agents, you transform a simple sequence of actions into an intelligent, adaptive workflow. 