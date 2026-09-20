In this exercise, you complete a Python Durable Functions app that processes claim documents in parallel. You add idempotent result persistence, activity retries, failure compensation, a human approval path with a timeout, fan-out/fan-in orchestration, and external event delivery. You then run and test the workflow locally with Azurite.

Tasks performed in this exercise:

- Download the project starter files
- Add durable workflow code to the Function App
- Run and test the workflow locally

This exercise takes approximately **30** minutes to complete.

## Before you start

In this section you review the tools and access required to complete the exercise.

To complete the exercise, you need:

- [Visual Studio Code](https://code.visualstudio.com/) on one of the [supported platforms](https://code.visualstudio.com/docs/supporting/requirements#_platforms).
- [Python 3.12](https://www.python.org/downloads/) or greater.
- [Azure Functions Core Tools](/azure/azure-functions/functions-run-local) v4 or later.
- The [Azurite](https://marketplace.visualstudio.com/items?itemName=Azurite.azurite) extension for Visual Studio Code.

Durable Functions requires a storage provider to save orchestration history and state. This exercise uses Azurite as the local storage provider.

## Get started

When you're finished with the exercise, return here to:

> [!div class="checklist"]
> * Complete the module
> * Earn a badge for completing this module

<br/>

Select the button to launch the exercise and follow the instructions.

<a href="https://go.microsoft.com/fwlink/?linkid=2378536" target="_blank">
    <img src="../media/launch-exercise.png" alt="Button to launch exercise.">
</a>
