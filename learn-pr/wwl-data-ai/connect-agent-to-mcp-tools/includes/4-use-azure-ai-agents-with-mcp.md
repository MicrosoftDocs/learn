You can enhance your Microsoft Foundry agent by connecting it to Model Context Protocol (MCP) servers. MCP servers provide tools and contextual data that your agent can use to perform tasks, extending its capabilities beyond built-in functions. Azure AI Agent Service includes support for remote MCP servers, allowing your agent to quickly connect to your server and access tools. 

When you use the Microsoft Foundry Agent Service to connect to your MCP server, you don't need to manually create an MCP client session or add any function tools to your agent. Instead, you create an MCP tool object that connects to your MCP server. Then you add information about the MCP server to the agent thread when invoking a prompt. This also allows you to connect and use different tools from multiple servers depending on your needs.

## Integrating remote MCP servers

To connect to an MCP server, you need:
- A remote MCP server endpoint (for example, https://api.githubcopilot.com/mcp/).
- A Microsoft Foundry agent configured to use the MCP tool.

You can connect to multiple MCP servers by adding them to your agent as separate tools. Each `MCPTool` can include the following parameters:
- `server_label`: A unique identifier for the MCP server (e.g., GitHub).
- `server_url`: The MCP server’s URL.
- `allowed_tools` (optional): A list of specific tools the agent is allowed to access.
- `require_approval` (optional): A boolean that determines whether tool invocations require human approval. If set to true, the agent will pause and wait for approval before invoking any tools on the MCP server.

The MCP tool also supports custom headers, which let you pass:
- Authentication keys (API keys, OAuth tokens).
- Other required headers for the MCP server.

## Invoking tools

When using the Azure MCP Tool object, you don't need to wrap function tools or invoke `session.call_tool`. Instead, the tools are automatically invoked when necessary during an agent run. To automatically invoke MCP tools:

- Create the `MCPTool` object with the server label and url.
- Use `update_headers` to apply any headers required by the server.
- Use the `require_approval` parameter to determine whether approval is required. Supported values are:
    - `always`: A developer needs to provide approval for every call. If you don't provide a value, this one is the default.
    - `never`: No approval is required.
- Create an agent and add the `MCPTool` object to its tools list
- Invoke a prompt on the agent, you should see the results of any invoked tools in the response.

If the model tries to invoke a tool in your MCP server with approval required, you get an `mcp_approval_request` in the agent response. This includes information about which tool is being invoked, and you can use this information to decide whether to approve the request. To approve, you send a follow-up message with the `mcp_approval_response` object, which includes an `approval_request_id` value and an `approve` boolean.

MCP integration is a key step toward creating richer, more context-aware AI agents. As the MCP ecosystem grows, you’ll have even more opportunities to bring specialized tools into your workflows and deliver smarter, more dynamic solutions.

