In this exercise, you'll learn how to create an Azure Cosmos DB database and container programmatically. Following the example from the previous exercise, you'll create a database named **"Products"** and a container named **"Clothing"**, and specify your partition key and throughput values.

::: zone pivot="csharp"

## Creating a database and container using C# and the .NET SDK

In this exercise, you'll create an Azure Cosmos DB  database, and container using the C# and the .NET SDK for Azure Cosmos DB.

### Create a new .NET app and database using C#

1. Sign into the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) using the account you activated the sandbox with.

    1. Locate your Cosmos DB resource, and select **Keys**.
    
    1. Copy the **URI** and **PRIMARY KEY** values, which you'll need later.

1. In the Cloud Shell, use the following command to create a new .NET Console application:

    ```bash
    dotnet new console --output myApp
    ```

    ASP.NET Core creates a new directory called *myApp*, which contains your new console C# app.

1. Change to your new app's directory:

    ```bash
    cd myApp
    ``` 

1. Add the `Microsoft.Azure.Cosmos` NuGet package as a project dependency:

    ```bash
    dotnet add package Microsoft.Azure.Cosmos --version 3.0.0
    ``` 

1. Restore all packages specified as dependencies in the project and compile the project:

    ```bash
    dotnet restore
    dotnet build
    ```

1. Open the Cloud Shell Code Editor to make changes to your project:

    ```bash
    code .
    ```

    The Bash shell screen splits into two sections, showing you the coding interface at the top. You can maximize the screen to have more space to edit your files.

    ![Bash Shell and Code Editor](../media/5-azure-cosmos-db-new-shell-editor-csharp.png)

1. Click *myApp.csproj* in the Explorer pane to open the file in the code editor.

    1. Add a new `<PropertyGroup>` XML element to the project configuration within the Project element. To do so, locate the existing `<PropertyGroup>` element, and add the following lines beneath it:

        ```xml
        <PropertyGroup>
            <LangVersion>latest</LangVersion>
        </PropertyGroup>
        ```

        Your XML file should resemble the following example:

        ```xml
        <Project Sdk="Microsoft.NET.Sdk">
            <PropertyGroup>
                <OutputType>Exe</OutputType>
                <TargetFramework>netcoreapp2.2</TargetFramework>
            </PropertyGroup>
            <PropertyGroup>
                <LangVersion>latest</LangVersion>
            </PropertyGroup>
            <ItemGroup>
                <PackageReference Include="Microsoft.Azure.Cosmos" Version="3.0.0" />
            </ItemGroup>
        </Project>
        ```

    1. Save your changes by typing <kbd>Ctrl+S</kbd>, or by selecting the **Save** option from the Editor menu on the upper right corner.

1. Click *Program.cs* in the Explorer pane to open the file in the editor.

    1. Add the following `using` statements to the top of the editor:

        ```csharp
        using System.Collections.Generic;
        using System.Collections.ObjectModel;
        using System.Linq;
        using System.Threading.Tasks;
        using Microsoft.Azure.Cosmos;
        ```

    1. Create a `CosmosClient` instance, which is the main "entry point" to using the SQL API in Azure Cosmos DB. To do so, locate the `Program` class and replace it with the following class:

        ```csharp
        public class Program
        {
            public static async Task Main(string[] args)
            {         
            }
        }
        ```

    1. Within the `Program` class, add the following lines of code to create variables for your connection information:

        ```csharp
        private static readonly string _endpointUri = "YOUR_URI";
        private static readonly string _primaryKey = "YOUR_KEY";
        ```

        Replace the values `YOUR_URI` and `YOUR_KEY` with the values that you obtained from your Cosmos DB resource in the Azure portal earlier.

    1. Locate the `Main` method, and add the following lines of code to create a `CosmosClient` instance:

        ```csharp
        using (CosmosClient client = new CosmosClient(_endpointUri, _primaryKey))
        {        
        }
        ```

    1. Add the following code within the `CosmosClient` creation block to create a new `Database` instance name **Products**:

        ```csharp
        DatabaseResponse databaseResponse = await client.CreateDatabaseIfNotExistsAsync("Products");
        Database targetDatabase = databaseResponse.Database;
        ```

        This code checks if a database with the specified parameters exists in your Azure Cosmos DB account. If a database that matches doesn't exist, it will create a new database.

    1. As a final step, add the following code below the `Database` instance to print out the ID of the database that you  created:

        ```csharp
        await Console.Out.WriteLineAsync($"Database Id:\t{targetDatabase.Id}");
        ```

        The `targetDatabase` variable contains metadata about the database, whether a new database is created or an existing one is read.

        Your final Program.cs code should resemble the following example:

        ```csharp
        using System;
        using System.Collections.Generic;
        using System.Collections.ObjectModel;
        using System.Linq;
        using System.Threading.Tasks;
        using Microsoft.Azure.Cosmos;
    
        namespace myApp
        {
            public class Program
            {
                private static readonly string _endpointUri = "YOUR_URI";
                private static readonly string _primaryKey = "YOUR_KEY";
                public static async Task Main(string[] args)
                {         
                    using (CosmosClient client = new CosmosClient(_endpointUri, _primaryKey))
                    {        
                        DatabaseResponse databaseResponse = await client.CreateDatabaseIfNotExistsAsync("Products");
                        Database targetDatabase = databaseResponse.Database;
                        await Console.Out.WriteLineAsync($"Database Id:\t{targetDatabase.Id}");
                    }
                }
            }
        }
        ```

        Notice you'll have different values for `YOUR_URI` and `YOUR_KEY`.

    1. Save your changes by typing <kbd>Ctrl+S</kbd>, or by selecting the **Save** option from the Editor menu on the upper right corner.
    
    1. Close the Code Editor by typing <kbd>Ctrl+Q</kbd>, or selecting **Close** from the Editor menu in the upper right.

