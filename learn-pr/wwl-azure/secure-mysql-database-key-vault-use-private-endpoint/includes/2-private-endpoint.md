In this unit, you'll lock down access to your MySQL database using a private endpoint. A private endpoint is a network interface that uses a private IP address from your virtual network. The network interface connects you privately and securely to a service that's powered by Azure Private Link.

Azure Private Link enables you to access Azure PaaS Services (for example, Azure Storage and SQL Database) and Azure hosted customer-owned/partner services over a private endpoint in your virtual network.

By enabling a private endpoint, you're bringing the service into your virtual network.

:::row:::
  :::column:::
    **Property**
  :::column-end:::
  :::column:::
    **Description**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Name
  :::column-end:::
  :::column:::
    A unique name within the resource group.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Subnet
  :::column-end:::
  :::column:::
    The subnet to deploy, where the private IP address is assigned.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Private-link resource
  :::column-end:::
  :::column:::
    The private-link resource to connect by using a resource ID or alias, from the list of available types. A unique network identifier is generated for all traffic that's sent to this resource.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Target subresource
  :::column-end:::
  :::column:::
    The subresource to connect. Each private-link resource type has various options to select based on preference.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Connection approval method
  :::column-end:::
  :::column:::
    Automatic or manual. Depending on the Azure role-based access control (RBAC) permissions, your private endpoint can be approved automatically. If you're connecting to a private-link resource without Azure RBAC permissions, use the manual method to allow the owner of the resource to approve the connection.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Request message
  :::column-end:::
  :::column:::
    You can specify a message for requested connections to be approved manually. This message can be used to identify a specific request.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Connection status
  :::column-end:::
  :::column:::
    A read-only property that specifies whether the private endpoint is active. Only private endpoints in an approved state can be used to send traffic. Other available states:

*Approved*: The connection was automatically or manually approved and is ready to be used.

*Pending*: The connection was created manually and is pending approval by the private-link resource owner.

*Rejected*: The connection was rejected by the private-link resource owner.

*Disconnected*: The connection was removed by the private-link resource owner. The private endpoint becomes informative and should be deleted for cleanup.


  :::column-end:::
:::row-end:::


Once you've enabled a private endpoint, you can block public access to your database.

1.  To start, you'll need to disable private endpoint network policies in the subnet you'll use to create the private endpoints.
    
    ```Bash
    az network vnet subnet update \
        --name $PRIVATE_ENDPOINTS_SUBNET_NAME \
        --resource-group $RESOURCE_GROUP \
        --vnet-name $VIRTUAL_NETWORK_NAME \
        --disable-private-endpoint-network-policies true
    ```

2.  Next, you'll create the private endpoint corresponding to the Azure Database for MySQL Single Server instance within the same subnet.
    
    ```Bash
    MYSQL_RESOURCE_ID=$(az resource show -g ${RESOURC_GROUP} -n ${SQL_SERVER_NAME}--resource-type
        "Microsoft.DBforMySQL/servers" \
        --query "id" -o tsv)
    
    az network private-endpoint creates \
        --name pe-openlab-mysql \
        --resource-group $RESOURCE_GROUP \
        --vnet-name $VIRTUAL_NETWORK_NAME \
        --subnet $PRIVATE_ENDPOINTS_SUBNET_NAME \
        --private-connection-resource-id $MYSQL_RESOURCE_ID \
        --group-id mysqlServer \
        --connection-name openlab-mysql-connection \
        --location $LOCATION
    ```
    
    Once you've created the private endpoint, you'll set up a private Azure DNS zone named **privatelink.mysql.database.azure.com** with an A DNS record matching the original DNS name with the suffix **mysql.database.azure.com** but replacing that suffix with **privatelink.mysql.database.azure.com**. Your apps connecting to the MySQL database won't need to be updated, but instead they can continue using the existing connection strings.

3.  To implement this configuration, start by creating a new private DNS zone and linking it to your virtual network.
    
    ```Bash
    az network private-dns zone create \
        --resource-group $RESOURCE_GROUP \
        --name "privatelink.mysql.database.azure.com"
    
    az network private-dns link vnet create \
        --resource-group $RESOURCE_GROUP \
        --zone-name "privatelink.mysql.database.azure.com"\
        --name MyDNSLink \
        --virtual-network $VIRTUAL_NETWORK_NAME \
        --registration-enabled false
    ```

4.  Next, create a new A record pointing to the IP address of the newly created private endpoint.
    
    ```Bash
    NIC_ID=$(az network private-endpoint show \
        --name pe-openlab-mysql \
        --resource-group $RESOURCE_GROUP \
        --query 'networkInterfaces[0].id' -o tsv)
    
    NIC_IPADDRESS=$(az resource show \
        --ids $NIC_ID \
        --api-version 2019-04-01 -o json | jq -r '.properties.ipConfigurations[0].properties.privateIPAddress')
    
    az network private-dns record-set a create \
        --name $SQL_SERVER_NAME \
        --zone-name privatelink.mysql.database.azure.com \
        --resource-group $RESOURCE_GROUP
    
    az network private-dns record-set a add-record \
        --record-set-name $SQL_SERVER_NAME \
        --zone-name privatelink.mysql.database.azure.com \
        --resource-group $RESOURCE_GROUP \
        -a $NIC_IPADDRESS
    ```

5.  You can now fully block connectivity to the public endpoint of your Azure Database for MySQL Single Server instance.
    
    ```Bash
    az mysql server update \
        --name $SQL_SERVER_NAME \
    -g $RESOURCE_GROUP \
        --public Disabled
    ```
