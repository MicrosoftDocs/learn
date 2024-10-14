In this module, we'll build a [Spring Cloud Gateway](https://spring.io/projects/spring-cloud-gateway) and deploy it on Azure Spring Apps.

Gateways are used to route public HTTP traffic to microservices:

- They handle the routing logic.
- They secure the access to the microservices, which won't be publicly available.
- They can also have Quality of Service (QoS) capabilities, like doing HTTP rate limiting.

## Create a Spring Cloud Gateway

To create our gateway, we use [https://start.spring.io](https://start.spring.io) with the command line:

```bash
curl https://start.spring.io/starter.tgz -d type=maven-project -d dependencies=cloud-gateway,cloud-eureka,cloud-config-client -d baseDir=todo-gateway -d bootVersion=3.1.5.RELEASE -d javaVersion=17 | tar -xzvf -
```

> [!NOTE]
> We use the `Cloud Gateway`, `Eureka Discovery Client`, and the `Config Client` components.

## Configure the application

In the `src/main/resources/application.properties` configuration file, add the following property:

```yaml
spring.main.allow-bean-definition-overriding=true
spring.cloud.gateway.discovery.locator.enabled=true
```

- The `spring.main.allow-bean-definition-overriding=true` part is to configure Spring Cloud Gateway to use the Spring Cloud Discovery Server bean configured in the Azure Spring Apps Client library.
- The `spring.cloud.gateway.discovery.locator.enabled=true` part is to configure Spring Cloud Gateway to use the Spring Cloud Service Registry to discover the available microservices.

## Create the application on Azure Spring Apps

As in the previous module, create a specific `todo-gateway` application in your Azure Spring Apps instance. As this application is a gateway, we add the `--assign-endpoint` flag so it's exposed publicly.

```bash
az spring app create --name todo-gateway --service "$SPRING_CLOUD_NAME" --resource-group "$RESOURCE_GROUP_NAME" --runtime-version Java_17 --assign-endpoint
```

## Deploy the application

You can now build your *todo-gateway* project and send it to Azure Spring Apps:

```bash
cd todo-gateway
./mvnw clean package -DskipTests
az spring app deploy --name todo-gateway --service "$SPRING_CLOUD_NAME" --resource-group "$RESOURCE_GROUP_NAME" --artifact-path target/demo-0.0.1-SNAPSHOT.jar
cd ..
```

## Test the project in the cloud

1. Go to **Apps** in your Azure Spring Apps instance.
    1. Verify **todo-gateway** has a registration status that says **1/1**. This information shows that it's correctly registered in the Spring Cloud Service Registry.
    1. Select **todo-gateway** to have more information on the microservice.
1. Copy/paste the public URL that's provided. Keep this URL handy for subsequent sections.

   There's a **Test Endpoint**—like for microservices—but the gateway is directly exposed on the internet, so we'll use the public URL.

As the gateway is connected to the Spring Cloud Service Registry, it should automatically open routes to the available microservices, with URL paths in the form of `/MICROSERVICE-ID/**`:
[The MICROSERVICE-ID must be in capital letters]

Test the `todo-service` microservice endpoint by doing: `curl https://XXXXXXXX-todo-gateway.azuremicroservices.io/TODO-SERVICE/` (replacing XXXXXXXX with the name of your Azure Spring Apps instance).

As in the previous module, the result of this command should be the three items that were initially inserted in the MySQL database:

```json
[{"id":"1","description":"First item","done":true},{"id":"2","description":"Second item","done":true},{"id":"3","description":"Third item","done":false}]
```
