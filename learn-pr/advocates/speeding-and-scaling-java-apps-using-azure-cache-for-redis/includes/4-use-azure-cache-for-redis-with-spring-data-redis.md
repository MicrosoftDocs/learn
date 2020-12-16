You will now create a Spring Boot application that will use Spring Data Redis to store and retrieve data from Azure Cache for Redis.

## Create a Spring Boot project using Spring Data Redis

To create our Spring Boot project, we will use [https://start.spring.io/](https://start.spring.io/) with the command line:

```bash
curl https://start.spring.io/starter.tgz -d dependencies=web,data-redis -d baseDir=spring-redis-application -d bootVersion=2.4.1.RELEASE -d javaVersion=1.8 | tar -xzvf -
```

> [!NOTE]
> We use the `Spring Web` and the `Spring Data Redis` components.

## Add Spring code to manage data using Spring Data Redis

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

And finish coding this application by adding a Spring MVC controller called `TodoController`:

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
