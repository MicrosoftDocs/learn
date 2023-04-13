---
interactive:bash
zone_pivot_groups:azure-interface
title:Create an Azure Service Bus
---
Azure Service Bus is a fully managed message broker with message queues and publish-subscribe articles (in a namespace). Service Bus is used to decouple applications and services from each other, providing the following benefits:

 -  Load-balancing work across competing workers.
 -  Safely routing and transferring data and control across service and application boundaries.
 -  Coordinating transactional work that requires a high-degree of reliability.

Data is transferred between different applications and services using **messages**. A message is a container holding metadata and contains data. The data can be any kind of information, including structured data encoded with the common formats such as the following ones: JSON, XML, and Plain Text.

As seen in the graphic below, Service Bus provides enterprise messaging among many kinds of software, including cloud applications, on-premises applications, and Azure services.

:::image type="content" source="../media/service-bus-integration-56cecfdf.png" alt-text="Diagram that shows how Azure Service Bus interacts with multiple components.":::


Some common messaging scenarios are:

 -  **Messaging**. Transfer business data, such as sales or purchase orders, journals, or inventory movements.
 -  **Decouple applications**. Improve reliability and scalability of applications and services. Producer and consumer don't have to be online or readily available at the same time. The load is leveled such that traffic spikes don't overtax a service.
 -  **Load balancing**. Allows for multiple competing consumers to read from a queue at the same time, each safely obtaining exclusive ownership to specific messages.
 -  **Topics and subscriptions**. Enable 1:*n* relationships between publishers and subscribers, allowing subscribers to select messages from a published message stream.
 -  **Transactions**. Allows you to do several operations, all in the scope of an atomic transaction.
 -  **Message sessions**. Implement high-scale coordination of workflows and multiplexed transfers that require strict message ordering or message deferral.

## Queues

Messages are sent to and received from **queues**. Queues store messages until the receiving application is available to receive and process them.

:::image type="content" source="../media/service-bus-queue-b9b36470.png" alt-text="Diagram that shows how queues store messages until the receiving application is available to process them.":::


Messages in queues are ordered and timestamped on arrival. Once the messages are received by the broker, the message is always held durably in triple-redundant storage, spread across availability zones if the namespace is zone-enabled. Service Bus never leaves messages in memory or volatile storage after they've been reported to the client as accepted.

Messages are delivered in **pull** mode, only delivering messages when requested. Unlike the busy-polling model of some other cloud queues, the pull operation can be long-lived and only complete once a message is available.

## Articles

You can also use **topics** to send and receive messages. While a queue is often used for point-to-point communication, topics are useful in publish/subscribe scenarios.

:::image type="content" source="../media/service-bus-topic-92b58aec.png" alt-text="Diagram that shows how the queue is used for point-to-point communication.":::


Topics can have multiple, independent subscriptions, which attach to the topic and otherwise work exactly like queues from the receiver side. A subscriber to a topic can receive a copy of each message sent to that topic. Subscriptions are named entities. Subscriptions are durable by default, but can be configured to expire and then be automatically deleted.

## Namespaces

A namespace is a container for all messaging components (queues and topics). Multiple queues and topics can be in a single namespace, and namespaces often serve as application containers.

A namespace can be compared to a server in the terminology of other brokers, but the concepts aren't directly equivalent. A Service Bus namespace is your own capacity slice of a large cluster made up of dozens of all-active virtual machines.

## Create and Azure Service Bus

In this unit, you'll create an Azure Service Bus namespace and queue to direct messages to. You'll create two queues called `visits-requests` and`visits-confirmations`.

Make sure to create the Service Bus namespace with a **Premium** SKU to take advantage of the JMS 2.0 messaging. Also, you'll add a connection string to your Service Bus namespace in Key Vault so the microservices can safely access the value.

> [!NOTE]
> As an alternative you can use the Managed Identity of your microservice to connect to the Service Bus. For this exercise, you'll store the connection string in your Key Vault.

The connection to the Service Bus needs to be stored in the `spring.jms.servicebus.connection-string`application property. You'll name your Key Vault secret `SPRING-JMS-SERVICEBUS-CONNECTIONSTRING` and add the text below in your **application.yml** file in the configuration repository. The modification will translate the secret in Key Vault to the correct application property for your microservices.

```
jms:
    servicebus:
        connection-string: ${spring.jms.servicebus.connectionstring}
        idle-timeout: 60000
        pricing-tier: premium
```

1.  Create a new Service Bus namespace. The name you use for your namespace should be globally unique, so update the value for the environment variable. You'll need to create the namespace with the **Premium** SKU.
    
    ```Bash
    SERVICEBUS_NAMESPACE=sb-$APPNAME-$UNIQUEID
    
    az servicebus namespace create \
        --resource-group $RESOURCE_GROUP \
        --name $SERVICEBUS_NAMESPACE \
        --location $LOCATION \
        --sku Premium
    ```

2.  Create a new queue in the namespace called `visits-requests`.
    
    ```Bash
    az servicebus queue create \
        --resource-group $RESOURCE_GROUP \
        --namespace-name $SERVICEBUS_NAMESPACE \
        --name visits-requests
    
    ```

4.  Retrieve the value of the connection string to the newly created Service Bus namespace.
    
    ```Bash
    SERVICEBUS_CONNECTIONSTRING=$(az servicebus namespace authorization-rule keys list \
        --resource-group $RESOURCE_GROUP \
        --namespace-name $SERVICEBUS_NAMESPACE \
        --name RootManageSharedAccessKey \
        --query primaryConnectionString \
        --output tsv)
    ```

5.  Create a new Key Vault secret for the connection string.
    
    ```Bash
    az keyvault secret set \
        --name SPRING-JMS-SERVICEBUS-CONNECTION-STRING \
        --value $SERVICEBUS_CONNECTIONSTRING \
        --vault-name $KEYVAULT_NAME
    ```

6.  In the configuration repository, search for the **application.yml** file. Add the following text below the mysql profile (likely, line 78).
    
    ```yaml
    jms:
        servicebus:
            connection-string: ${spring.jms.servicebus.connectionstring}
            idle-timeout: 60000
            pricing-tier: premium
    ```
    
    Make sure the YAML is correctly aligned. The **jms** element, and should be at the same level as the **config** and **datasource** elements.
7.  Commit and push your changes to the remote repository.
8.  ```Bash
    cd ~/projects/spring-petclinic-microservices-config
    git add .
    git commit -m 'added service bus'
    git push
    ```
