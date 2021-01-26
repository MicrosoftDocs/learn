In this unit, you will develop the Communications service to receive and process messages from Azure Service Bus by using an IDE of your choice to edit the code.

## Create and configure the communications microservice

### Create the communications service as a module

Use the Java IDE to add a Maven module to the `spring-petclinic-microservices` project. Call it `spring-petclinic-communications-service`.

Once the module is created, ensure that in the `spring-petclinic-microservices` project, the `pom.xml` file contains the below line.

```xml
<modules>
...
    <module>spring-petclinic-communications-service</module>
...
</modules>
```

### Add the maven dependencies for the Communications service

In the `pom.xml` file for the `spring-petclinic-communications-microservice`, add the below dependencies.

```xml
<dependencies>
    ...
    <!-- Azure Service Bus starter for Spring Boot -->
    <dependency>
        <groupId>com.microsoft.azure</groupId>
        <artifactId>azure-servicebus-jms-spring-boot-starter</artifactId>
        <version>2.3.2-SNAPSHOT</version>
    </dependency>
    
    <!-- JACKSON for JSON parsing -->
    <dependency>
        <groupId>com.fasterxml.jackson.core</groupId>
        <artifactId>jackson-databind</artifactId>
    </dependency>

    <!-- Spring JMS -->
    <!-- https://mvnrepository.com/artifact/org.springframework/spring-jms -->
    <dependency>
        <groupId>org.springframework</groupId>
        <artifactId>spring-jms</artifactId>
    </dependency>

    <!-- SendGrid Mail -->
    <dependency>
        <groupId>com.sendgrid</groupId>
        <artifactId>sendgrid-java</artifactId>
    </dependency>

    <!-- Thymeleaf -->
    <dependency>
        <groupId>org.thymeleaf</groupId>
        <artifactId>thymeleaf</artifactId>
        <version>3.0.9.RELEASE</version>
    </dependency>
    <dependency>
        <groupId>org.thymeleaf</groupId>
        <artifactId>thymeleaf-spring4</artifactId>
        <version>3.0.9.RELEASE</version>
    </dependency>
    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-thymeleaf</artifactId>
    </dependency>
    ...
</dependencies>
```

### Add the app configuration

Create a `AppConfig.java` file under the default `org.springframework.samples.petclinic.communication` package -

```java
package org.springframework.samples.petclinic.communication;

import java.util.Collections;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.samples.petclinic.communication.email.EmailService;
import org.springframework.samples.petclinic.communication.email.EmailServiceImpl;
import org.thymeleaf.spring4.SpringTemplateEngine;
import org.thymeleaf.templatemode.TemplateMode;
import org.thymeleaf.templateresolver.ClassLoaderTemplateResolver;
import org.thymeleaf.templateresolver.ITemplateResolver;

import com.sendgrid.SendGrid;
import com.sendgrid.SendGridAPI;

@Configuration
@PropertySource("classpath:application.properties")
public class AppConfig {

    @Value("${sendgrid.api.key}") String sendGridAPIKey;

    @Bean
    public EmailService getEmailService() {
    return new EmailServiceImpl();
    }

    @Bean
    public SendGridAPI getSendGridApi() {
        return new SendGrid(sendGridAPIKey);
    }
    
    @Bean
    public SpringTemplateEngine getSpringTemplateEngine() {
        SpringTemplateEngine templateEngine = new SpringTemplateEngine();
        templateEngine.addTemplateResolver(htmlTemplateResolver());
        return templateEngine;
    }
    
    private ITemplateResolver htmlTemplateResolver() {
        ClassLoaderTemplateResolver templateResolver = new ClassLoaderTemplateResolver();
        templateResolver.setPrefix("/emailTemplates/");
        templateResolver.setSuffix(".html");
        templateResolver.setTemplateMode(TemplateMode.HTML);
        templateResolver.setCharacterEncoding("UTF8");
        templateResolver.setCheckExistence(true);
        templateResolver.setCacheable(false);
        return templateResolver;
    }
}

```

## Write email module

Since the goal is to better engage with the customer by sending them emails when they sign up for the petclinic, or when they visit the clinic, we need to build a module that will send an email.

To do that, we first create a new package `org.springframework.samples.petclinic.communication.email` under the `org.springframework.samples.petclinic.communication` package.

In this package, we will first declare the `EmailService` interface -

```java
package org.springframework.samples.petclinic.communication.email;

import java.io.IOException;

public interface EmailService {

    void sendOwnerWelcomeEmail(String owner) throws IOException;

    void sendVisitRecordEmail(String visitRecord) throws IOException;

}

```

And then add the concrete implementation `EmailServiceImpl.java` as below -

> [!NOTE]
>
> Since this is a dummy application, we expect the customer data to be auto-generated and hence the email addresses will not be valid.
>
> Due to this, the email service uses the **EMAIL_ACTIVE** flag to disable actually sending the emails.
>
> When the flag is set to true, the emails are sent to a test account.

