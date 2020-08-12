Visual Studio Code enables you to create a console application by using the integrated terminal and a few short commands.

In this unit, you will create a basic console app using the integrated terminal, retrieve your Azure Cosmos DB connection string from the extension, and then configure the connection from your application to Azure Cosmos DB.

## Create a console app

1. In Visual Studio Code, select **File** > **Open Folder**.

1. Create a new folder named `learning-module` in the location of your choice, and then click **Select Folder**.

1. Ensure that file auto-save is enabled by clicking on the File menu and checking **Auto Save** if it is blank. You will be copying in several blocks of code, and this will ensure you are always operating against the latest edits of your files.

1. Create a pom.xml file with the default dependencies as shown below

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
                <version>4.3.0</version>
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

1. Allow Maven to automatically download the dependencies specified in pom.xml. If prompted by Maven to permit this, allow automatic download.

1. Create a Java source file named **CosmosApp.java**

## Connect the app to Azure Cosmos DB

1. Create a class **CosmosApp** in **CosmosApp.java**

1. Create the following class variables

    ```java
    private static String endpointUri = "<your-cosmosdb-hostname>"
    private static String primaryKey = "<your-cosmosdb-master-key>"
    ```

1. Copy your connection string by clicking the Azure icon on the left, expanding your Concierge Subscription, right-clicking your new Azure Cosmos DB account, and then clicking **Copy Connection String**. Substitute in your Azure Cosmos DB hostname and master key. For example, if your uri is `https://cosmosacct.documents.azure.com:443/`, your new variable assignment will look like this: `private static String endpointUri = "https://cosmosacct.documents.azure.com:443/";`. If your primary key is `elzirrKCnXlacvh1CRAnQdYVbVLspmYHQyYrhx0PltHi8wn5lHVHFnd1Xm3ad5cn4TUcH4U0MSeHsVykkFPHpQ==`, your new variable assignment will look like this: `private static String primaryKey = "elzirrKCnXlacvh1CRAnQdYVbVLspmYHQyYrhx0PltHi8wn5lHVHFnd1Xm3ad5cn4TUcH4U0MSeHsVykkFPHpQ==";`.

## Create the CosmosAsyncClient

Now it's time to create an instance of the `CosmosAsyncClient`, which is the client-side representation of the Azure Cosmos DB service. This client is used to configure and execute requests against the service.

1. In CosmosApp.java, add the following to the beginning of the `CosmosApp` class.

    ```csharp
    private CosmosAsyncClient client;
    ```

1. Create a `main` method in the class. In the main method add `System.out.println("Hello world.");`.

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

     System.out.println("Database and collection validation complete");

     client.close();
    ```

1. Right-click CosmosApp.java and run the program. You should see a message `Hello world.` as the `basicOperations` method is not being called.

1. Copy and paste the following code into the `main` method, overwriting the current `System.out.println("Hello world.");` line.

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

1. In VSCode, again run `CosmosApp.java`

    The console displays the following output.

    ```output
    Database and collection validation complete
    End of demo, press any key to exit.
    ```

In this unit, you set up the groundwork for your Azure Cosmos DB application. You set up your development environment in Visual Studio Code, created a basic "Hello World" project, connected the project to the Azure Cosmos DB endpoint, and ensured your database and collection exist.
