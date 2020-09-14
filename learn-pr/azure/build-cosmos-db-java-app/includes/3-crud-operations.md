Once the connection to Azure Cosmos DB has been made, the next step is to create, read, replace, and delete the documents that are stored in the database. In this unit, you will create User documents in your `WebCustomer` collection. Then, you'll retrieve them by ID, replace them, and delete them.

## Working with documents programmatically

Data is stored in JSON documents in Azure Cosmos DB. [Documents](https://docs.microsoft.com/azure/cosmos-db/databases-containers-items#azure-cosmos-items) can be created, retrieved, replaced, or deleted in the portal or programmatically. This lab focuses on programmatic operations. Azure Cosmos DB provides client-side SDKs for .NET, .NET Core, Java, Node.js, and Python, each of which supports these operations. In this module, we'll be using the Java SDK to perform CRUD (create, retrieve, update, and delete) operations on the NoSQL data stored in Azure Cosmos DB.

The main operations for Azure Cosmos DB documents are part of the [CosmosAsyncContainer](https://docs.microsoft.com/java/api/com.azure.cosmos.cosmosasynccontainer?view=azure-java-stable) class:
* [createItem](https://docs.microsoft.com/java/api/com.azure.cosmos.cosmosasynccontainer.createitem?view=azure-java-stable#com_azure_cosmos_CosmosAsyncContainer__T_createItem_T_com_azure_cosmos_models_PartitionKey_com_azure_cosmos_models_CosmosItemRequestOptions_)
* [readItem](https://docs.microsoft.com/java/api/com.azure.cosmos.cosmosasynccontainer.readitem?view=azure-java-stable#com_azure_cosmos_CosmosAsyncContainer__T_readItem_java_lang_String_com_azure_cosmos_models_PartitionKey_com_azure_cosmos_models_CosmosItemRequestOptions_java_lang_Class_T__)
* [replaceItem](https://docs.microsoft.com/java/api/com.azure.cosmos.cosmosasynccontainer.replaceitem?view=azure-java-stable#com_azure_cosmos_CosmosAsyncContainer__T_replaceItem_T_java_lang_String_com_azure_cosmos_models_PartitionKey_com_azure_cosmos_models_CosmosItemRequestOptions_)
* [upsertItem](https://docs.microsoft.com/java/api/com.azure.cosmos.cosmosasynccontainer.upsertitem?view=azure-java-stable#com_azure_cosmos_CosmosAsyncContainer__T_upsertItem_T_com_azure_cosmos_models_CosmosItemRequestOptions_)
* [deleteItem](https://docs.microsoft.com/java/api/com.azure.cosmos.cosmosasynccontainer.deleteitem?view=azure-java-stable#com_azure_cosmos_CosmosAsyncContainer_deleteItem_java_lang_String_com_azure_cosmos_models_PartitionKey_com_azure_cosmos_models_CosmosItemRequestOptions_)

Upsert performs a create or replace operation depending on whether the document already exists.

To perform any of these operations, you will need helper classes (Java POJO classes) that represent the objects stored in the database. Because we're working with a database of users, you'll want to have a **User** class representing user entities. This class will store primary data such as their first name, last name, and user id (which is required, as that's the partition key to enable horizontal scaling). Each user has some shipping preferences and coupons associated, so you will want **ShippingPreference** and **CouponsUsed** datatypes to represent those as well. Finally, each user may have some order history that is potentially unbounded, so want to have separate **OrderHistory** entities with a corresponding Java POJO class.

Navigate to **src/main/java/com/azure/azure-cosmos-java-sql-app-mslearn** and take a look in the **datatypes** folder - you will see several POJOs - **User**, **ShippingPreference**, **OrderHistory**, **CouponsUsed**. So we have provided all of the entity POJOs and their helper classes!

Next we will create some entities and perform some basic CRUD operations on the Azure Cosmos DB container and the documents it contains. Note that while you can pass Azure Cosmos DB a Jackson `ObjectNode` that directly specifies the JSON document, Azure Cosmos DB is also capable of serializing Java POJOs into JSON and we recommend this as the simplest approach all else being equal.

## Create documents

1. Open **User.java** and examine its contents. It should look something like 

    ```java
    import lombok.AllArgsConstructor;
    import lombok.Data;
    import lombok.NoArgsConstructor;

    import java.util.List;

    @Data
    @NoArgsConstructor
    @AllArgsConstructor
    public class User {

        /** Document ID (required by Azure Cosmos DB). */
        private String id;

        /** User ID. */
        private String userId;

        /** User last name. */
        private String lastName;

        /** User first name. */
        private String firstName;

        /** User email address. */
        private String email;

        /** User dividend setting. */
        private String dividend;

        /** User shipping preferences. */
        private ShippingPreference shippingPreference;

        /** User order history. */
        private List<OrderHistory> orderHistory;

        /** Coupons recorded by the user. */
        private List<CouponsUsed> coupons;
    }
    ```

    Observe that the access methods for the **id**, **userId**, etc. fields are *implicit* (not defined in code.) This is possible because we use Project Lombok @**Data** annotation to create them automatically.

    The @**NoArgsConstructor** and @**AllArgsConstructor** annotations will, respectively, generate a constructor with no arguments that sets default field values, and another constructor with a full set of arguments to specify all field values directly.

    Note **User** has an **id** property; all Azure Cosmos DB documents require an **id** property, therefore all POJO we intend to serialize into JSON documents must have an **id** field.

1. Now add the following method to `CosmosApp.java`:

    ```java
    /**
     * Take in list of Java POJOs, check if each exists, and if not insert it.
     * @param users List of User POJOs to insert.
     */
    private static void createUserDocumentsIfNotExist(final List<User> users) {
        Flux.fromIterable(users).flatMap(user -> {
            try {
                container.readItem(user.getId(), new PartitionKey(user.getUserId()), User.class).block();
                logger.info("User {} already exists in the database", user.getId());
                return Mono.empty();
            } catch (Exception err) {
                logger.info("Creating User {}", user.getId());
                return container.createItem(user, new PartitionKey(user.getUserId()), new CosmosItemRequestOptions());
            }
        }).blockLast();
    }
    ```

1. Then, return to the **basicOperations** method and add the following to the end of that method, *before* the `client.close()` call.

    ```java
    User maxaxam = new User(
        "1",
        "maxaxam",
        "Axam",
        "Max",
        "maxaxam@contoso.com",
        "2.0",
        new ShippingPreference(
            1,
            "90 W 8th St",
            "",
            "New York",
            "NY",
            "10001",
            "USA"
        ),
        new ArrayList<OrderHistory>(Arrays.asList(
            new OrderHistory(
                "3",
                "1000",
                "08/17/2018",
                "52.49"
            )
        )),
        new ArrayList<CouponsUsed>(Arrays.asList(
            new CouponsUsed(
                "A7B89F"
            )
        ))
    );

    User nelapin = new User(
            "2",
            "nelapin",
            "Pindakova",
            "Nela",
            "nelapin@contoso.com",
            "8.50",
            new ShippingPreference(
                1,
                "505 NW 5th St",
                "",
                "New York",
                "NY",
                "10001",
                "USA"
            ),
            new ArrayList<OrderHistory>(Arrays.asList(
                new OrderHistory(
                    "4",
                    "1001",
                    "08/17/2018",
                    "105.89"
                )
            )),
            new ArrayList<CouponsUsed>(Arrays.asList(
                new CouponsUsed(
                    "Fall 2018"
                )
            ))
    );

    createUserDocumentsIfNotExist(new ArrayList(Arrays.asList(maxaxam, nelapin)));
    ```

1. Build and run **CosmosApp.java** in the IDE or execute the program in the terminal using 

    ```bash
    mvn clean package
    mvn exec:java -Dexec.mainClass="com.azure.cosmos.examples.mslearnbasicapp.CosmosApp"
    ```

    The terminal will display output as the application creates each new user document.

    ```output
    INFO: Database and container validation complete
    INFO: Creating User 1
    INFO: Creating User 2
    ```

    You may see some additional text emitted by the logger as well, for example timestamps.

1. Congratulations! You have created your first data in Azure Cosmos DB from a Java application. Let's pause and evaluate what you did here.

   In **basicOperations** there are three new actions - create the *maxaxam* `User` instance, create the *nelapin* `User` instance, and finally call `createUserDocumentsIfNotExist` passing in *maxaxam* and *nelapin* in a list. Calling `createUserDocumentsIfNotExist` inserts both `User` instances as items/documents in Azure Cosmos DB. In having you pass the `User` instances as a list, our intent is to model a performant method for ingesting POJOs quickly into Azure Cosmos DB, using minimum compute resources. `createUserDocumentsIfNotExist` implements efficient async insertion of an list of POJOs. 

   Suppose that our goal is to maximize requests/second per thread. For comparison, the sync approach to writing `createUserDocumentsIfNotExist` - ignoring for a moment the `readItem` check - would be to iterate over each `User` in `users`, and for each `User` `u` make a *blocking* call to `createItem` as shown:

    ```java
    container.createItem(u, new PartitionKey(u.getUserId()), new CosmosItemRequestOptions()).block(); // <= Note the .block() which hangs until request response.
    ```

    This sync style implements an intuitive process - *issue request*, *wait for response*, *issue next request*, ... However `createUserDocumentsIfNotExist` does not employ this approach because blocking calls will essentially waste CPU cycles during the request response time, causing low requests/second. You may get around this requests/second issue by spawning multiple threads to make parallel blocking request calls. This will bring an execution-time improvement however if your goal is to be thrifty with thread resources, then this is still wasteful - each thread hangs during request response time when it could instead be multitasking to something else, giving you low requests/second per thread.

    For this reason, and for the purpose of showing you thread-efficient insertion of Java POJOs, we have instead provided an async example of document insertion. Azure Cosmos DB Java SDK v4 async support comes from [Project Reactor](https://projectreactor.io/), a Java framework which provides a stream-based, *declarative dataflow* programming model for async event-driven programming. `createDocumentsIfNotExist` implements Project Reactor async programming. In `createUserDocumentsIfNotExist`, `Flux.fromIterable(users)` is a Project Reactor factory method which creates a `Flux` instance which is a source of async events. In this case, each async "event" includes a `User` instance argument, and the `Flux` contains two such events, one for *maxaxam* and one for *nelapin*. The code inside of `.flatMap( ... ).blockLast();` defines a *pipeline* of sequential operations to be performed on the events emitted by the `Flux`; `createItem` is one of those operations, and the idea is that this pipeline is more or less identical to the synchronous implementation *except we do not block on the `createItem` call*. Specifically, the call to `blockLast()` *subscribes* to the assembled pipeline, causing the `Flux` to *asynchronously* emit its two events, and then the pipeline inside of `.flatMap( ... ).blockLast();` processes each of those events in a pseudo-parallel fashion. When one request is issued and waits for a response, Project Reactor will process other requests in the background, *which is the critical factor in maxing out requests/second per thread*.

    Now that we have demonstrated efficient async database requests with Project Reactor, for simplicity the rest of this lab will use blocking (sync) calls. To learn more about Project Reactor, take a look at the Azure Cosmos DB [Reactor Pattern Guide](https://github.com/Azure-Samples/azure-cosmos-java-sql-api-samples/blob/master/reactor-pattern-guide.md).

## Read documents

1. To read documents from the database, add the following method to `CosmosApp`

    ```java
    /**
     * Take in a Java POJO argument, extract id and partition key, and read the corresponding document from the container.
     * In this case the id is the partition key.
     * @param user User POJO to pull id and partition key from.
     */
    private static CosmosItemResponse<User> readUserDocument(final User user) {
        CosmosItemResponse<User> userReadResponse = null;

        try {
            userReadResponse = container.readItem(user.getId(), new PartitionKey(user.getUserId()), User.class).block();
            logger.info("Read user {}", user.getId());
        } catch (CosmosException de) {
            logger.error("Failed to read user {}", user.getId(), de);
        }

        return userReadResponse;
    }
    ```

1. Copy and paste the following code to the end of the `basicOperations` method, after the document creation code:

    ```java
    readUserDocument(maxaxam);
    ```

1. Build and run **CosmosApp.java** in the IDE or execute the program in the terminal using 

    ```bash
    mvn clean package
    mvn exec:java -Dexec.mainClass="com.azure.cosmos.examples.mslearnbasicapp.CosmosApp"
    ```

    The terminal displays the following output, where the output "Read user 1" indicates the document was retrieved.

    ```output
    INFO: Database and container validation complete
    INFO: User 1 already exists in the database
    INFO: User 2 already exists in the database
    INFO: Read user 1
    ```

    You may see some additional text emitted by the logger as well.

## Replace documents

Azure Cosmos DB supports replacing JSON documents. In this case, we'll update a user record to account for a change to their last name.

1. Add the `replaceUserDocument` method after the `readUserDocument` method in the `CosmosApp.java` file.

    ```java
    /**
     * Take in a Java POJO argument, extract id and partition key,
     * and replace the existing document with the same id and partition key to match.
     * @param user User POJO representing the document update.
     */
    private static void replaceUserDocument(final User user) {
        try {
            CosmosItemResponse<User> userReplaceResponse = container.replaceItem(user, user.getId(), new PartitionKey(user.getUserId())).block();
            logger.info("Replaced User {}", user.getId());
        } catch (CosmosException de) {
            logger.error("Failed to replace User {}", user.getUserId());
        }
    }
    ```

1. Copy and paste the following code to the end of the `basicOperations` method, after the document creation code.

    ```java
    maxaxam.setLastName("Suh");
    replaceUserDocument(maxaxam);
    ```

1. Build and run **CosmosApp.java** in the IDE or execute the program in the terminal using 

    ```bash
    mvn clean package
    mvn exec:java -Dexec.mainClass="com.azure.cosmos.examples.mslearnbasicapp.CosmosApp"
    ```

    The terminal displays the following output, where the output "Replaced last name for Suh" indicates the document was replaced.

    ```output
    INFO: Database and container validation complete
    INFO: User 1 already exists in the database
    INFO: User 2 already exists in the database
    INFO: Read user 1
    INFO: Replaced last name for Suh
    ```

## Delete documents

1. Copy and paste the `deleteUserDocument` method underneath your `replaceUserDocument` method.

    ```java
    /**
     * Take in a Java POJO argument, extract id and partition key,
     * and delete the corresponding document.
     * @param user User POJO representing the document update.
     */
    private static void deleteUserDocument(final User user) {
        try {
            container.deleteItem(user.getId(), new PartitionKey(user.getUserId())).block();
            logger.info("Deleted user {}", user.getId());
        } catch (CosmosException de) {
            logger.error("User {} could not be deleted.", user.getId());
        }
    }
    ```

1. Copy and paste the following code in the end of the `basicOperations` method.

    ```java
    deleteUserDocument(maxaxam);
    ```

1. Build and run **CosmosApp.java** in the IDE or execute the program in the terminal using 

    ```bash
    mvn clean package
    mvn exec:java -Dexec.mainClass="com.azure.cosmos.examples.mslearnbasicapp.CosmosApp"
    ```

    The terminal displays the following output, where the output "Deleted user 1" indicates the document was deleted.

    ```output
    INFO: Database and container validation complete
    INFO: User 1 already exists in the database
    INFO: User 2 already exists in the database
    INFO: Read User 1
    INFO: Replaced last name for Suh
    INFO: Deleted User 1
    ```

In this unit you created, replaced, and deleted documents in your Azure Cosmos DB database.
