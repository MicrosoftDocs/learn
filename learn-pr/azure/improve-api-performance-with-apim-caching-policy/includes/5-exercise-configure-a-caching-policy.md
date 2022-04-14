When you host APIs using Azure API Management, you are able to modify their behavior without re-writing code.

Let's say, you want to implement caching for the Board Pricing API. You would first add the API to Azure API Management and then write your caching policies.

In the following exercise, we'll import an API into Azure API Management and add a caching policy to it.

[!include[](../../../includes/azure-sandbox-regions-first-mention-note-friendly.md)]

> [!NOTE]
> In this exercise, the Board Gaming Web API is hosted in the **azurewebsites.net** domain. The API Management instance is in the **azure-api.net** domain.

## Create a Redis cache

In this module, we're using the Consumption tier for Azure API Management. That's because Azure configures API Management instances within a minute or so for this tier. Other tiers can take up to 30 minutes. The Consumption tier in API Management is intended for organizations that prefer to build APIs on serverless principles. This tier doesn't have its own internal cache. Instead, we must create an external Redis cache and configure API Management to use a caching policy.

Let's create a cache now. This allows the process to run behind the scenes, while we work on other steps:

1. Open the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true), using the same login ID you used to activate the sandbox.

1. Navigate to the Azure portal resource menu or the **Home** page, and select **Create a resource**. The **Create a resource** pane will appear.

1. In the **Create a resource** menu, select **Databases**, and then search for and select **Azure Cache for Redis**. The **New Redis Cache** pane will appear.

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

1. Select **Review + create** to validate your input, and then click **Create**.

## Create a Web API in Azure Apps Service

Now, let's deploy the sample Web API to Azure App Service:

1. Run the following command in Azure Cloud Shell, to clone the sample Web API:

    ```bash
    git clone https://github.com/MicrosoftDocs/mslearn-improve-api-performance-with-apim-caching-policy.git
    ```

1. Run the commands below to configure the Web API:

    ```bash
    cd mslearn-improve-api-performance-with-apim-caching-policy
    bash setup.sh
    ```

1. The script has seven parts that take several minutes to run. When the script is complete, three urls will be displayed:

    - Web API test URL for testing the Web API.
    - A Swagger URL for the Swagger UI.
    - A Swagger JSON URL for the OpenAPI definition.

    Copy and save these urls in an app like Notepad. We'll use them in the next task.

## Test the deployed Web API

Check to be sure the Web API has deployed successfully in Azure Cloud Shell. When deployment is complete, you'll be able to test it. Tests can be performed in the Web API by submitting a GET request in the browser or by checking the OpenAPI definition. These tests will run against the Web API in the **azurewebsites.net** domain, before it's been added to API Management:

1. Navigate to the Azure portal resource menu or the **Home** page, and select **All resources**. Then select the App Service resource type. The **BoardGamingAPI123aa456789** App Service pane appears (the numbers at the end will differ for your implementation).

1. As a test, select **Browse** in the command bar of the **Overview** tab. Notice the error message. The browser displays a **No webpage found for this address**, message. This occurs because the Web API doesn't implement an Azure website user interface.

1. In a new browser tab, paste the Web API test URL that you previously copied, and press <kbd>Enter</kbd>. The browser displays a response in JSON format. Notice that the result includes the server time with the label **quotePreparedTime**.

1. In a second browser tab, paste the Swagger URL that you copied previously, then press <kbd>Enter</kbd>. The browser will display the Swagger page for your *Board Gaming API*. Keep this browser tab open for later use.

1. In a third browser tab, paste the Swagger JSON URL that you copied previously. The browser will display the OpenAPI specification in JSON format.

Leave these tabs open; they'll be handy later.

## Create a new Azure API Management instance

Now that we have a functional API, let's set up API Management:

1. Navigate to the Azure portal resource menu or the **Home** page, and select **Create a resource**. The **Create a resource** pane will appear.

