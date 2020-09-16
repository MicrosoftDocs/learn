In this unit, you will create a basic console app using an IDE of your choice to edit code, and optionally using the terminal of your choice to run the code.

## Create Azure Cosmos DB resources

For completing this lab, Microsoft Learn provides you with a free Azure sandbox in which you can create accounts and resources. You will set up an Azure Cosmos DB account in this subscription and then create a database and container.

1. Log in to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) using the same account you activated the sandbox with.
1. Using the Azure portal, create an Azure Cosmos DB account with the name of your choice. When the opportunity arrives to choose a resource group for your account, find the resource group <rgn>[Sandbox resource group]</rgn> and select that.
1. In your Azure Cosmos DB account, create a database **Users**.
1. In the database **Users**, create a container **WebCustomers**. Provision **400 RU/s** for **WebCustomers**.

## Create your working directory

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
      <artifactId>azure-spring-data-2-3-cosmos</artifactId>
      <version>latest</version>
    </dependency>
    ```

    This dependency pulls in the latest version of Spring Data Azure Cosmos DB. You can close this file.

1. Next, you will build and run Hello World. Using your IDE or the terminal, open this project. Depending on your IDE, there may be an option to open the **pom.xml** file in the **spring** subdirectory as a project. Once the project is open, navigate to **src\main\java\com\azure\spring\data\cosmos** and open **CosmosApp.java** which is a template for the Java application we will develop. It should look something like this

    ```java
    import org.slf4j.Logger;
    import org.slf4j.LoggerFactory;
    import org.springframework.beans.factory.annotation.Autowired;
    import org.springframework.boot.CommandLineRunner;
    import org.springframework.boot.SpringApplication;
    import org.springframework.boot.autoconfigure.SpringBootApplication;
    import reactor.core.publisher.Flux;

    import java.util.Iterator;

    @SpringBootApplication
    public class SampleApplication implements CommandLineRunner {

        private final Logger logger = LoggerFactory.getLogger(SampleApplication.class);

        public static void main(String[] args) {
            SpringApplication.run(SampleApplication.class, args);
        }

        public void run(String... var1) {

            logger.info("Hello world.");
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
    mvn spring-boot:run
    ```

    and confirm that the application logs

    ```output
    INFO: Hello World.
    ```

    to the terminal.

## Connect the app to Azure Cosmos DB

1. Return to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true), navigate to the **Keys** blade, and find your Azure Cosmos DB connection details (URI and master key). 
1. Navigate to **src\main\resources**
1. Open **application.properties**. Find the `cosmos.uri` and `cosmos.key` properties and input your Azure Cosmos DB connection details. For example, if your uri is `https://cosmosacct.documents.azure.com:443/`, your property assignment will look like this: `cosmos.uri=https://cosmosacct.documents.azure.com:443/`. If your primary key is `elzirrKCnXlacvh1CRAnQdYVbVLspmYHQyYrhx0PltHi8wn5lHVHFnd1Xm3ad5cn4TUcH4U0MSeHsVykkFPHpQ==`, your property assignment will look like this: `cosmos.key=${ACCOUNT_KEY}=elzirrKCnXlacvh1CRAnQdYVbVLspmYHQyYrhx0PltHi8wn5lHVHFnd1Xm3ad5cn4TUcH4U0MSeHsVykkFPHpQ==`.
    
    > [!IMPORTANT]  
    > This demonstrates a major benefit of the Spring Data interface - your dataset endpoint, credentials, database and container names live in a properties file and write no code to handle this basic configuration. Spring Data automatically connects to your Azure Cosmos DB endpoint and accesses your database and container.
    >

## Test your app's connection to Azure Cosmos DB

1. Build and run **CosmosApp.java** in the IDE or execute the program in the terminal using 

    ```bash
    mvn clean package
    mvn spring-boot:run
    ```

    and if all is well your application will log

    ```output
    INFO: Hello World.
    ```

    to the terminal, and you will see no error messages recording Azure Cosmos DB connectivity. If that is the case, congratulations! Your Spring Data app is connected to Azure Cosmos DB.

    > [!IMPORTANT]  
    > This demonstrates a major benefit of the Spring Data interface - your dataset endpoint, credentials, database and container names live in a properties file. Unlike when you work directly with Azure Cosmos DB Java SDK, with Spring Data you write no code to handle these basic configurations. At startup Spring Data automatically connects to the specified Azure Cosmos DB endpoint and accesses your database and container, based on the configuration in your properties file. This kind of simplicity is an attractive aspect of Spring Data Azure Cosmos DB and the Spring Data interface in general.
    >

In this unit, you set up the groundwork for your Spring Data Azure Cosmos DB application. You set up your Maven application, created a basic "Hello World" project, and with a little bit of very simple configuration, extended it to connect the project to your Azure Cosmos DB endpoint.
