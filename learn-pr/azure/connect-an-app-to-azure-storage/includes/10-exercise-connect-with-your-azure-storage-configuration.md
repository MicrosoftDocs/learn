::: zone pivot="csharp"
Let's add code to retrieve the connection string from the configuration file and use it to connect to the Azure storage account.

## Retrieve the connection string

1. Open **Program.cs** in the code editor.

1. Add a `using` statement at the top of the file to reference the `Microsoft.WindowsAzure.Storage` namespace:

    ```csharp
    using Microsoft.WindowsAzure.Storage;
    ```
1. At the end of the `Main` method, add the following line to retrieve the Azure storage account connection string from the configuration file. The passed _key_ must match the name used in your **appsettings.json** file.

    ```csharp
    var connectionString = configuration["StorageAccountConnectionString"];
    ```

## Create a blob client

1. Use the static `CloudStorageAccount.TryParse` method to create a `CloudStorageAccount` object - it takes the connection string and an `out` parameter to return the created object. It returns a `bool` value indicating whether it successfully parsed the string.
    - If it fails, output a message to the console and return from the method.

    ```csharp
    if (!CloudStorageAccount.TryParse(connectionString,
            out CloudStorageAccount storageAccount))
    {
        Console.WriteLine("Unable to parse connection string");
        return;
    }
    ```

1. Use the returned `CloudStorageAccount` object to create a blob client.

    ```csharp
    var blobClient = storageAccount.CreateCloudBlobClient();
    ```

1. Next, use the blob client to retrieve a reference to a container named "photoblobs." Much like the account names, the Blob container names must be lowercase and composed of letters and numbers.

    ```csharp
    var blobContainer = blobClient.GetContainerReference("photoblobs");
    ```

1. Use the `CreateIfNotExistsAsync` method to create the container. This returns a `bool` indicating whether the container was created. Store this in a variable named `created`.
    - Notice that this is an **async** method - that means it will perform an actual network call.
    - You will need to use the `await` keywords to get the `bool` result.

    ```csharp
    bool created = await blobContainer.CreateIfNotExistsAsync();
    ```

1. Because we are using the `await` keyword, go ahead and change the signature for the `Main` method to be `async` and return a `Task`.

    ```csharp
    static async Task Main(string[] args)
    {
        ...
    }
    ```

    You'll also need to add a new `using` statement at the top:

    ```csharp
    using System.Threading.Tasks;
    ```

1. Finally, output whether we created the Blob container.

    ```csharp
    Console.WriteLine(created ? "Created the Blob container" : "Blob container already exists.");
    ```

1. Save the file.

The final file should look like this if you'd like to check your work.

```csharp
using System;
using Microsoft.Extensions.Configuration;
using System.IO;
using Microsoft.WindowsAzure.Storage;
using System.Threading.Tasks;

namespace PhotoSharingApp
{
    class Program
    {
        static async Task Main(string[] args)
        {
            var builder = new ConfigurationBuilder()
                .SetBasePath(Directory.GetCurrentDirectory())
                .AddJsonFile("appsettings.json");

            var configuration = builder.Build();
            var connectionString = configuration["StorageAccountConnectionString"];

            if (!CloudStorageAccount.TryParse(connectionString, out CloudStorageAccount storageAccount))
            {
                Console.WriteLine("Unable to parse connection string");
                return;
            }

            var blobClient = storageAccount.CreateCloudBlobClient();
            var blobContainer = blobClient.GetContainerReference("photoblobs");
            bool created = await blobContainer.CreateIfNotExistsAsync();

            Console.WriteLine(created ? "Created the Blob container" : "Blob container already exists.");
        }
    }
}
```

## Use C# 7.1 to build our app

Support for `async` and `await` on `Main` methods was added to C# 7.1. This might not be the default version of the compiler you are using. Let's make sure we use that version of the compiler by setting it in our configuration file.

1. Open the `PhotoSharingApp.csproj` and add `<LangVersion>7.1</LangVersion>` to the `PropertyGroup` that specifies the `TargetFramework`. It should look like this when you're finished:

    ```xml
    <Project Sdk="Microsoft.NET.Sdk">
      <PropertyGroup>
        <OutputType>Exe</OutputType>
        <LangVersion>7.1</LangVersion>
        <TargetFramework>netcoreapp2.0</TargetFramework>
      </PropertyGroup>
      ...
    </Project>
    ```

1. Save the file.

## Run the app

1. Build and run the application. **Note:** make sure you're in the correct working directory.

    ```bash
    dotnet run
    ```

::: zone-end

::: zone pivot="javascript"
Let's add code to connect to the Azure storage account using our stored connection string. The Azure client library will automatically use the **AZURE_STORAGE_CONNECTION_STRING** environment variable to get the connection string.

