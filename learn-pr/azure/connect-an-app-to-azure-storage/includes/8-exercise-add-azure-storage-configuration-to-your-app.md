::: zone pivot="csharp"

Let's add support to our .NET core application to retrieve a connection string from a configuration file. We'll start by adding the necessary plumbing to manage a configuration in a JSON file.

## Create a JSON configuration file

1. Change the directory to the PhotoSharingApp directory, if you aren't already there:

    ```bash
    cd PhotoSharingApp
    ```

1. Enter the following command to use the `touch` tool to create a file named **appsettings.json**:

    ```bash
    touch appsettings.json
    ```

1. Open the project in an editor. If you're working locally, you can use your editor of choice. We recommend Visual Studio Code, which is an extensible cross-platform IDE. If you're working in Azure Cloud Shell (to the right), we recommend the Cloud Shell editor. Use the following command to open the editor in either environment:

    ```bash
    code .
    ```

1. In the editor, select the **appsettings.json** file and add the following text:

    ```json
    {
        "ConnectionStrings": {
            "StorageAccount": "<value>"
        }
    }
    ```

1. Save the file using the keyboard shortcut (<kbd>Ctrl+S</kbd>) or select **Save** from the context menu (select the ellipsis `...` icon in the editor's title bar).

1. Now, we need use an Azure command to obtain the actual storage-account connection string. In Cloud Shell session, paste the following command, replacing `<name>` with the unique storage account name that you created in the previous exercise, and then press <kbd>Enter</kbd> to run the command:

    ```azurecli
    az storage account show-connection-string \
      --resource-group <rgn>[sandbox resource group name]</rgn> \
      --query connectionString \
      --name <name>
    ```

1. The response contains the connection string bounded by quotes, which looks much like the following example:

    ```text
    "DefaultEndpointsProtocol=https;EndpointSuffix=core.windows.net;AccountName=storage1ab;AccountKey=QtSCGB...7AeoW0Hw=="
    ```

1. Copy the connection string, and in the **appsettings.json** file in the editor, replace the `<value>` placeholder with this connection string.

1. Press <kbd>Ctrl+S</kbd> to save the file.

1. In the editor, open the project file **PhotoSharingApp.csproj**.

1. Copy and paste the following configuration block beneath the existing `<ItemGroup>` block.

    ```xml
    <ItemGroup>
        <None Update="appsettings.json">
            <CopyToOutputDirectory>PreserveNewest</CopyToOutputDirectory>
        </None>
    </ItemGroup>
    ```

1. Press <kbd>Ctrl+S</kbd> to save the file. (You must save this file, or you'll lose the change when you add the following package!)

## Add support to read a JSON configuration file

In Cloud Shell console, copy and run the following code to add a reference to the **Microsoft.Extensions.Configuration.Json** NuGet package:

```dotnetcli
dotnet add package Microsoft.Extensions.Configuration.Json
```

## Add code to read the configuration file

Now that we've added the required libraries to enable reading the configuration, we need to enable that functionality in our console application.

1. In the editor, select **Program.cs**.

1. At the top of the file is a commented line of code. Delete that line and add the following lines of code to the top of the file:

    ```csharp
    using System;    
    using Microsoft.Extensions.Configuration;
    using System.IO;
    ```

1. Replace the contents of the **Main** method (the line that contains "Hello World!") with the following code:

    ```csharp
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

    This code initializes the configuration system to read from the **appsettings.json** file.

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

1. Save the file.

::: zone-end

::: zone pivot="javascript"

Let's add support to our Node.js application to retrieve a connection string from a configuration file. We'll start by adding the necessary plumbing to manage a configuration from our JavaScript file.

## Create an .env configuration file

1. In the Azure Cloud Shell session, enter the following command to make sure you're in the correct working directory for your project.

    ```bash
    cd PhotoSharingApp 
    ```

1. Enter the following command to create a file named **.env**:

    ```bash
    touch .env
    ```

1. Open the project in the Cloud Shell editor:

    ```bash
    code .
    ```

1. In the editor, select the **.env** file, and add the following text.

    > [!NOTE]
    > You might need to select the refresh button in code to see the new files.

    ```bash
    AZURE_STORAGE_CONNECTION_STRING=<value>
    ```

    > [!TIP]
    > The **AZURE_STORAGE_CONNECTION_STRING** is a hard-coded environment variable that's used for Storage APIs to look up access keys.

1. Save the file using the keyboard shortcut (<kbd>Ctrl+S</kbd>) or select the ellipsis icon (`...`) in the title bar of the editor, and then select **Save** from the context menu.

1. Now, we need use an Azure command to obtain the actual storage account connection string. In Cloud Shell session, run the following command, replacing `<name>` with the storage account name that you created in the previous exercise.

    ```azurecli
    az storage account show-connection-string \
      --resource-group <rgn>[sandbox resource group name]</rgn> \
      --query connectionString \
      --name <name>
    ```

1. The response is a connection string bounded by quotes, which looks much like the following example:

    ```text
    "DefaultEndpointsProtocol=https;EndpointSuffix=core.windows.net;AccountName=storage1ab;AccountKey=QtSCGB...7AeoW0Hw=="  
    ```

1. Copy the connection string, and replace `<value>` in the **.env** file with this connection string.

1. Press <kbd>Ctrl+S</kbd> to save the file.

## Add support to read an environment configuration file

Node.js apps can include support to read from the **.env** file by adding the **dotenv** package.

1. In Cloud Shell session, run the following command to add a dependency to the  **dotenv** package using `npm`:

    ```bash
    npm install dotenv --save
    ```

## Add code to read the configuration file

Now that we've added the required libraries to enable reading the configuration, we need to enable that functionality in our application.

1. In the editor, open the **index.js** file.

1. At the top of the file is a line of code `#!/usr/bin/env node`. Underneath that line, add following line of code:

    ```javascript
    require('dotenv').config();
    ```

1. Press <kbd>Ctrl+S</kbd> to save the file.

::: zone-end

Now that we have the JSON config all wired up, we can start adding code to use our storage account.
