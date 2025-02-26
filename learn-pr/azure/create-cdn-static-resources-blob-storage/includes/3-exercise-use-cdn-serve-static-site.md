Serving video files to your global users can benefit from a Content Delivery Network (CDN). In this unit, you learn how to create a CDN endpoint and profile. Then, you see how to configure the endpoint to cache content from a static website.

## Create a Content Delivery Network

First, create a CDN and connect that CDN to the website that you created from your storage account.

[!include[](../../../includes/azure-sandbox-regions-first-mention-note-friendly.md)]

1. Sign into the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) using the same account you used to activate the sandbox.

1. On the Azure portal menu or from the **Home** page, select **+ Create a resource**.

1. Search for **Front Door and CDN profiles**, then select **Create**.

1. Select the radio button for **Explore other offerings**, then select the radio button for **Azure CDN Standard from Microsoft (classic)**.

    :::image type="content" source="../media/3-compare-offerings.png" alt-text="Screenshot of different Front Door and CDN offerings during create process.":::

1. Select **Continue** to configure the CDN profile.

1. On the *Basics* page, enter or select the following information:

    :::image type="content" source="../media/3-cdn-new-profile.png" alt-text="Screenshot of the basics page of CDN profile creation.":::

    | Settings | Value |
    |--|--|
    | Subscription | Select the sandbox environment subscription. |
    | Resource group | Select the existing Resource Group ("**<rgn>[sandbox resource group name]</rgn>**") from the drop-down list. |
    | Name | Enter a name for the CDN profile. |
    | Pricing tier | Select **Microsoft CDN (classic)**. |
    | Create a new CDN endpoint | Leave this option unchecked. |

1. Select **Review and Create**, then select **Create** to deploy the CDN profile.

1. Once the profile is created, select **Go to resource** to display the CDN profile pane.

## Create a CDN Endpoint

Now, create a CDN profile that connects to the source web server in the storage account. Take the following steps:

1. In the CDN Profile pane, select **+ Endpoint**.

    :::image type="content" source="../media/3-add-an-endpoint.png" alt-text="Screenshot of add an endpoint button from the CDN overview page.":::

1. On the **Add an endpoint** page, enter or select the following information:

    :::image type="content" source="../media/3-new-cdn-endpoint.png" alt-text="Screenshot of create a new CDN endpoint page in the Azure portal.":::

    | Settings | Value |
    |--|--|
    | Name | Enter a unique name for the endpoint. |
    | Origin type | Select **Custom origin**. |
    | Origin hostname | Enter the URL from when you created the web site. Remove the **https://** and the final trailing slash character. |
    | Origin Path | Leave as default. |
    | Origin host header | Leave as default. This value is the same as the Origin hostname. |
    | HTTP port | Leave default as port **80**. |
    | HTTPS port | Leave default as port **443**. |

    > [!NOTE]
    > **Origin type** specifies what type of hosting service is used. **Custom origin** is used for any other type of publicly accessible origin webserver. This can be a webserver hosted on Azure or elsewhere.

1. Select **Add** to create the endpoint. Note the message that it can take up to 10 minutes for the settings to reach every CDN POP.

1. After 10 minutes elapses, select the **Endpoint hostname** link. The web site should display.
