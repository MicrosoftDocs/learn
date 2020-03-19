You now understand how request units are used to determine database throughput. You also know how to use partition keys to create a scale-out strategy for your database. 


Now you're ready to create your database and container. In this exercise, you'll create an Azure Cosmos DB Database named **"Products"** and Container named **"Clothing"** and set your partition key and throughput values.

::: zone pivot="csharp"
## Creating your database and container using C# and the .NET SDK

In this exercise, you'll create an Azure Cosmos DB  database, and container using the C# and the .NET SDK for Azure Cosmos DB.

1. In the Azure portal, inside your Cosmos DB resource, select **Keys**. Copy the URI and PRIMARY KEY values as you'll need them later.

2. Open the Azure Cloud Shell Bash shell and create a new .Net Console application

    ```bash
    dotnet new console --output myApp
    ``` 

3. A new folder call myApp and a new console C# app will be created. Change your default directory to the new app directory

    ```bash
    cd myApp
    ``` 

4. Add the Microsoft.Azure.Cosmos NuGet package as a project dependency

    ```bash
    dotnet add package Microsoft.Azure.Cosmos --version 3.0.0
    ``` 

5. Restore all packages specified as dependencies in the project and compile the project

    ```bash
    dotnet restore
    dotnet build
    ```

6. Use the Shell Code Editor to make changes to update your project configuration.

    ```bash
    code .
    ```

    The Bash shell screen splits into two sections, showing you the coding interface at the top. You can maximize the screen to have more space to edit your files
     > [!div class="mx-imgBorder"]
    > ![Bash Shell and Code Editor](../media/5-azure-cosmos-db-new-shell-and-editor.png)

7. Click the myApp.csproj link in the Explorer pane to open the file in the editor. We'll now add a new PropertyGroup XML element to the project configuration within the Project element. To add a new PropertyGroup, insert the following lines of code under the line that reads:

    ```xml
    <PropertyGroup>
        <LangVersion>latest</LangVersion>
    </PropertyGroup>
    ```

8. Your new XML file should look like this:

    ```xml
    <Project Sdk="Microsoft.NET.Sdk">
        <PropertyGroup>
            <LangVersion>latest</LangVersion>
        </PropertyGroup>
        <PropertyGroup>
            <OutputType>Exe</OutputType>
            <TargetFramework>netcoreapp2.2</TargetFramework>
        </PropertyGroup>
        <ItemGroup>
            <PackageReference Include="Microsoft.Azure.Cosmos" Version="3.0.0" />
        </ItemGroup>
    </Project>
    ```
    Save your changes by typing Ctrl+S or selecting the Save option from the Editor menu on the upper right corner.

9. Click the Program.cs link in the Explorer pane to open the file in the editor. Within the Program.cs editor tab, Add the following using blocks to the top of the editor:

    ```csharp
    using System.Collections.Generic;
    using System.Collections.ObjectModel;
    using System.Linq;
    using System.Threading.Tasks;
    using Microsoft.Azure.Cosmos;
    ```

10. We'll now create a CosmosClient instance which is the main "entry point" to using the SQL API in Azure Cosmos DB. Locate the Program class and replace it with the following class:

    ```csharp
    public class Program
    {
        public static async Task Main(string[] args)
        {         
        }
    }
    ```
11. Within the Program class, add the following lines of code to create variables for your connection information:

    ```csharp
    private static readonly string _endpointUri = "YOUR_URI";
    private static readonly string _primaryKey = "YOUR_KEY";
    ```

    Replace the values YOUR_URI and YOUR_KEY with the values you obtained from your Cosmos DB resource on Step #1.

12. Locate the **Main** method and add the following lines of code to create a CosmosClient instance

    ```csharp
    using (CosmosClient client = new CosmosClient(_endpointUri, _primaryKey))
    {        
    }
    ```

13. Add the following code to the method to create a new Database instance if one doesn't already exist:

    ```csharp
    DatabaseResponse databaseResponse = await client.CreateDatabaseIfNotExistsAsync("Products");
    Database targetDatabase = databaseResponse.Database;
    ```

    This code checks if a database with the specified parameters exists in your Azure Cosmos DB account. If a database that matches doesn't exist, it will create a new database

