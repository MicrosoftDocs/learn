Now that you've locked down the internet access to the MySQL database, you'll perform a similar setup to protect the Key Vault content.

1.  Because you've already disabled network policies on the private link subnet, you can now proceed to create a private endpoint for the Key Vault instance.
    
    ```Bash
    KEYVAULT_RESOURCE_ID=$(az resource show -g ${RESOURCE_GROUP} -n ${KEYVAULT_NAME}--query "id" \
        --resource-type "Microsoft.KeyVault/vaults" -o tsv)
    
    az network private-endpoint create \
        --resource-group $RESOURCE_GROUP \
        --vnet-name $VIRTUAL_NETWORK_NAME \
        --subnet $PRIVATE_ENDPOINTS_SUBNET_NAME \
        --name pe-openlab-keyvault \
        --private-connection-resource-id "$KEYVAULT_RESOURCE_ID" \
        --group-ids vault \
        --connection-name openlab-keyvault-connection \
        --location $LOCATION
    ```

2.  You'll need to create a private DNS zone, this time for **privatelink.vaultcore.azure.net**.
    
    ```Bash
    az network private-dns zone create \
        --resource-group $RESOURCE_GROUP \
        --name "privatelink.vaultcore.azure.net"
    
    az network private-dns link vnet create \
        --resource-group $RESOURCE_GROUP \
        --zone-name "privatelink.vaultcore.azure.net" \
        --name MyVaultDNSLink \
        --virtual-network $VIRTUAL_NETWORK_NAME \
        --registration-enabled false
    ```

3.  You'll need to create the A record to link the Azure Key Vault instance name to the IP address of the private endpoint.
    
    ```Bash
    KEYVAULT_NIC_ID=$(az network private-endpoint show \
        --name pe-openlab-keyvault \ 
        --resource-group $RESOURCE_GROUP \ 
        --query 'networkInterfaces[0].id' -o tsv) KEYVAULT_NIC_IPADDRESS=$(az resource show \ 
        --ids $KEYVAULT_NIC_ID \
        --api-version 2019-04-01 -o json | jq -r '.properties.ipConfigurations[0].properties.privateIPAddress')
    
    az network private-dns record-set a add-record -g $RESOURCE_GROUP -z "privatelink.vaultcore.azure.net" -n $KEYVAULT_NAME -a $KEYVAULT_NIC_IPADDRESS 
    az network private-dns record-set list -g $RESOURCE_GROUP -z "privatelink.vaultcore.azure.net"
    ```