1. In the **Create a Resource** menu, select **Web**, and then select **API Management** from the result list. The **Create API Management** pane will appear.

1. Enter the following values for each setting in the **Basics** tab.

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

1. Select **Review + create** to validate your input, and then click **Create**.

## Configure API Management to use the external cache

Check to ensure that the Redis cache deployment is complete. If so, you can now configure the API Management instance to use your Redis cache as an external cache:

1. Navigate to the Azure portal resource menu or the **Home** page, and select **All resources**. Then select the *Azure Cache for Redis* resource type. An **Azure Cache for Redis** pane will appear.

1. Check the status message, found just below the **Essentials** headline. The resource should have a status of **Running**. If not, continue to check the status every few minutes, by clicking the **Refresh** link. Wait until the Redis cache deployment is complete before proceeding.

1. Select **Access Keys**, in the **Azure Cache for Redis** menu. This is found under **Settings** in the left navigation. The **Access keys** pane will appear for the Azure Cache for Redis instance that you just created.

1. Select the *Copy to clipboard* icon, that is found in the right corner of the **Primary connection string (StackExchange.Redis)** textbox.

    ![Obtaining the Redis cache connection string.](../media/5-obtain-redis-cache-connection-string.png)

1. Navigate to the **All resources** pane. Select the same API management service resource that you created earlier. The **API Management service** pane will appear.

1. Click **External cache** on the **API Management service** menu, which is found under **Deployment + Infrastructure** in the left navigation. The **External cache** pane for your API Management service will appear.

1. Select **Add** from the command bar. The **External cache** pane for your API Management service will appear.

1. Choose **Custom** from the **Cache instance** dropdown list. Then select the same location you used for the API Management instance from the **Use from** textbox.

1. Place your cursor in the **Connection string** textbox and paste the primary connection string that you have copied. Then click **Save** in the command bar.

    ![Configuring the external cache.](../media/5-configure-external-cache.png)

    The external cache you just created is now listed on the External cache page for your API Management service.

## Add the API in API Management

We must apply a policy to enable users to access the API. However before you can apply a policy, you must add the API to the API Management instance.

1. Navigate to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) menu or the **Home** page and click **All resources**. Then select the API Management service you created earlier.

1. Click **APIs** in the **API Management service** menu. The **APIs** pane for your API Management service will appear. It will offer you numerous templates to choose from.

1. Choose **OpenAPI** in the **Create from definition** section. The **Create from OpenAPI specification** dialog box will appear.

1. Paste the Swagger JSON URL that you copied previously, into the **OpenAPI specification** textbox.

    ![Adding an API.](../media/5-complete-api-add.png)

1. Click **Create**. The **APIs** pane for your API Management service will re-appear, listing all available API operations for that management instance.

## Test the API in API Management

The API has now been added to the management instance. Let's test the API before any policies are applied.

1. Select your API Management service, then click the **APIs** link. Now click the **Test** tab and choose the **GET - GetPriceEstimate** operation. The **GetPriceEstimate** pane will appear.

1. Enter the following values as **Template parameters** and **Query parameters**.

    | NAME | VALUE |
    | --- | --- |
    | ShippingCode | usa |
    | Game | chess |
    | Height | 8 |
    | Width | 8 |
    | | |

1. Click **Send**.

    :::image type="content" source="../media/5-test-api-in-apim.png" alt-text="Test the API in API Management.":::

1. Review the results. Notice that the precise time has been included in the *HTTP response*.

1. Click **Send** again to  the repeat request. Notice that the time in the *HTTP response* has changed.

## Add a caching policy

We can now enable caching. This is done by adding policies to inbound processing XML code.

1. Select your API Management service, then Click the **APIs** link. Next select the **Design** tab and choose the **GET - GetPriceEstimate** operation.  The **GetPriceEstimate** pane appears.

