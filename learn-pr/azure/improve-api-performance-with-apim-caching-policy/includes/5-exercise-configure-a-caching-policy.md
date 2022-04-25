When you host APIs using Azure API Management, you can modify their behavior without rewriting code, by using policies.

As the developer for a board game company, you decide to implement caching for the Board Pricing API. You first need to add the API to Azure API Management and then write your caching policies. We'll do this in the next exercise.

[!include[](../../../includes/azure-sandbox-regions-first-mention-note-friendly.md)]

> [!NOTE]
> In this exercise, the Board Gaming Web API is hosted in the **azurewebsites.net** domain. The API Management instance is in the **azure-api.net** domain.

## Create a Redis cache

We're using the Consumption tier for Azure API Management in this module. That's because Azure configures API Management instances for this tier within a minute or so. Other tiers can take up to 30 minutes.

The Consumption tier in API Management is intended for organizations that prefer to build APIs on serverless principles. This tier doesn't have its own internal cache. Instead, we need to create an external Redis cache and then configure a caching policy for API Management to use.

Let's create a cache now. Doing this will allow the setup to run behind the scenes while we work on other steps:

1. Sign in to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true). Use the same ID that you used to activate the sandbox.

1. On the Azure portal resource menu, or on the **Home** page, select **Create a resource**. The **Create a resource** pane appears.

1. In the **Create a resource** menu, select **Databases**, and then search for and select **Azure Cache for Redis**. The **New Redis Cache** pane appears.

