<!-- Application Gateway directs traffic to pools of web servers. Each server in a pool should provide a platform with the same capabilities, and run the same web app. The servers should also be configured identically. You can implement the web server using any appropriate technology such as Windows Server and IIS, or Linux and Apache. This approach helps to preserve any existing investment made for an existing web app you might be moving to Application Gateway. -->

In the motor vehicle department system, you decide to run the web app on two servers. You'll implement each server using a virtual machine.

In this exercise, you'll create a pair of virtual machines and install the vehicle registration web app. You'll also configure a virtual network that Application Gateway can use to connect to the virtual machines. Finally, you'll deploy the license renewal web site to an instance of Azure App Service.

<!-- > [!NOTE]
> You could also use virtual machine scale sets for hosting the pool of web server virtual machines. You can add or remove servers simply by scaling out and back in again. For simplicity, and to enable you to focus on Application Gateway, this lab creates two identical virtual machines manually. -->

![Diagram showing the resources that will be deployed](../media/3-resources.svg)

## Create a virtual network

[!include[](../../../includes/azure-sandbox-activate.md)]

- In the Cloud Shell window on the right, run the following command. This command uses the Azure command-line interface to create a virtual network named `vehicleappvnet`. It's a private network that provides addresses in the range 10.0.0.0 to 10.0.255.255. The command also creates a subnet called `webServerSubnet`, with the address range 10.0.1.0 to 10.0.1.255. This subnet will contain the virtual machines.

    ```azurecli
    az network vnet create \
      --resource-group <rgn>[sandbox resource group]</rgn> \
      --name vehicleAppVnet \
      --address-prefix 10.0.0.0/16 \
      --subnet-name webServerSubnet \
      --subnet-prefix 10.0.1.0/24
    ```

## Create virtual machines and deploy the vehicle registration site

1. Download the script that creates the virtual machines with the following command:

    ```bash
    git clone https://github.com/MicrosoftDocs/mslearn-load-balance-web-traffic-with-application-gateway/ module-files
    ```

1. Run the following commands to create and configure the virtual machines for the web servers. The virtual machines are called `webServer1` and `webServer2`. Each virtual machine runs Ubuntu Server 16.04.0-LTS. An administrative user account is created for each virtual machine, with the login name `azureuser`. Each virtual machine has the vehicle registration web app installed.

    The first command runs asynchronously to allow both virtual machines to be created simultaneously.

    ```azurecli
    az vm create \
      --resource-group <rgn>[sandbox resource group]</rgn> \
      --name webServer1 \
      --image Canonical:UbuntuServer:16.04.0-LTS:16.04.201610200 \
      --admin-username azureuser \
      --generate-ssh-keys \
      --vnet-name vehicleAppVnet \
      --subnet webServerSubnet \
      --public-ip-address "" \
      --nsg "" \
      --custom-data module-files/scripts/vmconfig.sh \
      --no-wait

    az vm create \
      --resource-group <rgn>[sandbox resource group]</rgn> \
      --name webServer2 \
      --image Canonical:UbuntuServer:16.04.0-LTS:16.04.201610200 \
      --admin-username azureuser \
      --generate-ssh-keys \
      --vnet-name vehicleAppVnet \
      --subnet webServerSubnet \
      --public-ip-address "" \
      --nsg "" \
      --custom-data module-files/scripts/vmconfig.sh
    ```

1. Run the following command to confirm both virtual machines were created successfully.

    ```azurecli
    az vm list \
      --resource-group <rgn>[sandbox resource group]</rgn> \
      --show-details \
      --output table
    ```

    You should see output similar to the following. Ensure the **PowerState** is **VM running** for both virtual machines before continuing.

    ```output
    Name          ResourceGroup                               PowerState    PublicIps    Fqdns    Location        Zones
    ------------  ------------------------------------------  ------------  -----------  -------  --------------  -------
    webServer1    <rgn>[sandbox resource group]</rgn>  VM running                          southcentralus
    webServer2    <rgn>[sandbox resource group]</rgn>  VM running                          southcentralus
    ```

You've now created the virtual machines running the vehicle registration web app. Both virtual machines are identical, and are part of the same virtual network.

## Create App Service and deploy the license renewal site

1. To start, run the following command to generate a unique name for the web site.

    ```bash
    APPSERVICE="licenserenewal$RANDOM"
    ```

1. Next, run the following command to create the app service plan the web app will use.

    ```azurecli
    az appservice plan create \
        --resource-group <rgn>[sandbox resource group]</rgn> \
        --name vehicleAppServicePlan \
        --sku S1
    ```

1. Lastly, create the web app and deploy the license renewal site.

    ```azurecli
    az webapp create \
        --resource-group <rgn>[sandbox resource group]</rgn> \
        --name $APPSERVICE \
        --plan vehicleAppServicePlan \
        --runtime "aspnet|v4.7" \
        --deployment-source-url https://github.com/MicrosoftDocs/mslearn-load-balance-web-traffic-with-application-gateway \
        --deployment-source-branch appService
    ```

Now let's take a closer look at configuring Application Gateway.
