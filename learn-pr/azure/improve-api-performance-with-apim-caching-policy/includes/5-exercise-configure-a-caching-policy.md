When you manage APIs with Azure API Management, you can modify API behavior without having to rewrite code, by use of policies. To cache API responses, you use API Management's caching policies.

As the developer for a board game company, you decide to implement caching for a Board Gaming API. First, you need to add the API to API Management. Then, you'll write your caching policies. We'll do both in this exercise.

[!include[](../../../includes/azure-exercise-subscription-prerequisite.md)]

> [!NOTE]
> In this exercise, the Board Gaming web API is hosted in the **azurewebsites.net** domain. The API Management instance is in the **azure-api.net** domain.

## Create a web API in Azure App Service

To create an Azure App Service web API, we use the following steps:

1. In the Azure taskbar, select the Cloud Shell icon to open Azure Cloud Shell.

    :::image type="content" source="../media/3-cloud-shell-icon.png" alt-text="Screenshot of Cloud Shell icon in taskbar.":::

1. Clone the sample web API by running the following command:

    ```bash
    git clone https://github.com/MicrosoftDocs/mslearn-improve-api-performance-with-apim-caching-policy.git
    ```

1. Set up the web API by running these commands:

    ```bash
    cd mslearn-improve-api-performance-with-apim-caching-policy
    bash setup.sh
    ```

Setup.sh has seven parts that take several minutes to run.  When it finishes, three URLs are displayed:

- A web API test URL to test the web API
- A Swagger URL for the Swagger UI
- A Swagger JSON URL for the OpenAPI definition

Make note of these URLs. We'll use them in the next task.

## Test the newly deployed web API

When the web API is successfully created in Cloud Shell, you can test it. Run a test by submitting a GET request in the browser or by checking the OpenAPI definition. This test runs against the web API in the **azurewebsites.net** domain before it's added to API Management.

1. On the Azure portal **Resource** menu, or on the **Home** page, select **All resources**. Then select the App Service resource. The **BoardGamingAPI123aa456789** App Service pane appears. The numbers at the end will differ for your implementation.

1. In the command bar of the **Overview** tab, as a test, select **Browse**. Notice the error message. The browser displays the message "No webpage found for this address". This occurs because the web API doesn't implement a web user interface.

1. In a new browser tab, paste the web API test URL that you previously copied, and select <kbd>Enter</kbd>. The browser displays a response in JSON format. Notice that the result includes the server time, with the label **quotePreparedTime**.

1. In a second browser tab, paste the Swagger URL that you copied previously and then select <kbd>Enter</kbd>. The browser displays the Swagger page for your *Board Gaming API*. Keep this browser tab open for later use.

1. In a third browser tab, paste the Swagger JSON URL that you copied previously. The browser displays the OpenAPI specification in JSON format.

Leave these tabs open. They'll be handy later.

## Create a new API Management instance

Now that we have a functional API, let's set up API Management. For this module we'll use the Basic v2 tier for API Management, which is designed for development and testing scenarios and provides an internal cache. (As an option, you can also configure an external cache.) Azure configures API Management instances for this tier in just a minute or so. 

1. On the Azure portal **Resource** menu, or on the **Home** page, select **Create a resource**. The **Create a resource** pane appears.

1. In the **Create a Resource** menu, select **Integration**, and then select **API Management** from the result list. The **Create API Management service** pane appears.

1. Enter the following values for each setting in the **Basics** tab.

    | Setting | Value |
    | --- | --- |
    | **Project details** |
    | Subscription | Select your subscription. |
    | Resource group | Select a new or existing resource group. A resource group is a logical container that holds related resources for an Azure solution. |
    | **Instance details** |
    | Region | Choose a region where you can deploy a Basic v2 instance. Example: South Central US |
    | Resource name | Choose a unique name. Make a note of it. You'll need it later on. |
    | Organization name | BoardGames |
    | Administrator email | The email address to receive all system notifications. |
    | **Pricing tier** |
    | Pricing tier | Basic v2 |

1. Select **Review + create** to validate your input, and then select **Create**.

## Add your API to API Management

We must apply a policy to enable caching of API responses. However, before you can apply a policy, you must add the API to the API Management instance.

