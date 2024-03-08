In this unit, you create a basic Quarkus application. You use Maven to bootstrap the application and an integrated development environment (IDE) of your choice to edit the code. Use a terminal of your choice to run the code. You use Docker to start a local PostgreSQL database so you can run and test the application locally.

## Generate the Quarkus application by using Maven

There are several ways to generate a Quarkus project structure. You can use the [Quarkus web interface](https://code.quarkus.io), an IDE plugin, or the Quarkus Maven plugin. Let's use the Maven plugin to generate the project structure.

You generate your application with several dependencies:

* The `resteasy` dependency to expose a REST endpoint
* The `jackson` dependency to serialize and deserialize JSON
* The `hibernate` dependency to interact with the database
* The `postgresql` dependency to connect to the PostgreSQL database
* The `docker` dependency to build a Docker image

You don't need to specify Azure dependencies because you run your application locally first and then deploy a containerized version of it to Azure Container Apps.

At a command prompt, generate the to-do application:

```bash
mvn -U io.quarkus:quarkus-maven-plugin:3.7.3:create \
    -DplatformVersion=3.7.3 \
    -DprojectGroupId=com.example.demo \
    -DprojectArtifactId=todo \
    -DclassName="com.example.demo.TodoResource" \
    -Dpath="/api/todos" \
    -DjavaVersion=17 \
    -Dextensions="resteasy-jackson, hibernate-orm-panache, jdbc-postgresql, docker"
```

This command creates a new Quarkus project. It generates a Maven directory structure (`src/main/java` for source code and `src/test/java` for tests). It creates some Java classes, some tests, and some Dockerfiles. It also generates a *pom.xml* file with all the needed dependencies (Hibernate, RESTEasy, Jackson, PostgreSQL, and Docker):

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
        <artifactId>quarkus-hibernate-orm</artifactId>
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

> [!NOTE]
> All the dependencies in the *pom.xml* file are defined in the Quarkus BOM (bill of materials) `io.quarkus.platform:quarkus-bom`.

## Code the application

Next, rename the generated *MyEntity.java* class to *Todo.java* (located in the same folder as the *TodoResource.java* file). Replace the existing code with the following Java code. It uses Java Persistence API (`jakarta.persistence.*` package) to store and retrieve data from your PostgreSQL server. It also uses [Hibernate ORM with Panache](https://quarkus.io/guides/hibernate-orm-panache) (inheriting from `io.quarkus.hibernate.orm.panache.PanacheEntity`) to simplify the persistence layer.

You use a JPA entity (`@Entity`) to map the Java `Todo` object directly to the PostgreSQL `Todo` table. The `TodoResource` REST endpoint then creates a new `Todo` entity class and persists it. This class is a domain model that's mapped on the `Todo` table. The table is automatically created by JPA.

Extending `PanacheEntity` gets you a number of generic create, read, update, and delete (CRUD) methods for your type. So you can do things like saving and deleting `Todo` objects in just one line of Java code.

Add the following code to the `Todo` entity:

```java
package com.example.demo;

import io.quarkus.hibernate.orm.panache.PanacheEntity;

import jakarta.persistence.Entity;
import java.time.Instant;

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

To manage that class, update the `TodoResource` so that it can publish REST interfaces to store and retrieve data by using HTTP. Open the `TodoResource` class and replace the code with the following:

```java
package com.example.demo;

import jakarta.inject.Inject;
import jakarta.transaction.Transactional;
import jakarta.ws.rs.Consumes;
import jakarta.ws.rs.GET;
import jakarta.ws.rs.POST;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.Produces;
import static jakarta.ws.rs.core.MediaType.APPLICATION_JSON;
import jakarta.ws.rs.core.Response;
import jakarta.ws.rs.core.UriBuilder;
import jakarta.ws.rs.core.UriInfo;
import org.jboss.logging.Logger;

import java.util.List;

@Path("/api/todos")
@Consumes(APPLICATION_JSON)
@Produces(APPLICATION_JSON)
public class TodoResource {

    @Inject
    Logger logger;

    @Inject
    UriInfo uriInfo;

    @POST
    @Transactional
    public Response createTodo(Todo todo) {
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

## Run the application

When you run the application in development mode, Docker needs to be running. That's because Quarkus detects that you need a PostgreSQL database (because of the PostgreSQL dependency `quarkus-jdbc-postgresql` declared in the *pom.xml* file), downloads the PostgreSQL Docker image, and starts a container with the database. It then automatically creates the `Todo` table in the database.

Make sure Docker is running locally on your machine and run the to-do application by using this command:

```bash
cd todo
./mvnw quarkus:dev    # On Mac or Linux
mvnw.cmd quarkus:dev  # On Windows
```

The Quarkus application should start and connect to your database. You should see the following output:

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
[io.quarkus] (Quarkus Main Thread) todo 1.0.0-SNAPSHOT on JVM (powered by Quarkus) started in 4.381s. Listening on: http://localhost:8080
[io.quarkus] (Quarkus Main Thread) Profile dev activated. Live Coding activated.
[io.quarkus] (Quarkus Main Thread) Installed features: [agroal, cdi, hibernate-orm, hibernate-orm-panache, jdbc-postgresql, narayana-jta, resteasy, resteasy-jackson, smallrye-context-propagation, vertx]

--
Tests paused
Press [r] to resume testing, [o] Toggle test output, [:] for the terminal, [h] for more options>
```

To test the application, you can use cURL.

In a separate terminal, create a new to-do item in the database with the following command.  You should see the log in the Quarkus console:

```bash
curl --header "Content-Type: application/json" \
    --request POST \
    --data '{"description":"Take Quarkus MS Learn","details":"Take the MS Learn on deploying Quarkus to Azure Container Apps","done": "true"}' \
    http://127.0.0.1:8080/api/todos
```

This command should return the created item (with an identifier):

```json
{"id":1,"description":"Take Quarkus MS Learn","details":"Take the MS Learn on deploying Quarkus to Azure Container Apps","done":true,"createdAt":"2022-12-30T15:17:20.280203Z"}
```

Create a second to-do by using the following cURL command:

```bash
curl --header "Content-Type: application/json" \
    --request POST \
    --data '{"description":"Take Azure Container Apps MS Learn","details":"Take the ACA Learn module","done": "false"}' \
    http://127.0.0.1:8080/api/todos
```

Next, retrieve the data by using a new cURL request:

```bash
curl http://127.0.0.1:8080/api/todos
```

This command returns the list of to-do items, including the items you created:

```json
[ 
  {"id":1,"description":"Take Quarkus MS Learn","details":"Take the MS Learn on deploying Quarkus to Azure Container Apps","done":true},
  {"id":2,"description":"Take Azure Container Apps MS Learn","details":"Take the ACA Learn module","done":false}
]
```

## Test the application

To test the application, you can use the existing `TodoResourceTest` class. It needs to test the REST endpoint. To test the endpoint, it uses [RESTAssured](https://rest-assured.io/). Replace code in the `TodoResourceTest` class with the following code:

```java
package com.example.demo;

import io.quarkus.test.junit.QuarkusTest;
import static io.restassured.RestAssured.given;
import static jakarta.ws.rs.core.HttpHeaders.CONTENT_TYPE;
import static jakarta.ws.rs.core.MediaType.APPLICATION_JSON;
import org.junit.jupiter.api.Test;

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

When you test the application, Docker Desktop needs to be running because Quarkus detects that it needs the PostgreSQL database for testing. Test the application by using this command:

```bash
./mvnw clean test    # On Mac or Linux
mvnw.cmd clean test  # On Windows
```

You should see output that looks similar to this:

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
