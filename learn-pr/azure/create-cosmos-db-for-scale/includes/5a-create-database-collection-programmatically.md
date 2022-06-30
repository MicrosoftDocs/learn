In this exercise, you'll learn how to create an Azure Cosmos DB database and container programmatically. Following the example from the previous exercise, you'll create a database with a variation of the name **Products** and a container with a variation of the name **Clothing**.

In Azure Cosmos DB, database names and container names must be unique in your subscription. Because you've already created a database named **Products** and a container named **Clothing**, the following exercises are set up to create databases named **Products-csharp**, **Products-java**, and **Products-cli** and containers named **Clothing-csharp**, **Clothing-java**, and **Clothing-cli**, depending on the programming language you select to begin the exercise. You'll also specify your partition key and throughput values.

::: zone pivot="csharp"

## Create a database and container using C# and the .NET SDK

In this exercise, you'll create an Azure Cosmos DB database and container using the C# and the .NET SDK for Azure Cosmos DB.

### Create a new .NET app, database, and container in C\#

1. Sign in to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) using the same account you used to activate the sandbox.

    1. In the Azure portal, in the Concierge subscription, go to the Cosmos DB account you created in this subscription.

    1. In the left menu, select **Keys**.

    1. In **Keys**, under **Read-write keys**, for **URI** and **PRIMARY KEY**, copy the values and save them on your local computer to use later.

        :::image type="content" source="../media/database-keys-uri.png" alt-text="Screenshot of the pane in the Azure portal where you copy U R I and primary key values.":::

1. In the sandbox Azure Cloud Shell terminal on the right, use the following command to create a new .NET Console application.

   > [!TIP]
   > If you've already used Cloud Shell to complete this exercise in one language and now you're doing the exercise in another language, be sure to refresh Cloud Shell to change language environments before you enter the following commands.
   >
   > :::image type="content" source="../media/cloud-shell-refresh.png" alt-text="Screenshot that shows the Refresh icon in the sandbox Cloud Shell terminal.":::

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

1. Open the Cloud Shell code editor to make changes to your project:

   ```bash
   code .
   ```

   Cloud Shell splits into two sections, the terminal and the code editor. You can maximize the screen to have more space to edit your files.

   :::image type="content" source="../media/azure-cosmos-db-new-shell-editor-csharp.png" alt-text="Screenshot that shows the Cloud Shell Bash terminal and code editor for C Sharp.":::

