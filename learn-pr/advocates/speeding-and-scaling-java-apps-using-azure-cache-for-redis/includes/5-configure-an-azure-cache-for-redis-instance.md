Let's start configuring our Azure Cache for Redis. In this unit, you will connect your Spring Boot application to the Azure Cache for Redis instance that you created earlier.

## Check if your Azure Cache for Redis instance is available

Creating a Redis instance can take some time, and it's time to check if it's now ready to be used. Use the following command to check:

```bash
az redis show --name $AZ_REDIS_NAME --resource-group $AZ_RESOURCE_GROUP
```

This will return a JSON file, containing an attribute named `provisioningState`.

If you have the [jq](https://stedolan.github.io/jq/) utility you can even do this in one line:

```bash
az redis show --name $AZ_REDIS_NAME --resource-group $AZ_RESOURCE_GROUP | jq '.provisioningState'
```

When the `provisioningState` has the value **"Succeeded"**, it means your Redis instance is fully available.

## Configure Spring Boot to connect to Azure Cache for Redis

Once your Redis instance is successfully created, retrieve its security keys:

```bash
az redis list-keys \
    --resource-group $AZ_RESOURCE_GROUP \
    --name $AZ_REDIS_NAME
```

Note the `primaryKey` as we will use it just afterwards.

Now open up the `src/main/resources/application.properties` configuration file, and add the following properties:

```properties
spring.redis.host=<xxxxxxx>.redis.cache.windows.net
spring.redis.password=<xxxxxxx>
spring.redis.port=6380
spring.redis.ssl=true
```

And replace the two `<xxxxxxx>` parameters with the following values:

- The first one is the name of your Redis instance, which you stored in the `$AZ_REDIS_NAME` variable earlier.
- The second one is the key to your Redis instance: this is the `primaryKey` we have just retrieved earlier.

## Test the application locally

You can now run your Spring Boot application, either by running the executable `DemoApplication` within your IDE, or by running the Spring Boot Maven plugin:

```bash
./mvnw spring-boot:run
```

Once the application is running, you can store some data into Redis:

```bash
curl -d '{"description":"a description", "details":"some details"}' -H "Content-Type: application/json" -X POST http://127.0.0.1:8080
```

And you can retrieve that data from Redis:

```bash
curl http://127.0.0.1:8080
```