14. Finally, add the following code to print out the ID of the database. The targetDatabase variable has metadata about the database whether a new database is created or an existing one is read.

    ```csharp
    await Console.Out.WriteLineAsync($"Database Id:\t{targetDatabase.Id}");
    ```
15. Your final Program.cs code should look like this:

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

    Notice you'll have different values for YOUR_URI and YOUR_KEY.

16. Close your Bash Code Editor by typing Ctrl+Q or selecting Close from the Editor menu in the upper right.

17. On the Bash Shell terminal, compile and run the .NET Core app.

    ```bash
    dotnet build
    dotnet run
    ```
18. After running your application, you should see this output in your console:

    ```bash
    Database Id:    Products
    ```

19. Now that your Database was created, you're ready to create a Container to store your documents. Locate the **using** block within the Main method and add the following code to create a new IndexingPolicy instance with a custom indexing policy configured:

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
20. Add the following lines of code to create a new Container instance if one doesn't already exist within your database. Specify the previously created settings and a value for throughput:

    ```csharp
    var containerResponse = await targetDatabase.CreateContainerIfNotExistsAsync(containerProperties, 10000);
    var customContainer = containerResponse.Container;
    ```
    
    This code checks to see if a container with the specified parameters exists in your database. It creates a new container if there is no match. Here is where we can specify the RU/s allocated for a newly created container. When not specified, the SDK has a default value for RU/s assigned to a container

21. Add the following code to print out the ID of the container:

    ```csharp
    await Console.Out.WriteLineAsync($"Custom Container Id:\t{customContainer.Id}");
    ```

22. Save your code. Your final Program.cs file should look like this:

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

    Notice you'll have different values for YOUR_URI and YOUR_KEY.

23. Close your Bash Code Editor by typing Ctrl+Q or selecting Close from the Editor menu in the upper right.

24. On the Bash Shell terminal, compile and run the .NET Core app.

    ```bash
    dotnet build
    dotnet run
    ```
25. After running your application, you should see this output in your console:

    ```bash
    Database Id:    Products
    Custom Container Id:    Clothing
    ```
::: zone-end

::: zone pivot="java"
## Creating your database and container using the Java SDK

In this exercise, you'll create an Azure Cosmos DB  database, and container using the Java SDK for Azure Cosmos DB. 

1. In the Azure portal, inside your Cosmos DB resource, select **Keys**. Copy the URI and PRIMARY KEY values as you'll need them later.

2. Open the Azure Cloud Shell Bash shell and create a new Java application using **Maven** and the *maven-archetype-quickstart*.  

    ```bash
    mvn archetype:generate -DgroupId=com.mslearn -DartifactId=cosmosjavaprj -DarchetypeArtifactId=maven-archetype-quickstart -DinteractiveMode=false
    ``` 
    Maven will create the project in a called cosmosjavaprj, and provide a sample App.

3. From the Bash Shell Terminal, navigate inside the newly created folder and open the Cloud Shell Code Editor:

    ```bash
    cd cosmosjavaprj
    code .
    ```

4. To add the Maven project dependencies required to work with Cosmos DB, you should update the pom.xml file located at the bottom of your project. Add the following entry within the dependencies section:

    ```xml
    <dependency>
      <groupId>com.microsoft.azure</groupId>
      <artifactId>azure-cosmosdb</artifactId>
      <version>2.4.3</version>
    </dependency>
    ```
    
    You'll also need to change the source and target compiler versions to Java 1.8. The code uses lambda syntax supported only on Java 8 onwards. Add the following code to below the dependencies section

    ```xml
    <properties>
        <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
        <maven.compiler.source>1.8</maven.compiler.source>
        <maven.compiler.target>1.8</maven.compiler.target>
    </properties>
    ```

    Make sure to save your changes by typing Ctrl+S or selecting Save from the Cloud Shell Editor menu on the upper right.

