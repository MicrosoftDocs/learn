Azure Container Apps dynamic sessions provide fast access to isolated execution environments for running AI-generated or user-submitted code. A code interpreter session keeps generated code outside the application process, preserves temporary files across related requests, and automatically removes the environment after a configurable idle period.

In this exercise, you deploy a Python code interpreter session pool, authorize your account with Microsoft Entra ID, and complete a Flask app that calls the Dynamic Sessions REST API. The app uploads sample data, executes a supplied analysis payload, validates the result, retrieves a generated chart from the reused session, detects an expected code failure, and explicitly deletes the session.

Tasks performed in this exercise:

- Download the project starter files and deploy a dynamic session pool
- Create a secure client with an application-generated session identifier
- Authenticate REST requests using Microsoft Entra ID
- Upload data and execute Python code in an isolated session
- List and download files from the reused session
- Detect an execution failure and explicitly delete the session
- Run the Flask app and inspect the REST operation results

This exercise takes approximately **30** minutes to complete.

## Before you start

In this section you review the tools and Azure permissions required to complete the exercise.

To complete the exercise, you need:

- An [Azure subscription](https://azure.microsoft.com/) with permissions to create a resource group and Azure Container Apps session pool, and to assign an Azure role.
- [Visual Studio Code](https://code.visualstudio.com/) on one of the [supported platforms](https://code.visualstudio.com/docs/supporting/requirements#_platforms).
- [Python 3.12](https://www.python.org/downloads/) or greater.
- The latest version of the [Azure CLI](/cli/azure/install-azure-cli).
- A region that supports Azure Container Apps dynamic sessions.
- **Optional:** The [Ruff extension for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=charliermarsh.ruff) for formatting and linting Python code.

## Get started

When you're finished with the exercise, return here to:

> [!div class="checklist"]
> * Complete the module
> * Earn a badge for completing this module

<br/>

Select the button to launch the exercise and follow the instructions.

<a href="https://go.microsoft.com/fwlink/?linkid=2381300" target="_blank">
    <img src="../media/launch-exercise.png" alt="Button to launch exercise.">
</a>