1. In the Explorer pane, select *myApp.csproj* to open the file in the editor.

   1. Add a new `<PropertyGroup>` XML element to the project configuration in the `Project` element. To add a new `<PropertyGroup>` XML element, find the existing `<PropertyGroup>` element, and then add the following lines beneath it:

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
               <TargetFramework>netcoreapp6.0</TargetFramework>
           </PropertyGroup>
           <PropertyGroup>
               <LangVersion>latest</LangVersion>
           </PropertyGroup>
           <ItemGroup>
               <PackageReference Include="Microsoft.Azure.Cosmos" Version="3.0.0" />
           </ItemGroup>
       </Project>
       ```

   1. Select **Ctrl+S** to save your changes, or select the **Save** option in the editor menu in the upper-right corner.

1. In the Explorer pane, select *Program.cs* to open the file in the editor.

    1. Add the following `using` statements to the top of the editor:

       ```csharp
       using System.Collections.Generic;
       using System.Collections.ObjectModel;
       using System.Linq;
       using System.Threading.Tasks;
       using Microsoft.Azure.Cosmos;
       ```

    1. Locate the `Program` class and replace it with the following class:

       ```csharp
       public class Program
       {
           public static async Task Main(string[] args)
           {         
           }
       }
       ```

    1. In the `Program` class, add the following lines of code to create variables for your connection information:

       ```csharp
       private static readonly string _endpointUri = "<YOUR_URI>";
       private static readonly string _primaryKey = "<YOUR_KEY>";
       ```

        Replace the values `<YOUR_URI>` and `<YOUR_KEY>` with the values that you retrieved from your Cosmos DB resource in the Azure portal.

    1. Locate the `Main` method, and add the following lines of code to create a `CosmosClient` instance. `CosmosClient` is the primary entry point to use the SQL API in Azure Cosmos DB:

       ```csharp
       using (CosmosClient client = new CosmosClient(_endpointUri, _primaryKey))
       {        
       }
       ```

    1. In the `CosmosClient` creation block, add the following code to create a new `Database` instance name **Products-csharp**:

       ```csharp
       DatabaseResponse databaseResponse = await client.CreateDatabaseIfNotExistsAsync("Products-csharp");
       Database targetDatabase = databaseResponse.Database;
       ```

        This code checks whether a database with the specified parameters exists in your Azure Cosmos DB account. If a database that matches doesn't exist, it creates a new database.

    1. As a final step, below the `Database` instance, add the following code to print the ID of the database you created:

        ```csharp
        await Console.Out.WriteLineAsync($"Database Id:\t{targetDatabase.Id}");
        ```

        The `targetDatabase` variable contains metadata about the database, whether a new database is created or an existing one is read.

        Your final *Program.cs* code should resemble the following example:

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
                private static readonly string _endpointUri = "<YOUR_URI>";
                private static readonly string _primaryKey = "<YOUR_KEY>";
                public static async Task Main(string[] args)
                {         
                    using (CosmosClient client = new CosmosClient(_endpointUri, _primaryKey))
                    {        
                        DatabaseResponse databaseResponse = await client.CreateDatabaseIfNotExistsAsync("Products-csharp");
                        Database targetDatabase = databaseResponse.Database;
                        await Console.Out.WriteLineAsync($"Database Id:\t{targetDatabase.Id}");
                    }
                }
            }
        }
        ```

        You'll have different values for `<YOUR_URI>` and `<YOUR_KEY`>.

    1. Select **Ctrl+S** to save your changes, or select the **Save** option in the editor menu in the upper-right corner.

    1. Select **Ctrl+Q** to close the code editor, or select **Close** in the editor menu.

1. In Cloud Shell, compile and run your .NET Core app:

    ```bash
    dotnet build
    dotnet run
    ```

    After you run your application, you should see the following output in your console:

    :::image type="content" source="../media/output-database-csharp.png" alt-text="Screenshot of the C Sharp database created in Cloud Shell.":::

### Create a partitioned container in C\#

Now that you've created your database, you're ready to create a container to store your documents.

