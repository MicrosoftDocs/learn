As the first step to creating your project's application, you need to create a .NET project. Recall that the .NET project should use the **Microsoft.Azure.Cosmos** SDK to connect to the account you have already created. There are three key requirements at this time:

- Create a .NET project
- Add a package reference to the SDK
- Connect using the client classes

:::image type="content" source="../media/project-visual-app.svg" alt-text="Illustration of icons of an Azure Cosmos DB account and .NET application." border="false":::

After you complete this exercise, you'll have a simple .NET application that successfully connects to your API for NoSQL account, but doesn't perform any operations yet.

## Persist connection string

Here, you get the connection string again and store it in an *environment variable* that is accessible from your .NET application.

01. Create a `resourceGroup` shell variable with the value prescribed here.

    ```azurecli
    resourceGroup="<rgn>[sandbox resource group name]</rgn>"
    ```

01. Query your resource group for the single Azure Cosmos DB account you created earlier in this project.

    ```azurecli
    az cosmosdb list \
        --resource-group $resourceGroup \
        --query [0].name \
        --output tsv
    ```

01. Use the same query again to save the name of the account in the `accountName` shell variable.

    ```azurecli
    accountName=$(az cosmosdb list \
        --resource-group $resourceGroup \
        --query [0].name \
        --output tsv)
    ```

01. Get the `Primary SQL Connection String` credential from the account and save it in a shell variable named `connectionString`.

    ```azurecli
    connectionString=$(az cosmosdb keys list \
        --name $accountName \
        --resource-group $resourceGroup \
        --type connection-strings \
        --query "connectionStrings[?description=='Primary SQL Connection String'].connectionString" \
        --output tsv)
    ```

01. To validate, output the connection string to the terminal.

    ```azurecli
    echo $connectionString
    ```

01. Save the `connectionString` shell variable as a new environment variable named `COSMOS_CONNECTION_STRING`.

    ```azurecli
    export COSMOS_CONNECTION_STRING=$connectionString
    ```

## Build and persist the project directory

Azure Cloud Shell persists files across sessions using Azure Files. A file share is mounted to the shell's running instance in the *clouddrive* directory. Here, you create your project folder in that directory.

01. Change to the already mounted *clouddrive* directory.

    ```bash
    cd ~/clouddrive
    ```

01. Create a new directory named *inventory* to be persisted across sessions.

    ```bash
    mkdir inventory
    ```

01. Change to the newly created *clouddrive/inventory* directory.

    ```bash
    cd ~/clouddrive/inventory
    ```

## Create a .NET console project

The .NET CLI creates and manages .NET projects within a specified directory. Here, you use the CLI to create a new console application and add a package reference to the SDK.

01. Create a new console application in the current directory.

    ```dotnetcli
    dotnet new console
    ```

    > [!TIP]
    > Since you did not specify a project name or a directory, the command will create the new project in the current directory and name the project to match the directory's name (inventory).

