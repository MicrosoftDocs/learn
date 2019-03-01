To access your Speech Translation subscription, you'll need to get two pieces of information from the Azure portal:

1. A **Subscription Key** that is passed with every request to authenticate the call.
1. The **Endpoint** that exposes your service on the network.

## View the Subscription Keys

1. Click **Resource groups** in the left sidebar of the portal, and then click the resource group created for the Translator Speech API.

1. Click the Translator Speech subscription name (such as "Translator Speech").
1. Select **Keys** under the "Resource Management" group to view your new API keys.
1. Copy the value of **KEY 1** or **KEY 2** to the clipboard for use in an application.

    ![Copying the Translator Speech API key to the clipboard](../media/4-access-keys-and-endpoints-keys.png)

## View the endpoint

1. Select **Overview** from the menu group, locate the "Endpoint" label, and make note of the **Endpoint** value. This value will be the URL used when generating temporary tokens.

    ![Reviewing the Translator  Speech API token issuer endpoint](../media/4-access-keys-and-endpoints-url.png)