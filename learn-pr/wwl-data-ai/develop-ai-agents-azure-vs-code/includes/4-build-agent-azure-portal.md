Building your first AI agent in the Foundry portal provides an accessible entry point to agent development. The portal's visual interface guides you through configuration without requiring code, making it easy to understand agent concepts while creating functional automation.

## Creating an agent in the Foundry portal

The Foundry portal streamlines agent creation through an intuitive interface:

1. **Navigate to Microsoft Foundry** at https://ai.azure.com and sign in with your Azure credentials
1. **Select your project** from the list of available projects, or create a new one
1. **Navigate to Agents** in the left navigation menu
1. **Select Create** to start building a new agent
1. **Enter agent details**:
   - **Name**: Provide a descriptive name for your agent
   - **Description**: Add a clear description of the agent's purpose
   - **Model**: Select a deployed model from the dropdown, or deploy a new model

The portal creates your agent and opens the configuration interface where you can refine its behavior and capabilities.

## Designing effective agent instructions

Agent instructions are the foundation of agent behavior. These instructions define how your agent understands its role, responds to users, and handles various scenarios. Well-crafted instructions lead to consistent, reliable agent behavior.

### Writing clear instructions

When writing system instructions for your agent:

**Be specific and clear** - Define exactly what the agent should do and how it should behave. Vague instructions lead to unpredictable responses.

**Provide context** - Explain the agent's role and the environment it operates in. For example: "You're a customer service agent for a healthcare organization. You help patients schedule appointments and answer general questions about services."

**Set boundaries** - Clearly define what the agent should and shouldn't do. Include guidelines for handling requests outside its scope.

**Include examples** - Show the agent examples of desired interactions when helpful. Examples demonstrate the tone, style, and level of detail you expect.

**Define personality** - Establish the tone and style of responses. Should the agent be formal or casual? Technical or accessible?

### Instruction example for a customer service agent

```text
You're a helpful customer service agent for Contoso Healthcare. Your role is to assist patients with scheduling appointments, answering questions about our services, and providing general information.

When helping patients:
- Always be polite, professional, and empathetic
- Confirm appointment details before finalizing bookings
- If asked about medical advice, politely explain you can't provide medical guidance and suggest consulting with their healthcare provider
- For complex billing questions, offer to connect them with our billing department
- Maintain patient privacy and never share personal information

Keep responses concise but informative. Use a warm, professional tone that makes patients feel cared for.
```

This instruction provides clear role definition, behavioral guidelines, boundaries, and tone guidance; all essential elements for consistent agent performance.

## Configuring agent properties

Beyond instructions, agents have several important properties you configure in the portal:

### Temperature setting

Temperature controls response randomness. Lower values (0.1-0.3) produce consistent, focused responses. Higher values (0.7-1.0) generate more creative, varied outputs. For most business agents, values between 0.3 and 0.7 balance consistency with natural language variation.

### Top P setting

Top P (nucleus sampling) controls response diversity by limiting the model's vocabulary choices. Values near 1.0 allow more variety, while lower values constrain outputs to more likely options. Most scenarios work well with the default value of 1.0.

### Response length limits

You can set maximum token limits for responses, preventing overly long outputs and controlling costs. Consider your use case—customer service agents might need shorter, focused responses, while research agents might benefit from longer, detailed answers.

## Testing your agent in the portal

The Foundry portal includes an integrated playground for testing your agent before deployment. This testing environment lets you validate instructions, try different scenarios, and refine behavior based on results.

To test your agent, select the Playground tab and start a conversation. The playground maintains conversation history during your session, allowing you to test multi-turn interactions and verify the agent maintains context appropriately.

## Adding basic tools

Before deployment, you can enhance your agent with basic capabilities:

**Code Interpreter** - Enables the agent to write and execute Python code for calculations, data analysis, and problem-solving.

**File Search** - Allows the agent to search through uploaded documents to answer questions.

**Bing Search** - Connects your agent to real-time internet information.

You add these tools through the Tools section in the agent configuration. Tool capabilities are explored in detail later in this module.

## Deploying your agent

Once you're satisfied with your agent's behavior in testing, you can deploy it for production use. The portal provides clear deployment status indicators and generates the connection information needed to integrate the agent into your applications. After deployment, you can access the agent through the Microsoft Foundry SDK or REST APIs.

Building agents in the Foundry portal provides an accessible, visual approach to agent development. The interface guides you through configuration while offering powerful capabilities for creating sophisticated automation.