01. Add a package reference to the [Microsoft.Azure.Cosmos](https://www.nuget.org/packages/Microsoft.Azure.Cosmos) SDK from NuGet.

    ```dotnetcli
    dotnet add package Microsoft.Azure.Cosmos
    ```

01. Build the .NET project to ensure you've correctly configured your project.

    ```dotnetcli
    dotnet build
    ```

    The output of the command should be similar to this example.

    ```output
    Microsoft (R) Build Engine version 17.2.0+41abc5629 for .NET
    Copyright (C) Microsoft Corporation. All rights reserved.
    
      Determining projects to restore...
      All projects are up-to-date for restore.
      inventory -> /usr/csuser/clouddrive/inventory/bin/Debug/net6.0/inventory.dll
    
    Build succeeded.
        0 Warning(s)
        0 Error(s)
    
    Time Elapsed 00:00:11.00
    ```

01. Open the code editor using the `code` command in the current directory.

    ```bash
    code .
    ```

## Connect to the account

Now, the .NET project should be built and ready for you to add your own custom code. You have access to the <xref:Microsoft.Azure.Cosmos> namespace and all of the classes necessary to connect to the API for NoSQL. Here, you open the *Program.cs* file and implement code to connect to the account using the client classes of the SDK.

01. Open the *Program.cs* file within the code editor for the Azure Cloud Shell.

    > [!TIP]
    > If you are not familiar with the Azure Cloud Shell's integrated editor, use the file explorer to select and open the *Program.cs* option.
    >
    > :::image type="content" source="../media/cloud-shell-code-editor.png" alt-text="Screenshot of the Azure Cloud Shell integrated editor with the Program.cs file highlighted." lightbox="../media/cloud-shell-code-editor.png":::
    >

01. Delete all existing code from the file.

01. Add a using directive for the <xref:Microsoft.Azure.Cosmos> and <xref:Microsoft.Azure.Cosmos.Fluent> namespaces.

    ```csharp
    using Microsoft.Azure.Cosmos;
    using Microsoft.Azure.Cosmos.Fluent;
    ```

01. Create a new local function named **GetClient** that returns an item of type <xref:Microsoft.Azure.Cosmos.CosmosClient>.

    ```csharp
    static CosmosClient GetClient()
    {
    }
    ```

01. Add the following lines of code within the `GetClient` local function.

    01. Create a string variable named `connectionString`. Set the initial value of the variable to the result of calling <xref:System.Environment.GetEnvironmentVariable(System.String)> passing in the name of the `COSMOS_CONNECTION_STRING` environment variable.

        ```csharp
        string connectionString = Environment.GetEnvironmentVariable("COSMOS_CONNECTION_STRING")!;
        ```

    01. Print the connection string to the console.

        ```csharp
        Console.WriteLine($"[Connection string]:\t{connectionString}");
        ```

    01. Create a new instance of the <xref:Microsoft.Azure.Cosmos.CosmosSerializationOptions> class named **serializerOptions**. Set the <xref:Microsoft.Azure.Cosmos.CosmosSerializationOptions.PropertyNamingPolicy> property to the value ``CamelCase`` from the <xref:Microsoft.Azure.Cosmos.CosmosPropertyNamingPolicy.CamelCase> enumeration.

        ```csharp
        CosmosSerializationOptions serializerOptions = new()
        {
            PropertyNamingPolicy = CosmosPropertyNamingPolicy.CamelCase
        };
        ```

    01. Create a new instance of the <xref:Microsoft.Azure.Cosmos.Fluent.CosmosClientBuilder> class by passing in the connection string to the constructor. Next, chain the <xref:Microsoft.Azure.Cosmos.Fluent.CosmosClientBuilder.WithSerializerOptions(Microsoft.Azure.Cosmos.CosmosSerializationOptions)> fluent method and set this method's parameter to `serializerOptions`. Finally, chain the <xref:Microsoft.Azure.Cosmos.Fluent.CosmosClientBuilder.Build> method to create an instance of type <xref:Microsoft.Azure.Cosmos.CosmosClient> named `output`.

        ```csharp
        CosmosClient output = new CosmosClientBuilder(connectionString)
            .WithSerializerOptions(serializerOptions)
            .Build();
        ```

    01. Print a message indicating that your client is ready.

        ```csharp
        Console.WriteLine("[Client ready]");    
        ```

    01. Return the `output` variable.

        ```csharp
        return output;
        ```

01. Back within the main program flow, call the `GetClient` method, store the result in a variable named `client`, and wrap this call with a using statement.

    ```csharp
    using CosmosClient client = GetClient();
    ```

01. **Save** the *Program.cs* file.

## Check your work

The application is now ready to run and connect to Azure Cosmos DB for NoSQL. Here, you compare your application code to our sample. Then, you check that your application works as expected by running the code.

### [Run application](#tab/run-app)

01. Run the .NET application in the terminal

    ```bash
    dotnet run
    ```

01. Observe the output of running the application. The output should match the example here.

    ```output
    [Connection string]:    AccountEndpoint=https://<account-name>.documents.azure.com:443/;AccountKey=<account-key>;
    [Client connected]
    ```

> [!NOTE]
> If building or running the .NET application results in an error, go to the **review code** section to validate that your code matches the example.

### [Review code](#tab/review-code)

01. Review the *inventory.csproj* project file to ensure that the project configuration matches this sample.

    ```xml
    <Project Sdk="Microsoft.NET.Sdk">    
      <PropertyGroup>
        <OutputType>Exe</OutputType>
        <TargetFramework>net6.0</TargetFramework>
        <ImplicitUsings>enable</ImplicitUsings>
        <Nullable>enable</Nullable>
      </PropertyGroup>    
      <ItemGroup>
        <PackageReference Include="Microsoft.Azure.Cosmos" Version="3.29.0" />
      </ItemGroup>    
    </Project>
    ```

01. Review the *Program.cs* code file to make sure that your code matches this sample.

    ```csharp
    using Microsoft.Azure.Cosmos;
    using Microsoft.Azure.Cosmos.Fluent;
    
    using CosmosClient client = GetClient();
    
    static CosmosClient GetClient()
    { 
        // Implementation removed for brevity
    }
    ```

01. Within the *Program.cs* code file, review the `GetClient` local function to make sure that your code matches this sample.

    ```csharp
    string connectionString = Environment.GetEnvironmentVariable("COSMOS_CONNECTION_STRING")!;

    Console.WriteLine($"[Connection string]:\t{connectionString}");

    CosmosSerializationOptions serializerOptions = new()
    {
        PropertyNamingPolicy = CosmosPropertyNamingPolicy.CamelCase
    };

    CosmosClient output = new CosmosClientBuilder(connectionString)
        .WithSerializerOptions(serializerOptions)
        .Build();

    Console.WriteLine("[Client ready]");

    return output;
    ```

---
