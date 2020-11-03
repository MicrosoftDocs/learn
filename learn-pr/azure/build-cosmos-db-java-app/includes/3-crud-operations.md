You've made the connection to Azure Cosmos DB. In this unit, you'll create user documents in your `WebCustomers` collection. Then, you'll retrieve the documents by ID, replace them, and delete them.

::: zone pivot="java"

## Working with documents programmatically

Data is stored in JSON documents in Azure Cosmos DB. [Documents](https://docs.microsoft.com/azure/cosmos-db/databases-containers-items#azure-cosmos-items) can be created, retrieved, replaced, or deleted in the portal or programmatically. This lab focuses on programmatic operations. Azure Cosmos DB provides client-side SDKs for .NET, .NET Core, Java, Node.js, and Python, each of which supports these operations. In this module, we'll use the Java SDK to perform CRUD (create, retrieve, update, and delete) operations on the NoSQL data stored in Azure Cosmos DB.

The main operations for Azure Cosmos DB documents are part of the [CosmosAsyncContainer](https://docs.microsoft.com/java/api/com.azure.cosmos.cosmosasynccontainer?view=azure-java-stable) class:
* [createItem](https://docs.microsoft.com/java/api/com.azure.cosmos.cosmosasynccontainer.createitem?view=azure-java-stable#com_azure_cosmos_CosmosAsyncContainer__T_createItem_T_com_azure_cosmos_models_PartitionKey_com_azure_cosmos_models_CosmosItemRequestOptions_)
* [readItem](https://docs.microsoft.com/java/api/com.azure.cosmos.cosmosasynccontainer.readitem?view=azure-java-stable#com_azure_cosmos_CosmosAsyncContainer__T_readItem_java_lang_String_com_azure_cosmos_models_PartitionKey_com_azure_cosmos_models_CosmosItemRequestOptions_java_lang_Class_T__)
* [replaceItem](https://docs.microsoft.com/java/api/com.azure.cosmos.cosmosasynccontainer.replaceitem?view=azure-java-stable#com_azure_cosmos_CosmosAsyncContainer__T_replaceItem_T_java_lang_String_com_azure_cosmos_models_PartitionKey_com_azure_cosmos_models_CosmosItemRequestOptions_)
* [upsertItem](https://docs.microsoft.com/java/api/com.azure.cosmos.cosmosasynccontainer.upsertitem?view=azure-java-stable#com_azure_cosmos_CosmosAsyncContainer__T_upsertItem_T_com_azure_cosmos_models_CosmosItemRequestOptions_)
* [deleteItem](https://docs.microsoft.com/java/api/com.azure.cosmos.cosmosasynccontainer.deleteitem?view=azure-java-stable#com_azure_cosmos_CosmosAsyncContainer_deleteItem_java_lang_String_com_azure_cosmos_models_PartitionKey_com_azure_cosmos_models_CosmosItemRequestOptions_)

Upsert performs a create or replace operation, depending on whether the document already exists.

To perform any of these operations, you'll need helper classes (Java POJO classes) that represent the objects stored in the database. Because we're working with a database of users, you'll want to have a `User` class that represents user entities. This class will store primary data such as their first name, last name, and user ID. (The ID is required because that's the partition key to enable horizontal scaling.)

Each user has some associated shipping preferences and coupons, so you'll want `ShippingPreference` and `CouponsUsed` datatypes to represent those entities. Finally, each user might have some order history that is potentially unbounded, so you'll want to have separate `OrderHistory` entities with a corresponding Java POJO class.

Go to **src/main/java/com/azure/azure-cosmos-java-sql-app-mslearn** and look in the **datatypes** folder. You'll see several POJOs: `User`, `ShippingPreference`, `OrderHistory`, and `CouponsUsed`. So we've provided all of the entity POJOs and their helper classes!

Next we'll create some entities and perform some basic CRUD operations on the Azure Cosmos DB container and the documents that it contains. You can pass Azure Cosmos DB a Jackson `ObjectNode` instance that directly specifies the JSON document. But Azure Cosmos DB is also capable of serializing Java POJOs into JSON, and we recommend this approach as the simplest option (all else being equal).

## Create documents

1. Open **User.java** and examine its contents. It should look something like this:

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

    Observe that the access methods for the `id`, `userId`, and other fields are *implicit* (not defined in code). This behavior is possible because we use Project Lombok `@Data` annotation to create them automatically.

    The `@NoArgsConstructor` annotation will generate a constructor with no arguments that sets default field values. The `@AllArgsConstructor` annotation will generate another constructor with a full set of arguments to specify all field values directly.

    Note that `User` has an `id` property. All Azure Cosmos DB documents require an `id` property, so all POJOs we intend to serialize into JSON documents must have an `id` field.

1. Add the following method to **CosmosApp.java**:

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

1. Return to the `basicOperations` method and add the following to the end of that method, *before* the `client.close()` call.

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

1. Build and run **CosmosApp.java** in the IDE, or run the program in the terminal by using: 

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

    You might see some additional text emitted by the logger, such as timestamps.

Congratulations! You've created your first data in Azure Cosmos DB from a Java application. Let's pause and evaluate what you did here.

In `basicOperations`, there are three new actions:

1. Create the *maxaxam* `User` instance.
1. Create the *nelapin* `User` instance.
1. Call `createUserDocumentsIfNotExist`, passing in *maxaxam* and *nelapin* in a list. 

Calling `createUserDocumentsIfNotExist` inserts both `User` instances as items/documents in Azure Cosmos DB. In having you pass the `User` instances as a list, our intent is to model a performant method for ingesting POJOs quickly into Azure Cosmos DB, using minimum compute resources. `createUserDocumentsIfNotExist` implements efficient async insertion of a list of POJOs. 

Suppose that our goal is to maximize requests/second per thread. For comparison, the sync approach to writing `createUserDocumentsIfNotExist` - ignoring for a moment the `readItem` check - would be to iterate over each `User` instance in `users`. For each `User` `u`, we'd make a *blocking* call to `createItem`:

```java
container.createItem(u, new PartitionKey(u.getUserId()), new CosmosItemRequestOptions()).block(); // <= Note the .block() which loops until request response.
```

This sync style implements an intuitive process: *issue request*, *wait for response*, *issue next request*. However, `createUserDocumentsIfNotExist` doesn't use this approach because blocking calls will essentially waste CPU cycles during the request response time, causing low requests/second. 

You might get around this requests/second issue by spawning multiple threads to make parallel blocking request calls. The multiple threads will bring an execution-time improvement. But if your goal is to be thrifty with thread resources, then this is still wasteful. Each thread loops during request response time when it could instead be multitasking to something else, giving you low requests/second per thread.

For this reason, and for the purpose of showing you thread-efficient insertion of Java POJOs, we have instead provided an async example of document insertion. Azure Cosmos DB Java SDK v4 async support comes from [Project Reactor](https://projectreactor.io/), a Java application framework that provides a stream-based, *declarative dataflow* programming model for async event-driven programming. `createDocumentsIfNotExist` implements Project Reactor async programming. 

In `createUserDocumentsIfNotExist`, `Flux.fromIterable(users)` is a Project Reactor factory method. It creates a `Flux` instance that's a source of async events. In this case, each async "event" includes a `User` instance argument. The `Flux` instance contains two such events, one for *maxaxam* and one for *nelapin*. The code inside `.flatMap( ... ).blockLast();` defines a *pipeline* of sequential operations to be performed on the events emitted by the `Flux` instance. 

One of those operations is `createItem`. The idea is that this pipeline is almost identical to the synchronous implementation except that we don't block on the `createItem` call. Specifically, the call to `blockLast()` *subscribes* to the assembled pipeline, causing the `Flux` to *asynchronously* emit its two events. Then the pipeline inside `.flatMap( ... ).blockLast();` processes each of those events in a pseudo-parallel fashion. When one request is issued and waits for a response, Project Reactor will process other requests in the background, which is the critical factor in maxing out requests/second per thread.

Now that we've demonstrated efficient async database requests with Project Reactor, the rest of this lab will use blocking (sync) calls for simplicity. To learn more about Project Reactor, see the Azure Cosmos DB [Reactor Pattern Guide](https://github.com/Azure-Samples/azure-cosmos-java-sql-api-samples/blob/master/reactor-pattern-guide.md).

## Read documents

1. To read documents from the database, add the following method to `CosmosApp`:

    ```java
    /**
     * Take in a Java POJO argument, extract ID and partition key, and read the corresponding document from the container.
     * In this case the ID is the partition key.
     * @param user User POJO to pull ID and partition key from.
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

1. Build and run **CosmosApp.java** in the IDE, or run the program in the terminal by using: 

    ```bash
    mvn clean package
    mvn exec:java -Dexec.mainClass="com.azure.cosmos.examples.mslearnbasicapp.CosmosApp"
    ```

    The terminal displays the following output, where "Read user 1" indicates that the document was retrieved.

    ```output
    INFO: Database and container validation complete
    INFO: User 1 already exists in the database
    INFO: User 2 already exists in the database
    INFO: Read user 1
    ```

    You might also see some additional text emitted by the logger.

## Replace documents

Azure Cosmos DB supports replacing JSON documents. In this case, we'll update a user record to account for a change to their last name.

1. Add the `replaceUserDocument` method after the `readUserDocument` method in the **CosmosApp.java** file.

    ```java
    /**
     * Take in a Java POJO argument, extract ID and partition key,
     * and replace the existing document with the same ID and partition key to match.
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

1. Build and run **CosmosApp.java** in the IDE, or run the program in the terminal by using: 

    ```bash
    mvn clean package
    mvn exec:java -Dexec.mainClass="com.azure.cosmos.examples.mslearnbasicapp.CosmosApp"
    ```

    The terminal displays the following output, where "Replaced last name for Suh" indicates that the document was replaced.

    ```output
    INFO: Database and container validation complete
    INFO: User 1 already exists in the database
    INFO: User 2 already exists in the database
    INFO: Read user 1
    INFO: Replaced last name for Suh
    ```

## Delete documents

1. Copy and paste the `deleteUserDocument` method under your `replaceUserDocument` method.

    ```java
    /**
     * Take in a Java POJO argument, extract ID and partition key,
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

1. Copy and paste the following code to the end of the `basicOperations` method.

    ```java
    deleteUserDocument(maxaxam);
    ```

1. Build and run **CosmosApp.java** in the IDE, or run the program in the terminal by using: 

    ```bash
    mvn clean package
    mvn exec:java -Dexec.mainClass="com.azure.cosmos.examples.mslearnbasicapp.CosmosApp"
    ```

    The terminal displays the following output, where "Deleted user 1" indicates that the document was deleted.

    ```output
    INFO: Database and container validation complete
    INFO: User 1 already exists in the database
    INFO: User 2 already exists in the database
    INFO: Read User 1
    INFO: Replaced last name for Suh
    INFO: Deleted User 1
    ```

::: zone-end

::: zone pivot="spring"

## Working with documents programmatically

Data is stored in JSON documents in Azure Cosmos DB. [Documents](https://docs.microsoft.com/azure/cosmos-db/databases-containers-items#azure-cosmos-items) can be created, retrieved, replaced, or deleted in the portal or programmatically. This lab focuses on programmatic operations. All of this operations are available in Azure Cosmos DB Java SDK and are also accessible through the Spring Data programming model. In this module, we'll use Spring Data Azure Cosmos DB to perform CRUD (create, retrieve, update, and delete) operations on the NoSQL data stored in Azure Cosmos DB.

The main operations for Spring Data Azure Cosmos DB documents are basic operations in the Spring Data programming model:
* `save` - point-write or update a document, depending on whether the document already exists.
* `view` -  point-read a document
* `delete` - point-delete a document

To perform any of these operations, you'll need helper classes (Java POJO classes) that represent the objects stored in the database. Because we're working with a database of online customers, you'll want to use the `WebCustomer` class to represent user entities. This class will store primary data such as their first name, last name, and user ID. (The ID is required because that's the partition key to enable horizontal scaling.)

Each web customer has some associated shipping preferences and coupons, so you'll want `ShippingPreference` and `CouponsUsed` datatypes to represent those entities. Finally, each web customer might have some order history that is potentially unbounded, so you'll want to have separate `OrderHistory` entities with a corresponding Java POJO class.

Go to **src/main/java/com/azure/cosmos/examples/springexamples**. You will see the `WebCustomer` POJO. Now look in the **common** folder. You'll see several POJOs: `ShippingPreference`, `OrderHistory`, and `CouponsUsed`. So we've provided all of the entity POJOs and their helper classes!

Next we'll create some entities and perform some basic CRUD operations on the Azure Cosmos DB container and the documents that it contains. You can pass Azure Cosmos DB a Jackson `ObjectNode` instance that directly specifies the JSON document. But Azure Cosmos DB is also capable of serializing Java POJOs into JSON, and we recommend this approach as the simplest option (all else being equal).

## Create and update documents

1. Open **WebCustomer.java** and examine its contents. It should look something like this:

    ```java
    // Copyright (c) Microsoft Corporation. All rights reserved.
    // Licensed under the MIT License.
    package com.azure.cosmos.examples.springexamples;

    import com.azure.cosmos.examples.springexamples.common.CouponsUsed;
    import com.azure.cosmos.examples.springexamples.common.OrderHistory;
    import com.azure.cosmos.examples.springexamples.common.ShippingPreference;
    import com.azure.spring.data.cosmos.core.mapping.Container;
    import com.azure.spring.data.cosmos.core.mapping.PartitionKey;
    import lombok.AllArgsConstructor;
    import lombok.Data;
    import lombok.NoArgsConstructor;

    import java.util.List;

    @Data
    @NoArgsConstructor
    @AllArgsConstructor
    @Container(containerName = "WebCustomer", ru = "400")
    public class WebCustomer {

        /** Document ID (required by Azure Cosmos DB). */
        private String id;

        /** WebCustomer ID. */
        private String userId;

        /** WebCustomer last name. */
        @PartitionKey
        private String lastName;

        /** WebCustomer first name. */
        private String firstName;

        /** WebCustomer email address. */
        private String email;

        /** WebCustomer dividend setting. */
        private String dividend;

        /** WebCustomer shipping preferences. */
        private ShippingPreference shippingPreference;

        /** WebCustomer order history. */
        private List<OrderHistory> orderHistory;

        /** Coupons recorded by the user. */
        private List<CouponsUsed> coupons;
    }
    ```

    Observe that the access methods for the `id`, `userId`, and other fields are *implicit* (not defined in code). This behavior is possible because we use Project Lombok `@Data` annotation to create them automatically.

    The `@NoArgsConstructor` annotation will generate a constructor with no arguments that sets default field values. The `@AllArgsConstructor` annotation will generate another constructor with a full set of arguments to specify all field values directly.

    Note that `WebCustomer` has an `id` property. All Azure Cosmos DB documents require an `id` property, so all POJOs we intend to serialize into JSON documents must have an `id` field.

1. Add the following method to **CosmosSample.java**:

    ```java
    /**
     * Take in list of Java POJOs and insert them into the database.
     * @param webCustomers List of WebCustomer POJOs to insert.
     */
    private void createWebCustomerDocumentsIfNotExist(final List<WebCustomer> webCustomers) {
        Flux.fromIterable(webCustomers).flatMap(webCustomer -> {
            logger.info("Creating WebCustomer {}", webCustomer.getId());
            return this.reactiveWebCustomerRepository.save(webCustomer);
        }).blockLast();
    }
    ```

1. Find the `run` method and add the following code to the end of that method.

    ```java
    WebCustomer maxaxam = new WebCustomer(
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

    WebCustomer nelapin = new WebCustomer(
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

    createWebCustomerDocumentsIfNotExist(new ArrayList(Arrays.asList(maxaxam, nelapin)));
    ```

1. Build and run **CosmosSample.java** in the IDE, or run the program in the terminal by using: 

    ```bash
    mvn clean package
    mvn spring-boot:run
    ```

    Amidst the terminal output, you should see

    ```output
    INFO: Database and container validation complete
    INFO: Creating User 1
    INFO: Creating User 2
    ```

Congratulations! You've created and/or updated your first data in Azure Cosmos DB from a Java application. Let's pause and evaluate what you did here.

In `run`, there are three new actions:

1. Create/update the *maxaxam* `WebCustomer` instance.
1. Create/update the *nelapin* `WebCustomer` instance.
1. Call `createWebCustomerDocumentsIfNotExist`, passing in *maxaxam* and *nelapin* in a list. 

Calling `createWebCustomerDocumentsIfNotExist` inserts both `WebCustomer` instances as items/documents in Azure Cosmos DB. In having you pass the `WebCustomer` instances as a list, our intent is to model a performant method for ingesting POJOs quickly into Azure Cosmos DB, using minimum compute resources. `createWebCustomerDocumentsIfNotExist` implements efficient async insertion of a list of POJOs. If either document already exists, then `save` will accomplish an update instead of a document create.

Suppose that our goal is to maximize requests/second per thread. For comparison, the sync approach to writing `createWebCustomerDocumentsIfNotExist` would be to iterate over each `WebCustomer` instance in `webCustomers`. For each `WebCustomer` `webCustomer`, we'd make a *blocking* call to `save`:

```java
this.reactiveWebCustomerRepository.save(webCustomer).block(); // <= Note the .block() which loops until request response.
```

This sync style implements an intuitive process: *issue request*, *wait for response*, *issue next request*. However, `createWebCustomerDocumentsIfNotExist` doesn't use this approach because blocking calls will essentially waste CPU cycles during the request response time, causing low requests/second. 

You might get around this requests/second issue by spawning multiple threads to make parallel blocking request calls. The multiple threads will bring an execution-time improvement. But if your goal is to be thrifty with thread resources, then this is still wasteful. Each thread loops during request response time when it could instead be multitasking to something else, giving you low requests/second per thread.

For this reason, and for the purpose of showing you thread-efficient insertion of Java POJOs, we have instead provided an async example of document insertion. Spring Data async support comes from [Project Reactor](https://projectreactor.io/), a Java application framework that provides a stream-based, *declarative dataflow* programming model for async event-driven programming. `createWebCustomerDocumentsIfNotExist` implements Project Reactor async programming. 

In `createWebCustomerDocumentsIfNotExist`, `Flux.fromIterable(webCustomers)` is a Project Reactor factory method. It creates a `Flux` instance that's a source of async events. In this case, each async "event" includes a `WebCustomer` instance argument. The `Flux` instance contains two such events, one for *maxaxam* and one for *nelapin*. The code inside `.flatMap( ... ).blockLast();` defines a *pipeline* of sequential operations to be performed on the events emitted by the `Flux` instance. 

In this case, the two operations in the pipeline are `save` calls. The idea is that this pipeline is almost identical to the synchronous implementation except that we don't block on the `save` call. Specifically, the call to `blockLast()` *subscribes* to the assembled pipeline, causing the `Flux` to *asynchronously* emit its two events. Then the pipeline inside `.flatMap( ... ).blockLast();` processes each of those events in a pseudo-parallel fashion. When one request is issued and waits for a response, Project Reactor will process other requests in the background, which is the critical factor in maxing out requests/second per thread.

Now that we've demonstrated efficient async database requests with Project Reactor, the rest of this lab will use blocking async calls (effectively sync calls) for simplicity. To learn more about Project Reactor, see the Azure Cosmos DB [Reactor Pattern Guide](https://github.com/Azure-Samples/azure-cosmos-java-sql-api-samples/blob/master/reactor-pattern-guide.md).

## Read documents

1. To read documents from the database, add the following method to `CosmosSample`:

    ```java
    /**
     * Take in a Java POJO argument, extract ID and partition key, and read the corresponding document from the container.
     * In this case the ID is the partition key.
     * @param webCustomer User POJO to pull ID and partition key from.
     */
    private WebCustomer readWebCustomerDocument(final WebCustomer webCustomer) {
        WebCustomer webCustomerResult = null;

        try {
            logger.info("Read webCustomer {}", webCustomer.getId());
            webCustomerResult = this.reactiveWebCustomerRepository.findById(webCustomer.getId(), new PartitionKey(webCustomer.getLastName())).block();
        } catch (CosmosException de) {
            logger.error("Failed to read webCustomer {}", webCustomer.getId(), de);
        }

        return webCustomer;
    }
    ```

1. Copy and paste the following code to the end of the `run` method, after the document creation code:

    ```java
    readWebCustomerDocument(maxaxam);
    ```

1. Build and run **CosmosSample.java** in the IDE, or run the program in the terminal by using: 

    ```bash
    mvn clean package
    mvn spring-boot:run
    ```

    Amidst the terminal output, you should see the following. "Read user 1" indicates that the document was retrieved.

    ```output
    INFO: Database and container validation complete
    INFO: User 1 already exists in the database
    INFO: User 2 already exists in the database
    INFO: Read user 1
    ```

## Delete documents

1. Copy and paste the `deleteWebCustomerDocument` method under your `readWebCustomerDocument` method.

    ```java
    /**
     * Take in a Java POJO argument, extract ID and partition key,
     * and delete the corresponding document.
     * @param webCustomer User POJO representing the document update.
     */
    private void deleteWebCustomerDocument(final WebCustomer webCustomer) {
        try {
            this.reactiveWebCustomerRepository.deleteById(webCustomer.getId(),new PartitionKey(webCustomer.getLastName())).block();
            logger.info("Deleted webCustomer {}", webCustomer.getId());
        } catch (CosmosException de) {
            logger.error("User {} could not be deleted.", webCustomer.getId());
        }
    }
    ```

1. Copy and paste the following code to the end of the `run` method.

    ```java
    deleteWebCustomerDocument(maxaxam);
    ```

1. Build and run **CosmosSample.java** in the IDE, or run the program in the terminal by using: 

    ```bash
    mvn clean package
    mvn spring-boot:run
    ```

    Amidst the terminal output, you should see the following. "Deleted user 1" indicates that the document was deleted.

    ```output
    INFO: Database and container validation complete
    INFO: User 1 already exists in the database
    INFO: User 2 already exists in the database
    INFO: Read User 1
    INFO: Replaced last name for Suh
    INFO: Deleted User 1
    ```


::: zone-end

In this unit, you created, updated, read and deleted documents in your Azure Cosmos DB database.
