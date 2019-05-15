In GitHub, webhooks can be set up on an organization or a specific repository. The webhook will be triggered each time one or more subscribed events occurs. For example, the *Gollum* event allows you to listen for wiki updates; specifically creation and updates for a wiki page.

Now that you've function app is being trigger by a webhook, you'll set up a webhook specifically for your company's Technology Wiki. The *Gollum* event provides detailed information about wiki page updates.

In this unit, you'll learn how to set up a webhook listening for a *Gollum* event, in a GitHub repository. 

## Setting up a webhook

Setting up a webhook is a two-step process. You specify how you want your webhook to behave through GitHub and what events should it listen to. Then you set up your Azure Function to receive and manage the payload received from the webhook.

In GitHub, you can install webhooks for an organization or a repository. In the example scenario case, we're setting one up on a specific repository.

To set up the webhook, go to the **settings** page of your repository in the GitHub portal. Click **Webhooks**, and then click **Add webhook**. Alternatively, you can build and manage a webhook through the Webhooks API, but this module doesn't cover this approach.

Webhooks require a couple of configuration options before you can use them. We'll go through each of these settings next.

### Payload URL

The payload URL is the URL of the server that will receive the webhook POST requests.

Each event type has specific payload format with relevant event information. All event payloads replicate the payloads for Event types, with the exception of the *original push event*, which has more details in the webhook payload.

### Content Type

Webhooks can be delivered using two different content types:

- The *application/json* content type delivers the JSON payload directly as the body of the POST request.
- The *application/x-www-form-urlencoded* content type sends the JSON payload as a form parameter, called *payload*.

> [!NOTE]
> The **Add webhook** page also enables you to specify how to protect the information sent by the webhook by using a *Secret*. This topic is covered later in this module.

## Events

Events are at the very center of webhooks. Webhooks fire whenever a certain action is taken in the repository. Your payload URL intercepts and acts upon these.

A full list of webhook events, and when they can run, can be found in the [Webhooks events reference](https://developer.github.com/webhooks/#events). For example, to respond whenever an issue is raised in a repository, click **Let me select individual events**, and then select **Issues**. Make sure you select **Active** to receive issue events for triggered webhooks.

To listen for updates to the wiki for the repository, select the *Wiki* checkbox; this event is the *Gollum* event mentioned earlier.