5. Navigate the folder structure on the Code Editor and click the App.java link in the Explorer pane to open the file in the editor. The file should be located under src\main\java\com\mslearn\App.java

     > [!div class="mx-imgBorder"]
    > ![Bash Shell and Code Editor](../media/5-azure-cosmos-db-new-shell-and-editor-java.png)


6.  Below the **package com.mslearn** line, add the following lines:

    ```java
    import java.util.ArrayList;
    import java.util.Collection;
    import java.util.List;
    import java.util.concurrent.CountDownLatch;
    import java.util.concurrent.ExecutorService;
    import java.util.concurrent.Executors;
    import com.microsoft.azure.cosmosdb.ConnectionPolicy;
    import com.microsoft.azure.cosmosdb.ConsistencyLevel;
    import com.microsoft.azure.cosmosdb.DataType;
    import com.microsoft.azure.cosmosdb.Database;
    import com.microsoft.azure.cosmosdb.DocumentClientException;
    import com.microsoft.azure.cosmosdb.DocumentCollection;
    import com.microsoft.azure.cosmosdb.IncludedPath;
    import com.microsoft.azure.cosmosdb.Index;
    import com.microsoft.azure.cosmosdb.IndexingPolicy;
    import com.microsoft.azure.cosmosdb.PartitionKeyDefinition;
    import com.microsoft.azure.cosmosdb.RequestOptions;
    import com.microsoft.azure.cosmosdb.ResourceResponse;
    import com.microsoft.azure.cosmosdb.rx.AsyncDocumentClient;
    import rx.Observable;
    import rx.Scheduler;
    import rx.schedulers.Schedulers;
    ```
7. Add the following class variables

    ```java
    private static final String databaseName = "Products";
    private static ExecutorService executorService;
    private static Scheduler scheduler;
    private static AsyncDocumentClient client;
    ```
8. Replace the default program content inside the main method with the following content:

    ```java
    executorService = Executors.newFixedThreadPool(100);
    scheduler = Schedulers.from(executorService);
    client = new AsyncDocumentClient.Builder().withServiceEndpoint("YOUR_URI")
    .withMasterKeyOrResourceToken("YOUR_KEY")
    .withConnectionPolicy(ConnectionPolicy.GetDefault()).withConsistencyLevel(ConsistencyLevel.Eventual)
    .build();
    ```
    The code will create a scheduler used to switch to a user app thread, which is required for async IO operations) and also the AsyncDocumentClient.
    Make sure to replace "YOUR_URI" and "YOUR_KEY" with the values you recorded in the first step.

9. Below the main method in the Program class, add the following methods for creating a database, and closing down the AsyncDocumentClient

    ```java
    private static void createDatabase() throws Exception {
        String databaseLink = String.format("/dbs/%s", databaseName);
        Observable<ResourceResponse<Database>> databaseReadObs = client.readDatabase(databaseLink, null);
        Observable<ResourceResponse<Database>> databaseExistenceObs = databaseReadObs.doOnNext(x -> {
            System.out.println("database " + databaseName + " already exists.");
        }).onErrorResumeNext(e -> {
            if (e instanceof DocumentClientException) {
                DocumentClientException de = (DocumentClientException) e;
                if (de.getStatusCode() == 404) {
                    System.out.println("database " + databaseName + " doesn't exist," + " creating it...");
                    Database dbDefinition = new Database();
                    dbDefinition.setId(databaseName);
                    return client.createDatabase(dbDefinition, null);
                }
            }
            System.err.println("Reading database " + databaseName + " failed.");
            return Observable.error(e);
        });
        databaseExistenceObs.toCompletable().await();
        System.out.println("Checking database " + databaseName + " completed!\n");
    }
    
    public static void close() {
        executorService.shutdown();
        client.close();
    }
    ```

10. Within the Main method, add the following lines of code to create and dispose of the AsyncDocumentClient instance

    ```java
    try {
        p.createDatabase();
        System.out.println(String.format("Database created, please hold while resources are released"));
    } catch (Exception e) {
        System.err.println(String.format("Cosmos DB GetStarted failed with %s", e));
    } finally {
        System.out.println("close the client");
        p.close();
    }
    System.exit(0);
    ```

