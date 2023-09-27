---
interactive:bash
zone_pivot_groups:azure-interface
title:Sending messages to Azure Service Bus
---
In the Spring Petclinic application, the **spring-petclinic-messaging-emulator** microservice is already prepared to send messages to an Azure Service Bus. You can use the existing microservices public endpoint to send messages to the Service Bus.

In this unit, you'll do the following activities:

 -  Create and deploy separate application in your Spring Apps service.
 -  Create a Managed Identity and allow it to access secrets in your Key Vault.
 -  Try another microservice and determine if messages are delivered to the Service Bus.
 -  Use the Service Bus Explorer for the `visits-requests` queue.

> [!NOTE]
> Make sure you have the most recent compiled version of the microservices by running a separate build, by running **mvn clean package -DskipTests**

In the Lab repository Extra folder, the messaging-emulator microservice is already prepared to send messages to an Azure Service Bus namespace. You can add this microservice to your current Spring Petclinic project, deploy it as an extra microservice in your Azure Spring Apps service and use this microservice's public endpoint to send messages to your Service Bus namespace. Test this functionality and inspect whether messages end up in the Service Bus namespace you created by using the Service Bus Explorer for the visits-requests queue.

Do the following procedure to test and send messages to an Azure Service Bus.

1.  As a first step in the parent **pom.xml** file, you'll have to uncomment the module for the `spring-petclinic-messaging-emulator` in the **&lt;modules&gt;** element at line 26
    
    ```azurecli
    <module>spring-petclinic-messaging-emulator</module>
    ```
2.  Update the compiled version of the microservices available by running another build.
    
    ```azurecli
    cd ~/projects/spring-petclinic-microservices
    mvn clean package -DskipTests
    ```
3.  Create a new application in your Spring Apps service for the `messaging-emulator`and assign a public endpoint to it.
    
    ```azurecli
    az spring app create 
        --service $SPRING_APPS_SERVICE \
        --resource-group $RESOURCE_GROUP \
        --name messaging-emulator \
        --assign-endpoint true
    ```
4.  Create a system-assigned identity to this new application and store the reference to the identity in an environment variable.
    
    ```azurecli
    cd ~/projects/spring-petclinic-microservices
    mvn clean package -DskipTests
    ```
5.  Create a new application in your Spring Apps Service for the `messaging-emulator`and assign it a public endpoint.
    
    ```azurecli
    az spring app identity assign \
        --service $SPRING_APPS_SERVICE \
        --resource-group $RESOURCE_GROUP \
        --name messaging-emulator \
        --system-assigned
    
    MESSAGING_EMULATOR_ID=$(az spring app identity show \
        --service $SPRING_APPS_SERVICE \
        --resource-group $RESOURCE_GROUP \
        --name messaging-emulator \
        --output tsv \
        --query principalId)
    ```

6.  Grant to the newly assigned identity the get and list permissions on your Key Vault secrets.
    
    ```azurecli
    az keyvault set-policy \
        --name $KEYVAULT_NAME \
        --resource-group $RESOURCE_GROUP \
        --secret-permissions get list \
        --object-id $MESSAGING_EMULATOR_ID
    ```

7.  You can now deploy the `messaging-emulator` application.
    
    ```azurecli
    az spring app deploy
        --service $SPRING_APPS_SERVICE \
        --resource-group $RESOURCE_GROUP \
        --name messaging-emulator \
        --no-wait \
        --artifact-path spring-petclinic-messaging-emulator/target/spring-petclinic-messaging-emulator-$VERSION.jar \
        --env SPRING_PROFILES_ACTIVE=mysql
    ```

8.  From the Azure portal, navigate to your resource group and to your Azure Spring Apps Service.
9.  From **Settings**, select **Apps.** Wait until the **Provisioning state** of the **messaging-emulator** app changes to **Succeeded**, then select **messaging-emulator.**
10. Select the *URL* on the overview page and open the microservice in separate browser tab.
11. From the open browser titled **Message**, enter **1** in the **Pet** text box and text in the **Message** box. Select **Submit.**
12. From the Azure portal, navigate to your Service Bus namespace.
13. Select **Queues** and the **visits-requests** queue.
14. On the **Overview** page, you'll see that there's an active message count of **1**.
15. Select **Service Bus Explorer (Preview)** and select **Peek from start** allowing a view of the messages in the queue without dequeuing.
16. Select **Peek**. You'll view information for the message recently placed in the message queue.
17. Select the message entry in the queue and review the **Message Body** section to confirm that its content matches the message you submitted.

To inspect the code of the **messaging-emulator** microservice, review:

 -  Dependencies for the Service Bus in the **pom.xm*l*** file.
 -  The `PetClinicVisitRequestSender` and `PetClinicMessageResponsesReceiver` classes in the `service` folder. The classes enable sending and receiving messages to and from a queue using JMS.
 -  The `PetClinicMessageRequest` and `PetClinicMessageResponse` classes in the **entity** folder to see the messages being send back and forth.
 -  The `MessagingConfig`class in the **config** folder provides conversion to and from JSON.

In the next unit, you'll add similar functionality to the **visits** service.
