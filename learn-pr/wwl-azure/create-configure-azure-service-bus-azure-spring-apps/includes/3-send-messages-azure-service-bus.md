In the Spring Petclinic application, the *messaging-emulator* microservice is already prepared to send messages to an Azure Service Bus. You can use the existing microservices public endpoint to send messages to the Service Bus.

In this unit, you'll do the following activities:

 -  Create and deploy separate application in your Spring Cloud service.
 -  Create a Managed Identity and allow it to access secrets in your Key Vault.
 -  Try another microservice and determine if messages are delivered to the Service Bus.
 -  Use the Service Bus Explorer for the `visits-requests` queue.

Do the following activities to send messages to an Azure Service Bus.

> [!NOTE]
> Make sure you have the most recent compiled version of the microservices by running a separate build.

```azurecli
mvn clean package -DskipTests
```

1.  Create a new application in your Spring Cloud Service for the `messaging-emulator`and assign it a public endpoint.

```azurecli
az spring-cloud app create 
    --service $SPRING_CLOUD_SERVICE \
    --resource-group $RESOURCE_GROUP \
    --name messaging-emulator \
    --assign-endpoint true
```

2.  Assign an identity to the new application and store the identity in an environment variable.

```azurecli
az spring-cloud app identity assign \
    --service $SPRING_CLOUD_SERVICE \
    --resource-group $RESOURCE_GROUP \
    --name messaging-emulator

messaging_emulator_id=$(az spring-cloud app identity show \
    --service $SPRING_CLOUD_SERVICE \
    --resource-group $RESOURCE_GROUP \
    --name messaging-emulator \
    --output tsv \
    --query principalId)
```

3.  Allow the identity **get** and **list** permissions on your Key Vault secrets.

```azurecli
az keyvault set-policy \
    --name $KEYVAULT_NAME \
    --resource-group $RESOURCE_GROUP \
    --secret-permissions get list \
    --object-id $messaging_emulator_id
```

4.  Deploy the **messaging-emulator``**application.

```azurecli
az spring-cloud app deploy 
    --service $SPRING_CLOUD_SERVICE \
    --resource-group $RESOURCE_GROUP \
    --name messaging-emulator \
    --no-wait \
    --artifact-path spring-petclinic-messaging-emulator/target/spring-petclinic-messaging-emulator-2.6.1.jar \
    --env SPRING_PROFILES_ACTIVE=mysql
```

5.  From the Azure portal, navigate to your resource group and to your Azure Spring Apps Service.
6.  Select **Apps** in your Azure Spring Apps Service and select the **messaging-emulator** app.
7.  Select the *URL* on the overview page and open the microservice in separate browser tab.
8.  Add a number for the**Pet** and a **Message** and select **Submit**.
9.  From the Azure portal, navigate to your Service Bus namespace.
10. Select **Queues** and the **visits-requests** queue.
11. On the overview page, you'll see that there's an active message count of 1.
12. Select **Service Bus Explorer (Preview)** and select **Peek** allowing a view of the messages in the queue without dequeuing.
13. Select **Peek**. You'll view information for the message recently placed in the message queue.

To inspect the code of the **messaging-emulator** microservice, review:

 -  Dependencies for the Service Bus in the***pom.xml*** file.
 -  The `PetClinicVisitRequestSender` and`PetClinicMessageResponsesReceiver` classes in the `service`folder. The classes enable sending and receiving messages to and from a queue using JMS.
 -  The `PetClinicMessageRequest` and `PetClinicMessageResponse` classes in the ***entity***folder to see the messages being send back and forth.
 -  The `MessagingConfig`class in the ***config***folder provides conversion to and from JSON.
