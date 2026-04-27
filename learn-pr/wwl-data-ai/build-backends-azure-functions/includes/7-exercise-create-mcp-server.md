The Model Context Protocol (MCP) is an open standard that defines how AI agents and language models discover and invoke external tools. Azure Functions includes an MCP extension that lets you expose function apps as MCP servers, where each function becomes a tool that MCP clients can call.

In this exercise, you create an Azure Functions project with the MCP extension, define tool trigger functions for document processing, configure the MCP server settings, and test the server locally by connecting to it from GitHub Copilot in agent mode.

> [!NOTE]
> This exercise uses the Azure Functions MCP extension, which is actively evolving. Visit the [Azure Functions MCP extension documentation](/azure/azure-functions/functions-bindings-mcp-tool-trigger) for the most up-to-date setup instructions, API surface, and configuration options.

Tasks performed in this exercise:

- Create a new Azure Functions project with the MCP extension
- Configure the MCP server settings in *host.json*
- Define MCP tool trigger functions in *function_app.py*
- Verify the Python environment
- Test the MCP server locally using GitHub Copilot in agent mode

This exercise takes approximately **25** minutes to complete.

## Before you start

To complete the exercise, you need:

- [Visual Studio Code](https://code.visualstudio.com/) on one of the [supported platforms](https://code.visualstudio.com/docs/supporting/requirements#_platforms).
- The [Azure Functions extension](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-azurefunctions) for Visual Studio Code.
- [Azure Functions Core Tools](/azure/azure-functions/functions-run-local) v4 or later.
- [Python 3.9](https://www.python.org/downloads/) or later.
- The [GitHub Copilot](https://marketplace.visualstudio.com/items?itemName=GitHub.copilot) extension for Visual Studio Code.

## Get started

Select the **Launch Exercise** button to open the exercise instructions in a new browser window. When you're finished with the exercise, return here to:

> [!div class="checklist"]
> * Complete the module
> * Earn a badge for completing this module

<br/>

<a href="https://go.microsoft.com/fwlink/?linkid=2352235" target="_blank">
    <img src="../media/launch-exercise.png" alt="Button to launch exercise.">
