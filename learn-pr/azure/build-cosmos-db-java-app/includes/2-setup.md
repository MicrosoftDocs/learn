In this unit, you'll create a basic console app by using an IDE of your choice to edit code. You'll optionally use the terminal of your choice to run the code.

## Create Azure Cosmos DB resources

For completing this lab, Microsoft Learn provides a free Azure sandbox in which you can create accounts and resources. You'll set up an Azure Cosmos DB account in this subscription and then create a database and container.

1. Sign in to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) by using the same account that you activated the sandbox with.
1. By using the Azure portal, create an Azure Cosmos DB account with the name of your choice. When the opportunity arrives to choose a resource group for your account, find the resource group <rgn>[Sandbox resource group]</rgn> and select that.
1. In your Azure Cosmos DB account, create a database called **Users**.
1. In the **Users** database, create a container called **WebCustomers**. Provision **400 RU/s** for **WebCustomers**.

## Create your working directory

::: zone pivot="java"

1. We provide a template for your Java application. Clone the template repo onto your system.

    ```
    git clone https://github.com/MicrosoftDocs/mslearn-cosmos-java-sql.git
    ```

1. Open Windows File Explorer and go to the cloned repo. Enter the **java_lab** subdirectory.

    > [!IMPORTANT]  
    > All of your work for this module will be under the **java_lab** subdirectory. 
    >

1. The template contains a Maven **pom.xml** file that already pulls in the required dependencies for your project. Open this file and examine it to find the following dependency:

    ```xml
    <dependency>
        <groupId>com.azure</groupId>
        <artifactId>azure-cosmos</artifactId>
        <version>4.8.0</version>
    </dependency>
    ```

    This dependency pulls in the latest version of the Azure Cosmos DB Java SDK. You can close this file.

1. Next, you'll build and run Hello World. By using your IDE or the terminal, open this project. Depending on your IDE, there might be an option to open the **pom.xml** file in the **java** subdirectory as a project. 

    After the project is open, go to **src/main/java/com/azure/azure-cosmos-java-sql-app-mslearn** and open **CosmosApp.java**, which is a template for the Java application that we'll develop. It should look something like this:

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

    As is, the application code implements a simple "Hello World."

1. *If your IDE offers tools to build and run your Maven application*: Build and run your application by using the IDE, and confirm that the application logs `Hello World` to the terminal.

1. *If you'll use the terminal to build and run your Maven application*: Use the following command to build the Maven project:

    ```bash
    mvn clean package
    ```

    Then run:

    ```bash
    mvn exec:java -Dexec.mainClass="com.azure.cosmos.examples.mslearnbasicapp.CosmosApp"  
    ```

    Confirm that the application logs the following output to the terminal:

    ```output
    INFO: Hello World.
    ```

## Connect the app to Azure Cosmos DB

1. Within the `CosmosApp` class, create the following static class variables for your Azure Cosmos DB connection details:

    ```java
    /** Azure Cosmos DB endpoint URI. */
    private static String endpointUri = "<your-cosmosdb-hostname>";

    /** Azure Cosmos DB primary key. */
    private static String primaryKey = "<your-cosmosdb-master-key>";
    ```

1. Return to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true), go to the **Keys** pane, and copy/paste your Azure Cosmos DB endpoint URI and primary key into the preceding variable definitions. 

    For example, if your URI is `https://cosmosacct.documents.azure.com:443/`, your new variable assignment will look like this: `private static String endpointUri = "https://cosmosacct.documents.azure.com:443/";`. If your primary key is `elzirrKCnXlacvh1CRAnQdYVbVLspmYHQyYrhx0PltHi8wn5lHVHFnd1Xm3ad5cn4TUcH4U0MSeHsVykkFPHpQ==`, your new variable assignment will look like this: `private static String primaryKey = "elzirrKCnXlacvh1CRAnQdYVbVLspmYHQyYrhx0PltHi8wn5lHVHFnd1Xm3ad5cn4TUcH4U0MSeHsVykkFPHpQ==";`.

## Create the CosmosAsyncClient instance

Now it's time to create an instance of `CosmosAsyncClient`, which is the client-side representation of the Azure Cosmos DB service. This client is used to configure and execute requests against the service.

