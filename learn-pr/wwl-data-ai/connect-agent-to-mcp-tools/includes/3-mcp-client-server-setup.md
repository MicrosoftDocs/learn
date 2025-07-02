To dynamically connect tools to your Azure AI Agent, you first need a functioning Model Context Protocol (MCP) setup. This includes both the MCP server, which hosts your tool catalog, and the MCP client, which fetches those tools and makes them usable by your agent.

## What is the MCP Server?

The MCP server acts as a registry for tools your agent can use. You can initialize your MCP server using `FastMCP("server-name")`. The FastMCP class uses Python type hints and docstrings to automatically generate tool definitions, making it easy to create and maintain MCP tools. These definitions are then served over HTTP when requested by the client. Because tool definitions live on the server, you can update or add new tools at any time, without having to modify or redeploy your agent.

## What is the MCP Client?

The MCP client acts as a bridge between your MCP server and the Azure AI Agent Service. The client initializes an MCP client session and connets to the server. Afterwards, it performs three key tasks:

- Discovers available tools from the MCP server using `session.list_tools()`.
- Generates Python function stubs that wrap the tools.
- Registers those functions with your agent.

This allows the agent to call any tool listed in the MCP catalog as if it were a native function, all without hardcoded logic.

## Register tools with an Azure AI Agent

When an MCP client session is initialized, the client can dynamically pull in tools from the MCP server. An MCP tool can be invoked using `session.call_tool(tool_name, tool_args)`. The tools should each be wrapped in an async function so that the agent is able to invoke them. Finally, those functions are bundled together and become part of the agent's toolset and are available during runtime for any user request.

**Overview of MCP agent tool integration**

- The **MCP server** hosts tool definitions decorated with `@mcp.tool`.
- The **MCP client** initializes an MCP client connection to the server. 
- The **MCP client**  fetches the available tool definitions with `session.list_tools()`.
- Each tool is wrapped in an async function that invokes `session.call_tool`
- The tool functions are bundled into `FunctionTool` that makes them usable by the agent.
- The `FunctionTool` is registered to the agent's toolset.

Now your agent is able to access and invoke your tools through natural language interaction. By setting up the MCP server and client, you create a clean separation between tool management and agent logic—enabling your system to adapt quickly as new tools become available.