Congratulations! In this module, you used Azure Service Bus to decouple your sender and receiver Spring Boot applications.

## Clean up resources

 The below command will delete and clean up the resources you created for the purposes of this module.

```bash
az servicebus namespace delete \
   --resource-group $AZ_RESOURCE_GROUP \
   --namespace-name $AZ_SB_PREMIUM_NAMESPACE

az group delete \
   --name $AZ_RESOURCE_GROUP \
   --location $AZ_LOCATION
```

## Extra resources

We recommend the following materials to learn about Java Message Service (JMS) 2.0 and how it works with Azure Service Bus:

   * [Java Message Service (JMS) 2.0 with Azure Service Bus Premium](https://docs.microsoft.com/azure/service-bus-messaging/how-to-use-java-message-service-20)
   * [Java Message Service (JMS) 2.0 entities in Azure Service Bus](https://docs.microsoft.com/azure/service-bus-messaging/java-message-service-20-entities)
   * [Java Message Service (JMS) 2.0 developer guide](https://docs.microsoft.com/azure/service-bus-messaging/jms-developer-guide?tabs=JMS-20)

For more information about Azure Service Bus, see:

   * [Azure Service Bus - documentation](https://docs.microsoft.com/azure/service-bus-messaging/)
   * [What is Azure Service Bus?](https://docs.microsoft.com/azure/service-bus-messaging/service-bus-messaging-overview)