1. In the code editor, open the *Program.cs* file to make changes to your app:

    ```bash
    code Program.cs
    ```

    1. In the `Main` method, find the `await Console.Out.WriteLineAsync(...)` method.

    1. Below the `WriteLineAsync()` method, add the following code to create a new `IndexingPolicy` instance with a custom indexing policy:

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
        var containerProperties = new ContainerProperties("Clothing-csharp", "/productId")
        {
            IndexingPolicy = indexingPolicy
        };
        ```

    1. Below your previous additions, add the following lines of code to create a new `Container` instance:

        ```csharp
        var containerResponse = await targetDatabase.CreateContainerIfNotExistsAsync(containerProperties, 10000);
        var customContainer = containerResponse.Container;
        ```

        This code checks to see whether a container with the specified parameters exists in your database. If there's no match, it creates a new container. You also can specify the RU/s allocated for the container that you create. When you don't specify the RU/s, the SDK has a default value for RU/s assigned to a container.

    1. Add the following code to print the ID of the container:

        ```csharp
        await Console.Out.WriteLineAsync($"Custom Container Id:\t{customContainer.Id}");
        ```

        Your final *Program.cs* file should look like this example:

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
                private static readonly string _endpointUri = "<YOUR_URI>";
                private static readonly string _primaryKey = "<YOUR_KEY>";
                public static async Task Main(string[] args)
                {         
                    using (CosmosClient client = new CosmosClient(_endpointUri, _primaryKey))
                    {        
                        DatabaseResponse databaseResponse = await client.CreateDatabaseIfNotExistsAsync("Products-csharp");
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
                        var containerProperties = new ContainerProperties("Clothing-csharp", "/productId")
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

        Remember that you'll have different values for `<YOUR_URI>` and `<YOUR_KEY>`.

    1. Select **Ctrl+S** to save your changes, or select the **Save** option in the editor menu in the upper-right corner.

    1. Select **Ctrl+Q** to close the code editor, or select **Close** in the editor menu.

1. In the Cloud Shell terminal, compile and run the .NET Core app:

    ```bash
    dotnet build
    dotnet run
    ```

   After you run your application, you should see this output in your console:

    :::image type="content" source="../media/output-container-csharp.png" alt-text="Screenshot of the C Sharp container created in Cloud Shell.":::

1. In the Azure portal, in your Azure Cosmos DB account, go to Data Explorer to see the new database and container you created by using C#:

   :::image type="content" source="../media/products-container-csharp.png" alt-text="Screenshot that shows the Products c sharp database and Clothing c sharp container in the Azure portal.":::

::: zone-end

::: zone pivot="java"

## Create a database and container using the Java SDK

In this exercise, you'll create an Azure Cosmos DB  database and a container using the Java SDK for Azure Cosmos DB.

### Create a new Java app, database, and container using Java

1. Sign in to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) using the same account you used to activate the sandbox.

    1. In the Azure portal, in the Concierge subscription, go to the Cosmos DB account you created in this subscription.

    1. In the left menu, select **Overview**.

    1. In the account summary, under **Write Locations**, select the copy icon to copy the location to your computer to use later.

        :::image type="content" source="../media/overview-write-locations.png" alt-text="Screenshot of an account overview pane with Write Locations selected.":::

    1. In the left menu, select **Keys**.

    1. In **Keys**, under **Read-write keys**, for **URI** and **PRIMARY KEY**, copy the values and save them on your local computer to use later.

        :::image type="content" source="../media/database-keys-uri.png" alt-text="Screenshot of the pane in the Azure portal where you copy URI and Primary key values.":::

1. In the sandbox Azure Cloud Shell terminal on the right, run the following command to create a new Java application using Maven and the maven-archetype-quickstart.

    > [!TIP]
    > If you've already used Cloud Shell to complete this exercise in one language and now you're doing the exercise inanother language, be sure to refresh Cloud Shell to change language environments before you enter the following commands.
    >
    > :::image type="content" source="../media/cloud-shell-refresh.png" alt-text="Screenshot that shows the Refresh icon in the sandbox Cloud Shell terminal.":::

    ```bash
    mvn archetype:generate -DgroupId=com.mslearn -DartifactId=cosmosjavaprj -DarchetypeArtifactId=maven-archetype-quickstart -DinteractiveMode=false
    ```

    Maven creates a project called *cosmosjavaprj* and provides a sample app file to get you started.

1. Change to your new app's directory:

    ```bash
    cd cosmosjavaprj
    ```

1. In Cloud Shell, open the code editor to make changes to your project:

    ```bash
    code .
    ```

    Cloud Shell splits into two sections, the terminal and the code editor. You can maximize the screen to have more space to edit your files.

    :::image type="content" source="../media/azure-cosmos-db-new-shell-editor-java.png" alt-text="Screenshot that shows the Cloud Shell terminal and code editor for Java.":::

1. In the Explorer pane, select *pom.xml* to open the file in the code editor. Replace the entire file with the following code:

    ```xml
    <?xml version="1.0" encoding="UTF-8"?>
    <project xmlns="http://maven.apache.org/POM/4.0.0"
             xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
             xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
        <modelVersion>4.0.0</modelVersion>
     
        <groupId>com.azure</groupId>
        <artifactId>azure-cosmos-java-sql-api-samples</artifactId>
        <version>1.0-SNAPSHOT</version>
        <name>Get Started With Sync / Async Java SDK for SQL API of Azure Cosmos DB Database Service
        </name>
        <properties>
            <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
        </properties>
     
        <build>
            <plugins>
                <plugin>
                    <artifactId>maven-compiler-plugin</artifactId>
                    <version>3.1</version>
                    <configuration>
                        <source>1.8</source>
                        <target>1.8</target>
                    </configuration>
                </plugin>
                <plugin>
                    <groupId>org.codehaus.mojo</groupId>
                    <artifactId>exec-maven-plugin</artifactId>
                    <version>1.6.0</version>
                </plugin>
                <plugin>
                    <groupId>org.apache.maven.plugins</groupId>
                    <artifactId>maven-eclipse-plugin</artifactId>
                    <version>2.8</version>
                    <configuration>
                        <classpathContainers>
                            <classpathContainer>
                                org.eclipse.jdt.launching.JRE_CONTAINER/org.eclipse.jdt.internal.debug.ui.launcher.StandardVMType/JavaSE-1.8
                            </classpathContainer>
                        </classpathContainers>
                    </configuration>
                </plugin>
            </plugins>
        </build>
        <dependencies>
            <dependency>
                <groupId>com.azure</groupId>
                <artifactId>azure-cosmos</artifactId>
                <version>4.0.1-beta.1</version>
            </dependency>
            <dependency>
                <groupId>com.github.javafaker</groupId>
                <artifactId>javafaker</artifactId>
                <version>1.0.2</version>
            </dependency>
        </dependencies>
    </project>
    ```

1. Select **Ctrl+S** to save your changes, or select the **Save** option in the editor menu in the upper-right corner.

1. In the Explorer pane of the code editor, expand the nodes in the tree to *src\main\java\com\mslearn*, and then select *App.java* to open the file in the editor:

   :::image type="content" source="../media/cloud-shell-app-java-file.png" alt-text="Screenshot that shows Cloud Shell and location of the App dot java file.":::

1. Below the `package com.mslearn` line, add the following imports:

    ```java
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

