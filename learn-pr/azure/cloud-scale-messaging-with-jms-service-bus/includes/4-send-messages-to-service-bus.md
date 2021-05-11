You'll now create a Spring Boot application that will send messages to an Azure Service Bus queue.

## Create a Spring Boot project

To create our Spring Boot project, we'll use [Spring Initializr](https://start.spring.io/) with the following command line:

```bash
curl https://start.spring.io/starter.tgz -d dependencies=web -d baseDir=spring-sender-application -d bootVersion=2.4.1.RELEASE -d javaVersion=1.8 | tar -xzvf -
```

## Send messages to a Service Bus queue

Now, let's send some messages to a Service Bus queue.

### Add the maven dependency for Service Bus Spring Boot Starter

In the `pom.xml` file in your `spring-sender-application`, add the following command under dependencies:

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

In the `application.properties` file in your `spring-sender-application`, add the following parameters:

```java
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

### Add code to send messages to Service Bus

Next, we'll add the business logic to send messages to a Service Bus queue.

In the directory `src/main/java/com/example/demo`, create a `SendController.java` file that has the following content:

```java
package com.example.demo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jms.core.JmsTemplate;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class SendController {
    
    private static final String queue = "test-queue-jms";

    @Autowired
    private JmsTemplate jmsTemplate;

    @GetMapping("/messages")
    public String postMessage(@RequestParam String message) {
        jmsTemplate.send(queue, s -> s.createTextMessage(message));
        return message;
    }
}
```

## Run the application locally

You can now run your Spring Boot application by running the following command:

```bash
./mvnw spring-boot:run
```

After the application startup completes, you can select the following links to send messages to the Service Bus queue.

```html
http://localhost:8080/messages?message=Hello

http://localhost:8080/messages?message=HelloAgain

http://localhost:8080/messages?message=HelloOnceAgain
```

You can change the string value in the message query parameter and send any text to the Service Bus queue.

The browser will display whatever is passed as the message query string parameter, which implies that the message has been accepted by Service Bus.

## See the messages on the Service Bus queue

> [!NOTE]
> Although viewing the messages helps to understand the send side of the messages, this step is optional.
>
> These messages will be received in the next step of this tutorial.
>

You can proceed to view the messages in the Service Bus explorer in the Azure portal:

1. Browse to the [Azure portal](https://portal.azure.com/?azure-portal=true).
1. Go to the specific Service Bus namespace.
1. In the left pane, select **Queues**, and then select the appropriate queue. For example, the queue for this demo is **test-queue-jms**.
1. In the left pane, select **Service Bus explorer**.
1. Select **Peek**, select **Queue**, and then select **Peek**.

After you finish the preceding steps, you should see this view:

:::image type="content" source="../media/service-bus-explorer-peek-view.png" alt-text="Screenshot of the Service Bus explorer peek experience." lightbox="../media/service-bus-explorer-peek-view.png":::
