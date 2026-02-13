I content moderation systems generate a high volume of events as they classify and review submissions. Azure Event Grid provides the routing layer that directs these events to the right downstream consumers based on event type, so each handler receives only the events it needs without polling or manual filtering.

In this exercise, you deploy an Event Grid Namespace with a namespace topic and filtered event subscriptions, then build a Python Flask application that publishes content moderation events and receives them using pull delivery. Event Grid subscriptions route flagged content, approved content, and all events to separate subscriptions so you can observe how filtering works in practice. You also use the receive, acknowledge, and reject operations that pull delivery provides to control how your application processes events.

Tasks performed in this exercise:

- Download the project starter files
- Deploy an Event Grid Namespace with a namespace topic
- Create event subscriptions with type filters
- Add code to the starter files to complete the app
- Run the app to publish, receive, and process moderation events

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

<a href="https://go.microsoft.com/fwlink/?linkid=2352234" target="_blank">
    <img src="../media/launch-exercise.png" alt="Button to launch exercise.">