1. In the *App.java* file, add the following lines of code to create variables for your connection information, and for your database and container instances:

    ```java
    private static String endpointUri = "<YOUR_URI>";
    private static String primaryKey = "<YOUR_KEY>";
    private static String writeLocation = "<YOUR_LOCATION>";

    private static CosmosAsyncDatabase targetDatabase;
    private static CosmosAsyncContainer customContainer;
    private static AtomicBoolean resourcesCreated = new AtomicBoolean(false);
    ```

    Replace the placeholder values for the `endpointUri`, `primaryKey`, and `writeLocation` variables with the respective values for **URI**, **PRIMARY KEY**, and **Write Locations** values from your Azure Cosmos DB account.

1. Locate the `main()` method and delete the `System.out` line:

    ```java
    public static void main( String[] args )
    {
        System.out.println( "Hello World!" );
    }
    ```

1. In the `main()` method, add the following lines of code to create a `CosmosAsyncClient` instance:

    ```java
    ConnectionPolicy defaultPolicy = ConnectionPolicy.getDefaultPolicy();
    defaultPolicy.setPreferredLocations(Lists.newArrayList(writeLocation));
    
    CosmosAsyncClient client = new CosmosClientBuilder()
            .setEndpoint(endpointUri)
            .setKey(primaryKey)
            .setConnectionPolicy(defaultPolicy)
            .setConsistencyLevel(ConsistencyLevel.EVENTUAL)
            .buildAsyncClient();
    ```

1. Below the `CosmosClientBuilder()` call, add the following code to create a new `CosmosAsyncDatabase` instance if it doesn't already exist:

    ```java
    client.createDatabaseIfNotExists("Products").flatMap(databaseResponse -> {
        targetDatabase = databaseResponse.getDatabase();
        return Mono.empty();
    }).subscribe(voidItem -> {}, err -> {}, () -> {
        resourcesCreated.set(true);
    });
    
    while (!resourcesCreated.get());
    ```

    This code will check to see whether a database already exists in your Azure Cosmos DB account. If it doesn't exist, it creates the database.

1. After the `while` loop, add the following code to print the ID of the database:

    ```java
    System.out.println(String.format("Database Id:\t%s",targetDatabase.getId()));
    ```

