You now have a self-signed certificate in Key Vault. Next, you'll configure a public domain name in Azure Spring Apps using the self-signed certificate.

In this exercise, you'll create a custom domain for the **api-gateway** service only. The service will be the only one to be externally exposed.

1.  As a first step you'll need to provide Azure Spring Apps the permissions to read the certificate from Key Vault. You'll need the URI to your Key Vault and the object ID of Spring Apps service.
    
    ```Bash
    VAULTURI=$(az keyvault show -n $KEYVAULT_NAME -g $RESOURCE_GROUP
        --query properties.vaultUri -o tsv)
    ASCDM_OID=$(az ad sp show
        --id 03b39d0f-4213-4864-a245-b1476ec03169 \
        --query objectId \
        --output tsv)
    ```

2.  Once you have the Key Vault URI and the Spring Apps object ID, you can allow this object ID access to your Key Vault.
    
    ```Bash
    az keyvault set-policy -g $RESOURCE_GROUP -n $KEYVAULT_NAME
        --object-id $ASCDM_OID \
        --certificate-permissions get list \
        --secret-permissions get list
    ```

3.  Next, configure TLS using the certificate.
    
    ```Bash
    CERT_NAME_IN_ASC=openlab-certificate
    az spring certificate add \
        --resource-group $RESOURCE_GROUP \
        --service $SPRING_APPS_SERVICE \
        --name $CERT_NAME_IN_ASC \
        --vault-certificate-name $CERT_NAME_IN_KV \
        --vault-uri $VAULTURI
    ```

4.  As a last step, you need to bind the custom domain to the api-gateway app.
    
    ```Bash
    APPNAME=api-gateway
    az spring app custom-domain bind \
        --resource-group $RESOURCE_GROUP \
        --service $SPRING_APPS_SERVICE \
        --domain-name $DNS_NAME \
        --certificate $CERT_NAME_IN_ASC \
        --app $APPNAME
    ```