1. On the Bash Shell terminal, compile and run your .NET Core app:

    ```bash
    dotnet build
    dotnet run
    ```

    After running your application, you should see the following output in your console:

    ```bash
    Database Id:    Products
    ```

### Add a new container to your database using C#

Now that you have created your database, you're ready to create a container to store your documents.

1. Open the *Program.cs* file in the Code Editor to make changes to your app:

    ```bash
    code Program.cs
    ```

    1. Locate the `await Console.Out.WriteLineAsync(...)` method within the `Main` method.
    
    1. Add the following code below the `WriteLineAsync()` method to create a new `IndexingPolicy` instance with a custom indexing policy:

        ```csharp
        IndexingPolicy indexingPolicy = new IndexingPolicy
        {
            IndexingMode = IndexingMode.Consistent,
            Automatic = true,
            IncludedPaths =
            {
                new IncludedPath
                {
                    Path = "/*"
                }
            }
        };
        var containerProperties = new ContainerProperties("Clothing", "/type")
        {
            IndexingPolicy = indexingPolicy
        };
        ```

    1. Add the following lines of code after your previous additions to create a new `Container` instance:

        ```csharp
        var containerResponse = await targetDatabase.CreateContainerIfNotExistsAsync(containerProperties, 10000);
        var customContainer = containerResponse.Container;
        ```
    
        This code checks to see if a container with the specified parameters exists in your database, and it creates a new container if there is no match. You can also specify the RU/s allocated for the container that you create. When you do not specify the RU/s, the SDK has a default value for RU/s assigned to a container.

    1. Add the following code to print out the ID of the container:

        ```csharp
        await Console.Out.WriteLineAsync($"Custom Container Id:\t{customContainer.Id}");
        ```

        Your final Program.cs file should look like this:

        ```csharp
        using System;
        using System.Collections.Generic;
        using System.Collections.ObjectModel;
        using System.Linq;
        using System.Threading.Tasks;
        using Microsoft.Azure.Cosmos;
    
        namespace myApp
        {
            public class Program
            {
                private static readonly string _endpointUri = "YOUR_URI";
                private static readonly string _primaryKey = "YOUR_KEY";
                public static async Task Main(string[] args)
                {         
                    using (CosmosClient client = new CosmosClient(_endpointUri, _primaryKey))
                    {        
                        DatabaseResponse databaseResponse = await client.CreateDatabaseIfNotExistsAsync("Products");
                        Database targetDatabase = databaseResponse.Database;
                        await Console.Out.WriteLineAsync($"Database Id:\t{targetDatabase.Id}");
                        IndexingPolicy indexingPolicy = new IndexingPolicy
                        {
                            IndexingMode = IndexingMode.Consistent,
                            Automatic = true,
                            IncludedPaths =
                            {
                                new IncludedPath
                                {
                                    Path = "/*"
                                }
                            }
                        };
                        var containerProperties = new ContainerProperties("Clothing", "/type")
                        {
                            IndexingPolicy = indexingPolicy
                        };
                        var containerResponse = await targetDatabase.CreateContainerIfNotExistsAsync(containerProperties, 10000);
                        var customContainer = containerResponse.Container;
                        await Console.Out.WriteLineAsync($"Custom Container Id:\t{customContainer.Id}");
                    }
                }
            }
        }
        ```

        Remember that you'll have different values for `YOUR_URI` and `YOUR_KEY`.

    1. Save your changes by typing <kbd>Ctrl+S</kbd>, or by selecting the **Save** option from the Editor menu on the upper right corner.

    1. Close the Code Editor by typing <kbd>Ctrl+Q</kbd>, or by selecting **Close** from the Editor menu in the upper right.