1. Now add a line at the end of the `main()` method to close the client:

    ```java
    client.close();
    ```

1. Your final *App.java* file should resemble the following example:

    ```java
    package com.mslearn;

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
        private static String endpointUri = "<YOUR_URI>";
        private static String primaryKey = "<YOUR_KEY>";
        private static String writeLocation = "<YOUR_LOCATION>";

        private static CosmosAsyncDatabase targetDatabase;
        private static CosmosAsyncContainer customContainer;
        private static AtomicBoolean resourcesCreated = new AtomicBoolean(false);
    
        public static void main( String[] args )
        {
            ConnectionPolicy defaultPolicy = ConnectionPolicy.getDefaultPolicy();
            defaultPolicy.setPreferredLocations(Lists.newArrayList(writeLocation));
            
            CosmosAsyncClient client = new CosmosClientBuilder()
                    .setEndpoint(endpointUri)
                    .setKey(primaryKey)
                    .setConnectionPolicy(defaultPolicy)
                    .setConsistencyLevel(ConsistencyLevel.EVENTUAL)
                    .buildAsyncClient();

            client.createDatabaseIfNotExists("Products-java").flatMap(databaseResponse -> {
                targetDatabase = databaseResponse.getDatabase();
                return Mono.empty();
            }).subscribe(voidItem -> {}, err -> {}, () -> {
                resourcesCreated.set(true);
            });
            
            while (!resourcesCreated.get());
            
            System.out.println(String.format("Database Id:\t%s",targetDatabase.getId()));

            client.close();   
    
        }
    }
    ```

    Make sure you replace the placeholder values for `<YOUR_URI>`, `<YOUR_KEY>`, and `<YOUR_LOCATION>`.

1. Select **Ctrl+S** to save your changes, or select the **Save** option in the editor menu in the upper-right corner.

1. Select **Ctrl+Q** to close the code editor, or select **Close** in the editor menu.

1. In the sandbox Cloud Shell terminal, compile and run your Java application:

    ```bash
    mvn compile
    mvn exec:java -Dexec.mainClass=com.mslearn.App -Dexec.cleanupDaemonThreads=false
    ```

    Your application creates a new database inside your Azure Cosmos DB account. You'll see the name in the output console:

    :::image type="content" source="../media/output-database-java.png" alt-text="Screenshot that shows the database output for Java.":::

### Create a partitioned container using Java

To create a container, you must specify a name and a partition key path. You'll specify those values when you create a container in this task. A partition key is a logical hint for distributing data onto a scaled-out underlying set of physical partitions and to efficiently route queries to the appropriate underlying partition.

1. In the previous section of this exercise, in *App.java*, you used the following code to create a database:

    ```java
    client.createDatabaseIfNotExists("Products-java").flatMap(databaseResponse -> {
        targetDatabase = databaseResponse.getDatabase();
        return Mono.empty();
    }).subscribe(voidItem -> {}, err -> {}, () -> {
        resourcesCreated.set(true);
    });
    ```

1. In *App.java* in the code editor, add a few empty lines before the `return Mono.empty();` statement. Here, you'll add code to create an indexing policy and container instance in the following steps:

    ```java
    client.createDatabaseIfNotExists("Products-java").flatMap(databaseResponse -> {
        targetDatabase = databaseResponse.getDatabase();

        /* ADD NEW CODE HERE */

        return Mono.empty();
    }).subscribe(voidItem -> {}, err -> {}, () -> {
        resourcesCreated.set(true);
    });
    ```

1. In the empty space, create a new `IndexingPolicy` instance, with a custom indexing policy configured:

    ```java
    IndexingPolicy indexingPolicy = new IndexingPolicy();
    indexingPolicy.setIndexingMode(IndexingMode.CONSISTENT);
    indexingPolicy.setAutomatic(true);
    List<IncludedPath> includedPaths = new ArrayList<>();
    IncludedPath includedPath = new IncludedPath();
    includedPath.setPath("/*");
    includedPaths.add(includedPath);
    indexingPolicy.setIncludedPaths(includedPaths); 
    ```

