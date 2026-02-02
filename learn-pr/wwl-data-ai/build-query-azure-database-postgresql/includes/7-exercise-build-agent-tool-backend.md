In this exercise, you create an Azure Database for PostgreSQL instance that serves as a tool backend for an AI agent. The database stores conversation context and task state that an agent can read and write during operation. You design a schema for agent memory, build Python functions that serve as agent tools, and test the complete workflow. This pattern provides a foundation for building AI agents that maintain persistent memory across sessions and can resume interrupted tasks.

Tasks performed in this exercise:

- Download project starter files and configure the deployment script
- Deploy an Azure Database for PostgreSQL Flexible Server with Microsoft Entra authentication
- Build Python tool functions for conversation and task state management
- Create a database schema for agent memory with tables for conversations, messages, and task checkpoints
- Test the agent memory workflow using a provided test script
- Query conversation context using SQL

This exercise takes approximately **30** minutes to complete.

## Before you start

To complete the exercise, you need:

- An Azure subscription with the permissions to deploy the necessary Azure services. If you don't already have one, you can [sign up for one](https://azure.microsoft.com/).
- [Visual Studio Code](https://code.visualstudio.com/) on one of the [supported platforms](https://code.visualstudio.com/docs/supporting/requirements#_platforms).
- The latest version of the [Azure CLI](/cli/azure/install-azure-cli).
- [Python 3.12](https://www.python.org/downloads/) or greater.
- [PostgreSQL command-line tools](https://www.postgresql.org/download/) (**psql**)


## Get started

Select the **Launch Exercise** button to open the exercise instructions in a new browser window. When you're finished with the exercise, return here to:

> [!div class="checklist"]
> * Complete the module
> * Earn a badge for completing this module

<br/>

<a href="https://go.microsoft.com/fwlink/?linkid=2349114" target="_blank">
    <img src="../media/launch-exercise.png" alt="Button to launch exercise.">
</a>
