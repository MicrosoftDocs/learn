---
interactive:bash
zone_pivot_groups:azure-interface
title:Update an existing microservice to use queues
---
In the previous unit, you saw how an existing microservice interacts with the Service Bus queue.

In this unit, you'll enable the **visits** microservice to read messages from a queue and write messages to separate queue. You'll need to add the necessary dependencies.

1.  From the Git Bash window, in the **config** repository you cloned locally, edit the **spring-petclinic-microservice/spring-petclinic-visits-service/pom.xml** file of the **visits** microservice.
2.  In the section, following the last dependency element, add the following dependency element.

```
<dependency>
    <groupId>com.azure.spring</groupId>
    <artifactId>spring-cloud-azure-starter-servicebus-jms</artifactId>
</dependency>
```