1. In **CosmosApp.java**, add the following static variable declaration to the `CosmosApp` class:

    ```java
    /** Azure Cosmos DB client instance. */
    private static CosmosAsyncClient client;

    /** Azure Cosmos DB database instance. */
    private static CosmosAsyncDatabase database;

    /** Azure Cosmos DB container instance. */
    private static CosmosAsyncContainer container;
    ```

    Most likely, the `client`, `database`, and `container` classes are not yet imported into your Java file. So it's a good time to take care of that now. Some IDEs might allow you to automatically import dependencies based on the code you type, and that can be useful here. In general, expect that when we give you a block of code to paste in, you might need to add some `import` statements in order for it to work.


1. Create a `private void` method called `basicOperations` with no arguments in the class. 

1. Add the following code to create a `CosmosAsyncClient` instance in the `basicOperations` method, and include code to check whether the **Users** database exists.

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

1. At this point, your `basicOperations` method contains the code to interact with Azure Cosmos DB. However, this method is not called in `main`, so our application still serves to print "Hello World." As a check, build and run **CosmosApp.java** in the IDE or run the program in the terminal by using: 

    ```bash
    mvn clean package
    mvn exec:java -Dexec.mainClass="com.azure.cosmos.examples.mslearnbasicapp.CosmosApp"  
    ```

    Confirm that the app still logs the following output to the terminal:

    ```output
    INFO: Hello World.
    ```

1. Copy and paste the following code into the `main` method, overwriting the current `logger.info("Hello World.");` line.

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

1. Build and run **CosmosApp.java** in the IDE, or run the program in the terminal by using: 

    ```bash
    mvn clean package
    mvn exec:java -Dexec.mainClass="com.azure.cosmos.examples.mslearnbasicapp.CosmosApp"  
    ```

    You might see a large number of log messages in the terminal, some of which are generated by the SDK itself. Read through and confirm that the app logs the following output to the terminal:

    ```output
    INFO: Database and container validation complete
    ```

In this unit, you set up the groundwork for your Azure Cosmos DB Java application. You set up your Maven application, created a basic "Hello World" project, and extended it to connect the project to the Azure Cosmos DB endpoint.

::: zone-end

::: zone pivot="spring"

1. We provide you with a template for your Java application. Clone the template repo onto your system

    ```
    git clone https://github.com/MicrosoftDocs/mslearn-cosmos-java-sql.git
    ```

1. Open the Windows Explorer and navigate to the cloned repo. Enter the **spring_lab** subdirectory.

    > [!IMPORTANT]  
    > All of your work for this module will be under the **spring_lab** subdirectory. 
    >

1. The template contains a Maven **pom.xml** which already pulls in the required dependencies for your project. Open this file and examine it to find the dependency below:

    ```xml
    <dependency>
      <groupId>com.azure</groupId>
      <artifactId>azure-spring-data-cosmos</artifactId>
      <version>3.1.0</version>
    </dependency>
    ```

    This dependency pulls in the latest version of Spring Data Azure Cosmos DB. You can close this file.

1. Next, you'll build and run Hello World. By using your IDE or the terminal, open this project. Depending on your IDE, there might be an option to open the **pom.xml** file in the **spring** subdirectory as a project. 

    After the project is open, go to **src/main/java/com/azure/cosmos/examples/springexamples** and open **CosmosSample.java**, which is a template for the Spring Data application that we'll develop. It should look something like this:

    ```java
    // Copyright (c) Microsoft Corporation. All rights reserved.
    // Licensed under the MIT License.
    package com.azure.cosmos.examples.springexamples;

    import com.azure.cosmos.CosmosException;
    import com.azure.cosmos.examples.springexamples.common.CouponsUsed;
    import com.azure.cosmos.examples.springexamples.common.OrderHistory;
    import com.azure.cosmos.examples.springexamples.common.ShippingPreference;
    import com.azure.cosmos.models.CosmosItemResponse;
    import com.azure.cosmos.models.PartitionKey;
    import org.slf4j.Logger;
    import org.slf4j.LoggerFactory;
    import org.springframework.beans.factory.annotation.Autowired;
    import org.springframework.boot.CommandLineRunner;
    import org.springframework.boot.SpringApplication;
    import org.springframework.boot.autoconfigure.SpringBootApplication;
    import reactor.core.publisher.Flux;
    import reactor.core.publisher.Mono;

    import java.util.ArrayList;
    import java.util.Arrays;
    import java.util.List;

    @SpringBootApplication
    public class CosmosSample implements CommandLineRunner {

        private final Logger logger = LoggerFactory.getLogger(CosmosSample.class);

        @Autowired
        private ReactiveWebCustomerRepository reactiveWebCustomerRepository;

        public static void main(String[] args) {
            SpringApplication.run(CosmosSample.class, args);
        }

        public void run(String... var1) {
            logger.info("Hello world.");
        }
    }
    ```

    As is, the application code implements a simple "Hello World."

