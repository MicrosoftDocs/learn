In this exercise, you deploy an Azure Managed Redis resource and complete a Python Flask web app that publishes and subscribes to Redis channels from a single page. You add code to connect to Redis with Microsoft Entra ID, publish event messages, broadcast to every channel, format received messages, listen for messages on a background thread, and subscribe to channels and patterns. You then run the app and watch messages arrive live as you publish them.

Tasks performed in this exercise:

- Download the project starter files
- Create an Azure Managed Redis resource
- Add code to the starter files to complete the app
- Run the app to publish and subscribe to messages

This exercise takes approximately **30-40** minutes to complete.

## Before you start

To complete the exercise, you need:

- An Azure subscription. If you don't already have one, you can [sign up for one](https://azure.microsoft.com/).
- [Visual Studio Code](https://code.visualstudio.com/) on one of the [supported platforms](https://code.visualstudio.com/docs/supporting/requirements#_platforms).
- [Python 3.12](https://www.python.org/downloads/) or greater.
- The latest version of the [Azure CLI](/cli/azure/install-azure-cli?view=azure-cli-latest).
- The Azure CLI **redisenterprise** extension. You can install it by running the **az extension add --name redisenterprise** command.

## Get started

Select the **Launch Exercise** button to open the exercise instructions in a new browser window. When you're finished with the exercise, return here to:

> [!div class="checklist"]
> * Complete the module
> * Earn a badge for completing this module

<br/>

<a href="https://go.microsoft.com/fwlink/?linkid=2344003" target="_blank">
    <img src="../media/launch-exercise.png" alt="Button to launch exercise.">
</a>

