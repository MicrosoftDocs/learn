You'll now create a Spring Boot application that will use Spring Data Redis to store and retrieve data from Azure Cache for Redis.

## Create a Spring Boot project by using Spring Data Redis

To create our Spring Boot project, we'll use [Spring Initializr](https://start.spring.io/) with the command line:

```bash
curl https://start.spring.io/starter.tgz -d dependencies=web,data-redis -d baseDir=spring-redis-application -d bootVersion=2.4.1.RELEASE -d javaVersion=1.8 | tar -xzvf -
```

> [!NOTE]
> We use the `Spring Web` and the `Spring Data Redis` components.
> `Spring Data Redis` uses the [Lettuce](https://github.com/lettuce-io/lettuce-core) Redis driver, and you'll be able to use it for more advanced tasks.

## Add Spring code to manage data by using Spring Data Redis

Next to the `DemoApplication` class, create a `Todo` domain object:

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

Then, create a Spring Data Redis repository to manage this collection, called `TodoRepository`:

```java
package com.example.demo;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface TodoRepository extends CrudRepository<Todo, String> {

}
```

Finish coding this application by adding a Spring MVC controller called `TodoController`:

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

## Check if your Azure Cache for Redis instance is available

Creating an Azure Cache for Redis instance can take a while, and it's time to check if it's now ready to be used. Use the following command to check:

```bash
az redis show --name $AZ_REDIS_NAME --resource-group $AZ_RESOURCE_GROUP
```

This command will return a JSON file that contains an attribute named `provisioningState`.

If you have the [jq](https://stedolan.github.io/jq/) utility, you can even do this command in one line:

```bash
az redis show --name $AZ_REDIS_NAME --resource-group $AZ_RESOURCE_GROUP | jq '.provisioningState'
```

When `provisioningState` has the value `Succeeded`, your Azure Cache for Redis instance is fully available.

## Configure Spring Boot to connect to Azure Cache for Redis

After you've successfully created your Azure Cache for Redis instance, retrieve its security keys:

```bash
az redis list-keys \
    --resource-group $AZ_RESOURCE_GROUP \
    --name $AZ_REDIS_NAME
```

Note the `primaryKey` value, because we'll use it later.

Now open the `src/main/resources/application.properties` configuration file, and add the following properties:

```properties
spring.redis.host=<xxxxxxx>.redis.cache.windows.net
spring.redis.password=<xxxxxxx>
spring.redis.port=6380
spring.redis.ssl=true
```

Replace the two `<xxxxxxx>` parameters with the following values:

- `spring.redis.host`: The name of your Redis instance, which you stored in the `$AZ_REDIS_NAME` variable earlier.
- `spring.redis.password`: The key to your Redis instance. This key is the `primaryKey` value that we retrieved earlier.

## Test the application locally

You can now run your Spring Boot application, either by running the executable `DemoApplication` within your IDE or by running the Spring Boot Maven plug-in:

```bash
./mvnw spring-boot:run
```

After the application is running, you can store some data in Redis:

```bash
curl -d '{"description":"a description", "details":"some details"}' -H "Content-Type: application/json" -X POST http://127.0.0.1:8080
```

And you can retrieve that data from Redis:

```bash
curl http://127.0.0.1:8080
```
