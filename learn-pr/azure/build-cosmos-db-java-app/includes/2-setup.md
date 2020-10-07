In this unit, you will create a basic console app using an IDE of your choice to edit code, and optionally using the terminal of your choice to run the code.

## Create Azure Cosmos DB resources

For completing this lab, Microsoft Learn provides you with a free Azure sandbox in which you can create accounts and resources. You will set up an Azure Cosmos DB account in this subscription and then create a database and container.

1. Log in to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) using the same account you activated the sandbox with.
1. Using the Azure portal, create an Azure Cosmos DB account with the name of your choice. When the opportunity arrives to choose a resource group for your account, find the resource group <rgn>[Sandbox resource group]</rgn> and select that.
1. In your Azure Cosmos DB account, create a database **Users**.
1. In the database **Users**, create a container **WebCustomers**. Provision **400 RU/s** for **WebCustomers**.

## Create your working directory

::: zone pivot="Java"

1. We provide you with a template for your Java application. Clone the template repo onto your system

    ```
    git clone https://github.com/MicrosoftDocs/mslearn-cosmos-java-sql.git
    ```

1. Open the Windows Explorer and navigate to the cloned repo. Enter the **java** subdirectory.

    > [!IMPORTANT]  
    > All of your work for this module will be under the **java** subdirectory. 
    >

1. The template contains a Maven **pom.xml** which already pulls in the required dependencies for your project. Open this file and examine it to find the dependency below:

    ```xml
    <dependency>
        <groupId>com.azure</groupId>
        <artifactId>azure-cosmos</artifactId>
        <version>latest</version>
    </dependency>
    ```

    This dependency pulls in the Azure Cosmos DB Java SDK latest version. You can close this file.

::: zone-end

::: zone pivot="Spring Data"

1. We provide you with a template for your Java application. Clone the template repo onto your system

    ```
    git clone https://github.com/MicrosoftDocs/mslearn-cosmos-java-sql.git
    ```

1. Open the Windows Explorer and navigate to the cloned repo. Enter the **spring** subdirectory.

    > [!IMPORTANT]  
    > All of your work for this module will be under the **spring** subdirectory. 
    >

1. The template contains a Maven **pom.xml** which already pulls in the required dependencies for your project. Open this file and examine it to find the dependency below:

    ```xml
    <dependency>
      <groupId>com.azure</groupId>
      <artifactId>azure-spring-data-cosmos</artifactId>
      <version>latest</version>
    </dependency>
    ```

    This dependency pulls in the latest version of Spring Data Azure Cosmos DB. You can close this file.

::: zone-end

1. Next, you will build and run Hello World. Using your IDE or the terminal, open this project. Depending on your IDE, there may be an option to open the **pom.xml** file in the **java** subdirectory as a project. Once the project is open, navigate to **src/main/java/com/azure/azure-cosmos-java-sql-app-mslearn** and open **CosmosApp.java** which is a template for the Java application we will develop. It should look something like this

    ```java
    import org.slf4j.Logger;
    import org.slf4j.LoggerFactory;

    public final class CosmosApp {

        /** For application to log INFO and ERROR. */
        private static Logger logger = LoggerFactory.getLogger(CosmosApp.class.getSimpleName());

        private CosmosApp() {
            // not called
        }

        /**
        * Main.
        * @param args Command line arguments
        */
        public static void main(final String[] args) {
            logger.info("Hello World.");
        }
    }
    ```

    As-is, the application code implements a simple "Hello world".

1. **If your IDE offers tools to build and run your Maven application** - then build and run your application using the IDE, and confirm that the application logs `Hello World` to the terminal.

1. **If you will use the terminal to build and run** -

    Execute

    ```bash
    mvn clean package
    ```

    to build the Maven project. Then execute

    ```bash
    mvn exec:java -Dexec.mainClass="com.azure.cosmos.examples.mslearnbasicapp.CosmosApp"  
    ```

    and confirm that the application logs

    ```output
    INFO: Hello World.
    ```

    to the terminal.

## Connect the app to Azure Cosmos DB

