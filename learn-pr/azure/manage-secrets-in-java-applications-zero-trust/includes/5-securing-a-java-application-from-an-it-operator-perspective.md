In this unit, you'll use the Azure CLI to grant your Java application access to the Azure Key Vault secrets.

You'll have the role of an IT operator, who will manage those secrets and grant access to them.

## Store secrets into Azure Key Vault

In your application, you had two secrets to store:

- `${azureDatabaseName}` is the name of the PostgreSQL database that was configured earlier in the `AZ_DATABASE_NAME` environment variable. Type `echo $AZ_DATABASE_NAME` to see it.
- `${azureDatabasePassword}` is the name of the database password that was configured earlier in the `AZ_DATABASE_PASSWORD` environment variable. Type `echo $AZ_DATABASE_PASSWORD` to see it.

Let's create an Azure Key Vault instance and store those secrets in it:

```bash
AZ_KEY_VAULT_NAME=kv-${AZ_RESOURCE_GROUP}

az keyvault create \
    --name $AZ_KEY_VAULT_NAME \
    --resource-group $AZ_RESOURCE_GROUP \
    --location $AZ_LOCATION

az keyvault secret set \
    --vault-name $AZ_KEY_VAULT_NAME \
    --name azureDatabaseName \
    --value ${AZ_DATABASE_NAME}

az keyvault secret set \
    --vault-name $AZ_KEY_VAULT_NAME \
    --name azureDatabasePassword \
    --value ${AZ_DATABASE_PASSWORD}
```

## Grant your application access to Azure Key Vault

To access Azure Key Vault, your Spring Boot application needs first to have an Azure identity assigned.

```bash
az spring-cloud app identity assign \
   --resource-group $AZ_RESOURCE_GROUP \
   --service $AZ_SPRING_CLOUD \
   --name application
```

Once this identity is assigned, you'll need to use the application's Principal ID and Tenant ID
as environment variables. Those variables will be used by the Azure Key Vault Spring Boot Starter
to access Azure Key Vault.

```bash
az spring-cloud app update \
   --resource-group $AZ_RESOURCE_GROUP \
   --service $AZ_SPRING_CLOUD \
   --name application \
   --env \
   AZURE_KEYVAULT_ENABLED=true \
   AZURE_KEYVAULT_URI=https://$AZ_KEY_VAULT_NAME.vault.azure.net/
```

Then, you'll need to grant your application access to the Azure Key Vault.

```bash
AZ_SPRING_CLOUD_PRINCIPAL_ID=$(az spring-cloud app identity show --resource-group $AZ_RESOURCE_GROUP --service $AZ_SPRING_CLOUD --name application | jq --raw-output '.principalId')

az keyvault set-policy \
    --name $AZ_KEY_VAULT_NAME \
    --resource-group $AZ_RESOURCE_GROUP \
    --object-id $AZ_SPRING_CLOUD_PRINCIPAL_ID \
    --secret-permissions get list
```

Your application should now have the permissions to access the secrets stored in Azure Key Vault.
