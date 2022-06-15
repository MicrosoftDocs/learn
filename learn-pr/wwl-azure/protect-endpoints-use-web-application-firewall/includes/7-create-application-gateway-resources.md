You're now ready to create an Application Gateway instance to expose your application to the internet.

> [!NOTE]
> An Application Gateway resource needs a dedicated subnet to be deployed into, however, you already created this subnet at the beginning of this exercise.

1.  An Application Gateway instance also needs a public IP address, which you'll create next by running the following commands from the Git Bash shell:
    
    ```Bash
    APPLICATION_GATEWAY_PUBLIC_IP_NAME=app-gw-openlab-public-ip
    az network public-ip create \
        --resource-group $RESOURCE_GROUP \
        --location $LOCATION \
        --name $APPLICATION_GATEWAY_PUBLIC_IP_NAME \
        --allocation-method Static \
        --sku Standard \
        --dns-name $DNS_LABEL
    ```

2.  In addition, an Application Gateway instance also needs to have access to the self-signed certificate in your Key Vault. You'll create a managed identity associated with the Application Gateway instance and retrieve the object ID of this identity.
    
    ```Bash
    APPGW_IDENTITY_NAME=msi-appgw-openlab
    az identity create \
        --resource-group $RESOURCE_GROUP \
        --name $APPGW_IDENTITY_NAME
    
    APPGW_IDENTITY_CLIENTID=$(az identity show \
        --resource-group $RESOURCE_GROUP \
        --name $APPGW_IDENTITY_NAME \
        --query clientId \
        --output tsv)
    
    APPGW_IDENTITY_OID=$(az ad sp show \
        --id $APPGW_IDENTITY_CLIENTID \
        --query objectId \
        --output tsv)
    ```

3.  You can now reference the object ID when granting the get and list permissions to the Key Vault secrets and certificates.
    
    ```Bash
    az keyvault set-policy \
        --name $KEYVAULT_NAME \
        --resource-group $RESOURCE_GROUP \
        --object-id $APPGW_IDENTITY_OID \
        --secret-permissions get list \
        --certificate-permissions get list
    ```
    
    > [!NOTE]
    > In order for this implementation to work, the Application Gateway instance requires access to certificate and secrets in the Azure Key Vault instance.

4.  Next, you need to retrieve the ID of the self-signed certificate stored in your Key Vault. You'll use the ID in the following step.
    
    ```Bash
    KEYVAULT_SECRET_ID_FOR_CERT=$(az keyvault certificate show \
        --name $CERT_NAME_IN_KV \
        --vault-name $KEYVAULT_NAME \
        --query sid \
        --output tsv)
    ```

5.  With all relevant information collected, you can now provision an instance of Application Gateway.
    
    ```Bash
    APPGW_NAME=appgw-openlab
    APPNAME=api-gateway
    SPRING_APP_PRIVATE_FQDN=${APPNAME}.private.azuremicroservices.io
    az network application-gateway create \
        --name $APPGW_NAME \
        --resource-group $RESOURCE_GROUP \
        --location $LOCATION \
        --capacity 2 \
        --sku WAF_v2 \
        --frontend-port 443 \
        --http-settings-cookie-based-affinity Disabled \
        --http-settings-port 443 \
        --http-settings-protocol Https \
        --public-ip-address $APPLICATION_GATEWAY_PUBLIC_IP_NAME \
        --vnet-name $VIRTUAL_NETWORK_NAME \
        --subnet $APPLICATION_GATEWAY_SUBNET_NAME \
        --servers $SPRING_APP_PRIVATE_FQDN \
        --key-vault-secret-id $KEYVAULT_SECRET_ID_FOR_CERT \
        --identity $APPGW_IDENTITY_NAME
    ```

6.  To complete the configuration of the instance of Application Gateway, you need to retrieve the public key of the self-signed certificate, which is required to configure the certificate as issued by a trusted certification authority.
    
    ```Bash
    az keyvault certificate download \
        --vault-name $KEYVAULT_NAME \
        --name $CERT_NAME_IN_KV \
        --file ./selfsignedcert.crt \
        --encoding DER
    
    az network application-gateway root-cert create \
        --resource-group $RESOURCE_GROUP \
        --cert-file ./selfsignedcert.crt \
        --gateway-name $APPGW_NAME \
        --name MySelfSignedTrustedRootCert
    ```

7.  Finally, you can now update the HTTP settings of the Application Gateway instance to configure self-signed certificate as issued by a trusted certification authority.
    
    ```Bash
    az network application-gateway http-settings update \
        --resource-group $RESOURCE_GROUP \
        --gateway-name $APPGW_NAME \
        --host-name-from-backend-pool false \
        --host-name $DNS_NAME \
        --name appGatewayBackendHttpSettings \
        --root-certs MySelfSignedTrustedRootCert
    ```
