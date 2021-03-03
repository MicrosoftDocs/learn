You will now create a Spring Boot application that will receive messages from a Service Bus queue.

## Create a Spring Boot project

Just like we did with the sender Spring Boot application, we will utilize the  [Spring Initializr](https://start.spring.io/) to create a Spring Boot project:

```bash
curl https://start.spring.io/starter.tgz -d dependencies=web -d baseDir=spring-receiver-application -d bootVersion=2.4.1.RELEASE -d javaVersion=1.8 | tar -xzvf -
```

## Receive messages from an Azure Service Bus queue

Here again, we will add the dependency and configuration.

### Add the maven dependency for Azure Service Bus Spring Boot Starter

In the `pom.xml` file in your `spring-receiver-application`, add the below under dependencies:

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

In the `application.properties` file in your `spring-receiver-application`, add the below parameters:

```properties
server.port=9090

spring.jms.servicebus.connection-string=<xxxxx>
spring.jms.servicebus.idle-timeout=20000
```

> [!NOTE]
> Please be sure to insert custom values for the configuration.
>
> To obtain the Service Bus connection string, run the below command on the Azure CLI and use the `Primary Connection String`.
>
>   ```bash
>    az servicebus namespace authorization-rule keys list \
>    --name RootManageSharedAccessKey \
>    --namespace-name $AZ_SB_PREMIUM_NAMESPACE \
>    --resource-group $AZ_RESOURCE_GROUP \
>   ```
>

### Add code to receive messages from Azure Service Bus

Next we will add business logic to receive messages from an Azure Service Bus queue.

In the directory `src/main/java/com/example/demo`, create a `ReceiveController` class that has the below content:

```java
package com.example.demo;

import org.springframework.jms.annotation.JmsListener;
import org.springframework.stereotype.Component;

@Component
public class Receiver {
    
    @JmsListener(destination = "test-queue-jms")
    public void receiveMessage(String message) {
        System.out.println("Received <" + message + ">");
    }
}
```

## Run the application locally

You can now run your Spring Boot application, either by running the executable DemoApplication within your IDE or by running the Spring Boot Maven plug-in:

```bash
./mvnw spring-boot:run
```

Once the application start-up completes, you will see the below log statements in the console where you ran the `./mvnw spring-boot:run` command.

```bash
Received <Hello>
Received <HelloAgain>
Received <HelloOnceAgain>
```

This indicates that the Spring Boot application has successfully received messages from the Azure Service Bus queue.

## See the entire workflow in action

If your sender application (from unit 4) is still running, you can click on the below link to send a message to the Azure Service Bus queue, 

```html
http://localhost:8080/messages?message=HelloOnceAgainAndAgain
```

which will in turn be received by your receiver application and will be displayed in your console.

```bash
Received <HelloOnceAgainAndAgain>
```
