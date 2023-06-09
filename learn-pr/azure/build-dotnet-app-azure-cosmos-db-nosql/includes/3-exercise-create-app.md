As the first step to creating your project's application, you need to create a .NET project. Recall that the .NET project should use the **Microsoft.Azure.Cosmos** SDK to connect to the account you have already created. There are three key requirements at this time:

- Create a .NET project
- Add a package reference to the SDK
- Connect using the client classes

:::image type="content" source="../media/project-visual-app.svg" alt-text="Illustration of icons of an Azure Cosmos DB account and .NET application." border="false":::

After you complete this exercise, you'll have a simple .NET application that successfully connects to your API for NoSQL account, but doesn't perform any operations yet.

## Create a .NET console project

The .NET CLI creates and manages .NET projects within a specified directory. Here, you use the CLI to create a new console application and add a package reference to the SDK.

1. Create a new console application in the current directory.

    ```dotnetcli
    dotnet new console
    ```

    > [!TIP]
    > Since you did not specify a project name or a directory, the command will create the new project in the current directory and name the project to match the directory's name (inventory).

1. Add a package reference to version **3** of the [Microsoft.Azure.Cosmos](https://www.nuget.org/packages/Microsoft.Azure.Cosmos) SDK from NuGet.

    ```dotnetcli
    dotnet add package Microsoft.Azure.Cosmos --version 3.*
    ```

1. Build the .NET project to ensure you've correctly configured your project.

    ```dotnetcli
    dotnet build
    ```

    The output of the command should be similar to this example:

    ```output
    MSBuild version 17.5.0+6f08c67f3 for .NET
      Determining projects to restore...
      All projects are up-to-date for restore.
      dotnet-env-azure-cosmos-db -> /workspaces/dotnet-env-azure-cosmos-db/bin/Debug/net7.0/dotnet-env-azure-cosmos-db.dll
    
    Build succeeded.
        0 Warning(s)
        0 Error(s)
    
    Time Elapsed 00:00:05.96
    ```

## Connect to the account

Now, the .NET project should be built and ready for you to add your own custom code. You have access to the <xref:Microsoft.Azure.Cosmos> namespace and all of the classes necessary to connect to the API for NoSQL. Here, you open the *Program.cs* file and implement code to connect to the account using the client classes of the SDK.

1. Open the *Program.cs* file within the code editor.

1. Delete all existing code from the file.

1. Add using directives for the following namespaces:

    - <xref:Microsoft.Azure.Cosmos>
    - <xref:Microsoft.Azure.Cosmos.Fluent>
    - <xref:Microsoft.Azure.Cosmos.Linq>

    ```csharp
    using Microsoft.Azure.Cosmos;
    using Microsoft.Azure.Cosmos.Fluent;
    using Microsoft.Azure.Cosmos.Linq;
    ```

1. Create a constant string variable named `connectionString`. Set the value of the variable to the connection string you recorded earlier in this module.

    ```csharp
    const string connectionString = "<your-azure-cosmos-db-connection-string>";
    ```

    Assuming the name of the Azure Cosmos DB account is `nybncrsna76fo-cosmos-nosql` and the key is `Aj2OSQqWhXfFzkITIi4MIbocWAAoBCUWnSPzHlQbDYA3TiyZCJlk8A6R1l6WqD45BxAG5vrsyQ4SCXEkPS1pLh==`, you would configure the JSON object like this example:

    ```csharp
    const string connectionString = "AccountEndpoint=https://nybncrsna76fo-cosmos-nosql.documents.azure.com:443/;AccountKey=Aj2OSQqWhXfFzkITIi4MIbocWAAoBCUWnSPzHlQbDYA3TiyZCJlk8A6R1l6WqD45BxAG5vrsyQ4SCXEkPS1pLh==;";
    ```

1. Print the connection string to the console.

    ```csharp
    Console.WriteLine($"[Connection string]:\t{connectionString}");
    ```

1. Create a new instance of the <xref:Microsoft.Azure.Cosmos.CosmosSerializationOptions> class named **serializerOptions**. Set the <xref:Microsoft.Azure.Cosmos.CosmosSerializationOptions.PropertyNamingPolicy> property to the value ``CamelCase`` from the <xref:Microsoft.Azure.Cosmos.CosmosPropertyNamingPolicy.CamelCase> enumeration.

    ```csharp
    CosmosSerializationOptions serializerOptions = new()
    {
        PropertyNamingPolicy = CosmosPropertyNamingPolicy.CamelCase
    };
    ```

1. Create a new instance of the <xref:Microsoft.Azure.Cosmos.Fluent.CosmosClientBuilder> class by passing in the connection string to the constructor. Next, chain the <xref:Microsoft.Azure.Cosmos.Fluent.CosmosClientBuilder.WithSerializerOptions(Microsoft.Azure.Cosmos.CosmosSerializationOptions)> fluent method and set this method's parameter to `serializerOptions`. Chain the <xref:Microsoft.Azure.Cosmos.Fluent.CosmosClientBuilder.Build> method to create an instance of type <xref:Microsoft.Azure.Cosmos.CosmosClient> named `client`. Finally, wrap the creation of the client variable with a using statement.

    ```csharp
    using CosmosClient client = new CosmosClientBuilder(connectionString)
        .WithSerializerOptions(serializerOptions)
        .Build();
    ```

1. Print a message indicating that your client is ready.

    ```csharp
    Console.WriteLine("[Client ready]");    
    ```

1. **Save** the *Program.cs* file.

## Check your work

The application is now ready to run and connect to Azure Cosmos DB for NoSQL. Here, you compare your application code to our sample. Then, you check that your application works as expected by running the code.

### [Run application](#tab/run-app)

1. Run the .NET application in the terminal

    ```bash
    dotnet run
    ```

1. Observe the output of running the application. The output should match the example here.

    ```output
    [Connection string]:    <your-azure-cosmos-db-connection-string>
    [Client ready]
    ```

> [!NOTE]
> If building or running the .NET application results in an error, go to the **Review code** tab to validate that your code matches the example.

### [Review code](#tab/review-code)

1. Review the *\*.csproj* project file to ensure that the project configuration matches this sample.

    ```xml
    <Project Sdk="Microsoft.NET.Sdk">    
      <PropertyGroup>
        <OutputType>Exe</OutputType>
        <TargetFramework>net7.0</TargetFramework>
        <ImplicitUsings>enable</ImplicitUsings>
        <Nullable>enable</Nullable>
      </PropertyGroup>    
      <ItemGroup>
        <PackageReference Include="Microsoft.Azure.Cosmos" Version="3.*" />
      </ItemGroup>    
    </Project>
    ```

1. Review the *Program.cs* code file to make sure that your code matches this sample.

    ```csharp
    using Microsoft.Azure.Cosmos;
    using Microsoft.Azure.Cosmos.Fluent;
    using Microsoft.Azure.Cosmos.Linq;
    
    const string connectionString = "<your-azure-cosmos-db-connection-string>";

    Console.WriteLine($"[Connection string]:\t{connectionString}");
    
    CosmosSerializationOptions serializerOptions = new()
    {
        PropertyNamingPolicy = CosmosPropertyNamingPolicy.CamelCase
    };
    
    using CosmosClient client = new CosmosClientBuilder(connectionString)
        .WithSerializerOptions(serializerOptions)
        .Build();
    
    Console.WriteLine("[Client ready]");
    ```

---
