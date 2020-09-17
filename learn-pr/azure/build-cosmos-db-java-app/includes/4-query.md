Now that you've created documents in your application, let's query them from your application. The Azure Cosmos DB Java SDK uses SQL queries. The .NET SDK has additional support for LINQ queries, but the Java SDK has no analog. This unit focuses on running SQL queries from your application, as opposed to the portal.

We'll use the user documents that you created for your online retailer application to test these queries.

## Run SQL queries

1. The following sample shows how a query can be performed in SQL from your Java code. Copy the code and add it to the end of the **CosmosApp.java** file.

    ```java
    /**
     * Execute a custom query on the Azure Cosmos DB container.
     * @param query Query String.
     */
    private static void executeSimpleQuery(final String query) {

        final int preferredPageSize = 10;
        CosmosQueryRequestOptions queryOptions = new CosmosQueryRequestOptions();

        CosmosPagedFlux<User> pagedFluxResponse = container.queryItems(
                query, queryOptions, User.class);

        logger.info("Running SQL query...");

        pagedFluxResponse.byPage(preferredPageSize).flatMap(fluxResponse -> {
            logger.info("Got a page of query result with " + fluxResponse.getResults().size()
                    + " items(s) and request charge of " + fluxResponse.getRequestCharge());

            logger.info("Item Ids " + fluxResponse
                    .getResults()
                    .stream()
                    .map(User::getId)
                    .collect(Collectors.toList()));

            return Flux.empty();
        }).blockLast();
    }
    ```

    In this code, notice that we're once again using Project Reactor's declarative dataflow programming model. This time, we're using it to handle query response pages asynchronously. We demonstrate an async approach because in a real use case, there might be hundreds or thousands of responses to a query. Aggregating query responses can be a CPU-intensive task that benefits from the increased thread efficiency of async programming. 
    
    In short, we want high throughput of handling query response pages, or high pages/sec per thread. `queryitems` returns the `CosmosPagedFlux` instance `pagedFluxResponse`, and `pagedFluxResponse.byPage(preferredPageSize)` creates a `Flux` instance that's a source of async page events. The pipeline of operations inside `.flatMap( ... ).blockLast();` operates asynchronously and in pseudo-parallel on the query response page that's associated with each event emitted by the `Flux` instance.

1. Copy and paste the following code to your `basicOperations` method, *before* the document deletion code.

    ```java
    executeSimpleQuery("SELECT * FROM User WHERE User.lastName = 'Pindakova'")
    ```

1. Build and run **CosmosApp.java** in the IDE, or run the program in the terminal by using: 

    ```bash
    mvn clean package
    mvn exec:java -Dexec.mainClass="com.azure.cosmos.examples.mslearnbasicapp.CosmosApp"
    ```

    In the terminal, the output should look something like this:

    ```output
    INFO: Database and container validation complete
    INFO: User 1 already exists in the database
    INFO: User 2 already exists in the database
    INFO: Read User 1
    INFO: Replaced last name for Suh
    INFO: Running SQL query...
    INFO: Got a page of query result with 1 items(s) and request charge of 2.83
    INFO: Item Ids [2]
    INFO: Deleted User 1
    ```

In this unit, you learned about SQL queries. You then added a SQL query to your application to retrieve user records.
