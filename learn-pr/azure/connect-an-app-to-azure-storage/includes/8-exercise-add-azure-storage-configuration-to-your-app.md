::: zone pivot="csharp"

Let's add support to our .NET core application to retrieve a connection string from a configuration file. We'll start by adding the necessary plumbing to manage a configuration in a JSON file.

## Create a JSON configuration file

1. Change the directory to the PhotoSharingApp directory, if you aren't already there.

    ```bash
    cd PhotoSharingApp
    ```

1. Use the `touch` tool on the command line to create a file named **appsettings.json**.

    ```bash
    touch appsettings.json
    ```

1. Open the project in an editor. If you are working locally, you can use your editor of choice. We recommend Visual Studio Code, which is an extensible cross-platform IDE. If you are working in the active sandbox Cloud Shell (to the right), we recommend Cloud Shell editor. The following command works to open either one.

    ```bash
    code .
    ```

1. In the editor, select the **appsettings.json** file and add the following text. 

    ```json
    {
        "ConnectionStrings": {
            "StorageAccount": "<value>"
        }
    }
    ```

1. Save the file using either keyboard shortcut (<kbd>Ctrl+S</kbd>) or context menu of Cloud Shell editor (select the ellipsis `...` in the top right corner).

1. Now we need use an Azure command to get the actual storage account connection string and replace the placeholder <value>. In Cloud Shell, run the following command, replacing `<name>` with the  unique storage account name that you created in the previous exercise.

    ```azurecli
    az storage account show-connection-string \
      --resource-group <rgn>[sandbox resource group name]</rgn> \
      --query connectionString \
      --name <name>
    ```

1. The response is a very long connection string bounded by quotes, which looks much like the following example:

    ```text
    "DefaultEndpointsProtocol=https;EndpointSuffix=core.windows.net;AccountName=storage1ab;AccountKey=QtSCGB...7AeoW0Hw=="
    ```

1. Copy the connection string, and in the **appsettings.json** file in the editor, replace the <value> placeholder with this connection string. 

1. Press <kbd>Ctrl+S</kbd> to save the file.

1. In the editor, open the project file **PhotoSharingApp.csproj**.

1. Add the following configuration block to the file in the project. Add `<ItemGroup>` from the existing code.

    ```xml
    <ItemGroup>
        <None Update="appsettings.json">
            <CopyToOutputDirectory>PreserveNewest</CopyToOutputDirectory>
        </None>
    </ItemGroup>
    ```

1. Press <kbd>Ctrl+S</kbd> to save the file. (Make sure you save this file, or you will lose the change when you add the following package!)

## Add support to read a JSON configuration file

In Cloud Shell command prompt section of the window, add a reference to the **Microsoft.Extensions.Configuration.Json** NuGet package.

```dotnetcli
dotnet add package Microsoft.Extensions.Configuration.Json
```

## Add code to read the configuration file

Now that we have added the required libraries to enable reading the configuration, we need to enable that functionality within our console application.

1. In the editor, select **Program.cs**.

1. At the top of the file, a **using System;** line is present. Underneath that line, add the following lines of code:

    ```csharp
    using Microsoft.Extensions.Configuration;
    using System.IO;
    ```

1. Replace the contents of the **Main** method (the line that contains "hello world!") with the following code. This code initializes the configuration system to read from the **appsettings.json** file.

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

Let's add support to our Node.js application to retrieve a connection string from a configuration file. We'll start by adding the necessary plumbing to manage a configuration from our JavaScript file.

## Create an .env configuration file

1. Make sure you are in the correct working directory (PhotoSharingApp) for your project.

    ```bash
    cd PhotoSharingApp 
    ```

1. Use the `touch` tool on the command line to create a file named **.env**.

    ```bash
    touch .env
    ```

1. Open the project in Cloud Shell editor.

    ```bash
    code .
    ```

1. In the editor, select the **.env** file, and add the following text.

    > [!TIP]
    > You may need to select the refresh button in code to see the new files.

    ```bash
    AZURE_STORAGE_CONNECTION_STRING=<value>
    ```

    > [!TIP]
    > The **AZURE_STORAGE_CONNECTION_STRING** is a hard-coded environment variable that is used for Storage APIs to look up access keys.

1. Save the file using either keyboard shortcut (<kbd>Ctrl+S</kbd>) or context menu of Cloud Shell editor (select the ellipsis `...` in the top right corner).

1. Now, we need use an Azure command to get the actual storage account connection string and replace the placeholder `<value>`. In Cloud Shell, run the following command, replacing `<name>` with the unique storage account name you created in the previous exercise.

    ```azurecli
    az storage account show-connection-string \
      --resource-group <rgn>[sandbox resource group name]</rgn> \
      --query connectionString \
      --name <name>
    ```

1. The response is a very long connection string bounded by quotes, which looks much like the following example:

    ```text
    "DefaultEndpointsProtocol=https;EndpointSuffix=core.windows.net;AccountName=storage1ab;AccountKey=QtSCGB...7AeoW0Hw=="  
    ```

1. Copy the connection string, and in the **.env** file, replace `<value>` with this connection string.

1. Press <kbd>Ctrl+S</kbd> to save the file.

## Add support to read an environment configuration file

Node.js apps can include support to read from the **.env** file by adding the **dotenv** package.

1. In the command prompt section of Cloud Shell, add a dependency to the  **dotenv** package using `npm`.

    ```bash
    npm install dotenv --save
    ```

## Add code to read the configuration file

Now that we have added the required libraries to enable reading configuration, we need to enable that functionality in our application.

1. In the editor, open **index.js** file.

1. At the top of the file, a `#!/usr/bin/env node` line is present. Underneath that line, add  following line of code:

    ```javascript
    require('dotenv').config();
    ```

1. Press <kbd>Ctrl+S</kbd> to save the file.

::: zone-end

Now that we have that all wired up, we can start adding code to use our storage account.
