Now that you've created documents in your application, let's query them from your application. Azure Cosmos DB Java SDK uses SQL queries; in .NET SDK there is additionally support for LINQ queries but Java SDK has not analogue. This unit focuses on running SQL queries from your application, as opposed to the portal.

We'll use the user documents you've created for your online retailer application to test these queries.

## Run SQL queries

1. The following sample shows how a query could be performed in SQL from your Java code. Copy the code and add it to the end of the `CosmosApp.java` file.

    ```java
    private static void executeSimpleQuery()
    {
        int preferredPageSize = 10;
        CosmosQueryRequestOptions queryOptions = new CosmosQueryRequestOptions();

        CosmosPagedFlux<Family> pagedFluxResponse = container.queryItems(
                "SELECT * FROM User WHERE User.lastName = 'Pindakova'", queryOptions, User.class);

        logger.info("Running SQL query...");

        pagedFluxResponse.byPage(preferredPageSize).flatMap(fluxResponse -> {
            logger.info("Got a page of query result with " +
                    fluxResponse.getResults().size() + " items(s)"
                    + " and request charge of " + fluxResponse.getRequestCharge());

            logger.info("Item Ids " + fluxResponse
                    .getResults()
                    .stream()
                    .map(User::getId)
                    .collect(Collectors.toList()));

            return Flux.empty();
        }).blockLast();
    }
    ```

1. Copy and paste the following code to your `basicOperations` method, **before** the document deletion code.

    ```java
    executeSimpleQuery();
    ```

1. Build and run **CosmosApp.java** in the IDE or execute the program in the terminal using 

    ```bash
    mvn clean package
    mvn exec:java -Dexec.mainClass="com.azure.azure-cosmos-java-sql-app-mslearn.CosmosApp"
    ```

    The console displays the output of the SQL query.

In this unit you learned about SQL queries, and then added a SQL query to your application to retrieve user records.
