In the Spring Petclinic application, the **messaging-emulator** microservice is already prepared to send messages to an Azure Service Bus. You can use the existing microservices public endpoint to send messages to the Service Bus.

In this unit, you'll do the following activities:

 -  Create and deploy separate application in your Spring Apps service.
 -  Create a Managed Identity and allow it to access secrets in your Key Vault.
 -  Try another microservice and determine if messages are delivered to the Service Bus.
 -  Use the Service Bus Explorer for the `visits-requests` queue.

> [!NOTE]
> Make sure you have the most recent compiled version of the microservices by running a separate build, by running **mvn clean package -DskipTests**

In the [Lab repository Extra folder](https://github.com/MicrosoftLearning/Deploying-and-Running-Java-Applications-in-Azure-Spring-Apps/tree/master/Extra), the messaging-emulator microservice is already prepared to send messages to an Azure Service Bus namespace. You can add this microservice to your current Spring Petclinic project, deploy it as an extra microservice in your Azure Spring Apps service and use this microservice's public endpoint to send messages to your Service Bus namespace. Test this functionality and inspect whether messages end up in the Service Bus namespace you just created by using the Service Bus Explorer for the visits-requests queue.

Do the following procedure to test and send messages to an Azure Service Bus.

1.  As a first step you will need to clone the [Lab repository](https://github.com/MicrosoftLearning/Deploying-and-Running-Java-Applications-in-Azure-Spring-Apps). From the Git Bash window, execute the following statement.<br>
    
    ```azurecli
    cd ~/projects git clone https://github.com/MicrosoftLearning/Deploying-and-Running-Java-Applications-in-Azure-Spring-Apps.git
    ```
2.  From the Git Bash window copy the `spring-petclinic-messaging-emulator` to the `spring-petclinic-microservices` directory.
    
    ```azurecli
    cp -R Deploying-and-Running-Java-Applications-in-Azure-Spring-Apps/Extra/spring-petclinic-messaging-emulator spring-petclinic-microservices
    ```
3.  In the main **pom.xml** file, add an extra module for the `spring-petclinic-messaging-emulator` in the **&lt;modules&gt;** element at line 26.
    
    ```azurecli
    
        
         spring-petclinic-messaging-emulator
        
    ```
4.  Update the compiled version of the microservices available by running an additional build.
    
    ```azurecli
    cd ~/projects/spring-petclinic-microservices
    mvn clean package -DskipTests
    ```
5.  Create a new application in your Spring Apps Service for the `messaging-emulator`and assign it a public endpoint.
    
    ```azurecli
    az spring app create \
        --service $SPRING_APPS_SERVICE \
        --resource-group $RESOURCE_GROUP \
        --name messaging-emulator \
        --assign-endpoint true
    ```

2.  Assign an identity to the new application and store the identity in an environment variable.
    
    ```azurecli
    az spring app identity assign \
        --service $SPRING_APPS_SERVICE \
        --resource-group $RESOURCE_GROUP \
        --name messaging-emulator
    
    messaging_emulator_id=$(az spring app identity show \
        --service $SPRING_APPS_SERVICE \
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
    az spring app deploy \
        --service $SPRING_APPS_SERVICE \
        --resource-group $RESOURCE_GROUP \
        --name messaging-emulator \
        --no-wait \
        --artifact-path spring-petclinic-messaging-emulator/target/spring-petclinic-messaging-emulator-2.6.1.jar \
        --env SPRING_PROFILES_ACTIVE=mysql
    ```

5.  From the Azure portal, navigate to your resource group and to your Azure Spring Apps Service.
6.  From **Settings**, select **Apps.** Wait until the **Provisioning state** of the **messaging-emulator** app changes to **Succeeded**, then select **messaging-emulator.**
7.  Select the *URL* on the overview page and open the microservice in separate browser tab.
8.  From the open browser titled **Message**, enter **1** in the **Pet** text box and text in the **Message** box. Select **Submit.**
9.  From the Azure portal, navigate to your Service Bus namespace.
10. Select **Queues** and the **visits-requests** queue.
11. On the **Overview** page, you'll see that there's an active message count of **1**.
12. Select **Service Bus Explorer (Preview)** and select **Peek from start** allowing a view of the messages in the queue without dequeuing.
13. Select **Peek**. You'll view information for the message recently placed in the message queue.
14. Select the message entry in the queue and review the **Message Body** section to confirm that its content matches the message you submitted.

To inspect the code of the **messaging-emulator** microservice, review:

 -  Dependencies for the Service Bus in the **pom.xm*l*** file.
 -  The `PetClinicVisitRequestSender` and `PetClinicMessageResponsesReceiver` classes in the `service` folder. The classes enable sending and receiving messages to and from a queue using JMS.
 -  The `PetClinicMessageRequest` and `PetClinicMessageResponse` classes in the **entity** folder to see the messages being send back and forth.
 -  The `MessagingConfig`class in the **config** folder provides conversion to and from JSON.

In the next unit, you'll add similar functionality to the **visits** service.
