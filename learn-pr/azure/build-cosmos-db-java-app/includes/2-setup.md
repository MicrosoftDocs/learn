In this unit, you will create a basic console app using an IDE of your choice to edit code, and optionally using the terminal of your choice to run the code.

The terminal commands in this lab assume a Windows OS.

## Create Azure Cosmos DB resources

1. In your Azure Cosmos DB account, create a database named **Users** with a container named **WebCustomers**. Provision 400 RU/s throughput on the **Users** container.

## Create your working directory

1. We provide you with a template for your Java application. Clone the template repo onto your system

    ```
    https://github.com/Azure-Samples/azure-cosmos-spring-or-java-sql-mslearn-template.git
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

    This depedency pulls in the Azure Cosmos DB Java SDK latest version. You can close this file.

1. Next, you will build and run Hello World. Using your IDE or the terminal, navigate to **src/main/java/com/azure/azure-cosmos-java-sql-app-mslearn**. In this directory you will find a file named **CosmosApp.java** which is a template for the Java application we will develop, it should look something like this

    ```java
    import org.slf4j.Logger;
    import org.slf4j.LoggerFactory;

    public class CosmosApp {

        protected static Logger logger = LoggerFactory.getLogger(CosmosApp.class.getSimpleName());

        public static void main(String[] args) {
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
    mvn exec:java -Dexec.mainClass="com.azure.azure-cosmos-java-sql-app-mslearn.CosmosApp"  
    ```

    and confirm that the application logs `Hello World` to the terminal.

## Connect the app to Azure Cosmos DB

1. Within the `CosmosApp` class, create the following static class variables for your Azure Cosmos DB connection details:

    ```java
    private static String endpointUri = "<your-cosmosdb-hostname>";
    private static String primaryKey = "<your-cosmosdb-master-key>";
    ```

1. Copy your connection string by clicking the Azure icon on the left, expanding your Concierge Subscription, right-clicking your new Azure Cosmos DB account, and then clicking **Copy Connection String**. Substitute in your Azure Cosmos DB hostname and master key. For example, if your uri is `https://cosmosacct.documents.azure.com:443/`, your new variable assignment will look like this: `private static String endpointUri = "https://cosmosacct.documents.azure.com:443/";`. If your primary key is `elzirrKCnXlacvh1CRAnQdYVbVLspmYHQyYrhx0PltHi8wn5lHVHFnd1Xm3ad5cn4TUcH4U0MSeHsVykkFPHpQ==`, your new variable assignment will look like this: `private static String primaryKey = "elzirrKCnXlacvh1CRAnQdYVbVLspmYHQyYrhx0PltHi8wn5lHVHFnd1Xm3ad5cn4TUcH4U0MSeHsVykkFPHpQ==";`.

## Create the CosmosAsyncClient

Now it's time to create an instance of the `CosmosAsyncClient`, which is the client-side representation of the Azure Cosmos DB service. This client is used to configure and execute requests against the service.

1. In **CosmosApp.java**, add the following static variable declaration to the `CosmosApp` class:

    ```java
    private static CosmosAsyncClient client;
    ```

1. Create a method `basicOperations` in the class. 

1. Add the following code to create a `CosmosAsyncClient` in the `basicOperations` method, and include code to check whether the **Users** database exists.

    ```java
     CosmosAsyncClient client = new CosmosClientBuilder()
         .setEndpoint(endpointUri)
         .setKey(primaryKey)
         .setConsistencyLevel(ConsistencyLevel.EVENTUAL)
         .directMode()
         .buildAsyncClient();

     database = client.getDatabase("Users");
     container = database.getContainer("WebCustomers");            

     System.out.println("Database and container validation complete");

     client.close();
    ```

1. At this point, your `basicOperations` method contains the code to interact with Azure Cosmos DB. However this method is not called in `main`, so our application still serves to print "Hello World". As a check, build and run **CosmosApp.java** in the IDE or execute the program in the terminal using 

    ```bash
    mvn clean package
    mvn exec:java -Dexec.mainClass="com.azure.azure-cosmos-java-sql-app-mslearn.CosmosApp"  
    ```

    and confirm that the app still logs `Hello World` to the terminal.

    This build confirms syntactic correctness.

1. Copy and paste the following code into the `main` method, overwriting the current `logger.info("Hello world.");` line.

    ```java
    try
    {
        CosmosApp p = new CosmosApp();
        p.basicOperations();
    }
    catch (CosmosException e)
    {
        Exception baseException = e.getBaseException();
        logger.error("Error: {}, Message: {}", e.message, baseException.message);
    }
    finally
    {
        logger.info("End of demo, press any key to exit.");
    }
    ```

    This will trigger the Azure Cosmos DB code in our application.

1. Build and run **CosmosApp.java** in the IDE or execute the program in the terminal using 

    ```bash
    mvn clean package
    mvn exec:java -Dexec.mainClass="com.azure.azure-cosmos-java-sql-app-mslearn.CosmosApp"  
    ```

    and confirm that the app logs to the terminal:

    ```output
    Database and container validation complete
    End of demo, press any key to exit.
    ```

In this unit, you set up the groundwork for your Azure Cosmos DB application. You set up your Maven application, created a basic "Hello World" project, and extended it to connect the project to the Azure Cosmos DB endpoint.
