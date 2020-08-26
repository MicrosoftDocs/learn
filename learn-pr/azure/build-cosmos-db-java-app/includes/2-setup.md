This section assumes 

1. You have already created a Maven project directory with a **src/** directory and an empty **pom.xml** file at the top level.

1. In your Azure Cosmos DB account, you have created a database named **Users** with a container named **WebCustomers**

In this unit, you will create a basic console app using an IDE of your choice to edit code, and optionally using the terminal of your choice to run the code.

The terminal commands in this lab are assuming a Windows OS.

## Build the skeleton of your app

1. First you will create the app directory structure. Under the **src/** directory of your Maven project, create the following directory structure: **src/main/java/com/azure/azure-cosmos-java-sql-app-mslearn**

1. Second, you will set up your Maven **pom.xml**. In your IDE, open the pom.xml file. Paste in the following dependencies shown below:

    ```xml
    <?xml version="1.0" encoding="UTF-8"?>
    <project xmlns="http://maven.apache.org/POM/4.0.0"
            xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
            xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
        <modelVersion>4.0.0</modelVersion>

        <groupId>com.azure</groupId>
        <artifactId>azure-cosmos-java-sql-app-mslearn</artifactId>
        <version>1.0-SNAPSHOT</version>
        <name>MSLearn sample Java app
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
                <version>latest</version>
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

            <dependency>
                <groupId>org.apache.commons</groupId>
                <artifactId>commons-lang3</artifactId>
                <version>3.10</version>
            </dependency>
        </dependencies>
    </project>
    ```

1. Save your changes to **pom.xml**. Depending on your IDE, it may automatically detect the **pom.xml** changes and ask to automatically download the new dependencies using Maven. Allow Maven to automatically download the dependencies specified in **pom.xml**.

1. Third, you will build and run Hello World. Using your IDE or the terminal, navigate to **src/main/java/com/azure/azure-cosmos-java-sql-app-mslearn** and create a Java source file named **CosmosApp.java**

1. Create a class **CosmosApp** in **CosmosApp.java**

1. Create a `main` method in the class. In the main method add `logger.info("Hello world.");`.

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

1. Create the following static class variables for your Azure Cosmos DB connection details

    ```java
    private static String endpointUri = "<your-cosmosdb-hostname>"
    private static String primaryKey = "<your-cosmosdb-master-key>"
    ```

1. Copy your connection string by clicking the Azure icon on the left, expanding your Concierge Subscription, right-clicking your new Azure Cosmos DB account, and then clicking **Copy Connection String**. Substitute in your Azure Cosmos DB hostname and master key. For example, if your uri is `https://cosmosacct.documents.azure.com:443/`, your new variable assignment will look like this: `private static String endpointUri = "https://cosmosacct.documents.azure.com:443/";`. If your primary key is `elzirrKCnXlacvh1CRAnQdYVbVLspmYHQyYrhx0PltHi8wn5lHVHFnd1Xm3ad5cn4TUcH4U0MSeHsVykkFPHpQ==`, your new variable assignment will look like this: `private static String primaryKey = "elzirrKCnXlacvh1CRAnQdYVbVLspmYHQyYrhx0PltHi8wn5lHVHFnd1Xm3ad5cn4TUcH4U0MSeHsVykkFPHpQ==";`.

## Create the CosmosAsyncClient

Now it's time to create an instance of the `CosmosAsyncClient`, which is the client-side representation of the Azure Cosmos DB service. This client is used to configure and execute requests against the service.

1. In **CosmosApp.java**, add the following static variable to the beginning of the `CosmosApp` class, underneath the `logger` variable declaration:

    ```java
    private static CosmosAsyncClient client;
    ```

1. Create a `basicOperations` method in the class. 

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

1. Build and run **CosmosApp.java** in the IDE or execute the program in the terminal using 

    ```bash
    mvn clean package
    mvn exec:java -Dexec.mainClass="com.azure.azure-cosmos-java-sql-app-mslearn.CosmosApp"  
    ```

    and confirm that the app logs `Hello world` to the terminal.

    This build confirms syntactic correctness - the `basicOperations` method is not being called, so we have not created an Azure Cosmos DB client yet.

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
        System.err.println(String.format("Error: %s, Message: %s", e.message, baseException.message));
    }
    finally
    {
        System.out.println("End of demo, press any key to exit.");
    }
    ```

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
