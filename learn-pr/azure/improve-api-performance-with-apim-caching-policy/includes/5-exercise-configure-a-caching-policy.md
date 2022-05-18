Companies that use Azure API Management to host APIs can modify their behavior without rewriting code by using policies.

Suppose you want to implement caching for the Board Pricing API. You want to add the API to API Management and write the necessary policies. The cost for a board is dependent on the height of the board, but not its width. 

In this exercise, you'll import an API into Azure API Management and add a caching policy to it.

[!include[](../../../includes/azure-sandbox-regions-first-mention-note-friendly.md)]

> [!NOTE]
> In this exercise, the Board Gaming Web API is hosted in the **azurewebsites.net** domain. The API Management instance is in the **azure-api.net** domain.

## Create a Redis cache

In this module, we're using the consumption tier for Azure API Management because Azure can set up API Management instances in this tier within a minute or so. Instances in other tiers can take 30 minutes to initiate. The consumption tier in API Management is intended for organizations who prefer to build APIs on serverless principles. This tier doesn't have its own internal cache, so, to use a caching policy, we must create an external Redis cache, and configure the API Management instance to use it. 

Let's create a cache now so that the process can complete while we take other steps:

1. Open the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) using the same login ID you used to activate the sandbox.

1. From the resource menu or from the **Home** page, select **Create a resource**. The **Create a resource** pane appears.

1. In the **Create a resource** menu, select **Databases**, and then search for and select **Azure Cache for Redis**. The **New Redis Cache** pane appears.

1. On the **Basics** tab, enter the following values for each setting.

    | Setting | Value |
    | --- | --- |
    | **Project details** |
    | Subscription | *Concierge Subscription* |
    | Resource group | *<rgn>Sandbox resource group</rgn>* |
    | **Instance Details** |
    | DNS name | Choose a unique name, for example, *boardgaming*. Make a note of it, you'll need it later on. |
    | Location | Select from one of the following: North Central US, West US, West Europe, North Europe, Southeast Asia, and Australia East. The Consumption tier used in this exercise is only available in these regions. |
    | Cache type | Standard C1 |
    | | |

    ![Creating a Redis cache.](../media/5-create-redis-cache.png)

1. Select **Review + create** to validate your input, and then select **Create**.

## Create a Web API in Azure Apps Service

Now, deploy the sample Web API to Azure App Service:

1. In Azure Cloud Shell, to clone the sample Web API, run this command:

    ```bash
    git clone https://github.com/MicrosoftDocs/mslearn-improve-api-performance-with-apim-caching-policy.git
    ```

1. To set up the Web API, run these commands:

    ```bash
    cd mslearn-improve-api-performance-with-apim-caching-policy
    bash setup.sh
    ```

1. The script has seven parts that take several minutes to run. When the script finishes, it displays three URLs:

    - Web API test URL for testing the Web API.
    - A Swagger URL for the Swagger UI.
    - A Swagger JSON URL for the OpenAPI definition.

    Note these urls; we'll use them in the next task. Optionally, copy these URLs to a text file for reference.

## Test the deployed Web API

When the Web API has been set up and successfully deployed in the Cloud Shell, let's test it. We can do that by submitting a GET request in the browser and also by checking the OpenAPI definition. These tests, run against the Web API before it's added to API Management, are in the **azurewebsites.net** domain:

1. On the Azure portal resource menu or from the **Home** page, select **All resources**, and then select the App Service resource type. The **BoardGamingAPI123aa456789** App Service pane appears (the numbers at the end will differ for your implementation).

1. On the **Overview** tab, in the command bar, select **Browse**. The browser displays a *No webpage found for this address* page. This is expected because the Web API doesn't implement an Azure website user interface.

1. In a new browser tab, paste the Web API test URL that you previously copied, and press <kbd>Enter</kbd>. The browser displays a response in JSON format. Notice that the result includes the server time with the label **quotePreparedTime**.

1. In a second browser tab, paste the Swagger URL that you previously copied, and press <kbd>Enter</kbd>. The browser displays the Swagger page for your *Board Gaming API*. Keep this browser tab open for later use.

1. In a third browser tab, paste the Swagger JSON URL that you previously copied. The browser displays the OpenAPI specification in JSON format.

