Now that you've locked down the internet access to the MySQL database, you'll perform a similar setup to protect the Key Vault content.

You've enabled a private endpoint, now you can block public access to your database.

1.  To start, you'll need to disable private endpoint network policies in the subnet you'll use to create the private endpoints.
    
    ```Bash
    az network vnet subnet update \
        --name $PRIVATE_ENDPOINTS_SUBNET_NAME \
        --resource-group $RESOURCE_GROUP \
        --vnet-name $VIRTUAL_NETWORK_NAME \
        --disable-private-endpoint-network-policies true
    ```

2.  Next, you'll create the private endpoint corresponding to the Azure Database for MySQL Single Server instance within the same subnet.
    
    ```
    KEYVAULT_RESOURCE_ID=$(az resource show -g ${RESOURCE_GROUP} -n ${KEYVAULT_NAME} \
        --query "id" \
        --resource-type "Microsoft.KeyVault/vaults" -o tsv)
    
    az network private-endpoint create --resource-group $RESOURCE_GROUP \
        --vnet-name $VIRTUAL_NETWORK_NAME \
        --subnet $PRIVATE_ENDPOINTS_SUBNET_NAME \
        --name pe-openlab-keyvault \
        --private-connection-resource-id "$KEYVAULT_RESOURCE_ID" \
        --group-id vault \
        --connection-name openlab-keyvault-connection \
        --location $LOCATION
    ```
    
    Once you've created the private endpoint, you'll set up a private Azure DNS zone named **privatelink.mysql.database.azure.com** with an A DNS record matching the original DNS name with the suffix **mysql.database.azure.com** but replacing that suffix with **privatelink.mysql.database.azure.com**. Your apps connecting to the MySQL database won't need to be updated, but instead they can continue using the existing connection strings.

3.  To implement this configuration, start by creating a new private DNS zone and linking it to your virtual network.
    
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

5.  Next, create a new A record pointing to the IP address of the newly created private endpoint.
    
    ```Bash
    KEYVAULT_NIC_ID=$(az network private-endpoint show \
        --name pe-openlab-keyvault \
        --resource-group $RESOURCE_GROUP \
        --query 'networkInterfaces[0].id' -o tsv)
    
    KEYVAULT_NIC_IPADDRESS=$(az resource show \
        --ids $KEYVAULT_NIC_ID \   
        --api-version 2019-04-01 -o json | jq -r '.properties.ipConfigurations[0].properties.privateIPAddress') \
    
    az network private-dns record-set a add-record -g $RESOURCE_GROUP -z "privatelink.vaultcore.azure.net" -n $KEYVAULT_NAME -a $KEYVAULT_NIC_IPADDRESS
    az network private-dns record-set list -g $RESOURCE_GROUP -z "privatelink.vaultcore.azure.net"
    ```
6.  You can now fully block connectivity to the public endpoint of your Azure Database for MySQL Single Server instance.
    
    ```Bash
    az keyvault update \
        --name $KEYVAULT_NAME \
        --resource-group $RESOURCE_GROUP \
        --public-network-access Disabled
    ```
