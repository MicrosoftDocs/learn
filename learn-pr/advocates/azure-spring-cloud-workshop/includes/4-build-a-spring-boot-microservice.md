In this module, we will build Spring Boot microservice that is cloud-enabled: it uses a Spring Cloud Service Registry and a [Spring Cloud Config Server](https://cloud.spring.io/spring-cloud-config) which are both managed and supported by Azure Spring Cloud.

This microservice will use Spring Data MongoDB to read and write data from an [Azure Cosmos DB database](https://docs.microsoft.com/azure/cosmos-db/?WT.mc_id=azurespringcloud-mslearn-judubois) database:

- That database will be automatically bound to our service by Azure Spring Cloud.
- CosmosDB is a globally-distributed database, which supports the MongoDB protocol, so in this (simplified) case, we will use it as if it was a normal MongoDB database.

## Create the application on Azure Spring Cloud

Create a specific `todo-service` application in your Azure Spring Cloud instance:

```bash
az spring-cloud app create -n todo-service
```

## Create a Cosmos DB database with the MongoDB API

Now create a Cosmos DB database using the MongoDB API:

- Cosmos DB is a globally distributed NoSQL database, that supports the MongoDB API.
- For this module, we will use it as a normal MongoDB server.
- When creating the MongoDB collection, be careful to keep the throughput at `400` (which should be the default value), in order to benefit from Cosmos DB's free tier.

```bash
az cosmosdb create \
    --name ${SPRING_CLOUD_NAME}-cosmosdb \
    --kind MongoDB

az cosmosdb mongodb database create \
    --account-name ${SPRING_CLOUD_NAME}-cosmosdb \
    --name "cosmosdb-todos"
```

Once this operation completes, you can have a look at what was created in the resource group that you created for this workshop.

## Bind the Cosmos DB database to the application

Azure Spring Cloud can automatically bind the Cosmos DB database we created to our microservice.

- Go to "Apps" in your Azure Spring Cloud instance.
- Select the `todo-service` application
- Go to `Service bindings`
- Click on `Create service binding``
  - Give your binding a name, for example `cosmosdb-todos`
  - Select the Cosmos DB account and database we created and select the `mongodb` API type
  - In the drop-down list, select the primary master key
  - Click on `Create` to create the database binding

That's all you need to do to have your Spring Boot microservice automatically configured to access the Cosmos DB database that we set up.

## Create a Spring Boot microservice

Now that we've provisioned the Azure Spring Cloud instance and configured the service binding, let's get the code for `todo-service` ready.

To create our microservice, we will use [https://start.spring.io/](https://start.spring.io/) with the command line:

```bash
curl https://start.spring.io/starter.tgz -d dependencies=web,data-mongodb,cloud-eureka,cloud-config-client -d baseDir=todo-service -d bootVersion=2.2.5.RELEASE | tar -xzvf -
```

> We use the `Spring Web`, `Spring Data MongoDB`, `Eureka Discovery Client` and the `Config Client` components.

## Add a "cloud" Maven profile

To deploy to Azure Spring Cloud, we add a "cloud" Maven profile in our Maven `pom.xml` file.

At the end of the application's `pom.xml` file (just before the closing `</project>` XML node), add the following code:

```xml
    <profiles>
        <profile>
            <id>cloud</id>
            <dependencies>
                <dependency>
                    <groupId>com.microsoft.azure</groupId>
                    <artifactId>spring-cloud-starter-azure-spring-cloud-client</artifactId>
                    <version>2.2.0</version>
                </dependency>
            </dependencies>
        </profile>
    </profiles>
```

## Add Spring code to manage data using Spring Data MongoDB

Next to the `DemoApplication` class, create a `Todo` MongoDB collection:

```java
package com.example.demo;

import org.springframework.data.annotation.Id;

public class Todo {

    @Id
    public String id;

    public String description;

    public boolean done;

    public Todo() {
    }

    public Todo(String id, String description, boolean done) {
        this.id = id;
        this.description = description;
        this.done = done;
    }
}
```

Then, create a Spring Data MongoDB repository to manage this collection, called `TodoRepository`:

```java
package com.example.demo;

import org.springframework.data.mongodb.repository.MongoRepository;

public interface TodoRepository extends MongoRepository<Todo, String> {

}
```

And finish coding this application by adding a Spring MVC controller called `TodoController`:

```java
package com.example.demo;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.PostConstruct;
import java.util.Arrays;
import java.util.List;

@RestController
public class TodoController {

    private final TodoRepository todoRepository;

    public TodoController(TodoRepository todoRepository) {
        this.todoRepository = todoRepository;
    }

    @PostConstruct
    public void init() {
        todoRepository.saveAll(Arrays.asList(
                new Todo("1", "First item", true),
                new Todo("2", "Second item", true),
                new Todo("3", "Third item", false)));
    }

    @GetMapping("/")
    public @ResponseBody
    List<Todo> showAllTodos() {
        return todoRepository.findAll();
    }
}
```

## Deploy the application

You can now build your "todo-service" project and send it to Azure Spring Cloud:

```bash
cd todo-service
./mvnw clean package -DskipTests -Pcloud
az spring-cloud app deploy -n todo-service --jar-path target/demo-0.0.1-SNAPSHOT.jar
cd ..
```

If you want to check the logs of the application, in case something fails, you can use the `az spring-cloud app logs` command:

```bash
az spring-cloud app logs -n todo-service -f
```

## Test the project in the cloud

Now that the application is deployed, it's time to test it!

- In the Azure Portal, go to "Apps" in your Azure Spring Cloud instance.
  - Verify that `todo-service` has a `Discovery status` which says `UP(1),DOWN(0)`. This shows that it is correctly registered in the Spring Cloud Service Registry.
  - Select `todo-service` to have more information on the microservice.
- Copy/paste the "Test Endpoint" that is provided.

You can now use cURL to test the endpoint. Your test command should look like:

```bash
curl https://primary:XXXXXXXXXXXXXXXXXXXXXXXXXXXXX@azure-spring-cloud-workshop.test.azuremicroservices.io/todo-service/default/
```

And the result of this command should be the three items that were previously inserted in the Cosmos DB database:

```json
[{"id":"1","description":"First item","done":true},{"id":"2","description":"Second item","done":true},{"id":"3","description":"Third item","done":false}]
```
