In this unit, you'll create a basic Quarkus application. You'll use Maven to bootstrap the application and an integrated development environment (IDE) of your choice to edit the code. Use a terminal of your choice to run the code.

## Generate the Quarkus application using Maven

There are different ways to generates a Quarkus project structure for you. You can use the [Quarkus web interface](https://code.quarkus.io), an IDE plugin, or the Quarkus Maven plugin. Let's use the Maven plugin to generate the project structure.

You'll generate your application scaffold with three dependencies: `resteasy`, `jackson`, `hibernate`, `postgresql`, and `docker`.
You will use the `resteasy` dependency to expose a REST endpoint, the `jackson` dependency to serialize and deserialize JSON, the `hibernate` dependency to interact with the database, the `postgresql` dependency to connect to the PostgreSQL database, and the `docker` dependency to build a Docker image. 
You don't need to specify Azure dependencies because you'll run your application locally first, and then deploy a containerized version of the application to Azure Container Apps.

At a command prompt, generate the application:

```bash
mvn -U io.quarkus:quarkus-maven-plugin:2.14.3.Final:create \
    -DplatformVersion=2.14.3.Final \
    -DprojectGroupId=com.example.demo \
    -DprojectArtifactId=todo \
    -DclassName="com.example.demo.TodoResource" \
    -Dpath="/api/todos" \
    -DjavaVersion=11 \
    -Dextensions="resteasy-jackson, hibernate-orm-panache, jdbc-postgresql, docker"
```

> [!NOTE]
> By default the project is generated using Java 17. We use the `javaVersion` parameter to override the default value and use Java 11.

## Code the application

Next, create a new Java class and add the following Java code to the `Todo`. It uses Java Persistence API (`javax.persistence.Entity` package) to store and retrieve data from your PostgreSQL server. It also uses [Hibernate ORM with Panache](https://quarkus.io/guides/hibernate-orm-panache) (`io.quarkus.hibernate.orm.panache.PanacheEntity` package) to simplify the persistence layer.

You'll use a JPA entity (`@Entity`) to map a Java `Todo` object directly to the PostgreSQL `Todo` table. Then, the `TodoResource` REST endpoint, will create a new `Todo` entity class and persist it. This class is a domain model that's mapped on the `Todo` table. The table will be automatically created by JPA.

By extending `PanacheEntity`, you get a bunch of generic create, read, update, and delete (CRUD) methods for your type. So you can do things like saving and deleting `Todo` objects.

Add the following code to the `Todo` entity:

```java
package com.example.demo;

import io.quarkus.hibernate.orm.panache.PanacheEntity;

import javax.persistence.Entity;

@Entity
public class Todo extends PanacheEntity {

    public String description;

    public String details;

    public boolean done;

    @Override
    public String toString() {
        return "Todo{" +
                "id=" + id + '\'' +
                ", description='" + description + '\'' +
                ", details='" + details + '\'' +
                ", done=" + done +
                '}';
    }
}
```

To manage that class, update the `TodoResource` that can publish REST interfaces to store and retrieve data by using HTTP. Implement a `TodoResource` class in the same package. Then add the following code:

```java
package com.example.demo;

import javax.transaction.Transactional;
import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.UriBuilder;
import javax.ws.rs.core.UriInfo;
import java.util.List;

import static javax.ws.rs.core.MediaType.APPLICATION_JSON;

@Path("/api/todos")
@Consumes(APPLICATION_JSON)
@Produces(APPLICATION_JSON)
public class TodoResource {

    @POST
    @Transactional
    public Response createTodo(Todo todo, @Context UriInfo uriInfo) {
        Todo.persist(todo);
        UriBuilder uriBuilder = uriInfo.getAbsolutePathBuilder().path(todo.id.toString());
        return Response.created(uriBuilder.build()).entity(todo).build();
    }

    @GET
    public List<Todo> getTodos() {
        return Todo.listAll();
    }
}
```

## Execute the application

Finally, start it again by using the following command:

```bash
./mvnw quarkus:dev 
```

The Quarkus application should start and connect to your database.

This screenshot shows the application connecting to the database:

![Screenshot showing the running application connecting to database.](../media/3-spring-boot-02.png)


To test the application, you can use `cURL`.

First, create a new to-do item in the database:

```bash
curl --header "Content-Type: application/json" \
    --request POST \
    --data '{"description":"configuration","details":"congratulations, you have set up your Quarkus application correctly!","done": "true"}' \
    http://127.0.0.1:8080
```

This command should return the created item:

```json
{"id":1,"description":"configuration","details":"congratulations, you have set up your Quarkus application correctly!","done":true}
```

Next, retrieve the data by using a new `cURL` request:

```bash
curl http://127.0.0.1:8080
```

This command returns the list of to-do items, including the item you created:

```json
[{"id":1,"description":"configuration","details":"congratulations, you have set up your Quarkus application correctly!","done":true}]
```

## Test the application

```java
package com.example.demo;

import io.quarkus.test.junit.QuarkusTest;
import org.junit.jupiter.api.Test;

import static io.restassured.RestAssured.given;
import static javax.ws.rs.core.HttpHeaders.CONTENT_TYPE;
import static javax.ws.rs.core.MediaType.APPLICATION_JSON;

@QuarkusTest
class TodoResourceTest {

    @Test
    void shouldGetAllTodos() {
        given()
                .when().get("/api/todos")
                .then()
                .statusCode(200);
    }

    @Test
    void shouldCreateATodo() {
        Todo todo = new Todo();
        todo.description = "Take Quarkus MS Learn";
        todo.details = "Take the MS Learn on deploying Quarkus to Azure Container Apps";
        todo.done = true;

        given().body(todo)
                .header(CONTENT_TYPE, APPLICATION_JSON)
                .when().post("/api/todos")
                .then()
                .statusCode(201);
    }
}
```
