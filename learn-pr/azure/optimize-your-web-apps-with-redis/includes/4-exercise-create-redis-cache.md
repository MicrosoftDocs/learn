Let's create an Azure Cache for Redis instance to store and return commonly used values.

<!-- Activate the sandbox -->
[!include[](../../../includes/azure-sandbox-activate.md)]

## Create a Redis cache in Azure

1. Sign into the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) using the same account you activated the sandbox with.

1. Click **Create a resource**, click **Databases**, and click **Redis Cache**.

    The following screenshot shows the Redis Cache location within the various database resource options on the Azure portal.

    ![Screenshot showing the Azure portal database options, with the Create a resource, Database, and Redis Cache options highlighted.](../media/4-create-a-cache-1.png)

### Configure your cache

Apply the following settings on the cache.

1. **DNS Name:** Create a globally unique name such as **ContosoSportsApp[nnn]**, where `[nnn]` is replaced with random numbers.

1. **Subscription:** Select the Concierge subscription.

1. **Resource group:** Select <rgn>[sandbox resource group name]</rgn> for the Resource Group.

1. **Location:** Normally, you would select a location near your customers - in this case, the East Coast.

    [!include[](../../../includes/azure-sandbox-regions-note-friendly.md)]

5. **Pricing tier:** Select **Basic C0**. This is the lowest tier you can use. Production apps would likely want to store more data and utilize some of the Premium features such as clustering which would require a higher tier selection.

1. Click **Create**. Azure will create and deploy the Redis Cache instance for you.

    > [!IMPORTANT]
    > Usually, the Redis cache resource will be created and viewable in the Azure portal very quickly, but the cache itself will not be available for a few minutes. The next steps show how to check the status of your cache.

## Verify your data

You can use the **Console** feature in the Azure portal to issue commands to your Redis cache instance after it has been created.

1. Locate your Redis cache through the **Notification** popup when it finishes deployment, or by selecting **All Resources** in the left-hand sidebar and using the filter box on the left to select Redis Cache instances. Alternatively, you can use the search box at the top and type the name of the cache.

1. Select your Redis cache instance.

1. Check the value of the "Status" field. The cache is not ready until the status is "Running". You might have to wait for a few minutes before proceeding.

1. Once the cache is running, Click the `>_ Console` button in the toolbar on the **Overview** blade for your Redis Cache. This will open a Redis console, which allows you to enter low-level Redis commands. Try some of the following:

    ```console
    ping
    ```

    ```output
    PONG
    ```

    ```console
    set test one
    ```

    ```output
    OK
    ```

    ```console
    get test
    ```

    ```output
    "one"
    ```

Switch back to the **Overview** panel either through the breadcrumb bar on the top, or use the scrollbar to slide the view back to the left.

## Retrieve the access keys and host name

1. Select **Settings** > **Access keys**.

1. Copy the **Primary connection string (StackExchange.Redis)** to a safe place, you will need it for the next exercise.

    This key includes your primary key and host name in a complete connection string for use within your application settings for the **StackExchange.Redis** package we are going to use.

Next, let's learn about some of the commands we can use to interrogate the cache.