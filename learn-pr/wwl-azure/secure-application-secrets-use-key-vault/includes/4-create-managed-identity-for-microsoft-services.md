In this unit, you'll connect your Key Vault to your Spring Petclinic microservices using a managed identity. The managed identity will be assigned to your application. The process will also create a Service Principal for your application in Microsoft Entra ID.

The apps deployed as the Spring Petclinic microservices will connect to the newly created Key Vault using a managed identity. The process of creating a managed identity will automatically create a Microsoft Entra service principal for your application. Managed identities minimize the overhead associated with managing service principals, since their secrets used for authentication are automatically rotated. The procedure below assigns a managed identity to a Spring Apps service application.

You'll assign an identity to the microservices used by the database:

 -  spring-petclinic-customers-service
 -  spring-petclinic-vets-service
 -  spring-petclinic-visits-service

1.  Secret rotation is handled by Managed Identity. The procedure below assigns a Managed Identity to an application in Spring Apps service by assigning an identity to each of the apps.
    
    ```Bash
    az spring app identity assign \
        --service $SPRING_APPS_SERVICE \
        --resource-group $RESOURCE_GROUP \
        --name customers-service \
        --system-assigned
    
    az spring app identity assign \
        --service $SPRING_APPS_SERVICE \
        --resource-group $RESOURCE_GROUP \
        --name visits-service \
        --system-assigned
    
    az spring app identity assign \
        --service $SPRING_APPS_SERVICE \
        --resource-group $RESOURCE_GROUP \
        --name vets-service \
        --system-assigned
    
    ```

2.  Export the identity details to a separate environment variable for each of the apps so you can reuse it in the next part of the exercise.
    
    ```Bash
    customers_service_id=$(az spring app identity show \
        --service $SPRING_APPS_SERVICE \
        --resource-group $RESOURCE_GROUP \
        --name customers-service \
        --output tsv \
        --query principalId)
    
    vets_service_id=$(az spring app identity show \
        --service $SPRING_APPS_SERVICE \
        --resource-group $RESOURCE_GROUP \
        --name vets-service \
        --output tsv \
        --query principalId)
    
    visits_service_id=$(az spring app identity show \
        --service $SPRING_APPS_SERVICE \
        --resource-group $RESOURCE_GROUP \
        --name visits-service \
        --output tsv \
        --query principalId)
    
    ```
