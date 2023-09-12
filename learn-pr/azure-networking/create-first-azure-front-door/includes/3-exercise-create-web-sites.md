In this exercise, you create a pair of virtual machines behind an internal load balancer and install the vehicle registration web app. You also configure a virtual network with a private endpoint that Front Door can use to connect to the virtual machines privately. Finally, you deploy the license renewal web site to an instance of Azure App Service and also establish private connectivity with Front Door.

## Create virtual machines and deploy the vehicle registration site

1. Open the [Azure Cloud Shell](https://shell.azure.com/?azure-portal=true) in your browser, and sign in to the directory with access to the subscription you want to create resources in.

1. Run the following command in the Cloud Shell to create a variable to store your resource group name, and a resource group for your resources. Replace `<resource group name>` with a name for your resource group, and `<location>` with the Azure region you'd like to deploy your resources in.

    > [!NOTE]
    > If you need to find the location name, you can use the following command: az account list-locations -o table

    ```azurecli
    RG=<resource group name>
    az group create --name $RG --location <location>
    ```

1. In the Cloud Shell window on the right, run the following command. This command uses the Azure command-line interface to create a virtual network named `vehicleappvnet`. It's a private network that provides addresses in the range 10.0.0.0 to 10.0.255.255. The command also creates a subnet called `webServerSubnet`, with the address range 10.0.1.0 to 10.0.1.255. This subnet contains the virtual machines.

    ```azurecli
    az network vnet create \
        --resource-group $RG \
        --name vehicleAppVnet \
        --address-prefixes 10.0.0.0/16 \
        --subnet-name webServerSubnet \
        --subnet-prefixes 10.0.1.0/24
    ```

1. To download the script that creates the virtual machines, run the following command.

    ```bash
    git clone https://github.com/MicrosoftDocs/mslearn-load-balance-web-traffic-with-application-gateway module-files
    ```

1. Create a Network Security Group (NSG) and NSG rule to apply to the web servers during creation.

    ```azurecli
    az network nsg create \
        --resource-group $RG \
        --name webNSG

    az network nsg rule create \
        --resource-group $RG \
        --nsg-name webNSG \
        --name myNSGRuleHTTP \
        --protocol '*' \
        --direction inbound \
        --source-address-prefix '*' \
        --source-port-range '*' \
        --destination-address-prefix '*' \
        --destination-port-range 80 \
        --access allow \
        --priority 200
    ```

1. To create and configure the virtual machines for the web servers, run the following commands. The virtual machines are called `webServer1` and `webServer2`. Each virtual machine runs Ubuntu Server. An administrative user account is created for each virtual machine, with the user name `azureuser`. Each virtual machine has the vehicle registration web app installed.

    The first command runs asynchronously to enable both virtual machines to be created simultaneously.

    ```azurecli
    az vm create \
        --resource-group $RG \
        --name webServer1 \
        --image UbuntuLTS \
        --admin-username azureuser \
        --generate-ssh-keys \
        --vnet-name vehicleAppVnet \
        --subnet webServerSubnet \
        --public-ip-address "" \
        --nsg webNSG \
        --custom-data module-files/scripts/vmconfig.sh \
        --no-wait

    az vm create \
        --resource-group $RG \
        --name webServer2 \
        --image UbuntuLTS \
        --admin-username azureuser \
        --generate-ssh-keys \
        --vnet-name vehicleAppVnet \
        --subnet webServerSubnet \
        --public-ip-address "" \
        --nsg webNSG \
        --custom-data module-files/scripts/vmconfig.sh
    ```

1. To confirm both virtual machines were created successfully, run the following command.

    ```azurecli
    az vm list \
        --resource-group $RG \
        --show-details \
        --output table
    ```

    You should see output similar to the following. Before continuing, ensure the **PowerState** is **VM running** for both virtual machines.

    ```output
    Name          ResourceGroup      PowerState    PublicIps    Fqdns    Location        Zones
    ------------  -----------------  ------------  -----------  -------  --------------  -------
    webServer1    MyResourceGroup    VM running                          southcentralus
    webServer2    MyResourceGroup    VM running                          southcentralus
    ```

## Create an internal load balancer and add virtual machines to backend pool

1. To create an internal load balancer resource, run the following command.

    ```azurecli
    az network lb create \
        --resource-group $RG \
        --name webServerILB \
        --sku standard \
        --vnet-name vehicleAppVnet \
        --subnet webServerSubnet \
        --frontend-ip-name webServerIP \
        --backend-pool-name webServerBackendPool
    ```

1. To create a health probe to check the availability of each VM instance, run the following command.

    ```azurecli
    az network lb probe create \
        --resource-group $RG \
        --lb-name webServerILB \
        --name webServerHealthProbe \
        --protocol tcp \
        --port 80
    ```

1. To create a load balancing rule to distribute traffic to the web servers, run the following command.

    ```azurecli
    az network lb rule create \
        --resource-group $RG \
        --lb-name webServerILB \
        --name myHTTPRule \
        --protocol tcp \
        --frontend-port 80 \
        --backend-port 80 \
        --frontend-ip-name webServerIP \
        --backend-pool-name webServerBackendPool \
        --probe-name webServerHealthProbe \
        --idle-timeout 15 \
        --enable-tcp-reset true
    ```

1. To add both web servers to the backend pool of the internal load balancer, run the following commands.

    ```azurecli
    az network nic ip-config address-pool add \
        --address-pool webServerBackendPool \
        --lb-name webServerILB \
        --ip-config-name ipconfigwebServer1 \
        --nic-name webServer1VMNic \
        --resource-group $RG
    
    az network nic ip-config address-pool add \
        --address-pool webServerBackendPool \
        --lb-name webServerILB \
        --ip-config-name ipconfigwebServer2 \
        --nic-name webServer2VMNic \
        --resource-group $RG
    ```

## Create a private link service and a private endpoint

The private link service is required to establish private communication between Front Door and the origin resources. A private endpoint is what Front Door establishes a connection with to achieve an internal connection over the Microsoft network.

1. To create a private link service and associate it with the internal load balancer, run the following commands. The first command disables private link network policy on the subnet to allow the private link service to be created.

    ```azurecli
    az network vnet subnet update \
        --name webServerSubnet \
        --resource-group $RG \
        --vnet-name vehicleAppVnet \
        --disable-private-link-service-network-policies true

    az network private-link-service create \
        --resource-group $RG \
        --name myPrivateLinkService \
        --vnet-name vehicleAppVnet \
        --subnet webServerSubnet \
        --lb-name webServerILB \
        --lb-frontend-ip-configs webServerIP
    ```

1. To create the private endpoint in a virtual network, run the following commands. Requests to establish connectivity to this private endpoint is automatically approved.

    ```azurecli
    export resourceid=$(az network private-link-service show \
        --name myPrivateLinkService \
        --resource-group $RG \
        --query id \
        --output tsv)

    az network private-endpoint create \
        --connection-name myPEconnectiontoPLS \
        --name myPrivateEndpoint \
        --private-connection-resource-id $resourceid \
        --resource-group $RG \
        --subnet webServerSubnet \
        --manual-request false \
        --vnet-name vehicleAppVnet
    ```

You've now created the virtual machines running the vehicle registration web app. Both virtual machines are identical and are part of the same virtual network. You've also set up a private link service and a private endpoint to access the virtual machines behind an internal load balancer.

## Create App Service and deploy the license renewal site

1. To start, to generate a unique name for the website, run the following command.

    ```bash
    APPSERVICE="licenserenewal$RANDOM"
    ```

1. Next, to create an App Service plan for the web app to use, run the following command.

    ```azurecli
    az appservice plan create \
        --resource-group $RG \
        --name vehicleAppServicePlan \
        --location eastus \
        --sku FREE
    ```

1. Lastly, create the web app and deploy the license renewal site.

    ```azurecli
    az webapp create \
        --resource-group $RG \
        --name $APPSERVICE \
        --plan vehicleAppServicePlan \
        --deployment-source-url https://github.com/MicrosoftDocs/mslearn-load-balance-web-traffic-with-application-gateway \
        --deployment-source-branch appService
    ```

Now, let's take a closer look at configuring Front Door.
