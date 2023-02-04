You want to manage the traffic to your apps using the Azure Spring Apps service. Azure Application Gateway is a web traffic load balancer that enables you to manage traffic to your web applications. Traditional load balancers operate at the transport layer (OSI layer 4 - TCP and UDP) and route traffic based on source IP address and port, to a destination IP address and port.

Application Gateway can make routing decisions based on other attributes of an HTTP request, for example URI path or host headers. This type of routing is known as application layer (OSI layer 7) load balancing. Azure Application Gateway can do URL-based routing.

For example, you can route traffic based on the incoming URL. So if `/documents` is in the incoming URL, you can route traffic to a specific set of servers (known as a pool) configured for images. If `/graphics` is in the URL, that traffic is routed to another pool that's optimized for videos.

:::image type="content" source="../media/application-gateway-overview-431dbbb9.png" alt-text="Screenshot of showing how to route traffic based on the incoming URL.":::


You'll provide the networking resources for your Spring Apps service and your Application Gateway. To deploy them in the same virtual network, you'll need a minimum of three subnets: one for your Application Gateway and two for your Spring Apps service. You'll also create the subnet containing Private Endpoints for backend services to your applications to use, like your database and the Azure Key Vault.

1.  Create a virtual network using the following commands from the Git Bash prompt:
    
    ```Bash
    VIRTUAL_NETWORK_NAME=springappsvnet
    az network vnet create \
        --resource-group $RESOURCE_GROUP \ 
        --name $VIRTUAL_NETWORK_NAME \
        --location $LOCATION \
        --address-prefix 10.1.0.0/16
    
    ```

2.  Create two subnets for Azure Spring Apps in this virtual network: one subnet for Application Gateway, the other another for the private endpoints of the MySQL Single Server instance and Azure Key Vault instance. You'll create environment variables for the subnet names of the Application Gateway and the Private Endpoints used later.
    
    ```
    SERVICE_RUNTIME_SUBNET_CIDR=10.1.0.0/24
    APP_SUBNET_CIDR=10.1.1.0/24
    APPLICATION_GATEWAY_SUBNET_CIDR=10.1.2.0/24
    PRIVATE_ENDPOINTS_SUBNET_CIDR=10.1.3.0/24
    DATABASE_SUBNET_CIDR=10.1.4.0/24
    APPLICATION_GATEWAY_SUBNET_NAME=app-gw-subnet
    PRIVATE_ENDPOINTS_SUBNET_NAME=private-endpoints-subnet
    DATABASE_SUBNET_NAME=database-subnet
    az network vnet subnet create \
    --resource-group $RESOURCE_GROUP \
        --vnet-name $VIRTUAL_NETWORK_NAME \
        --address-prefixes $SERVICE_RUNTIME_SUBNET_CIDR \
        --name service-runtime-subnet \
    az network vnet subnet create \
        --resource-group $RESOURCE_GROUP \
        --vnet-name $VIRTUAL_NETWORK_NAME \
        --address-prefixes $APP_SUBNET_CIDR \
        --name apps-subnet \
    az network vnet subnet create \
        --name $APPLICATION_GATEWAY_SUBNET_NAME \
        --resource-group $RESOURCE_GROUP \
        --vnet-name $VIRTUAL_NETWORK_NAME \
        --address-prefix $APPLICATION_GATEWAY_SUBNET_CIDR \
    az network vnet subnet create \
        --name $PRIVATE_ENDPOINTS_SUBNET_NAME \
        --resource-group $RESOURCE_GROUP \
        --vnet-name $VIRTUAL_NETWORK_NAME \
        --address-prefix $PRIVATE_ENDPOINTS_SUBNET_CIDR
    ```

3.  Assign the **Owner** role-based access control (RBAC) role to the Azure Service Provider for Spring Apps access in the scope of the newly created virtual network. The assignment allows the resource provider to create resources in the service-runtime-subnet and apps-subnet subnets. The GUID used in the second command is the service provider ID for Azure Spring Apps.
    
    > [!NOTE]
    > The export `MSYS_NO_PATHCONV=1` must be included to address an issue with implementing role assignment when using Azure CLI in Git Bash shell, as documented on [GitHub](https://github.com/Azure/azure-cli/issues/16317).
    
    ```Bash
    VIRTUAL_NETWORK_RESOURCE_ID=`az network vnet show \
        --name $VIRTUAL_NETWORK_NAME \
        --resource-group $RESOURCE_GROUP \
        --query "id" \
        --output tsv
    
    export MSYS_NO_PATHCONV=1
    
    az role assignment create \
        --role "Owner" \
        --scope $VIRTUAL_NETWORK_RESOURCE_ID \
        --assignee e8de9221-a19c-4c81-b814-fd37c6caf9d2
    
    
    ```