Leave these tabs open; they'll be handy later.

## Create a new Azure API Management instance

Now that we have a functional API, let's set up API Management:

1. On the Azure portal resource menu or from the **Home** page, select **Create a resource**. The **Create a resource** pane appears.

1. In the **Create a Resource** menu, select **Web**, and then select **API Management** from the result list. The **Create API Management** pane appears.

1. On the **Basics** tab, enter the following values for each setting.

    | Setting | Value |
    | --- | --- |
    | **Project details** |
    | Subscription | *Concierge Subscription* |
    | Resource group | In the dropdown list, select *<rgn>Sandbox resource group</rgn>*. |
    | **Instance details** |
    | Region | Choose the same location you used for the Redis Cache. |
    | Resource name | Choose a unique name. Make a note of it, you'll need it later on. |
    | Organization name | BoardGames |
    | Administrator email | Enter your email address. |
    | **Pricing tier** |
    | Pricing tier | Consumption |
    | | |

1. Select **Review + create** to validate your input, and then select **Create**.

## Configure API Management to use the external cache

Now, if the Redis cache deployment is complete, you can configure the API Management instance to use your Redis cache as an external cache:

1. On the Azure portal resource menu or from the **Home** page, select **All resources**, and then select the *Azure Cache for Redis* resource type. Your **Azure Cache for Redis** pane appears.

1. Check the **Essentials** section at the top of the pane. If the status doesn't show **Running**, you'll have to wait until the Redis cache deployment has completed. Refresh this pane every couple of minutes to update the status.

1. After setup is complete, in the **Azure Cache for Redis** menu, under **Settings**, select **Access keys**. The **Access keys** pane for your Azure Cache for Redis instance appears.

1. In the right corner of the **Primary connection string (StackExchange.Redis)** textbox, select the *Copy to clipboard* icon.

    ![Obtaining the Redis cache connection string.](../media/5-obtain-redis-cache-connection-string.png)

1. In the **All resources** pane, select the API management service resource that you created in a previous task. The **API Management service** pane appears.

1. In the **API Management service** menu, under **Deployment + Infrastructure**, select **External cache**. The **External cache** pane for your API Management service appears.

1. In the command bar, select **Add**. The **External cache** pane appears for your API Management service.

1. In the **Cache instance** dropdown list, select **Custom**, and then in the **Use from** textbox, select the same location you used for the API Management instance.

1. To paste in the primary connection string you copied, put the cursor in the **Connection string** textbox, press <kbd>Ctrl-v</kbd>, and then select **Save** from the command bar.

    ![Configuring the external cache.](../media/5-configure-external-cache.png)

    The external cache you just created is now listed on the External cache page for your API Management service.

## Add the API in API Management

We must apply a policy to enable users to access the API. Before you can apply a policy, you must add the API to the API Management instance.

1. On the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) menu or from the **Home** page, select **All resources** and then select the API Management service you previously created.

1. In the **API Management service** menu, under **APIs**, select **APIs**. The **APIs** pane for your API Management service appears with numerous template selections.

1. Under the **Create from definition** section, select **OpenAPI**. The **Create from OpenAPI specification** dialog box appears.

1. In the **OpenAPI specification** textbox, paste the Swagger JSON URL that you previously copied.

    ![Adding an API.](../media/5-complete-api-add.png)

1. Select **Create**. The **APIs** pane for your API Management service reappears showing all the operations available in the  API for the management instance.

## Test the API in API Management

The API is now added to the management instance. Let's test the API before any policy is applied.

1. In the **APIs** pane for your API Management service, select the **Test** tab, and then select the **GET - GetPriceEstimate** operation. The **GetPriceEstimate** pane appears.

1. Enter the following values for the **Template parameters** and **Query parameters**.

    | NAME | VALUE |
    | --- | --- |
    | ShippingCode | usa |
    | Game | chess |
    | Height | 8 |
    | Width | 8 |
    | | |

1. Select **Send**.

    :::image type="content" source="../media/5-test-api-in-apim.png" alt-text="Test the API in API Management.":::

1. Examine the results. Note the precise time that is included in the *HTTP response*.

1. Select **Send** to resend the request. Notice that the time in the *HTTP response* has changed.

