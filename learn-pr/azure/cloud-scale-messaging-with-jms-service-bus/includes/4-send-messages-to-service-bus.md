In this unit, you create a Spring Boot application that sends messages to an Azure Service Bus queue. Complete the following steps locally.

## Create a Spring Boot project

To create our Spring Boot project, we use [Spring Initializr](https://start.spring.io/) with the following command line:

```bash
curl https://start.spring.io/starter.tgz -d type=maven-project -d dependencies=web -d baseDir=spring-sender-application -d bootVersion=2.4.1.RELEASE -d javaVersion=1.8 | tar -xzvf -
```

## Send messages to a Service Bus queue

Now, let's send some messages to a Service Bus queue.

### Add the maven dependency for Service Bus Spring Boot Starter

In the `pom.xml` file in your `spring-sender-application`, add the following command under dependencies:

```xml
            <dependency>
                <groupId>com.microsoft.azure</groupId>
                <artifactId>azure-servicebus-jms-spring-boot-starter</artifactId>
                <version>2.3.3</version>
            </dependency>
```

### Add the configuration parameters

1. In the `spring-sender-application\src\main\resources` folder, edit the `application.properties` file, add the following parameters:

    ```java
    spring.jms.servicebus.connection-string=<xxxxx>
    spring.jms.servicebus.idle-timeout=20000
    ```

2. Set the `spring.jms.servicebus.connection-string` property to the connection string to your Service Bus namespace, which you saved earlier.

### Add code to send messages to Service Bus

Next, we add the business logic to send messages to a Service Bus queue.

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

1. Switch back to the root of the sample `spring-sender-application` folder where the `pom.xml` file is located, and run the following command to start your Spring Boot application. This step assumes that you have `mvn` installed on your Windows computer, and it's in the `PATH`. 

    ```bash
    mvn spring-boot:run
    ```

2. After the application startup completes, you can select the following links to send messages to the Service Bus queue.

    ```html
    http://localhost:8080/messages?message=Hello
    ```

    ```html
    http://localhost:8080/messages?message=HelloAgain
    ```

    ```html
    http://localhost:8080/messages?message=HelloOnceAgain
    ```

    You can change the string value in the message query parameter and send any text to the Service Bus queue.

    The browser displays whatever is passed as the message query string parameter, which implies that the Service Bus is accepting the message.

## See the messages on the Service Bus queue

> [!NOTE]
> Although viewing the messages helps to understand the send side of the messages, this step is optional.
>
> These messages will be received in the next step of this tutorial.
>

You can proceed to view the messages in the Service Bus explorer in the Azure portal:

1. Back in the Azure portal, select **Queues** on the left menu under **Entities**.
1. Select the appropriate queue. For example, the queue for this demo is **test-queue-jms**.
1. In the left pane, select **Service Bus explorer**.
1. Select **Peek from start**. You should see all three messages that you sent using HTTP commands. 

    :::image type="content" source="../media/service-bus-explorer-peek-view.png" alt-text="Screenshot of the Service Bus explorer peek experience." lightbox="../media/service-bus-explorer-peek-view.png":::
1. Select a message to see the message body in the bottom pane. 

    :::image type="content" source="../media/peek-messages.png" alt-text="Screenshot of the Service Bus explorer with peeked messages." lightbox="../media/peek-messages.png":::