1. On the Bash Shell terminal, compile and run the .NET Core app:

    ```bash
    dotnet build
    dotnet run
    ```
1. After running your application, you should see this output in your console:

    ```bash
    Database Id:    Products
    Custom Container Id:    Clothing
    ```

::: zone-end

::: zone pivot="java"

## Creating your database and container using the Java SDK

In this exercise, you'll create an Azure Cosmos DB  database, and container using the Java SDK for Azure Cosmos DB. 

### Create a new app using Maven and database using Java

1. Sign into the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) using the account you activated the sandbox with.

    1. Locate your Cosmos DB resource, and select **Keys**.
    
    1. Copy the **URI** and **PRIMARY KEY** values, which you'll need later.

1. Open the Azure Cloud Shell Bash shell and create a new Java application using **Maven** and the *maven-archetype-quickstart*:

    ```bash
    mvn archetype:generate -DgroupId=com.mslearn -DartifactId=cosmosjavaprj -DarchetypeArtifactId=maven-archetype-quickstart -DinteractiveMode=false
    ```

    Maven creates a project called *cosmosjavaprj*, and provides a sample App to get you started.

1. Change to your new app's directory:

    ```bash
    cd cosmosjavaprj
    ```

1. Open the Cloud Shell Code Editor to make changes to your project:

    ```bash
    code .
    ```

    The Bash shell screen splits into two sections, showing you the coding interface at the top. You can maximize the screen to have more space to edit your files.

    ![Bash Shell and Code Editor](../media/5-azure-cosmos-db-new-shell-editor-java.png)

1. Click *pom.xml* in the Explorer pane to open the file in the code editor.

    1. To add the Maven project dependencies required to work with Cosmos DB, add the following entry within the dependencies section:

        ```xml
        <dependency>
            <groupId>com.azure</groupId>
            <artifactId>azure-cosmos</artifactId>
            <version>4.0.1-beta.1</version>
        </dependency>
        <dependency>
            <groupId>org.apache.logging.log4j</groupId>
            <artifactId>log4j-slf4j-impl</artifactId>
            <version>2.13.0</version>
            <scope>test</scope>
        </dependency>

        <dependency>
            <groupId>org.apache.logging.log4j</groupId>
            <artifactId>log4j-api</artifactId>
            <version>2.11.1</version>
            <scope>test</scope>
        </dependency>
        <dependency>
            <groupId>org.slf4j</groupId>
            <artifactId>slf4j-jdk14</artifactId>
            <version>1.7.28</version>
        </dependency>
        ```
    
    1. You'll also need to change the source and target compiler versions to Java 1.8. The code uses lambda syntax supported only on Java 8 onwards. Add the following code to below the `<dependencies>` section:

        ```xml
        <properties>
            <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
            <maven.compiler.source>1.8</maven.compiler.source>
            <maven.compiler.target>1.8</maven.compiler.target>
        </properties>
        ```

    1. Save your changes by typing <kbd>Ctrl+S</kbd>, or by selecting the **Save** option from the Editor menu on the upper right corner.

### Create CosmosAsyncClient Instance

The CosmosAsyncClient class is the main "entry point" to using the SQL API in Azure Cosmos DB. You'll create an instance of the CosmosAsyncClient class by passing in connection metadata as parameters of the class' constructor. You'll then use this class instance throughout the lab.

1. In the Explorer pane of the Code Editor, expand the nodes in the tree to *src\main\java\com\mslearn*, then click *App.java* to open the file in the editor.

![Bash Shell and Code Editor](../media/5-azure-cosmos-db-new-shell-editor-java-app.png)