11. Your final App.java file should look like this

    ```java
    package com.mslearn;
    import java.util.ArrayList;
    import java.util.Collection;
    import java.util.List;
    import java.util.concurrent.CountDownLatch;
    import java.util.concurrent.ExecutorService;
    import java.util.concurrent.Executors;
    import com.microsoft.azure.cosmosdb.ConnectionPolicy;
    import com.microsoft.azure.cosmosdb.ConsistencyLevel;
    import com.microsoft.azure.cosmosdb.DataType;
    import com.microsoft.azure.cosmosdb.Database;
    import com.microsoft.azure.cosmosdb.DocumentClientException;
    import com.microsoft.azure.cosmosdb.DocumentCollection;
    import com.microsoft.azure.cosmosdb.IncludedPath;
    import com.microsoft.azure.cosmosdb.Index;
    import com.microsoft.azure.cosmosdb.IndexingPolicy;
    import com.microsoft.azure.cosmosdb.PartitionKeyDefinition;
    import com.microsoft.azure.cosmosdb.RequestOptions;
    import com.microsoft.azure.cosmosdb.ResourceResponse;
    import com.microsoft.azure.cosmosdb.rx.AsyncDocumentClient;
    import rx.Observable;
    import rx.Scheduler;
    import rx.schedulers.Schedulers;
    
    /**
     * Hello world!
     *
     */
    public class App 
    {
        private static final String databaseName = "Products";
        private static ExecutorService executorService;
        private static Scheduler scheduler;
        private static AsyncDocumentClient client;
    
        public static void main( String[] args )
        {
            executorService = Executors.newFixedThreadPool(100);
            scheduler = Schedulers.from(executorService);
            client = new AsyncDocumentClient.Builder().withServiceEndpoint("YOUR_URI")
            .withMasterKeyOrResourceToken("YOUR_KEY")
            .withConnectionPolicy(ConnectionPolicy.GetDefault()).withConsistencyLevel(ConsistencyLevel.Eventual)
            .build();
            try {
                createDatabase();
                System.out.println(String.format("Database created, please hold while resources are released"));
            } catch (Exception e) {
                System.err.println(String.format("Cosmos DB GetStarted failed with %s", e));
            } finally {
                System.out.println("close the client");
                close();
            }
            System.exit(0);
        }
    
        private static void createDatabase() throws Exception {
            String databaseLink = String.format("/dbs/%s", databaseName);
            Observable<ResourceResponse<Database>> databaseReadObs = client.readDatabase(databaseLink, null);
            Observable<ResourceResponse<Database>> databaseExistenceObs = databaseReadObs.doOnNext(x -> {
                System.out.println("database " + databaseName + " already exists.");
            }).onErrorResumeNext(e -> {
                if (e instanceof DocumentClientException) {
                    DocumentClientException de = (DocumentClientException) e;
                    if (de.getStatusCode() == 404) {
                        System.out.println("database " + databaseName + " doesn't exist," + " creating it...");
                        Database dbDefinition = new Database();
                        dbDefinition.setId(databaseName);
                        return client.createDatabase(dbDefinition, null);
                    }
                }
                System.err.println("Reading database " + databaseName + " failed.");
                return Observable.error(e);
            });
            databaseExistenceObs.toCompletable().await();
            System.out.println("Checking database " + databaseName + " completed!\n");
        }
    
        public static void close() {
            executorService.shutdown();
            client.close();
        }
    }
    
    ```
    Make sure you use the correct values for YOUR_URI and YOUR_KEY.

12. Save your changes by typing Ctrl+S or selecting Save from the Cloud Shell Editor menu on the upper right. 

13. Compile and run your Java application

    ```bash
    mvn compile
    mvn exec:java -Dexec.mainClass=com.mslearn.App
    ```

