Once the connection to Azure Cosmos DB has been made, the next step is to create, read, replace, and delete the documents that are stored in the database. In this unit, you will create User documents in your `WebCustomer` collection. Then, you'll retrieve them by ID, replace them, and delete them.

## Working with documents programmatically

Data is stored in JSON documents in Azure Cosmos DB. [Documents](https://docs.microsoft.com/azure/cosmos-db/databases-containers-items#azure-cosmos-items) can be created, retrieved, replaced, or deleted in the portal, as shown in the previous module, or programmatically, as described in this module. Azure Cosmos DB provides client-side SDKs for .NET, .NET Core, Java, Node.js, and Python, each of which supports these operations. In this module, we'll be using the Java SDK to perform CRUD (create, retrieve, update, and delete) operations on the NoSQL data stored in Azure Cosmos DB.

The main operations for Azure Cosmos DB documents are part of the [CosmosAsyncContainer](https://docs.microsoft.com/dotnet/api/microsoft.azure.documents.client.documentclient?view=azure-dotnet) class:
* [createItem](https://docs.microsoft.com/java/api/com.azure.cosmos.cosmosasynccontainer.createitem?view=azure-java-stable#com_azure_cosmos_CosmosAsyncContainer__T_createItem_T_com_azure_cosmos_models_PartitionKey_com_azure_cosmos_models_CosmosItemRequestOptions_)
* [readItem](https://docs.microsoft.com/java/api/com.azure.cosmos.cosmosasynccontainer.readitem?view=azure-java-stable#com_azure_cosmos_CosmosAsyncContainer__T_readItem_java_lang_String_com_azure_cosmos_models_PartitionKey_com_azure_cosmos_models_CosmosItemRequestOptions_java_lang_Class_T__)
* [replaceItem](https://docs.microsoft.com/java/api/com.azure.cosmos.cosmosasynccontainer.replaceitem?view=azure-java-stable#com_azure_cosmos_CosmosAsyncContainer__T_replaceItem_T_java_lang_String_com_azure_cosmos_models_PartitionKey_com_azure_cosmos_models_CosmosItemRequestOptions_)
* [upsertItem](https://docs.microsoft.com/java/api/com.azure.cosmos.cosmosasynccontainer.upsertitem?view=azure-java-stable#com_azure_cosmos_CosmosAsyncContainer__T_upsertItem_T_com_azure_cosmos_models_CosmosItemRequestOptions_)
* [deleteItem](https://docs.microsoft.com/java/api/com.azure.cosmos.cosmosasynccontainer.deleteitem?view=azure-java-stable#com_azure_cosmos_CosmosAsyncContainer_deleteItem_java_lang_String_com_azure_cosmos_models_PartitionKey_com_azure_cosmos_models_CosmosItemRequestOptions_)

Upsert performs a create or replace operation depending on whether the document already exists.

To perform any of these operations, you need to create a class that represents the object stored in the database. Because we're working with a database of users, you'll want to create a **User** class to store primary data such as their first name, last name, and user id (which is required, as that's the partition key to enable horizontal scaling) and classes for shipping preferences and order history.

Once you have those classes created to represent your users, you'll create new user documents for each instance, and then we'll perform some basic CRUD operations on the documents.

## Create documents

1. Next we will insert documents into Azure Cosmos DB. Note that you can pass Azure Cosmos DB a Jackson `ObjectNode` that directly specifies the JSON document, however Azure Cosmos DB is also capable of serializing Java POJOs into JSON. We will utilize the latter functionality in this section.
1. Examine the **com.azure.cosmos.examples.mslearnbasicapp.datatypes** package/directory and you will see several POJOs - **User**, **ShippingPreference**, **OrderHistory**, **CouponsUsed**. **User** depends on all of the other POJOs, and it is the **User** POJO which we will ultimately pass to Azure Cosmos DB Java SDK to be serialized as JSON.
1. Open **User.java** and examine its contents. It should look something like 

    ```java
    import lombok.AllArgsConstructor;
    import lombok.Data;
    import lombok.NoArgsConstructor;

    import java.util.ArrayList;
    import java.util.List;

    @Data
    @NoArgsConstructor
    @AllArgsConstructor
    public class User {
        private String id = "";
        private String userId = "";
        private String lastName = "";
        private String firstName = "";
        private String email = "";
        private String dividend = "";
        private ShippingPreference shippingPreference = new ShippingPreference();
        private List<OrderHistory> orderHistory = new ArrayList<OrderHistory>();
        private List<CouponsUsed> coupons = new ArrayList<CouponsUsed>();
    }
    ```

    Observe that the access methods for the **id**, **userId**, etc. fields are *implicit*. This is possible because we use Project Lombok **@Data** annotation to create them automatically.

    Note that documents must have an **id** property, which will be serialized as **id** in JSON.

1. Build and run **CosmosApp.java** in the IDE or execute the program in the terminal using 

    ```bash
    mvn clean package
    mvn exec:java -Dexec.mainClass="com.azure.cosmos.examples.mslearnbasicapp.CosmosApp"
    ```

    and confirm that it executes without issue.

1. Now add the following method to `CosmosApp.java`:

    ```java
    private static List<Object> createUserDocumentsIfNotExist(List<User> users)
    {
        return Flux.fromIterable(users).flatMap(user -> {
            return Mono.zip(container.readItem(user.getId(), new PartitionKey(user.getUserId()), User.class), Mono.just(user));
        }).flatMap(userResponseTuple -> {
            CosmosItemResponse<User> userReadResponse = userResponseTuple.getT1();
            User user = userResponseTuple.getT2();

            if (userReadResponse.getStatusCode() == 200) {
                logger.info("User {} already exists in the database", user.getId());
                return Mono.just(userReadResponse);
            } else {
                logger.info("Creating User {}", user.getId());
                return Mono.just(container.createItem(user, new PartitionKey(user.getUserId()), new CosmosItemRequestOptions()));
            }
        }).buffer().next().block();
    }
    ```

1. Then, return to the **BasicOperations** method and add the following to the end of that method, *before* the `client.close()` call.

    ```java
    User maxaxam = new User();

    createUserDocumentIfNotExists(maxaxam);

    User nelapin = new User();

    createUserDocumentIfNotExists(nelapin);
    ```

1. Build and run **CosmosApp.java** in the IDE or execute the program in the terminal using 

    ```bash
    mvn clean package
    mvn exec:java -Dexec.mainClass="com.azure.azure-cosmos-java-sql-app-mslearn.CosmosApp"
    ```

    The terminal will display output as the application creates each new user document.

    ```output
    Database and container validation complete
    Created User 1
    Created User 2
    End of demo, press any key to exit.
    ```

    You may see some additional text emitted by the logger as well.

## Read documents

1. To read documents from the database, add the following method to `CosmosApp`

    ```java
    private static CosmosItemResponse<User> readUserDocument(User user)
    {
        try
        {
            CosmosItemResponse<User> userReadResponse = container.readItem(user.getId(), new PartitionKey(user.getUserId()), User.class).block();
            logger.info("Read user {}", user.getId());
            return userReadResponse;
        }
        catch (CosmosExceptioni de)
        {
            logger.error("Failed to read user {}", user.getId(), de);
        }
    }
    ```

1. Copy and paste the following code to the end of the `basicOperations` method, after the document creation code:

    ```java
    readUserDocument(maxaxam);
    ```

1. Build and run **CosmosApp.java** in the IDE or execute the program in the terminal using 

    ```bash
    mvn clean package
    mvn exec:java -Dexec.mainClass="com.azure.azure-cosmos-java-sql-app-mslearn.CosmosApp"
    ```

    The terminal displays the following output, where the output "Read user 1" indicates the document was retrieved.

    ```output
    Database and container validation complete
    User 1 already exists in the database
    User 2 already exists in the database
    Read user 1
    End of demo, press any key to exit.
    ```

    You may see some additional text emitted by the logger as well.

## Replace documents

Azure Cosmos DB supports replacing JSON documents. In this case, we'll update a user record to account for a change to their last name.

1. Add the `replaceUserDocument` method after the `readUserDocument` method in the `CosmosApp.java` file.

    ```java
    private static CosmosItemResponse<User> updatedUserDocument(User user)
    {
        try
        {
            CosmosItemResponse<User> userReplaceResponse = container.replaceItem(user, user.getId(), new PartitionKey(user.getUserId()));
            logger.info("Replaced last name for {}", updatedUser.getLastName());
            return userReplaceResponse;
        }
        catch (CosmosException de)
        {
            logger.error("Failed to read {}", user.getUserId());
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
    mvn exec:java -Dexec.mainClass="com.azure.azure-cosmos-java-sql-app-mslearn.CosmosApp"
    ```

    The terminal displays the following output, where the output "Replaced last name for Suh" indicates the document was replaced.

    ```output
    Database and container validation complete
    User 1 already exists in the database
    Replaced last name for Suh
    User 2 already exists in the database
    Read user 1
    End of demo, press any key to exit.
    ```

## Delete documents

1. Copy and paste the `deleteUserDocument` method underneath your `replaceUserDocument` method.

    ```java
    private static CosmosItemResponse<User> deleteUserDocument(User deletedUser)
    {
        try
        {
            CosmosItemResponse<User> userDeleteResponse = container.deleteItem(deletedUser.getId(), new PartitionKey(deletedUser.getUserId())).block();
            logger.info("Deleted user {}", deletedUser.getId());
        }
        catch (CosmosException de)
        {
            logger.error("User {} not found for deletion", deletedUser.getId());
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
    mvn exec:java -Dexec.mainClass="com.azure.azure-cosmos-java-sql-app-mslearn.CosmosApp"
    ```

    The terminal displays the following output, where the output "Deleted user 1" indicates the document was deleted.

    ```output
    Database and container validation complete
    User 1 already exists in the database
    Replaced last name for Suh
    User 2 already exists in the database
    Read user 1
    Deleted user 1
    End of demo, press any key to exit.
    ```

In this unit you created, replaced, and deleted documents in your Azure Cosmos DB database.