1. Select **Add policy** from the **Inbound processing** section. The **Add inbound policy** pane will appear.

    ![Adding a policy.](../media/5-add-policy.png)

1. Click on **Cache responses**. The **Inbound processing** pane will then re-appear.

1. Enter **600** in the **Duration in seconds** textbox, found under **Cache responses**. Click **Save**.

1. Select **</>** in the **Inbound processing** section. The policy XML editor will appear.

1. Notice that a **&lt;cache-lookup&gt;** tag has been added to the **&lt;inbound&gt;** section, and a **&lt;cache-store&gt;** tag has been added to the **&lt;outbound&gt;** section.

    ![Policy editor with caching policies.](../media/5-policy-editor-with-caching-policies.png)

1. Click **Save**.

## Test the cache

We'll run the same test on the API in API Management and observe the results of the cache.

1. Select your API Management service, then click the **APIs** link. Then select the **Test** tab and choose the **GET - GetPriceEstimate** operation. The **GetPriceEstimate** pane will appear.

1. Enter the following values as **Template parameters** and **Query parameters**.

    | NAME | VALUE |
    | --- | --- |
    | ShippingCode | usa |
    | Game | chess |
    | Height | 8 |
    | Width | 8 |
    | | |

    :::image type="content" source="../media/5-test-api-in-apim.png" alt-text="Test the API in API Management.":::

1. Click **Send**.

1. Review the results. Notice that the precise time has been included in the *HTTP response*.

1. Click **Send** again to re-send the request. Notice that the time value in the response hasn't changed. That's because a cached response was served.

## Configure cache to vary results based on a query parameter

The cache must be configured to serve unique prices based on the *Height* query parameter. Board *Width* isn't used to calculate cost, so it won't be configured.

1. Select your API Management service, then click the **APIs** link. Next select the **Design** tab and choose the **GET - GetPriceEstimate** operation. The **GetPriceEstimate** pane will appear.

1. Select **</>** in the **Inbound processing** section, to edit the policy code.

1. Replace the entire `<cache-lookup>` tag, with the following XML:

    ```xml
    <cache-lookup vary-by-developer="false" vary-by-developer-groups="false" downstream-caching-type="none">
        <vary-by-query-parameter>height</vary-by-query-parameter>
    </cache-lookup>
    ```

1. Click **Save**.

## Test the new cache configuration

The cache will now deliver unique responses depending upon the *Height* query parameter. Since the *Width* parameter doesn't affect cost, a cached response can be used when the Width parameter is changed. Let's test that:

1. Select the **Test** tab in the **APIs** pane for your API Management service. Then choose the **GET - GetPriceEstimate** operation.  The **GetPriceEstimate** pane will appear.

1. Enter the following values as **Template parameters** and **Query parameters**.

    | NAME | VALUE |
    | --- | --- |
    | ShippingCode | usa |
    | Game | chess |
    | Height | 8 |
    | Width | 8 |
    | | |

1. Click **Send**.

1. Review the results. Notice that the precise time has been included in the response.

1. Click **Send** to repeat the request. Notice that like before the time value in the response hasn't changed. This is because a cached response was served.

1. To test the *Height* parameter, use the following values as *Template parameters* and *Query parameters*.

    | NAME | VALUE |
    | --- | --- |
    | ShippingCode | usa |
    | Game | chess |
    | Height | 100 |
    | Width | 8 |
    | | |

1. Click **Send**.

1. Review the results. This time, the results are updated and changed. A cache wasn't used because the Height query parameter in the request was changed. This is the correct response for our API.

1. Let's test the *Width* parameter. Enter the following values as *Template parameters* and *Query parameters*.

    | NAME | VALUE |
    | --- | --- |
    | ShippingCode | usa |
    | Game | chess |
    | Height | 100 |
    | Width | 500 |
    | | |

1. Click **Send**.

1. Review the results. This time, although the Width query parameter was changed, the result didn't change.  cached response was served.