14. Your Application will create a new database. The console will show this output:

    ```bash
    SLF4J: See http://www.slf4j.org/codes.html#StaticLoggerBinder for further details.
    database Products doesn't exist, creating it...
    Checking database Products completed!
    
    Database created, please hold while resources are released
    close the client
    ```

15. Now that a Database exists, we'll add the code to add a Container. Below the Class declaration, add the following variables:

    ```java
    private static final String collectionId = "Clothing";
    private static final String partitionKeyPath = "/type";
    private static final int throughPut = 400;
    ```

    You'll have seven class variables. The new name of the collection is defined by collectionId and partitionKeyPath indicates the partition key.

16. Now create another method within the class, below the createDatabase() method, to define the multi-partition parameters. This will set indexing policy for your collection, and include the partition key and collection id:

    ```java
    private static DocumentCollection getMultiPartitionCollectionDefinition() {
        DocumentCollection collectionDefinition = new DocumentCollection();
        collectionDefinition.setId(collectionId);
    
        PartitionKeyDefinition partitionKeyDefinition = new PartitionKeyDefinition();
        List<String> paths = new ArrayList<>();
        paths.add(partitionKeyPath);
        partitionKeyDefinition.setPaths(paths);
        collectionDefinition.setPartitionKey(partitionKeyDefinition);
    
        // Set indexing policy to be range for string and number
        IndexingPolicy indexingPolicy = new IndexingPolicy();
        Collection<IncludedPath> includedPaths = new ArrayList<>();
        IncludedPath includedPath = new IncludedPath();
        includedPath.setPath("/*");
        Collection<Index> indexes = new ArrayList<>();
        Index stringIndex = Index.Range(DataType.String);
        stringIndex.set("precision", -1);
        indexes.add(stringIndex);
    
        Index numberIndex = Index.Range(DataType.Number);
        numberIndex.set("precision", -1);
        indexes.add(numberIndex);
        includedPath.setIndexes(indexes);
        includedPaths.add(includedPath);
        indexingPolicy.setIncludedPaths(includedPaths);
        collectionDefinition.setIndexingPolicy(indexingPolicy);
    
        return collectionDefinition;
    }
    ```

17. Now, below this method, add another method that will create the multi partition collection and also set the throughput value:

    ```java
    public static void createMultiPartitionCollection() throws Exception {
        RequestOptions multiPartitionRequestOptions = new RequestOptions();
        multiPartitionRequestOptions.setOfferThroughput(throughPut);
        String databaseLink = String.format("/dbs/%s", databaseName);
    
        Observable<ResourceResponse<DocumentCollection>> createCollectionObservable = client.createCollection(
            databaseLink, getMultiPartitionCollectionDefinition(), multiPartitionRequestOptions);
    
        final CountDownLatch countDownLatch = new CountDownLatch(1);
    
        createCollectionObservable.single() // We know there is only single result
                .subscribe(collectionResourceResponse -> {
                    System.out.println(collectionResourceResponse.getActivityId());
                    countDownLatch.countDown();
                }, error -> {
                    System.err.println(
                            "an error occurred while creating the collection: actual cause: " + error.getMessage());
                    countDownLatch.countDown();
                });
        System.out.println("creating collection...");
        countDownLatch.await();
    }
    ```

18. Finally, update the try catch block on your *main* method to add a call to the new createMultiPartitionCollection() method. The new try catch block should look like this:

    ```java
    try {
            createDatabase();
            System.out.println(String.format("Database created, please hold while resources are released"));
            createMultiPartitionCollection();
        } catch (Exception e) {
            System.err.println(String.format("Cosmos DB GetStarted failed with %s", e));
        } finally {
            System.out.println("close the client");
            close();
        }
        System.exit(0);
    ```

19. Save your changes by typing Ctrl+S or selecting Save from the Cloud Shell Editor menu on the upper right. 

20. Compile and run your Java application

    ```bash
    mvn compile
    mvn exec:java -Dexec.mainClass=com.mslearn.App
    ```

