Model Context Protocol (MCP) servers provide AI assistants with direct access to your data sources, enabling more accurate and contextual suggestions. Building on the MCP concepts from the previous units, this unit covers how to connect to MCP server endpoints for Microsoft SQL Server, Azure SQL databases, and Fabric Lakehouse environments.

## Connect to SQL Server MCP endpoints

For SQL Server and Azure SQL databases, you can use the [SQL MCP Server](/sql/mcp/?azure-portal=true) or configure direct connections through supported tools.

**Using SQL MCP Server:**

SQL MCP Server is Microsoft's open-source solution built on Data API builder that enables AI agents to interact with SQL databases. To set up [SQL MCP servers in VS Code](/azure/data-api-builder/mcp/quickstart-visual-studio-code?azure-portal=true):

1. Install and configure SQL MCP Server for your database
2. Enable the MCP endpoint in your SQL MCP Server configuration
3. Note the MCP endpoint URL (typically ending in `/mcp`)
4. Add the server to VS Code using the MCP: Add Server command

**Direct SQL Server connection:**

As covered in the earlier unit on enabling GitHub Copilot, you can use the MSSQL extension's built-in integration in VS Code. Right-click your connected database and select **Chat with this database** to start schema-aware conversations without configuring a separate MCP server.

## Connect to Azure SQL MCP endpoints

Azure SQL databases support the same connection methods as SQL Server. For cloud deployments, consider these additional options:

**Using Azure MCP Server:**

The Azure MCP Server provides integration across Azure services, including SQL databases:

1. Install the Azure MCP Server extension in VS Code
2. Authenticate with your Azure account
3. Configure access to your Azure SQL resources
4. Use Agent mode to query your databases

**Configuring network access:**

Azure SQL databases require network configuration for MCP connections:

- Ensure your client IP is allowed through the Azure SQL firewall
- For private endpoints, configure your network to allow MCP traffic
- Consider using service principals for automated or shared MCP access

```json
{
  "servers": {
    "azure-sql-mcp": {
      "type": "http",
      "url": "https://your-api-endpoint.azurewebsites.net/mcp",
      "headers": {
        "Authorization": "Bearer ${input:azure_token}"
      }
    }
  },
  "inputs": [
    {
      "id": "azure_token",
      "type": "promptString",
      "description": "Azure access token",
      "password": true
    }
  ]
}
```

## Connect to Fabric Lakehouse MCP endpoints

Microsoft Fabric provides MCP server capabilities through data agents, allowing AI assistants to query lakehouses, warehouses, and semantic models.

**Publishing a Fabric data agent as MCP server:**

1. Create a data agent in your Fabric workspace
2. Configure the data agent with access to your lakehouse or warehouse
3. Publish the data agent
4. Navigate to the agent's **Settings** > **Model Context Protocol** tab
5. Copy the **MCP server URL** and **tool description**

**Configuring VS Code to connect:**

Create or update your `.vscode/mcp.json` file:

```json
{
  "servers": {
    "fabric-lakehouse": {
      "type": "http",
      "url": "https://your-fabric-mcp-endpoint-url"
    }
  }
}
```

When VS Code detects this configuration:

1. Select **Add Server** when prompted
2. Authenticate with your Microsoft account
3. The Fabric MCP server appears in your available tools

**Using the [Microsoft Fabric MCP Server extension](https://marketplace.visualstudio.com/items?itemName=ms-fabric.vscode-fabric-mcp-server):**

For a streamlined experience, install the Fabric MCP Server extension from the VS Code marketplace. This extension simplifies configuration and provides better integration with Fabric workspaces.

## Configure authentication for MCP endpoints

MCP servers require authentication to access your data sources. Common authentication methods include:

**Interactive authentication**: You sign in through a browser prompt when connecting. Best for development environments.

**Service principal**: Configure a Microsoft Entra ID application with appropriate permissions. Best for automated scenarios and shared environments.

**API keys**: Some MCP servers support API key authentication. Store keys securely using environment variables or VS Code's input prompts.

> [!IMPORTANT]
> Never store credentials directly in configuration files that might be committed to source control. Use environment variables, input prompts, or secure credential stores. For more guidance on protecting credentials, see the security considerations covered earlier in this module.

## Test your MCP connections

After configuring MCP endpoints, verify the connection is working:

**In VS Code Agent mode:**

1. Switch to Agent mode in the Copilot Chat panel
2. Click the tools icon to see available MCP servers
3. Verify your configured servers appear with a green status
4. Ask a question like "What tables are available in the database?"
5. Confirm the response reflects your actual database schema

**Troubleshooting common issues:**

| Issue | Likely Cause | Solution |
|-------|--------------|----------|
| Server not listed | Configuration file syntax error | Validate JSON in mcp.json |
| Authentication failed | Expired credentials | Re-authenticate or refresh tokens |
| Connection timeout | Network/firewall blocking | Check firewall rules and network access |
| Empty schema results | Insufficient permissions | Verify database permissions for the authenticated user |

## Best practices for MCP endpoint management

**Use least-privilege access**: Create dedicated accounts for MCP connections with only the permissions needed (typically read-only schema access).

**Separate environments**: Configure different MCP endpoints for development, test, and production databases. Avoid connecting AI assistants to production data during routine development.

**Monitor connections**: Track MCP server usage through logging and monitoring. Understand how often your AI assistant queries your databases.

**Keep configurations consistent**: For team environments, share MCP configurations through version control so everyone connects to the same endpoints.

> [!TIP]
> Start with a development or test database when learning MCP configuration. Once you're comfortable with the setup, extend to additional environments as needed.

With MCP endpoints configured, your AI assistant now has real-time access to your database schemas and metadata. Combined with custom instruction files from the previous unit, you have a fully configured, contextual AI development environment for your Microsoft SQL platforms.
