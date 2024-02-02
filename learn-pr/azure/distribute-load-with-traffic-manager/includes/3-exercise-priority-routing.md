Let's assume that your music-streaming application has an equal distribution of users in the western United States and western Europe. You'd like to have a failover version of the app in one region.

The sample application we use for this exercise displays the region in which it's running. One of the two instances has higher priority and is the primary endpoint. The other instance has a lower priority and is the failover endpoint. Taking the primary endpoint offline automatically routes all traffic to the failover endpoint.

In this exercise, you'll set up Traffic Manager to use the United States endpoint as the primary, failing over to the European endpoint if any errors occur.

## Create a new Traffic Manager profile

1. Run the following command in Cloud Shell to create a new Traffic Manager profile:

    ```azurecli
    az network traffic-manager profile create \
        --resource-group <rgn>Sandbox resource group </rgn> \
        --name TM-MusicStream-Priority \
        --routing-method Priority \
        --unique-dns-name TM-MusicStream-Priority-$RANDOM
    ```

    You're using these parameters in the command:

    - **--routing-method Priority**: Creates the Traffic Manager profile by using the priority routing method.
    - **--unique-dns-name**: Creates the globally unique domain name `<unique-dns-name>.trafficmanager.net`. We use the `$RANDOM` Bash function to return a random whole number to ensure that the name is unique.

## Deploy the web applications

1. Run the following command to deploy a Resource Manager template. The template creates two servers, one in the West Europe region, and one in the West US 2 region. Be patient, because the deployment might take a few minutes.

    ```azurecli
    az deployment group create \
        --resource-group <rgn>Sandbox resource group </rgn> \
        --template-uri  https://raw.githubusercontent.com/MicrosoftDocs/mslearn-distribute-load-with-traffic-manager/master/azuredeploy.json \
        --parameters password="$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 32)"
    ```

## Add the endpoints to Traffic Manager

1. The web applications are now running on virtual machines. Run the following commands to add the public IP address resources of the virtual machines as endpoints to the Traffic Manager profile:

    ```azurecli
    WestId=$(az network public-ip show \
        --resource-group <rgn>Sandbox resource group </rgn> \
        --name westus2-vm-nic-pip \
        --query id \
        --output tsv)

    az network traffic-manager endpoint create \
        --resource-group <rgn>Sandbox resource group </rgn> \
        --profile-name TM-MusicStream-Priority \
        --name "Primary-WestUS" \
        --type azureEndpoints \
        --priority 1 \
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
        --profile-name TM-MusicStream-Priority \
        --name "Failover-WestEurope" \
        --type azureEndpoints \
        --priority 2 \
        --target-resource-id $WestId
    ```

    The code gets the resource IDs from both virtual machines. Then, the code uses the IDs to add them as endpoints to the Traffic Manager profile. The code uses the `--priority` flag to set the West US app to the highest priority.

1. Let's take a quick look at the endpoints we configured. Run the following command:

    ```azurecli
    az network traffic-manager endpoint list \
        --resource-group <rgn>Sandbox resource group </rgn> \
        --profile-name TM-MusicStream-Priority \
        --output table
    ```

## Test the app

1. Let's take a look at what DNS shows for the web apps and for our Traffic Manager profile. Run the following commands to display the IP addresses for each of the resources we've created.

1. Retrieve the address for the West US 2 web app:

    ```azurecli
    nslookup $(az network public-ip show \
                --resource-group <rgn>Sandbox resource group </rgn> \
                --name westus2-vm-nic-pip \
                --query dnsSettings.fqdn \
                --output tsv)
    ```

1. Retrieve the address for the West Europe web app:

    ```azurecli
    nslookup $(az network public-ip show \
            --resource-group <rgn>Sandbox resource group </rgn> \
            --name westeurope-vm-nic-pip \
            --query dnsSettings.fqdn \
            --output tsv)
     ```

1. Retrieve the address for the Traffic Manager profile:

    ```azurecli
    # Retrieve the address for the Traffic Manager profile
    nslookup $(az network traffic-manager profile show \
                --resource-group <rgn>Sandbox resource group </rgn> \
                --name TM-MusicStream-Priority \
                --query dnsConfig.fqdn \
                --output tsv)
    ```

    The address for the Traffic Manager profile should match the IP address for the **westus2-vm-nic-pip** public IP assigned to the **westus2-vm** virtual machine.

1. Run the following command to go to the Traffic Manager profile's fully qualified domain name (FQDN). Your request is routed to the endpoint that responds with the highest priority.

    ```azurecli
    echo http://$(az network traffic-manager profile show \
        --resource-group <rgn>Sandbox resource group </rgn> \
        --name TM-MusicStream-Priority \
        --query dnsConfig.fqdn \
        --output tsv)
    ```

    The code prints out the FQDN in Cloud Shell. Select the FQDN to open a new browser window or tab.

1. Verify that the application is working and the location shown at the bottom of the page is West US 2:

    :::image type="content" source="../media/3-west-us-app.png" alt-text="Screenshot of the running West US web app." loc-scope="other"::: <!-- no-loc -->

1. Run the following command to disable the primary endpoint:

    ```azurecli
    az network traffic-manager endpoint update \
        --resource-group <rgn>Sandbox resource group </rgn>  \
        --name "Primary-WestUS" \
        --profile-name TM-MusicStream-Priority \
        --type azureEndpoints \
        --endpoint-status Disabled
    ```

1. Let's look again at what DNS shows for the web apps and for our Traffic Manager profile.

1. Retrieve the address for the West US 2 web app:

    ```azurecli
    nslookup $(az network public-ip show \
                --resource-group <rgn>Sandbox resource group </rgn> \
                --name westus2-vm-nic-pip \
                --query dnsSettings.fqdn \
                --output tsv)
    ```

1. Retrieve the address for the West Europe web app.\:

    ```azurecli
    nslookup $(az network public-ip show \
                --resource-group <rgn>Sandbox resource group </rgn> \
                --name westeurope-vm-nic-pip \
                --query dnsSettings.fqdn \
                --output tsv)
    ```

1. Retrieve the address for the Traffic Manager profile:

    ```azurecli
    nslookup $(az network traffic-manager profile show \
                --resource-group <rgn>Sandbox resource group </rgn> \
                --name TM-MusicStream-Priority \
                --query dnsConfig.fqdn \
                --output tsv)
   ```

    The address for the Traffic Manager profile should now match the West Europe web app.

1. Test the application again from your browser by refreshing the web page. Traffic Manager should automatically redirect the traffic to the West Europe endpoint. Depending on your browser, it might take a few minutes for the locally cached address to expire. Opening the site in a private window should bypass the cache, so you can see the change immediately.

    :::image type="content" source="../media/3-west-europe-app.png" alt-text="Screenshot of the running West Europe web app." loc-scope="other":::