1. After the code that creates your `IndexingPolicy` instance, add the following lines to create your container:

    ```java
    CosmosContainerProperties containerProperties = 
        new CosmosContainerProperties("Clothing-java", "/productId");
        containerProperties.setIndexingPolicy(indexingPolicy);
        return targetDatabase.createContainerIfNotExists(containerProperties, 10000);
    }).flatMap(containerResponse -> {
        customContainer = containerResponse.getContainer();
    ```

1. After the existing `System.out.println()` statement that prints the name of your database, add another `System.out.println()` statement that prints the name of your container:

    ```java
    System.out.println(String.format("Database Id:\t%s",targetDatabase.getId()));
    System.out.println(String.format("Container Id:\t%s",customContainer.getId()));
    ```

1. Your final code in the *App.java* file will look like this example:

    ```java
    package com.mslearn;
    
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
        private static String endpointUri = "<YOUR_URI>";
        private static String primaryKey = "<YOUR_KEY>";
        private static String writeLocation = "<YOUR_LOCATION>";

        private static CosmosAsyncDatabase targetDatabase;
        private static CosmosAsyncContainer customContainer;
        private static AtomicBoolean resourcesCreated = new AtomicBoolean(false);
    
        public static void main( String[] args )
        {
            ConnectionPolicy defaultPolicy = ConnectionPolicy.getDefaultPolicy();
            defaultPolicy.setPreferredLocations(Lists.newArrayList(writeLocation));
            
            CosmosAsyncClient client = new CosmosClientBuilder()
                    .setEndpoint(endpointUri)
                    .setKey(primaryKey)
                    .setConnectionPolicy(defaultPolicy)
                    .setConsistencyLevel(ConsistencyLevel.EVENTUAL)
                    .buildAsyncClient();

            client.createDatabaseIfNotExists("Products-java").flatMap(databaseResponse -> {
                targetDatabase = databaseResponse.getDatabase();
                IndexingPolicy indexingPolicy = new IndexingPolicy();
                indexingPolicy.setIndexingMode(IndexingMode.CONSISTENT);
                indexingPolicy.setAutomatic(true);
                List<IncludedPath> includedPaths = new ArrayList<>();
                IncludedPath includedPath = new IncludedPath();
                includedPath.setPath("/*");
                includedPaths.add(includedPath);
                indexingPolicy.setIncludedPaths(includedPaths);  
                CosmosContainerProperties containerProperties = 
                    new CosmosContainerProperties("Clothing-java", "/productId");
                containerProperties.setIndexingPolicy(indexingPolicy);
                return targetDatabase.createContainerIfNotExists(containerProperties, 10000); 
            }).flatMap(containerResponse -> {
                customContainer = containerResponse.getContainer();
                return Mono.empty();
            }).subscribe(voidItem -> {}, err -> {}, () -> {
                resourcesCreated.set(true);
            });
            
            while (!resourcesCreated.get());
    
            System.out.println(String.format("Database Id:\t%s",targetDatabase.getId()));
            System.out.println(String.format("Container Id:\t%s",customContainer.getId()));
    
            client.close();   
        }
    }
    ```

    Make sure you replace the placeholder values for `<YOUR_URI>`, `<YOUR_KEY>`, and `<YOUR_LOCATION>`.

1. Select **Ctrl+S** to save your changes, or select the **Save** option in the editor menu in the upper-right corner.

1. Select **Ctrl+Q** to close the code editor, or select **Close** in the editor menu.

1. In Cloud Shell, compile and run your Java application:

    ```bash
    mvn compile
    mvn exec:java -Dexec.mainClass=com.mslearn.App -Dexec.cleanupDaemonThreads=false
    ```

   Your application creates a new database with a partitioned container inside your Azure Cosmos DB account. You'll see the names in the output console:

   :::image type="content" source="../media/output-container-java.png" alt-text="Screenshot of output to create a database and container in Java.":::

