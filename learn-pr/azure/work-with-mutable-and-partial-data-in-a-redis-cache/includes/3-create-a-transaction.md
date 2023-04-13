Let's start by creating an instance of Azure Cache for Redis, and then create a simple transaction that inserts two data values into the cache.

## Create an Azure Cache for Redis

Let's start by creating an Azure Cache for Redis with the Azure CLI. Use Cloud Shell on the right side of the browser window to interact with Azure.

We'll use the `az redis create` command to create a new Azure Cache for Redis. It takes several parameters. Here are the most common. To see the complete list, check the documentation.

> [!div class="mx-tableFixed"]
> | Parameter | Description |
> |-----------|-------------|
> | `--name`    | Name of the cache - this must be globally unique and composed of letters, numbers, and dashes. |
> | `--resource-group` | Use the pre-created Resource Group **<rgn>[sandbox resource group name]</rgn>**, which is part of the Azure sandbox. |
> | `--location` | Specify the location where the cache should be located. Normally, you will want to choose a location close to the data consumers. In this case, you are limited to the locations available in the Azure sandbox. Select the closest location to you. |
> | `--vm-size` | Size of the Azure Cache for Redis. Valid values are [C0, C1, C2, C3, C4, C5, C6, P1, P2, P3, P4]. |
> | `--sku` | Azure Cache for Redis SKU. Valid values are [Basic, Standard, Premium]. |

### Select a location
<!-- Resource selection -->
[!include[](../../../includes/azure-sandbox-regions-first-mention-note.md)]

1. Create a cache using the following options:
    - Size: C0
    - SKU: Basic

1. Here's an example command line. Make sure to replace the `[name]` parameter with a unique name. You can replace the location if you want a different region than East US.

    ```azurecli
    REDIS_NAME=[name]

    az redis create \
        --name "$REDIS_NAME" \
        --resource-group <rgn>[sandbox resource group name]</rgn> \
        --location eastus \
        --vm-size C0 \
        --sku Basic
    ```

## Create a .NET Core console application

Next, create a .NET Core console application, which will be used to insert data values into our Azure Cache for Redis.

1. Create a new .NET Core application using Cloud Shell on the right hand side of the browser window. Name it "RedisData".

    ```bash
    cd ~
    dotnet new console --name RedisData
    ```

1. Change into the new directory created for your app.

    ```bash
    cd RedisData
    ```

1. Build and run the application - it should output "Hello World!"

    ```bash
    dotnet run
    ```

## Add the ServiceStack.Redis NuGet package

Now that we have our console application, we need to add the **ServiceStack.Redis** NuGet package. This will enable us to connect to the Azure Cache for Redis, and issue commands in C#.

1. Add the NuGet package **ServiceStack.Redis** using the terminal shell.

    ```bash
    dotnet add package ServiceStack.Redis
    ```

1. Build and run the application again to make sure it all compiles. It should still output "Hello World!"

## Get your Azure Cache for Redis connection string

To connect to your Azure Cache for Redis, you need a connection string that contains your password and URL. **ServiceStack.Redis** has its own connection string format: `[password]@[hostname]:[sslport]?ssl=true`.

You can retrieve your password with the Azure portal, or with the command line. Let's use the latter here because we used the portal approach in the *Optimize your web applications by caching read-only data with Redis* module.

Use the `az redis list-keys` command to get the access keys. Run these commands to get the primary key, store it in a variable called `REDIS_KEY`, and display it:

```azurecli
REDIS_KEY=$(az redis list-keys \
    --name "$REDIS_NAME" \
    --resource-group <rgn>[sandbox resource group name]</rgn> \
    --query primaryKey \
    --output tsv)

echo $REDIS_KEY
```

Next, run this command to put the connection string together, and display it on the command line. Note that the hostname is the name of the cache followed by `.redis.cache.windows.net`, and the port is **6380**, the default Redis SSL port.

```bash
echo "$REDIS_KEY"@"$REDIS_NAME".redis.cache.windows.net:6380?ssl=true
```

Copy the connection string to the clipboard &mdash; you'll be using it in the next step.

## Add the connection string to your app

1. Open Cloud Shell editor from the application folder.

    ```bash
    cd ~/RedisData
    code .
    ```

1. Use the following command to create a console project that has a `Main` method.

    ```bash
    dotnet new console --use-program-main --force
    ```

1. Select the **Program.cs** source file.

1. Create the following field in the `Program` class and paste in your connection string as the value.

    ```csharp
    static string redisConnectionString = "<connection string>";
    ```

    Here's an example:

    ```csharp
    static string redisConnectionString = "ToOosHLZw9Gwyr46ZlxcNeCCIzS35IBkEtwsCt1Xu4c=@myname.redis.cache.windows.net:6380?ssl=true";
    ```

## Insert two data values into your Azure Cache for Redis

Finally, we're going to add data into your Azure Cache for Redis.

1. Add the following `using` statement to the top of the **Program.cs** file.

    ```csharp
    using ServiceStack.Redis;
    ```

1. Replace the contents of the `Main` method with the following code. This will use a transaction to add two values. Make sure to save the file.

    ```csharp
    bool transactionResult = false;

    using (RedisClient redisClient = new RedisClient(redisConnectionString))
    using (var transaction = redisClient.CreateTransaction())
    {
        //Add multiple operations to the transaction
        transaction.QueueCommand(c => c.Set("MyKey1", "MyValue1"));
        transaction.QueueCommand(c => c.Set("MyKey2", "MyValue2"));

        //Commit and get result of transaction
        transactionResult = transaction.Commit();
    }

    if (transactionResult)
    {
        Console.WriteLine("Transaction committed");
    }
    else
    {
        Console.WriteLine("Transaction failed to commit");
    }
    ```

1. Before building and running the application, make sure that the Redis cache has been fully provisioned. It can sometimes take a few minutes after `az redis create` completes. Run the following command to check the status.

    ```azurecli
    az redis show \
        --name "$REDIS_NAME" \
        --resource-group <rgn>[sandbox resource group name]</rgn> \
        --query provisioningState
    ```

    If the status is `Creating`, try checking again in a couple of minutes. It will show `Succeeded` when finished.

1. Run the application, and verify that the console says **Transaction committed**.

    ```bash
    dotnet run
    ```

## Verify your data

To finish off, let's verify that the data we added is in our Azure Cache for Redis.

1. Sign in to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) using the same account you activated the sandbox with.

1. Locate your Azure Cache for Redis:

    1. On the Azure portal menu or from the **Home** page, select **All Resources**.

    1. Using the filter box on the left, search for and select Azure Cache for Redis instances.

        Alternatively, you can use the search box at the top, and enter the name of the cache.

1. Select your Azure Cache for Redis instance.

1. In the **Overview** pane for your Azure Cache for Redis, select **Console**. This will open an Azure Cache for Redis console, which enables you to enter low-level Azure Cache for Redis commands.

1. Run the command `get MyKey1`. Verify that the value returned is **MyValue1**.

1. Run the command `get MyKey2`. Verify that the value returned is **MyValue2**.

    ![Screenshot of the Azure Cache for Redis console showing the values of MyKey1 and MyKey2.](../media/4-redis-console.png)