## Add a caching policy

Now we can enable the cache by adding policies to the XML.

1. In the **APIs** pane for your API Management service, select the **Design** tab, and then select the **GET - GetPriceEstimate** operation.  The **GetPriceEstimate** pane appears.

1. In the **Inbound processing** section, select **Add policy**. The **Add inbound policy** pane appears.

    ![Adding a policy.](../media/5-add-policy.png)

1. Select **Cache responses**. The **Inbound processing** pane reappears.

1. Under **Cache responses**, in the **Duration in seconds** textbox, enter **600**, and then select **Save**.

1. In the **Inbound processing** section, select **</>**. The policy XML editor appears.

1. Notice that a **&lt;cache-lookup&gt;** tag has been added to the **&lt;inbound&gt;** section, and a **&lt;cache-store&gt;** tag has been added to the **&lt;outbound&gt;** section.

    ![Policy editor with caching policies.](../media/5-policy-editor-with-caching-policies.png)

1. Select **Save**.

## Test the cache

We'll run the same test on the API in API Management and observe the results of the cache.

1. In the **APIs** pane for your API Management service, select the **Test** tab, and then select the **GET - GetPriceEstimate** operation. The **GetPriceEstimate** pane appears.

1. Enter the following values for the **Template parameters** and **Query parameters**.

    | NAME | VALUE |
    | --- | --- |
    | ShippingCode | usa |
    | Game | chess |
    | Height | 8 |
    | Width | 8 |
    | | |

    :::image type="content" source="../media/5-test-api-in-apim.png" alt-text="Test the API in API Management.":::

1. Select **Send**.

1. Examine the results. Note the precise time that is included in the *HTTP response*.

1. Select **Send** to resend the request. Notice that the time in the response hasn't changed, because the cached response has been served.

## Configure the cache to vary by a query parameter

To ensure that the system caches different responses for different board heights, you must configure the cache to vary by the *Height* query parameter. You don't want to vary by the *Width* parameter, because that value isn't used in the cost calculation.

1. In the **APIs** pane for your API Management service, select the **Design** tab, and then select the **GET - GetPriceEstimate** operation. The **GetPriceEstimate** pane appears.

1. In the **Inbound processing** section, select **</>** to edit the policy code.

1. Replace the entire `<cache-lookup>` tag, with the following XML:

    ```xml
    <cache-lookup vary-by-developer="false" vary-by-developer-groups="false" downstream-caching-type="none">
        <vary-by-query-parameter>height</vary-by-query-parameter>
    </cache-lookup>
    ```

1. Select **Save**.

## Test the new cache configuration

The cache should now keep separate responses for different values of the *Height* query parameter. However, because the *Width* parameter doesn't influence the cost calculation, when you change only that parameter a cached response can be used. Let's test that:

1. In the **APIs** pane for your API Management service, select the **Test** tab, and then select the **GET - GetPriceEstimate** operation.  The **GetPriceEstimate** pane appears.

1. Enter the following values for the **Template parameters** and **Query parameters**.

    | NAME | VALUE |
    | --- | --- |
    | ShippingCode | usa |
    | Game | chess |
    | Height | 8 |
    | Width | 8 |
    | | |

1. Select **Send**.

1. Examine the results. Note the precise time that is included in the response.

1. Select **Send** to resend the request. As before, notice that the time in the response hasn't changed, because the cached response has been served.

1. To test the *Height* parameter, use the following values for *Template parameters* and *Query parameters*.

    | NAME | VALUE |
    | --- | --- |
    | ShippingCode | usa |
    | Game | chess |
    | Height | 100 |
    | Width | 8 |
    | | |

1. Select **Send**.

1. Examine the results. This time, because the height query parameter in the request has changed, the cached response isn't used and the result is updated. This behavior is correct for our API.

1. To test the *Width* parameter, enter the following values for *Template parameters* and *Query parameters*.

    | NAME | VALUE |
    | --- | --- |
    | ShippingCode | usa |
    | Game | chess |
    | Height | 100 |
    | Width | 500 |
    | | |

1. Select **Send**.

1. Examine the results. This time, although the width query parameter in the request has changed, the cached response is used, and the result doesn't change.
