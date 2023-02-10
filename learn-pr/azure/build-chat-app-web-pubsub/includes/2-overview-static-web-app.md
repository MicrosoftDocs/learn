:::image type="content" source="../media/tutorial-serverless-static-web-app.png" alt-text="Diagram showing how Azure Web PubSub works with Azure Static Web Apps." border="false":::

In this module, GitHub provides source control for a Static Web Apps application (Azure Repos could be used as an alternative). Azure monitors the repo branch you select, and every time there's a code change to the source repo, a new build of your web app is automatically triggered by GitHub Actions and deployed to Azure. Static Web Apps detects the new build and presents it to the end user.

The sample chat room application provided with this module has the following workflow.

1. When a user signs in to the app, the Azure Functions `login` API is triggered to generate a Web PubSub service client connection URL.
1. When the client initializes the connection request to Web PubSub, the service sends a system `connect` event that triggers the Functions `connect` API to authenticate the user.
1. When a client sends a message to Azure Web PubSub service, the service responds with a user `message` event and the Functions `message` API is triggered to broadcast the message to all the connected clients.
1. The Functions `validate` API is triggered periodically for [CloudEvents Abuse Protection](https://github.com/cloudevents/spec/blob/v1.0/http-webhook.md#4-abuse-protection) when the events in Azure Web PubSub are configured with predefined parameter `{event}`, that is, https://$STATIC_WEB_APP/api/{event}.

> [!NOTE]
> The Functions APIs `connect` and `message` are triggered when the Azure Web PubSub service is configured with these two events. 