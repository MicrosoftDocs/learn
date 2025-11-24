In this exercise, you create an Azure Managed Redis resource and complete the code for a console-based publisher and a subscriber app. The publisher app sends event messages to Redis channels, while the subscriber app listens for those messages using a graphical interface built with **tkinter**. You implement core pub/sub patterns including direct channel subscriptions, wildcard pattern matching, message formatting, and background message listening.

Tasks performed in this exercise:

- Download the project starter files
- Create an Azure Managed Redis resource
- Add code to complete both the publisher and subscriber apps
- Run the publisher and subscriber apps to send and receive messages

This exercise takes approximately **40** minutes to complete.

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