```java
package org.springframework.samples.petclinic.communication.email;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.thymeleaf.context.Context;
import org.thymeleaf.spring4.SpringTemplateEngine;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.sendgrid.Method;
import com.sendgrid.Request;
import com.sendgrid.Response;
import com.sendgrid.SendGridAPI;
import com.sendgrid.helpers.mail.Mail;
import com.sendgrid.helpers.mail.objects.Content;
import com.sendgrid.helpers.mail.objects.Email;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class EmailServiceImpl implements EmailService {

    @Autowired
    private SendGridAPI sendGridClient;

    @Autowired
    private SpringTemplateEngine templateEngine;

    @Value("${default.recipient}")
    private String DEFAULT_RECIPIENT;

    @Value("${email.active}")
    private boolean EMAIL_ACTIVE;


    @Override
    public void sendOwnerWelcomeEmail(String owner) throws IOException {
        // Extract owner information from the string.
        ObjectMapper objectMapper = new ObjectMapper();
        JsonNode rootNode = objectMapper.readTree(owner);
        JsonNode idNode = rootNode.path("id");
        JsonNode firstNameNode = rootNode.path("firstName");
        JsonNode lastNameNode = rootNode.path("lastName");
        JsonNode emailNode = rootNode.path("email");
        
        // Create the context to share the information on the owner.
        final Context ctx = new Context();
        ctx.setVariable("ownerid", idNode.asInt());
        ctx.setVariable("recipientName", firstNameNode.asText() + " " + lastNameNode.asText());


        // Create the email
        String contentBody = templateEngine.process("OwnerCreatedEmailTemplates", ctx);
        Content content = new Content("text/html", contentBody);
        Mail mail;

        // Send the email
        if (EMAIL_ACTIVE) {
            mail = new Mail(new Email("no-reply@springpetclinic.com"), "Welcome to PetClinic!", new Email(DEFAULT_RECIPIENT), content);
            Request request = new Request();
            request.setMethod(Method.POST);
            request.setEndpoint("mail/send");
            request.setBody(mail.build());
            Response response = sendGridClient.api(request);
            if (response.getStatusCode() == HttpStatus.ACCEPTED.value()) {
                log.info("Sent mail with Subject '" + mail.getSubject() + "' to recipient '" + DEFAULT_RECIPIENT + "'");
            } else {
                log.info("Problem sending mail with Subject '" + mail.getSubject() + "' to recipient '" + DEFAULT_RECIPIENT + "'");
            }
        } else {
            mail = new Mail(new Email("no-reply@springpetclinic.com"), "Welcome to PetClinic!", new Email(emailNode.asText()), content);
            log.info("Fake sending mail with Subject '" + mail.getSubject() + "' to recipient '" + emailNode.asText() + "'");
        }
    }


    @Override
    public void sendVisitRecordEmail(String visitRecord) throws IOException {
        // Extract visit record from string.
        ObjectMapper objectMapper = new ObjectMapper();
        JsonNode rootNode = objectMapper.readTree(visitRecord);
        JsonNode idNode = rootNode.path("id");
        JsonNode dateNode = rootNode.path("date");
        JsonNode descriptionNode = rootNode.path("description");
        JsonNode petIdNode = rootNode.path("petId");
        
        //Create the context to share the information on the owner.
        final Context ctx = new Context();
        ctx.setVariable("date", dateNode.asText());
        ctx.setVariable("description", descriptionNode.asText());
        
        // Create the email
            String contentBody = templateEngine.process("VisitRecordEmailTemplates", ctx);
        Content content = new Content("text/html", contentBody);
        Mail mail;
        
        // Send the email
        if (EMAIL_ACTIVE) {
            mail = new Mail(new Email("no-reply@springpetclinic.com"), "Your recent visit to PetClinic!", new Email(DEFAULT_RECIPIENT), content);
            Request request = new Request();
            request.setMethod(Method.POST);
            request.setEndpoint("mail/send");
            request.setBody(mail.build());
            Response response = sendGridClient.api(request);
            if (response.getStatusCode() == HttpStatus.ACCEPTED.value()) {
                log.info("Sent mail with Subject '" + mail.getSubject() + "' to recipient '" + DEFAULT_RECIPIENT + "'");
            } else {
                log.info("Problem sending mail with Subject '" + mail.getSubject() + "' to recipient '" + DEFAULT_RECIPIENT + "'");
            }
        } else {
            mail = new Mail(new Email("no-reply@springpetclinic.com"), "Your recent visit to PetClinic!", new Email(DEFAULT_RECIPIENT), content);
            log.info("Fake sending mail with Subject '" + mail.getSubject() + "' to recipient '" + DEFAULT_RECIPIENT + "'");
        }
    
    }
    }

```

