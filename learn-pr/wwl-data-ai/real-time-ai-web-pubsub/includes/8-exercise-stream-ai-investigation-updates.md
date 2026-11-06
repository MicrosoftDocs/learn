Azure Web PubSub manages persistent client connections so a backend can broadcast updates to multiple observers without managing its own WebSocket infrastructure. For a long-running AI investigation, live notifications keep responders informed while durable storage preserves the findings independently of their browser connections.

In this exercise, you deploy Azure Web PubSub and Azure Blob Storage, then complete a Python Flask app that shares one investigation with an on-call developer and a database specialist on a single page. A deterministic simulator supplies progress and findings about a fictional database incident, so you can focus on delivery and recovery without deploying an AI model. You generate scoped connection details, record and publish events, and batch findings before notifying both responders.

Tasks performed in this exercise:

- Download the project starter files.
- Deploy Azure Web PubSub and Blob Storage with Microsoft Entra ID access.
- Add Python code to connect observers and publish stored investigation updates.
- Run the app to verify shared delivery, independent connections, and recovery after a disconnect.

This exercise takes approximately **30** minutes to complete.

## Before you start

In this section you review the tools and permissions required to provision the resources and run the local app.

To complete the exercise, you need:

- An [Azure subscription](https://azure.microsoft.com/) with permission and quota to create Azure Web PubSub and storage resources, register resource providers, and assign Azure roles. **Owner**, or **Contributor** combined with **Role Based Access Control Administrator**, at the appropriate scope provides the required resource and role-assignment permissions.
- [Visual Studio Code](https://code.visualstudio.com/) on one of the [supported platforms](https://code.visualstudio.com/docs/supporting/requirements#_platforms).
- [Python 3.12](https://www.python.org/downloads/) or greater.
- The latest version of the [Azure CLI](/cli/azure/install-azure-cli). A later step installs or upgrades its **webpubsub** extension.
- **Optional:** The [Ruff extension for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=charliermarsh.ruff) for formatting and linting Python code.

The deployment uses the **Standard_S1** Web PubSub tier and a **Standard_LRS** storage account. These resources incur charges while provisioned. Review [Azure Web PubSub pricing](https://azure.microsoft.com/pricing/details/web-pubsub/) and delete the resources when you finish.

## Get started

Select the **Launch Exercise** button to open the exercise instructions in a new browser window. When you're finished with the exercise, return here to:

> [!div class="checklist"]
> * Complete the module
> * Earn a badge for completing this module

<br/>

<a href="https://go.microsoft.com/fwlink/?LinkId=2388076" target="_blank">
    <img src="../media/launch-exercise.png" alt="Button to launch exercise.">