1.  Below the **package com.mslearn** line, add the following imports:

    ```java
    import org.slf4j.Logger;
    import org.slf4j.LoggerFactory;
    import java.math.BigDecimal;
    import java.text.DecimalFormat;
    
    import com.azure.cosmos.ConnectionPolicy;
    import com.azure.cosmos.ConsistencyLevel;
    import com.azure.cosmos.CosmosAsyncClient;
    import com.azure.cosmos.CosmosAsyncDatabase;
    import com.azure.cosmos.CosmosAsyncContainer;
    import com.azure.cosmos.CosmosClientBuilder;
    import com.azure.cosmos.models.CosmosAsyncItemResponse;
    import com.azure.cosmos.models.CosmosContainerProperties;
    import com.azure.cosmos.models.CosmosItemResponse;
    import com.azure.cosmos.models.IndexingMode;
    import com.azure.cosmos.models.IndexingPolicy;
    import com.azure.cosmos.models.IncludedPath;
    
    import reactor.core.publisher.Flux;
    import reactor.core.publisher.Mono;
    
    import java.util.ArrayList;
    import java.util.List;
    import java.util.UUID;
    import java.util.concurrent.atomic.AtomicBoolean;
    import com.google.common.collect.Lists;
    ```

1. Within the App.java class, add the following lines of code to create variables for your connection information:

    ```java
    protected static Logger logger = LoggerFactory.getLogger(App.class.getSimpleName());
    private static String endpointUri = "YOUR_URI";
    private static String primaryKey = "YOUR_KEY";
    ```
    For the endpointUri variable, replace the placeholder value with the URI value and for the primaryKey variable, replace the placeholder value with the PRIMARY KEY value from your Azure Cosmos DB account.

1. Locate the main method and delete the `System.out` line:

    ```java
    public static void main( String[] args )
    {
        System.out.println( "Hello World!" );
    }
    ```

1. Within the main method, add the following lines of code to create a CosmosAsyncClient instance, replacing the Azure Cosmos DB Account Location placeholder with the location setting of your Azure Cosmos DB account:

    ```java
    ConnectionPolicy defaultPolicy = ConnectionPolicy.getDefaultPolicy();
    defaultPolicy.setPreferredLocations(Lists.newArrayList("<your azure cosmos db account location>"));
    
    CosmosAsyncClient client = new CosmosClientBuilder()
            .setEndpoint(endpointUri)
            .setKey(primaryKey)
            .setConnectionPolicy(defaultPolicy)
            .setConsistencyLevel(ConsistencyLevel.EVENTUAL)
            .buildAsyncClient();
    ```

1. Now add a line at the end of the main method which closes the client:

    ```java
    client.close();
    ```

1. Save your changes by typing <kbd>Ctrl+S</kbd>, or by selecting the **Save** option from the Editor menu on the upper right corner.

### Create a Database and a Partitioned Container using the SDK

To create a container, you must specify a name and a partition key path. You will specify those values when creating a container in this task. A partition key is a logical hint for distributing data onto a scaled out underlying set of physical partitions and for efficiently routing queries to the appropriate underlying partition

1. At the top of the Lab01Main class definition, add two more static class variables for the database and container instances:

    ```java
    private static CosmosAsyncDatabase targetDatabase;
    private static CosmosAsyncContainer customContainer;
    private static AtomicBoolean resourcesCreated = new AtomicBoolean(false);
    ```
1. All code added in subsequent steps should be placed between the build-client call and the close-client call in the main method:

    ```java
    CosmosAsyncClient client = new CosmosClientBuilder()
            .setEndpoint(endpointUri)
            .setKey(primaryKey)
            .setConnectionPolicy(defaultPolicy)
            .setConsistencyLevel(ConsistencyLevel.EVENTUAL)
            .buildAsyncClient();
    // <= Add code here
    client.close();  
    ```

1. Add the following code to the method to create new CosmosAsyncDatabase and CosmosAsyncContainerinstances if they do not already exist:

    ```java
    client.createDatabaseIfNotExists("EntertainmentDatabase").flatMap(databaseResponse -> {
        targetDatabase = databaseResponse.getDatabase();
        CosmosContainerProperties containerProperties = 
            new CosmosContainerProperties("CustomCollection", "/type");
        return targetDatabase.createContainerIfNotExists(containerProperties, 400);
    }).flatMap(containerResponse -> {
        customContainer = containerResponse.getContainer();
        return Mono.empty();
    }).subscribe(voidItem -> {}, err -> {}, () -> {
        resourcesCreated.set(true);
    });
    
    while (!resourcesCreated.get());
    ```
    
    This code will check to see if a database and a container already exist in your Azure Cosmos DB account with the specified configuration parameters. If a database or container that matches does not exist, it will be created.

