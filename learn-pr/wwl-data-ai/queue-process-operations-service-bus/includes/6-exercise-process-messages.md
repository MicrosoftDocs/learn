AI workflows often rely on messaging to decouple request intake from model inference and to route results to multiple downstream consumers. Azure Service Bus provides the reliability and routing layer that connects these components so each piece can scale and fail independently.

In this exercise, you create an Azure Service Bus namespace and build a Python Flask web application that demonstrates core messaging patterns using an AI inference scenario. You work with queues to send and receive inference requests using peek-lock delivery, inspect the dead-letter queue for malformed payloads that failed processing, and use topics with filtered subscriptions to fan out inference results by priority level.

Tasks performed in this exercise:

- Download the project starter files
- Create an Azure Service Bus namespace
- Create messaging entities using the Azure CLI
- Add code to the starter files to complete the app
- Run the app to perform messaging operations

This exercise takes approximately **30** minutes to complete.

## Before you start

To complete the exercise, you need:

- An Azure subscription. If you don't already have one, you can [sign up for one](https://azure.microsoft.com/).
- [Visual Studio Code](https://code.visualstudio.com/) on one of the [supported platforms](https://code.visualstudio.com/docs/supporting/requirements#_platforms).
- [Python 3.12](https://www.python.org/downloads/) or greater.
- The latest version of the [Azure CLI](/cli/azure/install-azure-cli).

## Get started

Select the **Launch Exercise** button to open the exercise instructions in a new browser window. When you're finished with the exercise, return here to:

> [!div class="checklist"]
> * Complete the module
> * Earn a badge for completing this module

<br/>

<a href="https://go.microsoft.com/fwlink/?linkid=2352823" target="_blank">
    <img src="../media/launch-exercise.png" alt="Button to launch exercise.">
