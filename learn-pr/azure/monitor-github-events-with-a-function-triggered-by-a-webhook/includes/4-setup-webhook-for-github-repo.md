In GitHub, webhooks can be set up on an organization or a specific repository. The webhook will be triggered each time one or more subscribed events occurs. For example, the *Gollum* event allows you to listen for wiki updates; specifically creation and updates for a wiki page.

In this unit, you'll learn how to set up a webhook listening for a change event from your company's GitHub wiki. 

## Setting up a webhook

Setting up a webhook is a two-step process. You specify how you want your webhook to behave through GitHub and what events it should listen to. Then you set up your function in Azure Functions to receive and manage the payload received from the webhook.

In GitHub, you can install webhooks for an organization or a repository. In the example scenario case, we're setting up a webhook on a specific repository.

To set up the webhook, go to the **settings** page of your repository in the GitHub portal. Click **Webhooks**, and then click **Add webhook**. Alternatively, you can build and manage a webhook through the Webhooks API, but this module doesn't cover this approach.

Webhooks require a couple of configuration options before you can use them. We'll go through each of these settings next.

### Payload URL

The payload URL is the URL of the server that will receive the webhook POST requests.

Each event type has a specific payload format. That payload contains information about the event that triggered the webhook.

### Content Type

Webhooks can be delivered using two different content types:

- The *application/json* content type delivers the JSON payload directly as the body of the POST request.
- The *application/x-www-form-urlencoded* content type sends the JSON payload as a form parameter, called *payload*.

> [!NOTE]
> The **Add webhook** page also enables you to specify how to protect the information sent by the webhook by using a *Secret*. This topic is covered later in this module.

## Events

Events are at the center of webhooks. Events occur whenever actions are taken in the repository. When the event occurs, the webhook fires off and calls the URL that you specify, sending along the payload and event information to your URL.

A full list of webhook events, and when they can run, can be found in the [Webhooks events reference](https://developer.github.com/webhooks/#events). For example, to respond whenever an issue is raised in a repository, click **Let me select individual events**, and then select **Issues**. Make sure you select **Active** to receive issue events for triggered webhooks.

To listen for updates to the wiki for the repository, select the *Wiki* checkbox; this event is the *Gollum* event mentioned earlier. In the next exercise, we'll walk you through the process of setting up a webhook for a GitHub repository.