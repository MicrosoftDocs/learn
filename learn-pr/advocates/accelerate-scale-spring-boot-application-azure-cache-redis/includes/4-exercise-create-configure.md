In this unit, you create a Spring Boot application that uses Spring Data Redis to store and retrieve data from Azure Cache for Redis. You can create the application, except for the final connection to Azure Cache for Redis, while you wait for your Azure Cache for Redis instance to finish deploying.

## Create the Spring Boot project

To create your Spring Boot project, run the following [Spring Initializr](https://start.spring.io/) command line:

```bash
curl https://start.spring.io/starter.tgz -d type=maven-project -d dependencies=web,data-redis -d baseDir=spring-redis-application -d bootVersion=2.4.1.RELEASE -d javaVersion=1.8 | tar -xzvf -
```

> [!NOTE]
> The command uses `Spring Web` and `Spring Data Redis` components. `Spring Data Redis` uses the [Lettuce](https://github.com/lettuce-io/lettuce-core) Redis driver, which you can also use for more advanced tasks.

## Add Spring code to manage data

1. In your Spring Boot project, next to the *DemoApplication* class, add a *Todo*  domain object as follows:

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

1. Create a Spring Data Redis repository called *TodoRepository* to manage this collection, as follows:

   ```java
   package com.example.demo;
   
   import org.springframework.data.repository.CrudRepository;
   import org.springframework.stereotype.Repository;
   
   @Repository
   public interface TodoRepository extends CrudRepository<Todo, String> {
   
   }
   ```

1. Add a Spring MVC controller called *TodoController*, as follows:

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

## Get Azure Cache for Redis security keys

1. Run the following command to check whether your Azure Cache for Redis instance is ready to use.

   ```azurecli
   az redis show --name $AZ_REDIS_NAME --resource-group $AZ_RESOURCE_GROUP
   ```

   The command returns JSON data that contains a `provisioningState` attribute. When `provisioningState` has the value `Succeeded`, your Azure Cache for Redis instance is fully available.

   >[!TIP]
   >If you have the [jq](https://stedolan.github.io/jq/) utility, you can use the following single command line to check readiness:
   >
   >```azurecli
   >az redis show --name $AZ_REDIS_NAME --resource-group $AZ_RESOURCE_GROUP | jq '.provisioningState'
   >```

1. When the Azure Cache for Redis instance is ready, run the following command to retrieve its security keys:

   ```azurecli
   az redis list-keys \
       --resource-group $AZ_RESOURCE_GROUP \
       --name $AZ_REDIS_NAME
   ```

   Copy the `primaryKey` value from the output to use in the next step.

## Configure Spring Boot to connect to Azure Cache for Redis

Open the *src/main/resources/application.properties* configuration file in your application and add the following properties. Replace the `<redisName>` placeholder with your Redis instance name, and replace the `<redisPrimaryKey>` placeholder with the `primaryKey` value you got from the previous step.

```yaml
spring.redis.host=<redisName>.redis.cache.windows.net
spring.redis.password=<redisPrimaryKey>
spring.redis.port=6380
spring.redis.ssl=true
```

## Test the application locally

1. Run your Spring Boot application, either by running the executable *DemoApplication* in your development environment or by running the Spring Boot Maven plug-in as follows:

   ```bash
   ./mvnw spring-boot:run
   ```

1. With the application running, store some data in Redis by using the following command:

   ```bash
   curl -d '{"description":"a description", "details":"some details"}' -H "Content-Type: application/json" -X POST http://127.0.0.1:8080
   ```

1. Now retrieve that data from Redis:

   ```bash
   curl http://127.0.0.1:8080
   ```

Go on to the next unit to learn how to use Azure Cache for Redis to store HTTP session data through Spring Session.
