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

This command creates a new Quarkus project. Despite generating a Maven directory structure (`src/main/java`), it has created some Java classes and some tests. It has also generated a `pom.xml` file with all the needed dependencies (Hibernate, RestEasy, Jackson, PostgreSQL and Docker).  

```xml
  <dependencies>
    <dependency>
      <groupId>io.quarkus</groupId>
      <artifactId>quarkus-hibernate-orm-panache</artifactId>
    </dependency>
    <dependency>
      <groupId>io.quarkus</groupId>
      <artifactId>quarkus-resteasy-jackson</artifactId>
    </dependency>
    <dependency>
      <groupId>io.quarkus</groupId>
      <artifactId>quarkus-jdbc-postgresql</artifactId>
    </dependency>
    <dependency>
      <groupId>io.quarkus</groupId>
      <artifactId>quarkus-container-image-docker</artifactId>
    </dependency>
    <dependency>
      <groupId>io.quarkus</groupId>
      <artifactId>quarkus-arc</artifactId>
    </dependency>
    <dependency>
      <groupId>io.quarkus</groupId>
      <artifactId>quarkus-resteasy</artifactId>
    </dependency>
    <dependency>
      <groupId>io.quarkus</groupId>
      <artifactId>quarkus-junit5</artifactId>
      <scope>test</scope>
    </dependency>
    <dependency>
      <groupId>io.rest-assured</groupId>
      <artifactId>rest-assured</artifactId>
      <scope>test</scope>
    </dependency>
  </dependencies>

```

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

    public Instant createdAt = Instant.now();

    @Override
    public String toString() {
        return "Todo{" +
                "id=" + id + '\'' +
                ", description='" + description + '\'' +
                ", details='" + details + '\'' +
                ", done=" + done +
                ", createdAt=" + createdAt +
                '}';
    }
}
```

To manage that class, update the `TodoResource` that can publish REST interfaces to store and retrieve data by using HTTP. Update the `TodoResource` class and add the following code:

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

    @Inject
    Logger logger;

    @POST
    @Transactional
    public Response createTodo(Todo todo, @Context UriInfo uriInfo) {
        logger.info("Creating todo: " + todo);
        Todo.persist(todo);
        UriBuilder uriBuilder = uriInfo.getAbsolutePathBuilder().path(todo.id.toString());
        return Response.created(uriBuilder.build()).entity(todo).build();
    }

    @GET
    public List<Todo> getTodos() {
        logger.info("Getting all todos");
        return Todo.listAll();
    }
}
```

## Execute the application

To execute the application is development mode, you need Docker Desktop to be up and running. That's because Quarkus detects that you need a PostgreSQL database (thanks to the PostgreSQL dependency `quarkus-jdbc-postgresql` in the `pom.xml`), downloads the PostgreSQL Docker image, and starts a container with the database. Then, it automatically creates the `Todo` table in the database. 

Start the application by using the following command:

```bash
./mvnw quarkus:dev 
```

The Quarkus application should start and connect to your database. You should have the following output:

```shell
[io.qua.dat.dep.dev.DevServicesDatasourceProcessor] Dev Services for the default datasource (postgresql) started.
[io.qua.hib.orm.dep.HibernateOrmProcessor] Setting quarkus.hibernate-orm.database.generation=drop-and-create to initialize Dev Services managed database
__  ____  __  _____   ___  __ ____  ______ 
 --/ __ \/ / / / _ | / _ \/ //_/ / / / __/ 
 -/ /_/ / /_/ / __ |/ , _/ ,< / /_/ /\ \   
--\___\_\____/_/ |_/_/|_/_/|_|\____/___/   
[org.hib.eng.jdb.spi.SqlExceptionHelper] (JPA Startup Thread) SQL Warning Code: 0, SQLState: 00000

[org.hib.eng.jdb.spi.SqlExceptionHelper] (JPA Startup Thread) table "todo" does not exist, skipping
[org.hib.eng.jdb.spi.SqlExceptionHelper] (JPA Startup Thread) SQL Warning Code: 0, SQLState: 00000
[org.hib.eng.jdb.spi.SqlExceptionHelper] (JPA Startup Thread) sequence "hibernate_sequence" does not exist, skipping
[io.quarkus] (Quarkus Main Thread) todo 1.0.0-SNAPSHOT on JVM (powered by Quarkus 2.14.3.Final) started in 4.381s. Listening on: http://localhost:8080
[io.quarkus] (Quarkus Main Thread) Profile dev activated. Live Coding activated.
[io.quarkus] (Quarkus Main Thread) Installed features: [agroal, cdi, hibernate-orm, hibernate-orm-panache, jdbc-postgresql, narayana-jta, resteasy, resteasy-jackson, smallrye-context-propagation, vertx]

--
Tests paused
Press [r] to resume testing, [o] Toggle test output, [:] for the terminal, [h] for more options>
```


To test the application, you can use `cURL`.

First, create a new to-do item in the database:

```bash
curl --header "Content-Type: application/json" \
    --request POST \
    --data '{"description":"Take Quarkus MS Learn","details":"Take the MS Learn on deploying Quarkus to Azure Container Apps","done": "true"}' \
    http://127.0.0.1:8080/api/todos
```

This command should return the created item (with an identifier):

```json
{"id":1,"description":"Take Quarkus MS Learn","details":"Take the MS Learn on deploying Quarkus to Azure Container Apps","done":true}
```

Create a second Todo with the following `cURL` command:

```bash
curl --header "Content-Type: application/json" \
    --request POST \
    --data '{"description":"Take Azure Container Apps MS Learn","details":"Take the ACA Learn module","done": "false"}' \
    http://127.0.0.1:8080/api/todos
```

Next, retrieve the data by using a new `cURL` request:

```bash
curl http://127.0.0.1:8080/api/todos
```

This command returns the list of to-do items, including the item you created:

```json
[ {"id":1,"description":"Take Quarkus MS Learn","details":"Take the MS Learn on deploying Quarkus to Azure Container Apps","done":true},
  {"id":2,"description":"Take Azure Container Apps MS Learn","details":"Take the ACA Learn module","done":false}
]
```

## Test the application

To test the application, you can use the existing `TodoResourceTest` class. It needs to test the REST endpoint and for that it uses [RESTAssured](https://rest-assured.io/). Update the `TodoResourceTest` class and add the following code:

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

To test the application, you also need Docker Desktop to be up and running because Quarkus detects that it needs the PostgreSQL database for testing. Test the application by using the following command:

```bash
./mvnw clean test
```

You shoud have the following output:

```shell
[INFO] -------------------------------------------------------
[INFO]  T E S T S
[INFO] -------------------------------------------------------
[INFO] Running com.example.demo.TodoResourceTest
[INFO] 
[INFO] Results:
[INFO] 
[INFO] Tests run: 2, Failures: 0, Errors: 0, Skipped: 0
[INFO] 
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
```