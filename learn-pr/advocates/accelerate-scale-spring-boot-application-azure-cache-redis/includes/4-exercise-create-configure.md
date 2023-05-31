In this unit, you create a Spring Boot application that uses Spring Data Redis to store and retrieve data from Azure Cache for Redis.

## Create a Spring Boot project

To create your Spring Boot project, use the following [Spring Initializr](https://start.spring.io/) command line:

```bash
curl https://start.spring.io/starter.tgz -d type=maven-project -d dependencies=web,data-redis -d baseDir=spring-redis-application -d bootVersion=2.4.1.RELEASE -d javaVersion=1.8 | tar -xzvf -
```

> [!NOTE]
> The command uses `Spring Web` and `Spring Data Redis` components. `Spring Data Redis` uses the [Lettuce](https://github.com/lettuce-io/lettuce-core) Redis driver, which you can use for more advanced tasks.

## Add Spring code to manage data

1. Next to the `DemoApplication` class, create a `Todo` domain object:

   ```java
   package com.example.demo;
   
   import org.springframework.data.annotation.Id;
   import org.springframework.data.redis.core.RedisHash;
   
   import java.io.Serializable;
   
   @RedisHash("Todo")
   public class Todo implements Serializable {
   
       public Todo() {
       }
   
       public Todo(String description, String details, boolean done) {
           this.description = description;
           this.details = details;
           this.done = done;
       }
   
       @Id
       private Long id;
   
       private String description;
   
       private String details;
   
       private boolean done;
   
       public Long getId() {
           return id;
       }
   
       public void setId(Long id) {
           this.id = id;
       }
   
       public String getDescription() {
           return description;
       }
   
       public void setDescription(String description) {
           this.description = description;
       }
   
       public String getDetails() {
           return details;
       }
   
       public void setDetails(String details) {
           this.details = details;
       }
   
       public boolean isDone() {
           return done;
       }
   
       public void setDone(boolean done) {
           this.done = done;
       }
   }
   ```

1. Next, create a Spring Data Redis repository to manage this collection, called `TodoRepository`:

   ```java
   package com.example.demo;
   
   import org.springframework.data.repository.CrudRepository;
   import org.springframework.stereotype.Repository;
   
   @Repository
   public interface TodoRepository extends CrudRepository<Todo, String> {
   
   }
   ```

1. Finish coding this application by adding a Spring MVC controller called `TodoController`:

   ```java
    package com.example.demo;
   
   import org.springframework.http.HttpStatus;
   import org.springframework.web.bind.annotation.*;
   
   @RestController
   @RequestMapping("/")
   public class TodoController {
   
       private final TodoRepository todoRepository;
   
       public TodoController(TodoRepository todoRepository) {
           this.todoRepository = todoRepository;
       }
   
       @PostMapping("/")
       @ResponseStatus(HttpStatus.CREATED)
       public Todo createTodo(@RequestBody Todo todo) {
           return todoRepository.save(todo);
       }
   
       @GetMapping("/")
       public Iterable<Todo> findAllTodos() {
           return todoRepository.findAll();
       }
   }
   ```

## Check your Azure Cache for Redis instance

Run the following command to check whether your Azure Cache for Redis instance is ready to use.

```azcli
az redis show --name $AZ_REDIS_NAME --resource-group $AZ_RESOURCE_GROUP
```

The command returns a JSON file that contains an attribute named `provisioningState`. When `provisioningState` has the value `Succeeded`, your Azure Cache for Redis instance is fully available.

If you have the [jq](https://stedolan.github.io/jq/) utility, you can use it to check the readiness in one line.

```azcli
az redis show --name $AZ_REDIS_NAME --resource-group $AZ_RESOURCE_GROUP | jq '.provisioningState'
```

## Configure Spring Boot to connect to Azure Cache for Redis

1. When the Azure Cache for Redis instance is ready, use the following command to retrieve its security keys:

   ```azcli
   az redis list-keys \
       --resource-group $AZ_RESOURCE_GROUP \
       --name $AZ_REDIS_NAME
   ```

   Note the `primaryKey` value to use later.

1. Now open the *src/main/resources/application.properties* configuration file, and add the following properties. Replace the placeholders with these values:

   - `spring.redis.host`: Your Redis instance name, which you stored in the `$AZ_REDIS_NAME` variable earlier.
   - `spring.redis.password`: The `primaryKey` value for your Redis instance, which you noted earlier.

```properties
spring.redis.host=<redisInstanceName>.redis.cache.windows.net
spring.redis.password=<redisPrimaryKey>
spring.redis.port=6380
spring.redis.ssl=true
```


## Test the application locally

1. Run your Spring Boot application, either by running the executable `DemoApplication` within your IDE or by running the Spring Boot Maven plug-in as follows:

   ```bash
   ./mvnw spring-boot:run
   ```

1. After the application is running, store some data in Redis as follows:

   ```bash
   curl -d '{"description":"a description", "details":"some details"}' -H "Content-Type: application/json" -X POST http://127.0.0.1:8080
   ```

1. Retrieve that data from Redis.

   ```bash
   curl http://127.0.0.1:8080
   ```
Proceed to the next unit to use Spring Session to store HTTP session data in Redis.