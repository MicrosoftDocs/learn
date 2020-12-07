::: zone pivot="java"

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

    In this code, notice that we're once again using Project Reactor's declarative dataflow programming model. This time, we're using it to handle query response pages asynchronously. We demonstrate an async approach because in a real use-case, there might be hundreds or thousands of responses to a query. Aggregating query responses can be a CPU-intensive task that benefits from the increased thread efficiency of async programming. 
    
    In short, we want high throughput of handling query responses, or high pages/sec per thread. `queryitems` returns the `CosmosPagedFlux` instance `pagedFluxResponse`, and `pagedFluxResponse.byPage(preferredPageSize)` creates a `Flux` instance that's a source of async page events. The pipeline of operations inside `.flatMap( ... ).blockLast();` operates asynchronously and in pseudo-parallel on the query response page that's associated with each event emitted by the `Flux` instance.

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

::: zone-end

::: zone pivot="spring"

Now that you've created documents in your application, let's query them from your application. Spring Data Azure Cosmos DB exposes both derived query methods as well as custom query methods - and both of these build on the SQL-language query capability of the underlying Azure Cosmos DB Java SDK v4.  This unit focuses on running Spring Data Azure Cosmos DB queries from your application, as opposed to the portal.

We'll use the `WebCustomer` documents that you created for your online retailer application to test these queries.

## Create and call derived query methods

*Derived query methods* are Spring Data repository methods with no implementation; instead, the method name signals Spring Data to translate each method call and its arguments into a query on the underlying database. For example, when you call `findById` with some arguments, Spring Data reads the method name as "find by ID" and assembles a database query which returns the document specified by the arguments. 

Spring Data Azure Cosmos DB includes a number of built-in *derived query methods* including `findById`. In this section, we will show how to implement new derived query methods.

1. We will create a derived query method which queries all documents having a certain value for the `firstName` field. Navigate to **ReactiveWebCustomerRepository.java** and paste in the following method *declaration*:

    ```java
    Flux<WebCustomer> findByFirstName(String firstName);
    ```

    This repository method declares to Spring Data that you want a method which queries on `firstName` when it is called. Recall that the `WebCustomer` class began with an `@Container` annotation specifying `containerName` as `WebCustomers`. Since `findByFirstName` returns `Flux<WebCustomer>`, Spring Data knows to query `WebCustomers` when this method is called.

1. Copy and paste the following code to your `run` method, *before* the `deleteWebCustomerDocument` call.

    ```java
    logger.info("Running derived query...");
    Flux<WebCustomer> webCustomers = reactiveWebCustomerRepository.findByFirstName("Max");
    webCustomers.flatMap(webCustomer -> {
        logger.info("- WebCustomer is : {}", webCustomer.getUserId());
        return Mono.empty();
    }).blockLast();
    ```
    
    In this code, notice that we're once again using Project Reactor's declarative dataflow programming model. This time, we're using it to handle query response pages asynchronously. We demonstrate an async approach because in a real use-case, there might be hundreds or thousands of responses to a query. Aggregating query responses can be a CPU-intensive task that benefits from the increased thread efficiency of async programming. 
    
    In short, we want high throughput of handling query responses, or high responses/sec per thread. `findByFirstName` returns the `Flux<WebCustomer>` instance `webCustomers`. The pipeline of operations inside `.flatMap( ... ).blockLast();` operates asynchronously and in pseudo-parallel on the query responses associated with each event emitted by the `Flux<WebCustomer>`.

1. Build and run **CosmosSample.java** in the IDE, or run the program in the terminal by using: 

    ```bash
    mvn clean package
    mvn spring-boot:run
    ```

    In the terminal, the output should look something like this:

    ```output
    INFO: Database and container validation complete
    INFO: User 1 already exists in the database
    INFO: User 2 already exists in the database
    INFO: Read User 1
    INFO: Replaced last name for Suh
    INFO: Running derived query...
    INFO: - WebCustomer is : maxaxam
    INFO: Deleted User 1
    ```

## Create and call custom query methods

*Custom query methods* are Spring Data repository methods with an `@Query` annotation specifying a query string - and the query string contains placeholders for the method arguments. This time, the method name has no impact on what query is performed. The `@Query` annotation signals Spring Data to issue a SQL-language query to the underlying database, *after* filling in the argument placeholders with the values of the method arguments.  

1. We will create a custom query method which queries all documents having a certain value for the `lastName` field. Navigate to **ReactiveWebCustomerRepository.java** and paste in the following method declaration:

    ```java
    @Query(value = "SELECT * FROM User WHERE User.lastName = @lastName")
    Flux<WebCustomer> findByLastName(@Param("lastName") String lastName);
    ```

    This repository method declares to Spring Data that you want a method which queries on `lastName` when it is called. The `lastName` argument value will be substituted for the `@lastName` placeholder.

1. Copy and paste the following code to your `run` method, after the derived query code.

    ```java
    logger.info("Running custom query...");
    webCustomers = reactiveWebCustomerRepository.findByLastName("Axam");
    webCustomers.flatMap(webCustomer -> {
        logger.info("- WebCustomer is : {}", webCustomer.getUserId());
        return Mono.empty();
    }).blockLast();
    ```

1. Build and run **CosmosSample.java** in the IDE, or run the program in the terminal by using: 

    ```bash
    mvn clean package
    mvn spring-boot:run
    ```

    In the terminal, the output should look something like this:

    ```output
    INFO: Database and container validation complete
    INFO: User 1 already exists in the database
    INFO: User 2 already exists in the database
    INFO: Read User 1
    INFO: Replaced last name for Suh
    INFO: Running derived query...
    INFO: - WebCustomer is : maxaxam
    INFO: Running custom query...
    INFO: - WebCustomer is : maxaxam    
    INFO: Deleted User 1
    ```

::: zone-end

In this unit, you learned about derived and custom queries. You then added both query types to your application to retrieve user records.
