Agents become more useful when they can go beyond the repository and interact with other tools, systems, and services. Model Context Protocol, or MCP, makes that possible by giving agents a consistent way to discover and use external capabilities.

In GitHub environments, MCP is not just about connecting to tools. It is also about controlling how those tools are introduced, configured, and governed. That includes configuring MCP servers, using a registry to discover available servers, and enforcing allow lists so only approved servers can be used.

In this unit, you'll learn:

- What MCP is
- How MCP servers work
- How registries make server discovery easier
- How allow lists control which servers can be used
- How MCP fits into agentic workflows and agent tooling on GitHub

## What is MCP?

Model Context Protocol is a standard way for AI clients to connect to tools and services through MCP servers. Instead of building a one-off integration for every tool, an MCP-compatible client can connect to a server that exposes tools in a structured format.

This gives agents a consistent model for:

- Discovering available tools
- Sending structured requests
- Receiving structured results
- Reusing the same interaction pattern across different systems

## What is an MCP server?

An MCP server is the component that exposes tools to an AI client.

The server sits between the client and the underlying system. It presents available tools in a format the client understands, accepts requests, and then performs the real action against the connected service.

Depending on the setup, an MCP server can:

- Run locally on a developer machine
- Run remotely as a hosted service
- Connect to local resources
- Bridge to remote APIs and platforms

The GitHub MCP server is one example. It connects AI clients to GitHub capabilities such as repositories, issues, and pull requests.

## Local and remote MCP servers

MCP servers can be configured locally or remotely.

A local MCP server runs on your machine. This is useful when you want tighter control over configuration, access to local resources, or a custom setup.

A remote MCP server is hosted elsewhere and accessed over the network. This reduces setup work and makes it easier to use the same server across environments.

In supported IDEs, the GitHub MCP server can be configured remotely or locally, with the remote option positioned as the recommended setup for most users. GitHub Enterprise Server supports local MCP server configuration, while GitHub Enterprise Cloud with data residency supports both local and remote options.

### Add a remote MCP server as a tool to an agent (VS Code)

MCP servers are added directly through the Copilot Chat interface and become tools the agent can use.

Steps:

1. Click the GitHub Copilot icon at the top of the editor
1. Open Copilot Chat and switch to Agent mode
1. Click the Tools icon in the chat panel
1. Click Configure tools in the top-right corner of the Copilot Chat panel.
1. Click Add MCP server
1. In the setup dialog:
    1. Select HTTP as the server type
    1. Enter the server URL (example for GitHub MCP server):
    1. https://api.githubcopilot.com/mcp/
    1. Press Enter
    1. A server name is automatically generated
    1. Choose the scope; current workspace or all workspaces
    1. Click Authenticate and sign in go GitHub
    1. Save the configuration

The MCP server is now available as a tool inside the agent, and the agent can call its capabilities during tasks.

### Add a local MCP server as a tool to an agent

A local MCP server runs on your machine and allows your agent to interact with local tools, files, or custom services. The setup process in VS Code is the same as adding any MCP server.

The only difference is the server you connect to. Instead of using a hosted URL like the GitHub MCP server, you provide a local endpoint, for example:

```
http://localhost:3000
```

Local MCP servers:

- Run on your machine
- Can access local resources and custom workflows
- Typically, do not require external authentication

## What is an MCP registry?

An MCP registry is a catalog of MCP servers.

Instead of asking every developer to manually configure every server, a registry provides a central place where compatible clients can discover which servers are available and how to use them.

This simplifies setup in two ways:

- It makes server discovery easier
- It standardizes how servers are described and distributed

By default, supported IDE experiences can use the GitHub MCP Registry, and developers can also switch to a custom registry when needed.

## How registries help with configuration

Registries reduce friction because they remove much of the manual work involved in adding servers.

Instead of editing configuration files by hand for every server, a developer can browse or search a registry, select a server, install it, and trust it for use in their environment.

This makes registries especially useful when:

- Teams want a simpler setup experience
- Organizations want a standard set of approved servers
- Developers need a curated list instead of unmanaged discovery

GitHub also supports custom MCP registries for organizations and enterprises, as long as the registry follows the required MCP registry specification and endpoint structure.

### Configure MCP registries

To use a custom MCP registry in GitHub, an organization or enterprise must create or host a registry that GitHub Copilot can access.

Steps:

1. Create or host an MCP registry. You can do this in one of three ways:
    - Fork and self-host the open-source MCP Registry
    - Run the open-source registry locally using Docker
    - Build and publish your own custom registry implementation
