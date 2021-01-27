::: zone pivot="csharp"

Let's add support to our .NET core application to retrieve a connection string from a configuration file. We'll start by adding the necessary plumbing to manage configuration in a JSON file.

## Create a JSON configuration file

1. Change the directory (`cd`) to the PhotoSharingApp directory, if you aren't already there.

1. Use the `touch` tool on the command line to create a file named **appsettings.json**.

    ```bash
    touch appsettings.json
    ```

1. Open the project in an editor. If you are working locally, use your editor of choice. We recommend Visual Studio Code, which is an extensible cross-platform IDE. If you are working in the Cloud Shell, we recommend the Cloud Shell editor. The following command works for both.

    ```bash
    code .
    ```

1. Select the **appsettings.json** file in the editor and add the following text. Save the file. In the Cloud Shell editor, there is a menu in the top right corner that has common file operations.

    ```json
    {
    "ConnectionStrings": {
        "StorageAccount": "<value>"
    }
    }
    ```

1. Now we need to get the storage account connection string, and place it into the configuration for our app. In Cloud Shell, run the following command. Replace `<name>` with your unique storage account name.

    ```azurecli
    az storage account show-connection-string \
      --resource-group <rgn>[sandbox resource group name]</rgn> \
      --query connectionString \
      --name <name>
    ```

1. Copy the connection string that is returned from that command, and replace `<value>` in the **appsettings.json** file with this connection string. Save the file.

1. Next, open the project file, **PhotoSharingApp.csproj**, in the editor.

1. Add the following configuration block to the file in the project. Add `<ItemGroup>` from the existing code.

    ```xml
    <ItemGroup>
        <None Update="appsettings.json">
            <CopyToOutputDirectory>PreserveNewest</CopyToOutputDirectory>
        </None>
    </ItemGroup>
    ```

1. Save the file. (Make sure you do this, or you will lose the change when you add the following package!)

## Add support to read a JSON configuration file

In the command prompt section of the window, add a reference to the  **Microsoft.Extensions.Configuration.Json** NuGet package.

```dotnetcli
dotnet add package Microsoft.Extensions.Configuration.Json
```

## Add code to read the configuration file

Now that we have added the required libraries to enable reading configuration, we need to enable that functionality within our console application.

1. Select **Program.cs** in the editor.

1. At the top of the file, a **using System;** line is present. Underneath that line, add the following lines of code:

    ```csharp
    using Microsoft.Extensions.Configuration;
    using System.IO;
    ```

1. Replace the contents of the **Main** method with the following code. This code initializes the configuration system to read from the **appsettings.json** file.

    ```csharp
    var builder = new ConfigurationBuilder()
        .SetBasePath(Directory.GetCurrentDirectory())
        .AddJsonFile("appsettings.json");

    var configuration = builder.Build();
    ```

Your **Program.cs** file should now look like this:

```csharp
using System;
using Microsoft.Extensions.Configuration;
using System.IO;

namespace PhotoSharingApp
{
    class Program
    {
        static void Main(string[] args)
        {
            var builder = new ConfigurationBuilder()
                .SetBasePath(Directory.GetCurrentDirectory())
                .AddJsonFile("appsettings.json");

            var configuration = builder.Build();
        }
    }
}
```

::: zone-end

::: zone pivot="javascript"

Let's add support to our Node.js application to retrieve a connection string from a configuration file. We'll start by adding the necessary plumbing to manage configuration from our JavaScript file.

## Create an .env configuration file

1. Make sure you are in the correct working directory for your project.

1. Use the `touch` tool on the command line to create a file named **.env**.

    ```bash
    touch .env
    ```

1. Open the project in the Cloud Shell editor.

    ```bash
    code .
    ```

1. Select the **.env** file in the editor, and add the following text.

    > [!TIP]
    > You may need to select the refresh button in code to see the new files.

    ```plaintext
    AZURE_STORAGE_CONNECTION_STRING=<value>
    ```

    > [!TIP]
    > The **AZURE_STORAGE_CONNECTION_STRING** value is a hard-coded environment variable used for Storage APIs to look up access keys. You can use your own name if you prefer, but you must supply the name when you create the `BlobServiceClient` object in your Node.js app.

1. Save the file.

1. Now we need to get the storage account connection string and place it into the configuration for our app. In Cloud Shell, run the following command. Replace `<name>` with your unique storage account name.

    ```azurecli
    az storage account show-connection-string \
      --resource-group <rgn>[sandbox resource group name]</rgn> \
      --query connectionString \
      --name <name>
    ```

1. Copy the connection string that is returned from that command (minus the quotes), and replace `<value>` in the **.env** file with this connection string.
1. Save the file.

## Add support to read an environment configuration file

Node.js apps can include support to read from the **.env** file by adding the **dotenv** package.

In the command prompt section of the window, add a dependency to the  **dotenv** package using `npm`.

```bash
npm install dotenv --save
```

## Add code to read the configuration file

Now that we have added the required libraries to enable reading configuration, we need to enable that functionality within our application.

1. Select **index.js** in the editor.

1. At the top of the file, a `#!/usr/bin/env node` line is present. Underneath that line, add a `require` statement to load the **dotenv** package. This code will make environment variables defined in our **.env** file available to the program.

    ```javascript
    #!/usr/bin/env node
    require('dotenv').config();
    // ... more code follows
    ```

::: zone-end

Now that we have that all wired up, we can start adding code to use our storage account.
