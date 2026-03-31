Now that you have GitHub Copilot and Fabric Copilot enabled, you can customize how they behave during chat sessions. Selecting the right model and configuring Model Context Protocol (MCP) tools significantly improves the relevance and accuracy of AI suggestions for your database work.

## Understanding model selection

GitHub Copilot supports multiple AI models, each with different capabilities and performance characteristics. You can select which model to use for different scenarios based on your needs. Available models typically include:

- **GPT**: Advanced reasoning capabilities, excellent for complex T-SQL generation and database design questions
- **Claude models**: Strong at explaining code and providing detailed documentation
- **Gemini models**: Available in some configurations with different strengths

To change models in a Copilot chat session in **SSMS**:

1. Open the Copilot Chat window
2. Look for the model selector dropdown at the top of the chat
3. Select the model you want to use for your current session

To change models in a Copilot chat session in **VS Code**:

1. Open the Copilot Chat panel (**Ctrl+Alt+I**)
2. Use the model picker in the chat interface
3. Switch models as needed for different tasks

> [!TIP]
> For complex query optimization or database design questions, try more advanced models. For quick code completions, faster models often provide sufficient results with lower latency.

## What is Model Context Protocol (MCP)?

Model Context Protocol (MCP) is an open standard that allows AI assistants to connect directly to external data sources and tools. Instead of the AI assistant only seeing the code in your editor, MCP enables it to query your actual database schema, sample data, and metadata in real time.

With MCP configured, when you ask "What columns are in the Customers table?", the assistant can query your database directly rather than relying on whatever code context is visible in your editor. This produces more accurate and reliable suggestions.

:::image type="content" source="../media/data-flow.png" alt-text="Diagram showing Model Context Protocol architecture with GitHub Copilot as the MCP Host connecting through an MCP Client to an MCP Server that accesses a SQL Database.":::

MCP follows a client-server architecture:

- **MCP Host**: Your AI environment (GitHub Copilot, Claude, etc.)
- **MCP Client**: The protocol client that connects to MCP servers
- **MCP Server**: A service that exposes specific data sources or tools

## Configure MCP tools in GitHub Copilot

GitHub Copilot supports MCP integration through agent mode in VS Code. To [use MCP servers in VS Code](/azure/data-api-builder/mcp/quickstart-visual-studio-code?azure-portal=true):

### Enable agent mode

Agent mode allows GitHub Copilot to use external tools, including MCP servers, to gather context and perform actions on your behalf.

1. Open the Copilot Chat panel in VS Code
2. Look for the mode selector (Ask, Edit, or Agent)
3. Switch to **Agent** mode to access MCP tools

### Add an MCP Server

You can add MCP servers to your VS Code workspace using the Command Palette or by manually editing the configuration file.

1. Open the Command Palette (**Ctrl+Shift+P**)
2. Type **MCP: Add Server** and select it
3. Choose the server type (HTTP or Stdio)
4. Enter the server URL or configuration

### Manage MCP Tools

Once MCP servers are added, you can control which tools are active for each chat session.

1. In Agent mode, select the tools icon in the chat panel
2. View available MCP servers and their tools
3. Enable or disable specific tools as needed

When MCP tools are configured, you'll see them listed when you click the tools icon in Agent mode. The assistant can then use these tools to query your databases and provide contextual suggestions.

## MCP server options for SQL databases

Several MCP server options are available for connecting AI assistants to SQL databases:

- **SQL MCP Server**: Connects to SQL Server and Azure SQL databases using Microsoft's open-source solution built on Data API builder. This option provides a secure, managed way to expose database metadata to AI assistants.

- **Microsoft Fabric MCP Server**: Connects to [Fabric data agents as MCP servers](/fabric/data-science/data-agent-mcp-server?azure-portal=true), enabling AI assistants to query lakehouses, warehouses, and SQL databases within Fabric workspaces.

- **Azure MCP Server**: Provides broader Azure resource integration, including database services.

To configure a SQL MCP server in VS Code:

1. Create a `.vscode` folder in your workspace (if it doesn't exist)
2. Create a file named `mcp.json` in the `.vscode` folder
3. Add your server configuration:

```json
{
  "servers": {
    "sql-server": {
      "type": "http",
      "url": "https://your-mcp-endpoint/mcp"
    }
  }
}
```

4. VS Code detects the configuration and prompts you to start the server
5. Authenticate when prompted

## Configure MCP in Fabric Copilot

Fabric Copilot automatically has access to your workspace resources, but you can publish data agents as MCP servers for use in external tools:

1. Create and configure a data agent in your Fabric workspace
2. Publish the data agent
3. Go to the agent's **Settings** and open the **Model Context Protocol** tab
4. Copy the **MCP server URL**
5. Use this URL to configure MCP clients in VS Code or other tools

This approach allows you to use the same data agent from both the Fabric portal and external development environments.

## Best practices for model and MCP configuration

- **Start with defaults**: Begin with default model and MCP settings, then adjust based on your experience. Not every scenario requires the most advanced configuration.

- **Match models to tasks**: Use more capable models for complex design decisions, simpler models for routine code completion.

- **Limit MCP scope**: Configure MCP connections with least-privilege access. If your AI workflow only needs schema information, don't grant data read permissions.

- **Test configurations**: After changing model or MCP settings, verify the assistant still provides accurate suggestions. Different models might interpret prompts differently.

> [!IMPORTANT]
> MCP servers establish direct connections to your databases. Ensure your network security policies allow these connections and that authentication follows the security best practices covered earlier in this module.

With model selection and MCP tools configured, your AI assistant has the context it needs to provide accurate, database-specific suggestions. The next unit covers how to create custom instruction files that further guide the assistant's behavior.