Additionally, we add the below **Thymeleaf** templates for the email body. These are placed under the `src/main/resources/emailTemplates` folder in the `spring-petclinic-communications-service` application.

> [!NOTE]
> Be sure to replace the <REPLACE_WITH_YOUR_API_GATEWAY_URL> with the URL specific to the API gateway for your microservices.
>

***OwnerCreatedEmailTemplates.html***

```html
<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
  </head>
  <body>
    <p th:text="'Hi ' + ${recipientName} + ','"></p>
    
    Welcome to PetClinic!
    
    
    You can perform the below operations
    <ul>
    <li><a th:href="@{'https://<REPLACE_WITH_YOUR_API_GATEWAY_URL>.azuremicroservices.io/#!/owners/details/' + ${ownerid}}" > View your profile </a> </li>
    <li><a th:href="@{'https://<REPLACE_WITH_YOUR_API_GATEWAY_URL>.azuremicroservices.io/#!/owners/' + ${ownerid} + '/edit'}" > Edit your profile </a> </li>
    <li><a th:href="@{'https://<REPLACE_WITH_YOUR_API_GATEWAY_URL>.azuremicroservices.io/#!/owners/' + ${ownerid} + '/new-pet'}" > Add a new pet </a> </li>
    
    <li><a th:href="@{https://<REPLACE_WITH_YOUR_API_GATEWAY_URL>.azuremicroservices.io/#!/vets}" > View the vets </a> </li>
    
    
    
    </ul>
     <p>
      Regards, <br />
      <em>The PetClinic Team</em>
    </p>
  </body>
</html>
```

***VisitRecordEmailTemplates.html***

```html
<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
  </head>
  <body>
        <p>Dear Pet Owner!</p>
        
        <p th:text="'Here is a summary of your recent visit on ' + ${date} + '!'"></p>
        
        <p th:text="${description}"></p>
        <p>
          Regards, <br />
      <em>The PetClinic Team</em>
    </p>
  </body>
</html>
```

## Receive from Queues

Now that we have the mechanism to send emails sorted out, we can proceed to receive from the Queues and proceed to send these emails.

We do this by creating a JmsListener on the queue **CreatedOwner** (to which we sent messages from the `spring-petclinic-customers-service` in the previous section). Once a message lands on the queue, we retrieve it, parse the customer information and send an email to the customer.

We start this by creating a new package `org.springframework.samples.petclinic.communication.listeners` under `org.springframework.samples.petclinic.communication`.

We then create a `OwnerCreatedQueueListener` class and place the below code in the file.

```java
package org.springframework.samples.petclinic.communication.listeners;

import java.io.IOException;
import java.util.concurrent.TimeUnit;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jms.annotation.JmsListener;
import org.springframework.samples.petclinic.communication.email.EmailService;
import org.springframework.stereotype.Component;

@Component
public class OwnerCreatedQueueListener {
    
    private static final String QUEUE_NAME = "CreatedOwner";
    
    @Autowired
    private EmailService emailService;

  
    @JmsListener(destination = QUEUE_NAME, containerFactory = "jmsListenerContainerFactory")
    public void receiveMessage(String ownerString) throws IOException, InterruptedException {
        
        // remove the header information
        String refinedOwnerString = ownerString.substring(ownerString.indexOf("{"));
        TimeUnit.SECONDS.sleep(1);
        emailService.sendOwnerWelcomeEmail(refinedOwnerString);
        
    }
    
}

```

## Receive from Topics

Just like we received from the Queues, we can setup subscriptions on Topics and receive and process messages from those as well.

In the below example, we will create a subscription on the topic **visitRecordTopic** (to which we sent messages from the `spring-petclinic-visits-service` in the previous section) by setting up a `JmsListener` on it. When the messages are sent by the `spring-petclinic-visits-service` to the **visitRecordTopic**, the jmslistener we define here will receive the message and send the email to the customer regarding their recent visit.

To achieve this, we need to create a `VisitRecordTopicListener` class and place the below code in the file.

```java
package org.springframework.samples.petclinic.communication.listeners;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jms.annotation.JmsListener;
import org.springframework.samples.petclinic.communication.email.EmailService;
import org.springframework.stereotype.Component;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
public class VisitRecordTopicListener {

    private static final String TOPIC_NAME = "visitRecordTopic";

    @Autowired
    private EmailService emailService;

    @JmsListener(destination = TOPIC_NAME, subscription = "visitRecordSubscriber", containerFactory = "topicJmsListenerContainerFactory")
    public void receiveMessage(String visitRecordString) throws IOException {
        // remove the header information
        String refinedVisitRecordString = visitRecordString.substring(visitRecordString.indexOf("{"));
        
        emailService.sendVisitRecordEmail(refinedVisitRecordString);
    }
}
```
