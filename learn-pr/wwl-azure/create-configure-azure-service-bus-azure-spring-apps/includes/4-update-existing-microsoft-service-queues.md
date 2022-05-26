In the previous unit, you saw how an existing microservice interacts with the Service Bus queue.

In this unit, you'll enable the **visits** microservice to read messages from a queue and write messages to separate queue. You'll need to add the necessary dependencies.

1. In the **\_pom.xml\_ file** of the`_visits_ microservice`, add the following dependency.

`<dependency> <groupId>com.azure.spring</groupId> <artifactId>spring-cloud-azure-starter-servicebus-jms</artifactId> <version>4.0.0</version> </dependency>`

# 
