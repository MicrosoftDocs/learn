In GitHub, webhooks can be set up for an organization or for a specific repository. A webhook is triggered each time one or more subscribed events occur. For example, the *Gollum* event allows you to listen for wiki updates, in particular, the creation of and updates for a wiki page.

In this unit, you'll learn how to set up a webhook that listens for a change event from your company's GitHub wiki.

## Set up a webhook

Setting up a webhook is a two-step process. First, you specify in GitHub how you want your webhook to behave and which events it will listen to. Second, you set up your function in Azure Functions to receive and manage the payload received from the webhook. In the example scenario, we're setting up a webhook for a specific repository.

To set up the webhook, in the GitHub portal, select **Settings** from the top menu bar. The **Settings** page appears, with the name of your repository. In the left menu, select **Webhooks**, and then select **Add webhook**. You can also build and manage a webhook through the Webhooks API, which is not covered in this module.

Webhooks require a couple of configuration options before you can use them. We'll go through each of these settings next.

### Payload URL

The payload URL is the URL of the server that will receive the webhook POST requests.

Each event type has a specific payload format. That payload contains information about the event that triggered the webhook.

### Content type

Webhooks can be delivered using two different content types:

- The *application/json* content type delivers the JSON payload directly as the body of a POST request.
- The *application/x-www-form-urlencoded* content type sends the JSON payload as a form parameter, named *payload*.

> [!NOTE]
> The **Add webhook** page also enables you to specify how to protect the information sent by the webhook by using a *Secret*. This topic is covered later in this module.

## Events

Events are at the center of webhooks. Events occur whenever actions are taken in the repository. When the event occurs, the webhook fires and calls the URL that you specify, sending along the payload and event information to your URL. For example, to respond whenever an issue is raised in a repository, select **Let me select individual events**, and then select the **Issues** checkbox. Make sure you select the **Active** checkbox to receive issue events for triggered webhooks. Then select **Add webhook** to activate the trigger.

To listen for updates to the wiki for the repository, select the **Wiki** checkbox; this event is the *Gollum* event mentioned earlier. Select **Add webhook** to save all the individual events you selected.

A full list of webhook events, and when they can run, can be found by visiting [GitHub Webhooks Events](https://developer.github.com/webhooks/#events). 

In the next exercise, we'll walk you through the process of setting up a webhook for a GitHub repository.
