You'll now create a Spring Boot application that will receive messages from an Azure Service Bus queue.

## Create a Spring Boot project

Let's open up a new terminal window, and just like we did with the sender Spring Boot application, we'll use the [Spring Initializr](https://start.spring.io/) to create a Spring Boot project.

```bash
curl https://start.spring.io/starter.tgz -d dependencies=web -d baseDir=spring-receiver-application -d bootVersion=2.4.1.RELEASE -d javaVersion=1.8 | tar -xzvf -
```

## Receive messages from a Service Bus queue

Here again, we'll add the dependency and configuration.

### Add the maven dependency for Service Bus Spring Boot Starter

In the `pom.xml` file in your `spring-receiver-application`, add the following command under dependencies:

```xml
<dependencies>
    ...
        <dependency>
            <groupId>com.microsoft.azure</groupId>
            <artifactId>azure-servicebus-jms-spring-boot-starter</artifactId>
            <version>2.3.3</version>
        </dependency>
    ...
</dependencies>
```

### Add the configuration parameters

In the `application.properties` file in your `spring-receiver-application`, add the following parameters:

```java
server.port=9090

spring.jms.servicebus.connection-string=<xxxxx>
spring.jms.servicebus.idle-timeout=20000
```

> [!NOTE]
> Be sure to insert custom values for the configuration.
>
> To obtain the Service Bus connection string, run the following command on the Azure CLI and use the `Primary Connection String`.
>
>   ```bash
>    az servicebus namespace authorization-rule keys list \
>    --name RootManageSharedAccessKey \
>    --namespace-name $AZ_SB_PREMIUM_NAMESPACE \
>    --resource-group $AZ_RESOURCE_GROUP
>   ```
>

### Add code to receive messages from Service Bus

Next, we'll add business logic to receive messages from a Service Bus queue.

In the directory `src/main/java/com/example/demo`, create a `ReceiveController.java` file that has the following content:

```java
package com.example.demo;

import org.springframework.jms.annotation.JmsListener;
import org.springframework.stereotype.Component;

@Component
public class ReceiveController {
    
    @JmsListener(destination = "test-queue-jms")
    public void receiveMessage(String message) {
        System.out.println("Received <" + message + ">");
    }
}
```

## Run the application locally

You can now run your Spring Boot application by running the following command:

```bash
./mvnw spring-boot:run
```

After the application startup completes, you'll see the following log statements in the console where you ran the `./mvnw spring-boot:run` command.

```bash
Received <Hello>
Received <HelloAgain>
Received <HelloOnceAgain>
```

The appearance of the statements indicates that the Spring Boot application has successfully received messages from the Service Bus queue.

## See the entire workflow in action

If your sender application (from unit 4) is still running, you can select the following link to send a message to the Service Bus queue:

```html
http://localhost:8080/messages?message=HelloOnceAgainAndAgain
```

which will in turn be received by your receiver application and will be displayed in your console.

```bash
Received <HelloOnceAgainAndAgain>
```
