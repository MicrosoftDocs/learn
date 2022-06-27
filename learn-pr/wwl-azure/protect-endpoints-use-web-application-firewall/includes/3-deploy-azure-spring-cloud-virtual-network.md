Now that all the networking resources are available, you'll need to recreate your Azure Spring Apps service within the virtual network. Additionally, you'll need delete your previous Azure Spring Apps instance.

When you recreate your Spring Cloud instance in the virtual network, you'll also need to update some of the steps from the previous exercise:

 -  Recreate the config server setup.
 -  Recreate and redeploy all apps.
     -  In the previous exercise, you assigned an endpoint to the api-gateway and admin service apps. At this point in this challenge, you won't yet assign an endpoint to them, you'll do so in the next step after configuring your internal DNS.
 -  Reassign a managed identity to each of the apps and give them access to your Key Vault so they can access the username and password info needed for connecting to the database.

1.  Delete the existing Azure Spring Apps instance by running the following command from the Git Bash shell prompt.
    
    ```Bash
    az spring-cloud delete \
        --name $SPRING_CLOUD_SERVICE \
        --resource-group $RESOURCE_GROUP
    ```

2.  Next, recreate your Azure Spring Apps instance by specifying the virtual network and subnets you created.
    
    ```Bash
    SPRING_CLOUD_SERVICE=springcloudsvc$RANDOM$RANDOM
    az config set defaults.group=$RESOURCE_GROUP defaults.spring-cloud=$SPRING_CLOUD_SERVICE
    az spring-cloud create \
        --resource-group $RESOURCE_GROUP \
        --name $SPRING_CLOUD_SERVICE \
        --vnet $VIRTUAL_NETWORK_NAME \
        --service-runtime-subnet service-runtime-subnet \
        --app-subnet apps-subnet \
        --sku standard \
        --location $LOCATION
    ```
    
    > [!NOTE]
    > Provisioning will take approximately 15 minutes.

3.  Set up the config server.
    
    ```Bash
    az spring-cloud config-server git set
        --name $SPRING_CLOUD_SERVICE \
        --resource-group $RESOURCE_GROUP \
        --uri $GIT_REPO \
        --label main \
        --password $GIT_PASSWORD \
        --username $GIT_USERNAME
    ```

4.  Recreate each of the apps in Spring Cloud, including managed identities for the `customers-service,visits-service`, and `vets-service` app.
    
    ```Bash
    az spring-cloud app create \
        --service $SPRING_CLOUD_SERVICE \
        --resource-group $RESOURCE_GROUP \
        --name api-gateway
    
    az spring-cloud app create \
        --service $SPRING_CLOUD_SERVICE \
        --resource-group $RESOURCE_GROUP \
        --name admin-service
    
    az spring-cloud app create \
        --service $SPRING_CLOUD_SERVICE \
        --resource-group $RESOURCE_GROUP \
        --name customers-service \
        --assign-identity true
    
    az spring-cloud app create \
        --service $SPRING_CLOUD_SERVICE \
        --resource-group $RESOURCE_GROUP \
        --name visits-service \
        --assign-identity true
    
    az spring-cloud app create \
        --service $SPRING_CLOUD_SERVICE \
        --resource-group $RESOURCE_GROUP \
        --name vets-service \
        --assign-identity true
    ```

5.  Retrieve the managed identities of the `customers`, `visits`and `vets`apps, and grant them access to the Key Vault instance.
    
    ```Bash
    CUSTOMERS_SERVICE_ID=$(az spring-cloud app identity show \
        --service $SPRING_CLOUD_SERVICE \
        --resource-group $RESOURCE_GROUP \
        --name customers-service \
        --output tsv \
        --query principalId)
    
    az keyvault set-policy \
        --name $KEYVAULT_NAME \
        --resource-group $RESOURCE_GROUP \
        --secret-permissions get list  \
        --object-id $CUSTOMERS_SERVICE_ID
    
    VISITS_SERVICE_ID=$(az spring-cloud app identity show \
        --service $SPRING_CLOUD_SERVICE \
        --resource-group $RESOURCE_GROUP \
        --name visits-service \
        --output tsv \
        --query principalId)
    
    az keyvault set-policy \
        --name $KEYVAULT_NAME \
        --resource-group $RESOURCE_GROUP \
        --secret-permissions get list  \
        --object-id $VISITS_SERVICE_ID
    
    VNETS_SERVICE_ID=$(az spring-cloud app identity show \
        --service $SPRING_CLOUD_SERVICE \
        --resource-group $RESOURCE_GROUP \
        --name vets-service \
        --output tsv \
        --query principalId)
    
    az keyvault set-policy \
        --name $KEYVAULT_NAME \
        --resource-group $RESOURCE_GROUP \
        --secret-permissions get list  \
        --object-id $VNETS_SERVICE_ID
    ```

6.  Redeploy each of the apps.
    
    ```Bash
    az spring-cloud app deploy \
        --service $SPRING_CLOUD_SERVICE \
        --resource-group $RESOURCE_GROUP \
        --name api-gateway \
        --no-wait \
        --artifact-path spring-petclinic-api-gateway/target/spring-petclinic-api-gateway-2.6.3.jar
    
    az spring-cloud app deploy \
        --service $SPRING_CLOUD_SERVICE \
        --resource-group $RESOURCE_GROUP \
        --name admin-service \
        --no-wait \
        --artifact-path spring-petclinic-admin-server/target/spring-petclinic-admin-server-2.6.3.jar
    
    az spring-cloud app deploy \
        --service $SPRING_CLOUD_SERVICE \
        --resource-group $RESOURCE_GROUP \
        --name customers-service \
        --no-wait \
        --artifact-path spring-petclinic-customers-service/target/spring-petclinic-customers-service-2.6.3.jar \
        --env SPRING_PROFILES_ACTIVE=mysql
    
    az spring-cloud app deploy \
        --service $SPRING_CLOUD_SERVICE \
        --resource-group $RESOURCE_GROUP \
        --name visits-service \
        --no-wait \
        --artifact-path spring-petclinic-visits-service/target/spring-petclinic-visits-service-2.6.3.jar \
        --env SPRING_PROFILES_ACTIVE=mysql
    
    az spring-cloud app deploy \
        --service $SPRING_CLOUD_SERVICE \
        --resource-group $RESOURCE_GROUP \
        --name vets-service \
        --no-wait \
        --artifact-path spring-petclinic-vets-service/target/spring-petclinic-vets-service-2.6.3.jar \
        --env SPRING_PROFILES_ACTIVE=mysql
    ```