1. In the Azure portal, in your Azure Cosmos DB account, go to Data Explorer to see the new database and container you created by using Java:

   :::image type="content" source="../media/products-container-java.png" alt-text="Screenshot that shows the Products java database and Clothing java container in the Azure portal.":::

::: zone-end

::: zone pivot="cli"

## Create an Azure Cosmos DB database and container with the Azure CLI

1. Sign in to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) with the account you used to activate the sandbox. Find the Azure Cosmos DB account you created in the Concierge subscription. Note the name of your Cosmos DB account.

1. In the sandbox Azure Cloud Shell terminal on the right, paste the following command to store the name of the Azure Cosmos DB account name in an environment variable. Make sure to replace `<COSMOS-DB-ACCOUNT-NAME>` with the name of the Azure Cosmos DB account you created in the Concierge subscription in the Azure portal.

   > [!TIP]
   > If you've already used Cloud Shell to complete this exercise in one language and now you're doing the exercise in another language, be sure to refresh Cloud Shell to change language environments before you enter the following commands.
   >
   > :::image type="content" source="../media/cloud-shell-refresh.png" alt-text="Screenshot that shows the Refresh icon in the sandbox Cloud Shell terminal.":::

    ```bash
    export NAME=<COSMOS-DB-ACCOUNT-NAME>
    ```

    [!include[](../../../includes/azure-cloudshell-copy-paste-tip.md)]

1. Use the `cosmosdb database create` command to create the `Products-cli` database in the account. It takes a `db-name` parameter that you'll set to **Products-cli**. This  database will hold inventory data:

    ```azure-cli
    az cosmosdb sql database create \
        --account-name $NAME \
        --name "Products-cli" \
        --resource-group <rgn>[sandbox resource group name]</rgn>
    ```

    This command displays a JSON object that might look like the following example excerpt:

    ```json
    {
      "id": "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/<rgn>[sandbox resource group name]</rgn>/providers/Microsoft.DocumentDB/databaseAccounts/cosmos123456/sqlDatabases/Products-cli",
      "location": null,
      "name": "Products-cli",
      "resource": {
        ...
      },
      "resourceGroup": "<rgn>[sandbox resource group name]</rgn>",
      "tags": null,
      "type": "Microsoft.DocumentDB/databaseAccounts/sqlDatabases"
    }
    ```

1. Use the `cosmosdb sql container create` command to create the `Clothing-cli` container. In this code, you specify your partition key and throughput values:

    ```azure-cli
    az cosmosdb sql container create \
        --account-name $NAME \
        --database-name "Products-cli" \
        --name "Clothing-cli" \
        --partition-key-path "/productId" \
        --throughput 1000 \
        --resource-group <rgn>[sandbox resource group name]</rgn>
    ```

    This command displays a JSON object that might look like the following example excerpt:

    ```json
    {
      "id": "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/<rgn>[sandbox resource group name]</rgn>/providers/Microsoft.DocumentDB/databaseAccounts/cosmos123456/sqlDatabases/Products/containers/Clothing-cli",
      "location": null,
      "name": "Clothing-cli",
      "resource": {
        ...
      },
      "resourceGroup": "<rgn>[sandbox resource group name]</rgn>",
      "tags": null,
      "type": "Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers"
    }
    ```

1. In the Azure portal, in your Azure Cosmos DB account, go to Data Explorer to see the new database and container you created by using the Azure CLI:

   :::image type="content" source="../media/products-container-cli.png" alt-text="Screenshot that shows the Products c l i database and the Clothing c l i container in the Azure portal.":::

::: zone-end

In this unit, you programmatically created a database and container with throughput and scaling settings that are appropriate for your business needs.

If you completed the exercise for each of the three languages shown (C#, Java, and Azure CLI), you'll see a database and container for each example, in addition to the database and container you created in the Azure portal in an earlier exercise.

:::image type="content" source="../media/products-container-all.png" alt-text="Screenshot that shows four databases and containers in Data Explorer in the Azure portal.":::
