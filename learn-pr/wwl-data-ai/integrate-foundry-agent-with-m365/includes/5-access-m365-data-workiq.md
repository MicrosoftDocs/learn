When building agents that help users with workplace tasks, access to organizational data can dramatically improve the agent's usefulness. Microsoft Work IQ provides a way to connect AI agents to Microsoft 365 data, including emails, meetings, documents, Teams messages, and people information.

## What is Work IQ?

Microsoft Work IQ is a command-line interface (CLI) and server that connects AI assistants to your Microsoft 365 Copilot data. It enables agents to query workplace information using natural language, providing rich context that helps agents give more relevant and accurate responses.

With Work IQ, your agents can answer questions like:

- "What did my manager say about the project deadline?"
- "Find my recent documents about Q4 planning"
- "Summarize today's messages in the Engineering channel"
- "Who is working on Project Alpha?"

Work IQ accesses data across multiple Microsoft 365 services:

| Data type | Example capabilities |
|-----------|---------------------|
| **Emails** | Search messages, find communications from specific people |
| **Meetings** | Check calendar, retrieve meeting notes and decisions |
| **Documents** | Find files in SharePoint and OneDrive, search content |
| **Teams messages** | Summarize channel discussions, find specific conversations |
| **People** | Identify team members, find collaborators on projects |

## Understanding MCP servers

Work IQ is built on the **Model Context Protocol (MCP)**, an open protocol that enables AI assistants to connect to external data sources and tools. Understanding MCP helps explain how Work IQ functions.

An MCP server exposes capabilities that AI agents can use. These capabilities might include:

- **Tools**: Actions the agent can take, like searching for documents or sending messages
- **Resources**: Data sources the agent can query
- **Prompts**: Predefined templates for common queries

When you configure an MCP server for your agent, the agent discovers what tools and resources are available and can use them to fulfill user requests. Work IQ acts as an MCP server specifically designed for Microsoft 365 data.

## How Work IQ operates

Work IQ runs in two modes:

### CLI mode

In CLI mode, you run queries directly from your terminal:

```bash
workiq ask -q "What requirements did Sarah share about the authentication feature?"
```

This mode is useful for quick queries during development or for scripts that need to retrieve workplace information.

### MCP server mode

In MCP server mode, Work IQ integrates with AI assistants like GitHub Copilot in Visual Studio Code. Your AI assistant can automatically access workplace context when relevant to your work.

For example, if you're implementing a feature that was discussed in a recent meeting, your AI assistant can access that meeting context to provide more relevant suggestions.

## Installing Work IQ

You can install Work IQ in several ways depending on your preferred workflow.

### Install using npm

```bash
# Global installation
npm install -g @microsoft/workiq

# Or run directly without installation
npx -y @microsoft/workiq mcp
```

### Install using GitHub Copilot CLI

If you use GitHub Copilot CLI, you can install Work IQ as a plugin:

1. Open GitHub Copilot CLI by running `copilot`.
2. Add the plugins marketplace (one-time setup): `/plugin marketplace add github/copilot-plugins`
3. Install Work IQ: `/plugin install workiq@copilot-plugins`
4. Restart Copilot CLI and start querying your Microsoft 365 data.

### Configure for Visual Studio Code

You can add Work IQ as an MCP server through the VS Code settings. Add the following to your MCP configuration:

```json
{
  "workiq": {
    "command": "npx",
    "args": [
      "-y",
      "@microsoft/workiq",
      "mcp"
    ],
    "tools": [
      "*"
    ]
  }
}
```

Before first use, accept the End User License Agreement:

```bash
workiq accept-eula
```

## Prerequisites for Work IQ

To use Work IQ, you need:

- Node.js installed on your machine (if using the CLI locally)
- A Microsoft 365 subscription with a Copilot license
- Administrative consent for the Work IQ application in your Microsoft Entra tenant

> [!IMPORTANT]
> Work IQ requires administrative consent because it accesses organization-wide Microsoft 365 data. If you're not a tenant administrator, contact your IT department to request access.

## Security and data access

Work IQ inherits the security model of Microsoft 365 Copilot:

- **Permission-based access**: Work IQ can only access data you already have permission to view
- **No data storage**: Work IQ doesn't store your Microsoft 365 data; it retrieves information on-demand
- **Enterprise security**: All data access follows your organization's security policies
- **Admin visibility**: Administrators can monitor and control Work IQ usage

When you query Work IQ, it accesses data through Microsoft Graph with your authenticated identity. This means:

- You can't access documents you don't have permission to view
- Queries are auditable by your organization
- Data protection policies apply to Work IQ queries

## Using Work IQ with agent development

Work IQ helps you understand the context your users work in during agent development. You can interact with Work IQ through either the CLI or the MCP server, depending on your workflow.

### CLI approach

The CLI is useful for quick, ad-hoc queries during development. Run the `workiq ask` command directly from your terminal:

```bash
# Find project context
workiq ask -q "What were the key decisions in last week's architecture review meeting?"

# Understand requirements from documents
workiq ask -q "Summarize the requirements in the user portal spec document"

# Check team communications
workiq ask -q "What has the engineering team discussed about the API changes?"
```

The CLI approach works well for scripts, one-off queries, or when you need quick answers without opening an IDE.

### MCP server approach

When Work IQ runs as an MCP server, your AI assistant can access the same Microsoft 365 data automatically. Instead of running CLI commands, you interact naturally with your AI assistant, which calls Work IQ tools behind the scenes.

For example, in VS Code with GitHub Copilot configured to use Work IQ:

- Ask Copilot: "What requirements did Sarah share about the authentication feature?"
- Copilot uses Work IQ's MCP tools to query your Microsoft 365 data
- You receive the answer in the chat without running any commands

The MCP approach integrates workplace context seamlessly into your development workflow. Your AI assistant decides when to query Work IQ based on your questions, making the experience feel natural rather than requiring explicit commands.

Both approaches access the same underlying data with the same permissions. Choose the CLI for scripting and quick terminal queries, or the MCP server for integrated AI assistant experiences.

> [!NOTE]
> Work IQ is currently in preview. Features and APIs may change as the product evolves.
