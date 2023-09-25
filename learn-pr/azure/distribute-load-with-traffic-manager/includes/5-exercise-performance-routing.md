Your network architect would like to ensure customers have the best performance. By using the performance routing method in Traffic Manager, you can ensure that users access the location closest to them. Let's configure an instance of Traffic Manager to use performance routing.

## Create a Traffic Manager profile using performance routing

1. Create a new Traffic Manager profile that's set up with performance routing. Run these commands:

    ```azurecli
        az network traffic-manager profile create \
        --resource-group <rgn>Sandbox resource group </rgn> \
        --name TM-MusicStream-Performance \
        --routing-method Performance \
        --unique-dns-name TM-MusicStream-Performance-$RANDOM \
        --output table
    ```

1. Create two new endpoints that point to the public IP addresses of the virtual machines. Run these commands:

    ```azurecli
    WestId=$(az network public-ip show \
        --resource-group <rgn>Sandbox resource group </rgn> \
        --name westus2-vm-nic-pip \
        --query id \
        --output tsv)

    az network traffic-manager endpoint create \
        --resource-group <rgn>Sandbox resource group </rgn> \
        --profile-name TM-MusicStream-Performance \
        --name "WestUS" \
        --type azureEndpoints \
        --target-resource-id $WestId
     ```

     ```azurecli
    WestId=$(az network public-ip show \
        --resource-group <rgn>Sandbox resource group </rgn> \
        --name westeurope-vm-nic-pip \
        --query id \
        --output tsv)

    az network traffic-manager endpoint create \
        --resource-group <rgn>Sandbox resource group </rgn> \
        --profile-name TM-MusicStream-Performance \
        --name "WestEurope" \
        --type azureEndpoints \
        --target-resource-id $WestId
    ```

## Test the new configuration

1. Run this command to go to the Traffic Manager profile's fully qualified domain name (FQDN). Your request is routed to the endpoint that responds with the lowest latency.

    ```azurecli
    echo http://$(az network traffic-manager profile show \
        --resource-group <rgn>Sandbox resource group </rgn> \
        --name TM-MusicStream-Performance \
        --query dnsConfig.fqdn \
        --output tsv)
    ```

1. Depending on where you're located, you're directed to the best-performing endpoint.

    :::image type="content" source="../media/5-performance-testing.png" alt-text="Screenshot of a webpage running the web app closest to you." loc-scope="other":::

1. Run the following `nslookup` command to resolve the Traffic Manager profile's domain name:

    ```azurecli
    nslookup $(az network traffic-manager profile show \
            --resource-group <rgn>Sandbox resource group </rgn> \
            --name TM-MusicStream-Performance \
            --query dnsConfig.fqdn \
            --output tsv)
    ```

    The `nslookup` command returns where the domain name resolves. For example, if you're closest to Europe, it returns the following output:

    ```output
    Non-authoritative answer:
    tm-musicstream-performance-29605.trafficmanager.net     canonical name = westus2-vm-rmzkcs3kmupuq.westus2.cloudapp.azure.com.
    Name:   westus2-vm-rmzkcs3kmupuq.westus2.cloudapp.azure.com
    Address: 13.66.168.61
    ```

If your customers have two endpoints that have equal network latency, they might be routed to either endpoint. Refresh the web page to see if you're served the same endpoint.
