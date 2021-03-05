You will now create a Spring Boot application that will send messages to a Service Bus queue.

## Create a Spring Boot project

To create our Spring Boot project, we'll use [Spring Initializr](https://start.spring.io/) with the command line:

```bash
curl https://start.spring.io/starter.tgz -d dependencies=web -d baseDir=spring-sender-application -d bootVersion=2.4.1.RELEASE -d javaVersion=1.8 | tar -xzvf -
```

## Send messages to an Azure Service Bus queue

### Add the maven dependency for Azure Service Bus Spring Boot Starter

In the `pom.xml` file in your `spring-sender-application`, add the below under dependencies:

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

In the `application.properties` file in your `spring-sender-application`, add the below parameters:

```properties
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
>    --resource-group $AZ_RESOURCE_GROUP
>   ```
>

### Add code to send messages to Azure Service Bus

Next we will add the business logic to send messages to an Azure Service Bus queue.

In the directory `src/main/java/com/example/demo`, create a `SendController.java` file that has the below content:

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

You can now run your Spring Boot application by running the below command:

```bash
./mvnw spring-boot:run
```

Once the application start-up completes, you can click on the below links to send messages to the Service Bus queue.

```html
http://localhost:8080/messages?message=Hello

http://localhost:8080/messages?message=HelloAgain

http://localhost:8080/messages?message=HelloOnceAgain
```

You can change the string value in the message query parameter and send any text to the Azure Service Bus queue.

The browser will display whatever is passed as the message query string parameter, which implies that the message has been accepted by Azure Service Bus.

## See the messages on the Azure Service Bus queue

> [!NOTE]
> While viewing the messages helps understand the send side of the messages, this step is optional.
>
> These messages will be received in the next step of this tutorial.
>

You can proceed to view the messages in the Service Bus explorer in the Azure portal.

The steps for this are as below :

1. Browse to the [Azure portal](https://portal.azure.com/?azure-portal=true).
2. Navigate to the specific Service Bus namespace.
3. In the left menu navigation, click on **Queues**, and then select the appropriate queue (i.e. test-queue-jms for this demo).
4. Then click on **Service Bus explorer** on the left navigation menu.
5. Click on **Peek**, select **Queue**, and then hit the **Peek** button.

Following the above steps should give the below view.

:::image type="content" source="../media/SB_Explorer_peek_view.png" alt-text="Screenshot of the Service Bus explorer peek experience." lightbox="../media/SB_Explorer_peek_view.png":::