1. Within the `CosmosApp` class, create the following static class variables for your Azure Cosmos DB connection details:

    ```java
    /** Azure Cosmos DB endpoint URI. */
    private static String endpointUri = "<your-cosmosdb-hostname>";

    /** Azure Cosmos DB primary key. */
    private static String primaryKey = "<your-cosmosdb-master-key>";
    ```

1. Return to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true), navigate to the **Keys** blade, and copy-paste your Azure Cosmos DB endpoint URI and primary key into the variable definitions above. For example, if your uri is `https://cosmosacct.documents.azure.com:443/`, your new variable assignment will look like this: `private static String endpointUri = "https://cosmosacct.documents.azure.com:443/";`. If your primary key is `elzirrKCnXlacvh1CRAnQdYVbVLspmYHQyYrhx0PltHi8wn5lHVHFnd1Xm3ad5cn4TUcH4U0MSeHsVykkFPHpQ==`, your new variable assignment will look like this: `private static String primaryKey = "elzirrKCnXlacvh1CRAnQdYVbVLspmYHQyYrhx0PltHi8wn5lHVHFnd1Xm3ad5cn4TUcH4U0MSeHsVykkFPHpQ==";`.

## Create the CosmosAsyncClient

Now it's time to create an instance of the `CosmosAsyncClient`, which is the client-side representation of the Azure Cosmos DB service. This client is used to configure and execute requests against the service.

1. In **CosmosApp.java**, add the following static variable declaration to the `CosmosApp` class:

    ```java
    /** Azure Cosmos DB client instance. */
    private static CosmosAsyncClient client;

    /** Azure Cosmos DB database instance. */
    private static CosmosAsyncDatabase database;

    /** Azure Cosmos DB container instance. */
    private static CosmosAsyncContainer container;
    ```

    Most likely the `client`, `database` and `container` classes are not yet imported into your Java file, so it is a good time to take care of that now. Some IDEs may allow you to auto-import dependencies based on the code you type and that can be useful here. Regardless, in general, expect that when we give you a block of code to paste in, you may need to add some `import` statements in order for it to work.


1. Create a `private void` method `basicOperations` with no arguments in the class. 

1. Add the following code to create a `CosmosAsyncClient` in the `basicOperations` method, and include code to check whether the **Users** database exists.

    ```java
     client = new CosmosClientBuilder()
         .endpoint(endpointUri)
         .key(primaryKey)
         .consistencyLevel(ConsistencyLevel.EVENTUAL)
         .directMode()
         .contentResponseOnWriteEnabled(true)
         .buildAsyncClient();

     database = client.getDatabase("Users");
     container = database.getContainer("WebCustomers");            

     logger.info("Database and container validation complete");

     client.close();
    ```

1. At this point, your `basicOperations` method contains the code to interact with Azure Cosmos DB. However this method is not called in `main`, so our application still serves to print "Hello World". As a check, build and run **CosmosApp.java** in the IDE or execute the program in the terminal using 

    ```bash
    mvn clean package
    mvn exec:java -Dexec.mainClass="com.azure.cosmos.examples.mslearnbasicapp.CosmosApp"  
    ```

    and confirm that the app still logs

    ```output
    INFO: Hello World.
    ```

    to the terminal.

1. Copy and paste the following code into the `main` method, overwriting the current `logger.info("Hello world.");` line.

    ```java
    try {
        CosmosApp p = new CosmosApp();
        p.basicOperations();
    } catch (CosmosException e) {
        logger.error("Failed while executing app.", e);
    } finally {
        logger.info("End of demo, press any key to exit.");
    }
    ```

    This will trigger the Azure Cosmos DB code in our application.

1. Build and run **CosmosApp.java** in the IDE or execute the program in the terminal using 

    ```bash
    mvn clean package
    mvn exec:java -Dexec.mainClass="com.azure.cosmos.examples.mslearnbasicapp.CosmosApp"  
    ```

    You may see a large number of log messages in the terminal, some of which are generated by the SDK itself. Read through and confirm that the app logs to the terminal:

    ```output
    INFO: Database and container validation complete
    ```

In this unit, you set up the groundwork for your Azure Cosmos DB Java application. You set up your Maven application, created a basic "Hello World" project, and extended it to connect the project to the Azure Cosmos DB endpoint.