## Create a blob client

1. Open **index.js** in the code editor.

1. Start by including the **azure-storage** module. Store the module in a variable named **storage**.

    ```javascript
    #!/usr/bin/env node
    require('dotenv').load();

    const storage = require('azure-storage');
    ```

1. Next, right after that, use the **storage** object to create the `BlobService` object and store it in a global named **blobService**. Remember, these are lightweight objects representing access to the storage account.

    ```javascript
    const blobService = storage.createBlobService();
    ```

1. Add a constant to represent the container we want to create. We'll name the container "photoblobs".

    ```javascript
    const containerName = 'photoblobs';
    ```

## Create a container

We can use the `BlobService` object to work with blob APIs in Azure storage. As mentioned before, all the APIs that make network calls are asynchronous to keep the app responsive. The `createContainerIfNotExists` method is one such method. We'll use _promises_ to handle the callback that contains the response.

1. Add a `util` constant at the top of the file (after the initial `require` you added) to load the `util` package.

    ```javascript
    #!/usr/bin/env node
    require('dotenv').load();
    
    const util = require('util');
    const storage = require('azure-storage');
    const blobService = storage.createBlobService();
    const containerName = 'photoblobs';
    ```
    
1. Next, after all the constants, use `util.promisify` to take the callback version of `createContainerIfNotExists` and turn it into a promise-returning method.
    - Since the callback method is on an object, make sure to add a `bind` call at the end to connect it to that context.
    - Assign the return value to a constant at the top of the file named `createContainerAsync`, as shown below.
    - You'll also need a `require` for the `util` module near the top of the file.

    ```javascript
    const util = require('util');
    const storage = require('azure-storage');
    const blobService = storage.createBlobService();
    const containerName = 'photoblobs';

    const createContainerAsync = util.promisify(blobService.createContainerIfNotExists).bind(blobService);
    ```

2. Remove the "Hello, World!" output from `main()`.

3. Call your new `createContainerAsync` promise.
    - Pass it the **containerName** constant.
    - Apply the `await` keyword to the call.
    - Wrap the call in a `try` / `catch` construct and output any error.

    ```javascript
    try {
        await createContainerAsync(containerName);
    }
    catch (err) {
        console.log(err.message);
    }
    ```

1. The `createContainerAsync` promise returns the first value from the underlying `createContainerIfNotExists`, which is the container result. This includes information on whether the container was created or not. Capture the result in a variable, and output whether the container was created based on the `result.created` property.

    ```javascript
    try {
        var result = await createContainerAsync(containerName);
        if (result.created) {
            console.log(`Blob container ${containerName} created`);
        }
        else {
            console.log(`Blob container ${containerName} already exists.`);
        }
    }
    catch (err) {
        console.log(err.message);
    }
    ```

1. Finally, decorate the `main` function with the `async` keyword.

1. Save the file.

The final file should look like this, if you'd like to check your work.

```javascript
#!/usr/bin/env node

require('dotenv').load();

const util = require('util');

const storage = require('azure-storage');
const blobService = storage.createBlobService();
const createContainerAsync = util.promisify(blobService.createContainerIfNotExists).bind(blobService);

const containerName = 'photoblobs';

async function main() {
    try {
        var result = await createContainerAsync(containerName);
        if (result.created) {
            console.log(`Blob container ${containerName} created`);
        }
        else {
            console.log(`Blob container ${containerName} already exists.`);
        }
    }
    catch (err) {
        console.log(err.message);
    }
}

main();
```

## Run the app

1. Build and run the application. **Note:** make sure you're in the PhotoSharingApp directory.

    ```bash
    node index.js
    ```

    > [!TIP]
    > If you get an error about the use of the `await` keyword, make sure you have added the `async` keyword to the `main` function definition per the final step in the instructions above.

::: zone-end

It should report that the blob container was created. If you run it a second time, it should tell you it already exists.

To verify the container:

1. Sign into the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) using the same account you activated the sandbox with.

1. Navigate to your storage account. You can use the **All Resources** section to find the storage account or search by name from the _search box_ at the top of the portal window.

1. Select the **Blobs** entry of the storage account in the **Blob services** section.

1. You should see your **photoblobs** container in the Blobs panel. You can delete the container through the "..." menu on the right-hand side of the entry to try recreating it with your app.

> [!NOTE]
> The container will disappear from the portal very quickly, but it takes a few minutes to delete. If you attempt to recreate it before it's been completely de-provisioned, you will get an error.

## Delete the app
If you decide you don't want to keep the application source code in your Cloud Shell environment, you can use the following command to remove the folder and all the contents.

```bash
rm -r PhotoSharingApp/
```