1. On the **Basics** tab, enter the following values for each setting.

    | Setting | Value |
    | --- | --- |
    | **Project details** |
    | Subscription | *Concierge Subscription* |
    | Resource group | *<rgn>Sandbox resource group</rgn>* |
    | **Instance Details** |
    | DNS name | Choose a unique name, for example, *boardgaming*. Make a note of it. You'll need it later on. |
    | Location | Select from one of the following: North Central US, West US, West Europe, North Europe, Southeast Asia, and Australia East. The Consumption tier that's used in this exercise is only available in these regions. |
    | Cache type | Standard C1 |
    | | |

    ![Screenshot that shows the form that's used to create a new Redis cache.](../media/5-create-redis-cache.png)

1. Select **Review + create** to validate your input, and then select **Create**.

## Create a Web API in Azure Apps Service

Now in the sandbox environment create a Web API in Azure Apps Service. We do this by using a two-step process:

1. In Azure Cloud Shell, clone the sample Web API by running the following command:

    ```bash
    git clone https://github.com/MicrosoftDocs/mslearn-improve-api-performance-with-apim-caching-policy.git
    ```

1. Set up the Web API, by running the following two commands:

    ```bash
    cd mslearn-improve-api-performance-with-apim-caching-policy
    bash setup.sh
    ```

Setup.sh has seven parts that take several minutes to run.  When it is complete, three URLs are displayed:

    - A Web API, test URL, for testing the Web API.
    - A Swagger URL for the Swagger UI.
    - A Swagger JSON URL for the OpenAPI definition.

    Make note of these URLs. We'll use them in the next task. 

## Test the newly deployed Web API

When the Web API is successfully created in Cloud Shell, then you can test it. Run tests by submitting a GET request in the browser or by checking the OpenAPI definition. The tests run against the Web API in the **azurewebsites.net** domain before it's added to API Management:

1. On the Azure portal **Resource** menu, or the **Home** page, select **All resources**. Then select the App Service resource. The **BoardGamingAPI123aa456789** App Service pane appears (the numbers at the end will differ for your implementation).

1. In the command bar of the **Overview** tab, as a test, select **Browse**. Notice the error message, the browser displays the message "No webpage found for this address". This occurs because the Web API doesn't implement an Azure website user interface.

1. In a new browser tab, paste the Web API, test URL that you previously copied, and select <kbd>Enter</kbd>. The browser displays a response in JSON format. Notice that the result includes the server time, with the label **quotePreparedTime**.

1. In a second browser tab, paste the Swagger URL that you copied previously, then select <kbd>Enter</kbd>. The browser displays the Swagger page for your *Board Gaming API*. Keep this browser tab open for later use.

1. In a third browser tab, paste the Swagger JSON URL that you copied previously. The browser displays the OpenAPI specification in JSON format.

Leave these tabs open; they'll be handy later.

## Create a new Azure API Management instance

Now that we have a functional API, let's set up API Management:

1. On the Azure portal **Resource** menu, or the **Home** page, select **Create a resource**. The **Create a resource** pane appears.

1. In the **Create a Resource** menu, select **Web**, and then select **API Management** from the result list. The **Create API Management** pane appears.

1. Enter the following values for each setting in the **Basics** tab.

    | Setting | Value |
    | --- | --- |
    | **Project details** |
    | Subscription | *Concierge Subscription* |
    | Resource group | In the dropdown list, select *<rgn>Sandbox resource group</rgn>*. |
    | **Instance details** |
    | Region | Choose the same location you used for the Redis Cache. |
    | Resource name | Choose a unique name. Make a note of it. You'll need it later on. |
    | Organization name | BoardGames |
    | Administrator email | Enter your email address. |
    | **Pricing tier** |
    | Pricing tier | Consumption |
    | | |

1. Select **Review + create** to validate your input, and then select **Create**.

## Configure API Management to use the external cache

You can configure the API Management instance to use your Redis cache as an external cache, only when the Redis cache is completely deployed:

1. On the Azure portal **Resource** menu, or the **Home** page, select **All resources**. Then select the *Azure Cache for Redis* resource type. An **Azure Cache for Redis** pane appears.

1. In the **Essentials** section of the pane, the resource status should display as **Running**. Continue to check the status every few minutes, by clicking the **Refresh** link. Proceed only when the Redis cache deployment is complete.

1. In the **Azure Cache for Redis** menu, in the **Settings** section of the left navigation, select **Access Keys**. The **Access keys** pane appears for the Azure Cache for Redis instance that you just created.

1. In the right corner of the **Primary connection string (StackExchange.Redis)** textbox, select the *Copy to clipboard* icon.

    ![Screenshot that shows how to obtain the Redis cache connection string.](../media/5-obtain-redis-cache-connection-string.png)

1. In the **All resources** pane, select the same API Management service resource that you created earlier. The **API Management service** pane appears.

1. On the **API Management service** menu, in **Deployment + Infrastructure** in the left navigation, select **External cache**. The **External cache** pane for your API Management service appears.

1. Select **Add** from the command bar. The **External cache** pane for your API Management service appears.

1. In the **Cache instance** dropdown list, select **Custom**. Then in the **Use from** textbox, select the same location that you used for the API Management instance.

1. In the **Connection string** textbox, paste the primary connection string that you have copied. Then in the command bar, select **Save**.

    ![Screenshot that shows how to configure the external cache.](../media/5-configure-external-cache.png)

    The external cache you just created is now listed on the External cache page for your API Management service.

## Add your API to API Management

We must apply a policy to enable users to access the API. However before you can apply a policy, you must add the API to the API Management instance.

1. In the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) menu, or from the **Home** page, select **All resources**. Then select the API Management service you created earlier.

1. In the **API Management service** menu, select **APIs**. The **APIs** pane for your API Management service appears. It offers numerous templates for you to choose from.

1. In the **Create from definition** section, choose **OpenAPI**. The **Create from OpenAPI specification** dialog box appears.

1. In the **OpenAPI specification** textbox, paste the Swagger JSON URL that you copied previously.

    ![Screenshot that shows how to add an API to API Management.](../media/5-complete-api-add.png)

1. Select **Create**. The **APIs** pane for your API Management service reappears, listing all available API operations for that management instance.

## Test the API in API Management

The API has now been added to the management instance. Let's test the API before any policies are applied.

1. In the **APIs** pane for your API Management service, select the **Test** tab and then select the **GET - GetPriceEstimate** operation. The **GetPriceEstimate** pane appears.

1. Enter the following values as **Template parameters** and **Query parameters**.

    | NAME | VALUE |
    | --- | --- |
    | ShippingCode | usa |
    | Game | chess |
    | Height | 8 |
    | Width | 8 |
    | | |

1. Select **Send**.

    :::image type="content" source="../media/5-test-api-in-apim.png" alt-text="Screenshot that shows how to test the API in API Management.":::

1. Review the results. Notice that the precise time has been included in the *HTTP response*.

1. Select **Send** again to the repeat request. Notice that the time in the *HTTP response* has changed.