1. After the while loop, add the following code to print out the ID of the database:

    ```java
    logger.info("Database Id:\t{}",targetDatabase.getId());
    logger.info("Container Id:\t{}",customContainer.getId());
    ```

1. Your final App.java file should resemble the following example:

    ```java
    package com.mslearn;
    
    import org.slf4j.Logger;
    import org.slf4j.LoggerFactory;
    import java.math.BigDecimal;
    import java.text.DecimalFormat;
    
    import com.azure.cosmos.ConnectionPolicy;
    import com.azure.cosmos.ConsistencyLevel;
    import com.azure.cosmos.CosmosAsyncClient;
    import com.azure.cosmos.CosmosAsyncDatabase;
    import com.azure.cosmos.CosmosAsyncContainer;
    import com.azure.cosmos.CosmosClientBuilder;
    
    import com.azure.cosmos.models.CosmosAsyncItemResponse;
    import com.azure.cosmos.models.CosmosContainerProperties;
    import com.azure.cosmos.models.CosmosItemResponse;
    import com.azure.cosmos.models.IndexingMode;
    import com.azure.cosmos.models.IndexingPolicy;
    import com.azure.cosmos.models.IncludedPath;
    
    import reactor.core.publisher.Flux;
    import reactor.core.publisher.Mono;
    
    import java.util.ArrayList;
    import java.util.List;
    import java.util.UUID;
    import java.util.concurrent.atomic.AtomicBoolean;
    import com.google.common.collect.Lists;
    
    /**
     * Hello world!
     *
     */
    public class App 
    {
        protected static Logger logger = LoggerFactory.getLogger(App.class.getSimpleName());
        private static String endpointUri = "YOUR_URI";
        private static String primaryKey = "YOUR_KEY";
        private static CosmosAsyncDatabase targetDatabase;
        private static CosmosAsyncContainer customContainer;
        private static AtomicBoolean resourcesCreated = new AtomicBoolean(false);
    
        public static void main( String[] args )
        {
            ConnectionPolicy defaultPolicy = ConnectionPolicy.getDefaultPolicy();
            defaultPolicy.setPreferredLocations(Lists.newArrayList("<your azure cosmos db account location>"));
    
            CosmosAsyncClient client = new CosmosClientBuilder()
                    .setEndpoint(endpointUri)
                    .setKey(primaryKey)
                    .setConnectionPolicy(defaultPolicy)
                    .setConsistencyLevel(ConsistencyLevel.EVENTUAL)
                    .buildAsyncClient();
            
            client.createDatabaseIfNotExists("EntertainmentDatabase").flatMap(databaseResponse -> {
                targetDatabase = databaseResponse.getDatabase();
                CosmosContainerProperties containerProperties = 
                    new CosmosContainerProperties("CustomCollection", "/type");
                return targetDatabase.createContainerIfNotExists(containerProperties, 400);
            }).flatMap(containerResponse -> {
                customContainer = containerResponse.getContainer();
                return Mono.empty();
            }).subscribe(voidItem -> {}, err -> {}, () -> {
                resourcesCreated.set(true);
            });
            
            while (!resourcesCreated.get());
            logger.info("Database Id:\t{}",targetDatabase.getId());
            logger.info("Container Id:\t{}",customContainer.getId());
    
            client.close();
    
        }
    }
    
    ```
    
    Make sure you use the correct values for `YOUR_URI` and `YOUR_KEY`.

1. Save your changes by typing <kbd>Ctrl+S</kbd>, or by selecting the **Save** option from the Editor menu on the upper right corner.

1. Close the Code Editor by typing <kbd>Ctrl+Q</kbd>, or selecting **Close** from the Editor menu in the upper right.

1. On the Bash Shell terminal, compile and run your Java application:

```bash
mvn package
mvn exec:java -Dexec.mainClass=com.mslearn.App
```

Your Application will create a new database and container inside your Azure Cosmos DB account.


::: zone-end

## Summary

In this unit, you programmatically created a database and container with throughput and scaling settings that are appropriate for your business needs.
