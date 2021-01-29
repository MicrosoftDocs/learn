Congratulations! You've deployed a Spring Boot microservices application that interacts with Azure Service Bus.

You used the following steps:

1. You used an existing Spring microservices application - the [Spring Petclinic Microservices](https://github.com/Azure-Samples/spring-petclinic-microservices)

2. You modified the existing microservices - customers and visit microservices - to send messages to Azure Service Bus.

3. You created a new microservice on this application - Communications microservice to receive messages from queues and subscriptions on Azure Service Bus.

4. You setup an emailer module to send emails based on messages received from the Queues and Subscriptions.

## Clean up resources

In the preceding steps, you created Azure resources in a resource group. If you don't expect to need these resources in the future, delete the resource group from portal, or by running the following command in the Cloud Shell:

```bash
az group delete --name <your resource group name> --yes
```

This command may take a minute to run.

> [!IMPORTANT]
> It's important that you de-provision the Azure resources used in this module to avoid accruing unwanted charges.

## Additional resources

For more information about Spring JMS, see Spring's [reference documentation](https://docs.spring.io/spring-framework/docs/3.0.x/spring-framework-reference/html/jms.html).

For more information about how to use JMS with Azure Service Bus, see [the Azure Service Bus JMS 2.0 documentation](https://docs.microsoft.com/azure/service-bus-messaging/how-to-use-java-message-service-20).

For more information about Java Message Service entities and how they work with Azure Service Bus, check out the [JMS 2.0 entities documentation](https://docs.microsoft.com/azure/service-bus-messaging/java-message-service-20-entities).