## Add a caching policy

We can now enable caching. This is done by adding policies to inbound processing XML code.

1. Select your API Management service, then Click the **APIs** link. Next select the **Design** tab and choose the **GET - GetPriceEstimate** operation.  The **GetPriceEstimate** pane appears.

1. Select **Add policy** from the **Inbound processing** section. The **Add inbound policy** pane appears.

    ![Screenshot that shows how to add a caching policy.](../media/5-add-policy.png)

1. Select **Cache responses**. The **Inbound processing** pane reappears.

1. Under **Cache responses**, in the **Duration in seconds** textbox, found, enter **600**. Then select **Save**.

1. In the **Inbound processing** section, select **</>**. The policy XML editor appears.

1. Notice that a **&lt;cache-lookup&gt;** tag has been added to the **&lt;inbound&gt;** section. A **&lt;cache-store&gt;** tag has also been added to the **&lt;outbound&gt;** section.

    ![Screenshot that shows a policy editor with caching policies.](../media/5-policy-editor-with-caching-policies.png)

1. Select **Save**.

## Test the cache

We'll run the same test on the API in API Management and review the results.

1. In the **APIs** pane for your API Management service, select the **Test** tab. Then select the **GET - GetPriceEstimate** operation. The **GetPriceEstimate** pane appears.

1. Enter the following values as **Template parameters** and **Query parameters**.

    | NAME | VALUE |
    | --- | --- |
    | ShippingCode | usa |
    | Game | chess |
    | Height | 8 |
    | Width | 8 |
    | | |

    :::image type="content" source="../media/5-test-api-in-apim.png" alt-text="Screenshot that shows how to test the API in API Management.":::

1. Select **Send**.

1. Review the results. Notice that the precise time has been included in the *HTTP response*.

1. Select **Send** again to repeat the request. Notice that the time value in the response hasn't changed. That's because a cached response has been served.

## Configure the cache to vary results based on query parameters

The cache needs to be configured for it to serve unique prices based on the *Height* query parameter. Board *Width* isn't used to calculate cost, so it won't be configured.

1. In the **APIs** pane for your API Management service, select the **Design** tab. Then select the **GET - GetPriceEstimate** operation. The **GetPriceEstimate** pane appears.

1. In the **Inbound processing** section, select **</>** to edit the policy code.

1. Replace the entire `<cache-lookup>` tag, with the following XML:

    ```xml
    <cache-lookup vary-by-developer="false" vary-by-developer-groups="false" downstream-caching-type="none">
        <vary-by-query-parameter>height</vary-by-query-parameter>
    </cache-lookup>
    ```

1. Select **Save**.

## Test the new cache configuration

The cache should now deliver unique responses depending on the *Height* query parameter. Since the *Width* parameter doesn't affect cost, a cached response can be used when the Width parameter is changed. Let's test that:

1. In the **APIs** pane for your API Management service, select the **Test** tab. Then select the **GET - GetPriceEstimate** operation.  The **GetPriceEstimate** pane appears.

1. Enter the following values as **Template parameters** and **Query parameters**.

    | NAME | VALUE |
    | --- | --- |
    | ShippingCode | usa |
    | Game | chess |
    | Height | 8 |
    | Width | 8 |
    | | |

1. Select **Send**.

1. Review the results. Notice that the precise time is included in the response.

1. Select **Send** to repeat the request. Notice that like before, the time value in the response hasn't changed. That's because a cached response was served.

1. To test the *Height* parameter, use the following values as *Template parameters* and *Query parameters*.

    | NAME | VALUE |
    | --- | --- |
    | ShippingCode | usa |
    | Game | chess |
    | Height | 100 |
    | Width | 8 |
    | | |

1. Select **Send**.

1. Review the results. This time, the results are updated and changed. A cache wasn't used because the Height query parameter was changed in the request. The response is correct for our API.

1. Let's test the *Width* parameter. Enter the following values as *Template parameters* and *Query parameters*.

    | NAME | VALUE |
    | --- | --- |
    | ShippingCode | usa |
    | Game | chess |
    | Height | 100 |
    | Width | 500 |
    | | |

1. Select **Send**.

1. Review the results. This time, although the Width query parameter changed, the result didn't change. That's because a cached response was served.