21. You now have a new collection on your database. Your console output should look like:

    ```bash
    SLF4J: See http://www.slf4j.org/codes.html#StaticLoggerBinder for further details.
    database Products already exists.
    Checking database Products completed!
    
    Database created, please hold while resources are released
    creating collection...
    21f90092-5c5c-46f2-afc8-5177971a70c7
    close the client
    ```

::: zone-end

::: zone pivot="cli"

## Create an Azure Cosmos DB account + database with the Azure CLI

The first thing we need to do is create an empty Azure Cosmos DB database and container to work with. We want them to match the ones you created in the last module in this Learning Path: a database named **"Products"** and a container named **"Clothing"**. Use the following instructions and the Azure Cloud Shell on the right side of the screen to recreate the database.


We'll start by creating an environment variable to hold the Azure Cosmos DB account name so you don't have to type the same value each time in the following commands. The database account name must be unique across all Azure Cosmos DB instances.

### Create the Azure Cosmos DB account

We'll use the Azure CLI `cosmosdb create` command to create a new Azure Cosmos DB account. The command accepts the following parameters:

| Parameter | Required | Description |
|---|---|---|
| `--name`  | Yes | The unique name for the resource. |
| `--kind`  | No | Kind of database, we'll use _GlobalDocumentDB_. |
| `--resource-group` | Yes | The resource group that owns this database. Normally you would create one in your Azure subscription, but in this case, we're using the Azure Sandbox and a Resource Group named **<rgn>[sandbox Resource Group]</rgn>** has been created for you. |

1. Paste the following command into the Cloud Shell on the right to create to generate a random Azure Cosmos DB account name and store it in an environment variable to use later.

    ```azurecli
    export NAME=cosmos$RANDOM
    ```

1. Use the following command into the Cloud Shell on the right to create a new Azure Cosmos DB account with your specified name.

    ```azurecli
    az cosmosdb create \
        --name $NAME \
        --kind GlobalDocumentDB \
        --resource-group <rgn>[sandbox resource group name]</rgn>
    ```

    [!include[](../../../includes/azure-cloudshell-copy-paste-tip.md)]

    The command takes a few minutes to complete.

    The cloud shell displays the settings as a JSON object for the new account once it's deployed - something like the following:

    ```json
    {
      "capabilities": [],
      "consistencyPolicy": {
        "defaultConsistencyLevel": "Session",
        "maxIntervalInSeconds": 5,
        "maxStalenessPrefix": 100
      },
      "databaseAccountOfferType": "Standard",
      "documentEndpoint": "https://xyz.documents.azure.com:443/",
      "enableAutomaticFailover": false,
      "enableMultipleWriteLocations": false,
      "failoverPolicies": [
        {
          "failoverPriority": 0,
          "id": "xyz-southcentralus",
          "locationName": "South Central US"
        }
      ],
      ...
    }
    ```

1. Create the `Products` database in the account using the `cosmosdb database create` command. It takes a `db-name` parameter that we'll set to **"Products"** since this database will hold the inventory data.

    ```azurecli
    az cosmosdb sql database create \
        --account-name $NAME \
        --name "Products" \
        --resource-group <rgn>[sandbox resource group name]</rgn>
    ```

    This command won't take long and should produce something like:

    ```json
    {
      "_colls": "colls/",
      "_etag": "\"00005d64-0000-0500-0000-5cdc936d0000\"",
      "_rid": "hxoKAA==",
      "_self": "dbs/hxoKAA==/",
      "_ts": 1557959533,
      "_users": "users/",
      "id": "Products"
    }
    ```

1. Finally, create the `Clothing` container with the `cosmosdb collection create` command in the Cloud Shell.

    ```azurecli
    az cosmosdb sql container create \
        --account-name $NAME \
        --database-name "Products" \
        --name "Clothing" \
        --partition-key-path "/productId" \
        --throughput 1000 \
        --resource-group <rgn>[sandbox resource group name]</rgn>
    ```

Now that you have your Azure Cosmos DB account, database, and container, let's go add some data!


::: zone-end

## Summary

In this unit, you used your knowledge of partition keys and request units to create a database and container with throughput and scaling settings appropriate for your business needs.