1. In the [Azure portal](https://portal.azure.com/) menu, or on the **Home** page, select **All resources**. Then select the API Management service that you created earlier.

1. In the left navigation, under **APIs**, select **APIs**. The **APIs** pane for your API Management service appears. It offers numerous templates for you to choose from.

1. In the **Create from definition** section, choose **OpenAPI**. The **Create from OpenAPI specification** dialog box appears.

    :::image type="content" source="../media/5-add-api-to-management.png" alt-text="Screenshot that shows how to add an API to API Management in the portal.":::

1. In the **OpenAPI specification** box, paste the Swagger JSON URL that you copied previously.

    :::image type="content" source="../media/5-complete-api-add.png" alt-text="Screenshot that shows how to configure an OpenAPI specification in the portal.":::

1. Select **Create**. The **APIs** pane for your API Management service reappears. It lists all available API operations for that management instance.

## Test the API in API Management

The API is now added to the management instance. Let's test how the API functions before any policies are applied.

1. Select the API that you added, select the **Test** tab, and then select the **GET - GetPriceEstimate** operation. The **GetPriceEstimate** pane appears.

1. Enter the following values as **Template parameters** and **Query parameters**.

    | NAME | VALUE |
    | --- | --- |
    | ShippingCode | usa |
    | Game | chess |
    | Height | 8 |
    | Width | 8 |

1. Select **Send**.

    :::image type="content" source="../media/5-test-api-in-apim.png" alt-text="Screenshot that shows how to test the API in API Management.":::

1. Review the results. Notice that the precise `quotePreparedTime` is included in the *HTTP response* payload.

    :::image type="content" source="../media/5-view-cached-response.png" alt-text="Screenshot that shows the timestamp of the payload in the test console. ":::

1. Select **Send** to repeat the request. Notice that the time in the *HTTP response* payload has changed.

## Add a caching policy

We can now enable caching by adding response caching policies.

1. Select the **Design** tab for your API, and choose the **GET - GetPriceEstimate** operation.  The **GetPriceEstimate** pane appears.

1. In the **Inbound processing** section, select **+ Add policy**. The **Add inbound policy** pane appears.

    :::image type="content" source="../media/5-add-policy.png" alt-text="Screenshot that shows how to add a caching policy.":::

1. Select **Cache responses**. The **Inbound processing** pane reappears.

1. Under **Cache responses**, in the **Duration in seconds** box, enter **600**. Then select **Save**.

1. In the **Inbound processing** section, select **</>**. The policy XML editor appears.

1. Notice that a `<cache-lookup>` tag has been added to the `<inbound>` section. A `<cache-store>` tag has also been added to the `<outbound>` section.

    :::image type="content" source="../media/5-policy-editor-with-caching-policies.png" alt-text="Screenshot that shows a policy editor with caching policies.":::

1. Select **Save**.

## Test the cache

We'll run the same test on the API as in the previous section, from within API Management. We'll then review the results.

1. In the **APIs** pane for your API Management service, select the **Test** tab. Then select the **GET - GetPriceEstimate** operation. The **GetPriceEstimate** pane appears.

1. Enter the following values as **Template parameters** and **Query parameters**.

    | NAME | VALUE |
    | --- | --- |
    | ShippingCode | usa |
    | Game | chess |
    | Height | 8 |
    | Width | 8 |

    :::image type="content" source="../media/5-test-api-in-apim.png" alt-text="Screenshot that shows how to test the API in API Management.":::

1. Select **Send**.

1. Review the results. Notice that the precise `quotePreparedTime` is included in the *HTTP response* payload.

1. Select **Send** to repeat the request. Notice that the `quotePreparedTime` value in the response is still the same. That's because a cached response is served.

## Configure the cache to vary results based on query parameters

We'll configure the cache to serve unique prices based on the *Height* query parameter. Board *Width* isn't used to calculate cost, so it won't be configured.

1. Select the **Design** tab for your API. Then select the **GET - GetPriceEstimate** operation. The **GetPriceEstimate** pane appears.

1. In the **Inbound processing** section, select **</>** to edit the policy code.

1. Replace the entire `<cache-lookup>` tag with the following XML:

    ```xml
    <cache-lookup vary-by-developer="false" vary-by-developer-groups="false" downstream-caching-type="none">
        <vary-by-query-parameter>height</vary-by-query-parameter>
    </cache-lookup>
    ```

1. Select **Save**. 

## Test the new cache configuration

The cache should now deliver unique responses based on the *Height* query parameter. Since the *Width* parameter doesn't affect cost, a cached response is used even when the width changes. Let's test that:

1. In the **APIs** pane for your API Management service, select the **Test** tab. Then select the **GET - GetPriceEstimate** operation.  The **GetPriceEstimate** pane appears.

1. Enter the following values as **Template parameters** and **Query parameters**.

    | NAME | VALUE |
    | --- | --- |
    | ShippingCode | usa |
    | Game | chess |
    | Height | 8 |
    | Width | 8 |

1. Select **Send**.

1. Review the results. Notice that the `quotePreparedTime` is included in the response.

    :::image type="content" source="../media/5-view-cached-response.png" alt-text="Screenshot that shows the timestamp of the payload in the test console. ":::

1. Select **Send** to repeat the request. Notice that like before, the time value in the response hasn't changed. That's because a cached response was served.

1. To test the *Height* parameter, use the following values as *Template parameters* and *Query parameters*.

    | NAME | VALUE |
    | --- | --- |
    | ShippingCode | usa |
    | Game | chess |
    | Height | 100 |
    | Width | 8 |

1. Select **Send**.

1. Review the result. This time, the result is updated and changed. A cache wasn't used because the *Height* query parameter was changed in the request. This response is correct for our API.

1. Let's test the *Width* parameter. Enter the following values as *Template parameters* and *Query parameters*.

    | NAME | VALUE |
    | --- | --- |
    | ShippingCode | usa |
    | Game | chess |
    | Height | 100 |
    | Width | 500 |

1. Select **Send**.

1. Review the result. This time, although the *Width* query parameter is different, the result doesn't change. That's because a cached response is served.
