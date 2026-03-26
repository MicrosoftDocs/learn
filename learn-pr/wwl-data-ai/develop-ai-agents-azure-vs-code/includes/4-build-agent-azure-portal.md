Building your first AI agent in the Foundry portal provides an accessible entry point to agent development. The portal's visual interface guides you through configuration without requiring code, making it easy to understand agent concepts while creating functional automation.

## Creating an agent in the Foundry portal

The Foundry portal streamlines agent creation through an intuitive interface:

1. **Navigate to Microsoft Foundry** at https://ai.azure.com and sign in with your Azure credentials
1. **Select your project** from the list of available projects, or create a new one
1. **Select Build > Agents** in the left navigation menu
1. **Select Create** to start building a new agent
1. **Enter agent details**:
   - **Name**: Provide a descriptive name for your agent
   - **Description**: Add a clear description of the agent's purpose
   - **Model**: Select a deployed model from the dropdown, or deploy a new model

The portal creates your agent and opens the configuration interface where you can refine its behavior and capabilities.

## Configuring agent instructions and properties

Agent instructions are the foundation of agent behavior. In the **Instructions** field, you define how your agent understands its role, responds to users, and handles various scenarios. Clear, specific instructions lead to consistent, reliable agent behavior. You'll configure instructions in more detail when working in Visual Studio Code later in this module.

Beyond instructions, the portal lets you configure model parameters such as **Temperature** (which controls response randomness) and **Top P** (which controls response diversity). These configuration options are explored further in the Visual Studio Code configuration unit.

## Testing your agent in the portal

The Foundry portal includes an integrated playground for testing your agent before deployment. This testing environment lets you validate instructions, try different scenarios, and refine behavior based on results.

To test your agent, select the Playground tab and start a conversation. The playground maintains conversation history during your session, allowing you to test multi-turn interactions and verify the agent maintains context appropriately.

## Adding basic tools

Before deployment, you can enhance your agent with tools from the tool catalog in the **Tools** section of the agent configuration (also accessible via **Build > Tools** in the portal). The catalog organizes tools into three categories:

- **Configured** - Built-in tools ready to use immediately, such as Code Interpreter and File Search
- **Catalog** - Additional tools you can add, including Bing Web Search, Azure AI Search, SharePoint, and more
- **Custom** - Your own tools added through OpenAPI specifications or MCP servers

Tool capabilities and configuration are explored in detail in the *Extend agent capabilities* unit later in this module.

## Deploying your agent

Once you're satisfied with your agent's behavior in testing, you can deploy it for production use. The portal provides clear deployment status indicators and generates the connection information needed to integrate the agent into your applications. After deployment, you can access the agent through the Microsoft Foundry SDK or REST APIs.

Building agents in the Foundry portal provides an accessible, visual approach to agent development. The interface guides you through configuration while offering powerful capabilities for creating sophisticated automation.
