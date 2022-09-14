You've redeployed your Azure Spring Apps service to a virtual network and redeployed your apps to the service. Next, you'll need to set up a private DNS service for your apps to be discoverable in your virtual network.

1.  To find the IP address used for your Spring Apps service, you'll be querying for the internal load balancer IP address of the service runtime network.
    
    ```Bash
    SERVICE_RUNTIME_RG=`az spring show \
        --resource-group $RESOURCE_GROUP \
        --name $SPRING_APPS_SERVICE \
        --query "properties.networkProfile.serviceRuntimeNetworkResourceGroup" \
        --output tsv`
    
    IP_ADDRESS=`az network lb frontend-ip list \
        --lb-name kubernetes-internal \
        --resource-group $SERVICE_RUNTIME_RG \
        --query "[0].privateIpAddress" \
        --output tsv`
    ```

2.  Create a private DNS zone to forward resolution requests targeting the `private.azuremicroservices.io` namespace to this internal IP address.
    
    ```Bash
    az network private-dns zone create \
        --resource-group $RESOURCE_GROUP \
        --name private.azuremicroservices.io
    ```

3.  Link the private DNS zone to your virtual network.
    
    ```Bash
    az network private-dns link vnet create \
        --resource-group $RESOURCE_GROUP \
        --name azure-spring-cloud-dns-link \
        --zone-name private.azuremicroservices.io \
        --virtual-network $VIRTUAL_NETWORK_NAME \
        --registration-enabled false
    ```

4.  Create a DNS ***A record*** to forward all calls to the private IP of the Azure Spring Apps service.
    
    ```Bash
    az network private-dns record-set a add-record \
        --resource-group $RESOURCE_GROUP \
        --zone-name private.azuremicroservices.io \
        --record-set-name '*' \
        --ipv4-address $IP_ADDRESS
    ```

5.  Update your **api-gateway** and **admin-service** apps to get an FQDN based on your private DNS zone.
    
    ```Bash
    az spring app update \
        --resource-group $RESOURCE_GROUP \
        --name api-gateway \
        --service $SPRING_APPS_SERVICE \
        --assign-endpoint true
    
    az spring app update \
        --resource-group $RESOURCE_GROUP \
        --name admin-service \
        --service $SPRING_APPS_SERVICE \
        --assign-endpoint true
    ```

If you attempt to connect to the Spring Petclinic application through the endpoint assigned to the **api-gateway**, you'll be unable to connect. You won't connect because the endpoint is only available within the virtual network.

If you have another virtual machine in the virtual network, you could test these **api-gateway** and **admin-service** endpoints.
