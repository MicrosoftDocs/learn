You've created a managed identity for `spring-petclinic-customers-service`, `spring-petclinic-vets-service` and `spring-petclinic-visits-service`. The three apps use the database hosted by the Azure Database for MySQL Single Server instance.

The three apps of your application use the database hosted by the Azure Database for MySQL Single Server instance, so their managed instances will need to be granted permissions to access the secrets:

 -  spring-petclinic-customers-service
 -  spring-petclinic-vets-service
 -  spring-petclinic-visits-service

In this unit, you'll configure the managed identities access to your Key Vault.

Assign access policy for Key Vault for each Spring Cloud app identity by running the following script.

```Bash
az keyvault set-policy \
    --name $KEYVAULT_NAME \
    --resource-group $RESOURCE_GROUP \
    --secret-permissions get list  \
    --object-id $CUSTOMERS_SERVICE_ID

az keyvault set-policy \
    --name $KEYVAULT_NAME \
    --resource-group $RESOURCE_GROUP \
    --secret-permissions get list  \
    --object-id $VETS_SERVICE_ID

az keyvault set-policy \
    --name $KEYVAULT_NAME \
    --resource-group $RESOURCE_GROUP \
    --secret-permissions get list  \
    --object-id $VISITS_SERVICE_ID

```