1. Ensure the registry meets GitHub requirements. The registry must:
    - Follow the MCP registry v0.1 specification
    - Expose the required HTTPS endpoints:
        - GET /v0.1/servers
        - GET /v0.1/servers/{serverName}/versions/latest
        - GET /v0.1/servers/{serverName}/versions/{version}
    - Include required CORS headers so Copilot can access it:
        - Access-Control-Allow-Origin: *
        - Access-Control-Allow-Methods: GET, OPTIONS
        - Access-Control-Allow-Headers: Authorization, Content-Type
1. (Optional) Include local MCP servers:
    - If you want developers to use local MCP servers under restricted policies, those servers must be listed in the registry
    - Server IDs must match exactly
1. (Alternative) Use Azure API Center
    - Azure API Center can act as a managed MCP registry
    - Enable anonymous access so Copilot can fetch the registry
    - Copy the API Center endpoint URL for later use
1. Provide the registry URL to your organization or enterprise
    - This URL will be used in Copilot policy settings
    - It makes the registry available across your company

Once configured, the registry becomes the source of truth for available MCP servers, allowing developers to discover and use approved tools in a consistent way.

## What is an allow list?

An allow list is a policy that controls which MCP servers are permitted.

This matters because MCP expands what an agent can access. Without guardrails, an agent could be connected to tools that expose sensitive systems or allow unsafe actions.

An allow list solves this by restricting server usage to approved entries. In practice, this means an organization or enterprise can decide whether developers can:

- Use MCP servers at all
- Use any MCP server
- Use only specific MCP servers defined in a registry

GitHub supports MCP allowlist enforcement at the organization and enterprise level, tied to the Copilot seat that governs the user.

## How MCP servers, registries, and allow lists work together

These three concepts solve different parts of the same problem:

- **MCP server** exposes tools
- **Registry** makes servers discoverable and trustable
- **Allow list** decides which servers are permitted

Together, they create a model that is both flexible and controlled.

A developer or team can discover useful servers through a registry, while the organization still retains governance over which servers are allowed in practice.

### Configure MCP allow lists

MCP allow lists control which MCP servers developers are permitted to use. This is configured at the organization or enterprise level in GitHub.

Steps (Enterprise):

1. Navigate to your enterprise on GitHub
1. At the top of the page, click AI controls
1. In the sidebar, click MCP
1. Ensure MCP servers in Copilot is set to Enabled everywhere
1. In the MCP Registry URL section:
    - Enter the URL of your registry
    - Click Save
    - If using Azure API Center, enter the base URL only (do not include /v0.1/servers)
1. In Restrict MCP access to registry servers, choose:
    - Allow all → no restrictions, any MCP server can be used
    - Registry only → only servers from the registry are allowed

Steps (Organization):

1. In GitHub, click your profile picture and select Organizations
1. Select your organization
1. Click Settings
1. In the sidebar, click Copilot, then Policies
1. In the Features section:
    - Ensure MCP servers in Copilot is Enabled
1. (Optional) In MCP Registry URL:
    - Enter your registry URL
    - Click Save
    - If using Azure API Center, enter the base URL only
1. In Restrict MCP access to registry servers, choose:
    - Allow all
    - Registry only

>[!NOTE]
>Notes: If the Allow all option is selected, developers can add and use any MCP server without restrictions. If Registry only is selected, developers are limited to using only the MCP servers defined in the configured registry. In this case, even local MCP servers must be included in the registry, and their server IDs must match exactly. Once a policy is selected, it is applied immediately to all developers.

Allow lists ensure that agents only use approved MCP servers, giving organizations control over what tools can be accessed.

## A practical GitHub workflow

A realistic GitHub-centered MCP flow looks like this:

1. An organization configures an MCP registry
1. The organization defines an allow list policy for approved servers
1. A developer opens an MCP-capable IDE or client
1. The client discovers approved servers from the registry
1. The developer enables a server such as the GitHub MCP server
1. The agent uses tools from that server during a task

In this model, agents gain new capabilities without giving up control over security and governance.

## Why this matters for agent execution

MCP gives agents access to more tools, but more tools also means more responsibility.

To use MCP safely at scale, you need more than connectivity. You need:

- A server that exposes tools correctly
- A registry that makes approved servers discoverable
- An allow list that limits what can be used

That combination makes MCP practical for real teams. It allows agents to expand beyond GitHub while keeping setup manageable and access controlled.

## Key takeaway

MCP extends agent capabilities by connecting them to tools through MCP servers. Registries simplify how those servers are discovered and configured. Allow lists provide the guardrails that decide which servers are allowed.

Together, these pieces make MCP both scalable and governable.

Next, you will learn how to define execution environments and permission boundaries so agents can use GitHub and MCP-connected tools safely.
