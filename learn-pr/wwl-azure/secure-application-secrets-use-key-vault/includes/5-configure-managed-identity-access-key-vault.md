By now, you've created a managed identity for `spring-petclinic-customers-service`, `spring-petclinic-vets-service` and `spring-petclinic-visits-service`. The three apps use the database hosted by the Azure Database for MySQL Single Server instance.

The three apps of your application use the database hosted by the Azure Database for MySQL Single Server instance, so their managed instances will need to be granted permissions to access the secrets:

 -  spring-petclinic-customers-service
 -  spring-petclinic-vets-service
 -  spring-petclinic-visits-service

In this unit, you'll configure the managed identities access to your Key Vault.

1.  Assign access policy for Key Vault for each Spring Cloud app identity.

```Bash
az keyvault set-policy \
    --name $KEYVAULT_NAME \
    --resource-group $RESOURCE_GROUP \
    --secret-permissions get list  \
    --object-id $customers_service_id

az keyvault set-policy \
    --name $KEYVAULT_NAME \
    --resource-group $RESOURCE_GROUP \
    --secret-permissions get list  \
    --object-id $vets_service_id

az keyvault set-policy \
    --name $KEYVAULT_NAME \
    --resource-group $RESOURCE_GROUP \
    --secret-permissions get list  \
    --object-id $visits_service_id

```