1. *If your IDE offers tools to build and run your Maven application*: Build and run your application by using the IDE, and confirm that the application logs `Hello World` to the terminal.

1. *If you'll use the terminal to build and run your Maven application*: Use the following command to build the Maven project:

    ```bash
    mvn clean package
    ```

    Then run:

    ```bash
    mvn spring-boot:run
    ```

    Confirm that the application logs the following output to the terminal, amidst all of the other output:

    ```output
    INFO: Hello World.
    ```

## Connect the app to Azure Cosmos DB

1. Navigate to **src/main/resources/** using a file explorer tool. You should see a file named **application.properties.rename**. Spring Data emphasizes configuration files over hard-coded configuration parameters; to create the configuration file for your Spring Data project, copy **application.properties.rename** to **application.properties** and open the new **application.properties** file. You should see

    ```bash
    cosmos.uri=${ACCOUNT_HOST}
    cosmos.key=${ACCOUNT_KEY}
    cosmos.secondaryKey=${SECONDARY_ACCOUNT_KEY}

    dynamic.collection.name=spel-property-collection
    # Populate query metrics
    cosmos.queryMetricsEnabled=true
    ```

    You are going to populate `${ACCOUNT_HOST}` and `${ACCOUNT_KEY}`, using a method of your choice - either copy-paste the values into **application.properties**, or define these environment variables in your IDE. In the next step you will find the values these variables should have.

1. Return to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true), go to the **Keys** pane, and copy the Azure Cosmos DB endpoint URI and primary key. As discussed in the previous step, use the method of your choice to assign your Azure Cosmos DB endpoint URI and primary key to the aforementioned variables.

    For example, if your URI is `https://cosmosacct.documents.azure.com:443/`, and you choose to paste the endpoint and primary key into **application.properties**, the line in **application.properties** will subsequently look like this: `cosmos.uri=https://cosmosacct.documents.azure.com:443/`. If your primary key is `elzirrKCnXlacvh1CRAnQdYVbVLspmYHQyYrhx0PltHi8wn5lHVHFnd1Xm3ad5cn4TUcH4U0MSeHsVykkFPHpQ==`, then following the same process your new variable assignment will look like this: `cosmos.key=elzirrKCnXlacvh1CRAnQdYVbVLspmYHQyYrhx0PltHi8wn5lHVHFnd1Xm3ad5cn4TUcH4U0MSeHsVykkFPHpQ==`.

## Configure the Azure Cosmos DB client

Spring Data Azure Cosmos DB automatically instantiates the Azure Cosmos DB client at startup. The Azure Cosmos DB client is the client-side representation of the Azure Cosmos DB service, used to execute requests against the service. Your code can configure the Azure Cosmos DB client before it is instantiated, using a set of builder methods along with properties pulled from **application.properties**. 

1. Open **CosmosProperties.java**. We have provided this file in a completed form, so just examine its contents.

    ```java
    @ConfigurationProperties(prefix = "cosmos")
    public class CosmosProperties {

        private String uri;

        private String key;

        private String secondaryKey;

        private boolean queryMetricsEnabled;

        public String getUri() {
            return uri;
        }

        public void setUri(String uri) {
            this.uri = uri;
        }

        public String getKey() {
            return key;
        }

        public void setKey(String key) {
            this.key = key;
        }

        public String getSecondaryKey() {
            return secondaryKey;
        }

        public void setSecondaryKey(String secondaryKey) {
            this.secondaryKey = secondaryKey;
        }

        public boolean isQueryMetricsEnabled() {
            return queryMetricsEnabled;
        }

        public void setQueryMetricsEnabled(boolean enableQueryMetrics) {
            this.queryMetricsEnabled = enableQueryMetrics;
        }
    }
    ```

    Observe the class members `uri`, `key`, `secondaryKey`, `queryMetricsEnabled`. Looking back at **application.properties**, **observe that the `CosmosProperties` member names correspond closely to the application.properties property names**. The `CosmosProperties` class presents getters and setters for the rest of your application to access configuration settings from **application.properties**. Notice there is no code here to pull the config from **application.properties** - Spring Data understands the structure of this file and automatically sets the member variables after parsing the config file.

    We will leverage this setup going forward, when we configure the Azure Cosmos DB client.

1. In **CosmosSampleConfiguration.java**, examine the `CosmosSampleConfiguration` class and find the empty `cosmosClientBuilder` method:

    ```java
    @Bean
    public CosmosClientBuilder cosmosClientBuilder() {
        return null;
    }
    ```

    At startup, Spring Data will automatically call this method, obtain the `CosmosClientBuilder` which this method returns, and call its `build()` method - at which point (under the hood) a `CosmosAsyncClient` instance will be created based on the configuration settings contained within the `CosmosClientBuilder`. You can use this method to configure the `CosmosClientBuilder` using builder methods.

1. Notice how near the top of `CosmosSampleConfiguration` we declare an "autowired" `CosmosProperties` variable, `properties`

    ```java
    @Autowired
    private CosmosProperties properties;
    ```
    
    Notice there is no definition of this variable in the code - once again, `@Autowired` signals Spring Data to instantiate this variable automatically *and populate its member variables with parsed values from the configuration file*. We can use `properties` to get the *uri* and *key* for our Azure Cosmos DB account and implement `cosmosClientBuilder` as shown below:

    ```java
    @Bean
    public CosmosClientBuilder cosmosClientBuilder() {
        DirectConnectionConfig directConnectionConfig = DirectConnectionConfig.getDefaultConfig();
        return new CosmosClientBuilder()
            .endpoint(properties.getUri())
            .key(properties.getKey())
            .directMode(directConnectionConfig);
    }
    ```

    This implementation
    1. Pulls the *uri* and *key* from `properties`
    1. Plugs them into the `endpoint` and `key` builder methods
    1. Additionally configures the network connection to the Azure Cosmos DB service. (In *direct mode* your client application talks directly to the back-end Azure Cosmos DB partitions.)

1. Return to **CosmosSampleConfiguration.java** and find the `getDatabaseName` method:

    ```java
    @Override
    protected String getDatabaseName() { return ""; }
    ```

    Change the default return value to `"Users"`, the name of your database. This way, when Spring Data automatically connects to Azure Cosmos DB at startup, it will connect to the **Users* database.

1. Navigate to **WebCustomer.java**. You will notice that the `WebCustomer` class is preceded by an `@Container` annotation:

    ```java
    @Container(containerName = "", ru = "")
    ```

    `@Container` takes two arguments: 
    * `containerName`: The name of the Azure Cosmos DB container (**WebCustomers**)
    * `ru`: The provisioned throughput on your container. 400 RU/s is a good default for a Microsoft Learn exercise.

    Customize the `@Container` for your use-case, as shown:

    ```java
    @Data
    @NoArgsConstructor
    @AllArgsConstructor
    @Container(containerName = "WebCustomers", ru = "400")
    public class WebCustomer {
    ```

1. At this point, your Spring Data project is set up to interact with Azure Cosmos DB. However, the `run` method does not make use of any functionality, so our application still serves to print "Hello World." As a check, build and run **CosmosSample.java** in the IDE or run the program in the terminal by using: 

    ```bash
    mvn clean package
    mvn spring-boot:run
    ```

    You should see verbose output in the terminal - including indications that your application is connecting to the Azure Cosmos DB service.

    Confirm that the app still logs the following output to the terminal:

    ```output
    INFO: Hello World.
    ```

In this unit, you set up the groundwork for your Azure Cosmos DB Java application. You customized the Maven application and extended a basic "Hello World" project to connect to an Azure Cosmos DB endpoint.

::: zone-end
