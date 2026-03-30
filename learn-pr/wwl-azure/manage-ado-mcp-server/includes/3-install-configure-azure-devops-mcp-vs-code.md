Reliable setup is the foundation of every successful MCP workflow. If installation and tool discovery are incomplete, later prompts can appear inconsistent even when your request is correct. The objective of this unit is to help you establish a stable, repeatable setup path for Azure DevOps MCP Server in Visual Studio Code.

## Environment prerequisites

Before installation, confirm these baseline conditions:

- Visual Studio Code (or other supported MCP Client) is installed and updated.
- GitHub Copilot is enabled for your account.
- Node.js 20 or later is available when required by your install method.
- You have access to an Azure DevOps Organization and Project.

## Installation workflow

There are several possible ways to install the Azure DevOps MCP Server integration in your environment. The easiest is possibly using a **one-click** banner install (which you can experience from the exercise unit later in this module), but you can also set up an **mcp.json** config file in your **.vscode** folder, with the necessary parameters. 

> [!NOTE] 
> The Product Team provides a [GitHub repo](https://github.com/microsoft/azure-devops-mcp?tab=readme-ov-file#-installation--getting-started) with up-to-date information.  

During setup, the key success factor is that the Azure DevOps MCP Server toolset becomes available to GitHub Copilot. In most environments, this appears as an `ado` tool collection in tool configuration.

After initial installation, verify that the ADO MCP server is recognized by opening the GitHub Copilot tool configuration. Next, run a read operation as your first test, such as:

`List all projects in my Azure DevOps organization`.

Expected response behavior:

1. Copilot proposes a specific MCP tool call.
2. You can inspect the payload before execution.
3. The call returns structured project information.

If those three outcomes occur, your setup is functionally ready for next steps.

> [!IMPORTANT]
> The first time you execute the prompt, making a call to the ado tools, you will get asked to authenticate using your Azure DevOps credentials

## Common setup problems

When setup fails, issues usually fall into a few predictable categories:

- **Tool not visible**: MCP server not registered or extension reload needed.
- **Tool visible but no execution**: authentication incomplete or blocked by policy.
- **Prompt not routed to MCP**: request too generic, missing Azure DevOps context.
- **Intermittent behavior**: stale session state, often fixed by editor restart.

> [!IMPORTANT]
> Make sure you have the right permissions towards the Azure DevOps Organization and Project

## Practical troubleshooting sequence

When you suspect setup problems, troubleshoot in this order:

1. Confirm runtime prerequisites (editor, account, network).
2. Confirm Azure DevOps MCP server appears in tool configuration.
3. Restart Visual Studio Code and re-open chat.
4. Retry with an explicitly scoped Azure DevOps prompt.
5. Re-authenticate if prompted.

This sequence resolves most onboarding issues quickly without unnecessary reinstall attempts.
