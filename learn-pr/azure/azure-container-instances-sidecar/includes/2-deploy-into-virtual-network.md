Suppose you work at network provider, and you are responsible for creating Application Programmable Interface (APIs) for your customers. These APIs are a premium service for which you charge your customers, so they need to be able to launch and stop their APIs on-demand. Once a customer has started an API, they are responsible for its life cycle. A critical requirement is that APIs are not exposed to the public Internet, and that a specific customer only has access to their own API.

Azure Container Instance offer an ideal platform for this type of applications:

- They are a purely on-demand infrastructure, offering very granular per-second billing
- Azure Container Instances offer quick startup times
- Azure Container Instances allow for very granular sizing
- Both Windows and Linux container images are supported

You will start the exercises in this module by creating an Azure Container Instance inside of a Virtual Network, so that the API is only accessible by the customer with access to that Virtual Network. Since the application running inside of the Azure Container Instance will only be reachable from inside the Virtual Network, you will create a test virtual machine to verify that the application is working to simulate customer access. The application will consist of the API that will access an external database, that you will deploy as an Azure SQL Database.

[Virtual Networks](https://docs.microsoft.com/azure/virtual-network/virtual-networks-overview) are isolated networking segments where workloads can be deployed so that they are only accessible privately, and optionally over the public Internet. Virtual Networks typically host virtual machines, but other Azure resources such as Azure Container Instances can be deployed to Virtual Networks as well. An Azure Container Instance deployed inside of a Virtual Network will receive a [private IP address](https://docs.microsoft.com/azure/virtual-network/private-ip-addresses) from the Virtual Network range, and as a consequence it will only be reachable from inside the Virtual Network, from peered Virtual Networks or from on-premises networks connected via [Site-to-Site VPN](https://docs.microsoft.com/azure/vpn-gateway/tutorial-site-to-site-portal) or [ExpressRoute](https://docs.microsoft.com/azure/expressroute/expressroute-introduction).

![Diagram that shows an overview of the topology.](../media/2-vnet-overview.png)

The previous diagram shows the topology you will deploy:

- Inside of an Azure Virtual Network we will deploy our Azure Container Instance that contains the application (the customer API in this example).
- The same Virtual Network will contain a virtual machine, that you will use to test the API. You need this because the Azure Container Instance deployed in the Virtual Network will not be reachable via the public Internet, as dictated by the requirements.
- The customer API needs a database to operate. You will create an [Azure SQL Database](https://docs.microsoft.com/azure/azure-sql/database/sql-database-paas-overview) for this purpose. Note that in this unit the Azure SQL Database will be reached over the public Internet.

1. Sign into the [Azure portal](https://portal.azure.com/?azure-portal=true) with your Azure subscription. If you do not have a valid Azure subscription, you can create a free subscription [here](https://azure.microsoft.com/free/).

1. Open the Azure Cloud Shell from the Azure portal using the Cloud Shell icon.

    :::image type="content" source="../media/2-portal-cloudshell-access.png" alt-text="screenshot of header with Cloud Shell icon highlighted":::


1. Define some variables that will help you in this unit:

    ```azurecli
    # Variables
    rg=acilab
    location=northeurope
    aci_name=learnaci
    aci_dns=${aci_name}${RANDOM}
    vnet_name=acivnet
    vnet_prefix=192.168.0.0/16
    vm_subnet_name=vm
    vm_subnet_prefix=192.168.1.0/24
    aci_subnet_name=aci
    aci_subnet_prefix=192.168.2.0/24
    ```

1. Create a resource group and a virtual machine that we will use for testing purposes. In this example, you will let Azure create the Virtual Network for you when you deploy the Virtual Machine:

    ```azurecli
    # Create test RG and VM
    az group create -n $rg -l $location
    az vm create -n test-vm -g $rg -l $location --image ubuntuLTS --generate-ssh-keys \
        --public-ip-address test-vm-pip --vnet-name $vnet_name \
        --vnet-address-prefix $vnet_prefix --subnet $vm_subnet_name --subnet-address-prefix $vm_subnet_prefix
    vm_pip=$(az network public-ip show -n test-vm-pip -g $rg --query ipAddress -o tsv) && echo $vm_pip
    ```

    Verify that you can connect to the Azure Virtual Machine over SSH:

    ```bash
    # Test SSH connectivity to virtual machine
    ssh $vm_pip
    [...]
    exit
    ```

1. Create the database that the application will connect to. You will use the smallest Azure SQL Database SKU (Basic) to reduce costs, but please note that this size is not recommended for production environments:

    ```azurecli
    # Create database
    sql_server_name=sqlserver$RANDOM
    sql_db_name=mydb
    sql_username=azure
    sql_password=$(tr -dc A-Za-z0-9 </dev/urandom 2>/dev/null | head -c 15)
    az sql server create -n $sql_server_name -g $rg -l $location --admin-user $sql_username --admin-password $sql_password
    sql_server_fqdn=$(az sql server show -n $sql_server_name -g $rg -o tsv --query fullyQualifiedDomainName)
    az sql db create -n $sql_db_name -s $sql_server_name -g $rg -e Basic -c 5 --no-wait
    ```
    
1. Now you have all the required components, and you can deploy the Azure Container Instance. You will use the Azure CLI for this deployment as well, where you specify in environment variables the Fully-Qualified Domain Name and the credentials of the Azure SQL Database, so that the Azure Container Instance can connect to it (please retry the command if you get an error on the first attempt):

    ```azurecli
    # Create ACI in a new subnet
    az network vnet subnet create -g $rg --vnet-name $vnet_name -n $aci_subnet_name --address-prefix $aci_subnet_prefix
    vnet_id=$(az network vnet show -n $vnet_name -g $rg --query id -o tsv)
    aci_subnet_id=$(az network vnet subnet show -n $aci_subnet_name --vnet-name $vnet_name -g $rg --query id -o tsv)
    az container create -n $aci_name -g $rg -e "SQL_SERVER_USERNAME=$sql_username" \
      "SQL_SERVER_PASSWORD=$sql_password" \
      "SQL_SERVER_FQDN=${sql_server_fqdn}" \
      --image erjosito/sqlapi:1.0 \
      --ip-address private --ports 8080 --vnet $vnet_id --subnet $aci_subnet_id
    ```
    
1. Now you can connect to the test Virtual Machine and verify connectivity from there. As a first step you will retrieve the IP address of the container instance with the `az container show` command. Note that this IP address will be private, hence you need to access it from the test VM. The deployed API has an endpoint `/api/healthcheck` which will return the value `OK` if the container is up and running:

    ```azurecli
    # Test container reachability
    aci_ip=$(az container show -n $aci_name -g $rg --query 'ipAddress.ip' -o tsv) && echo $aci_ip
    ssh -n -o BatchMode=yes -o StrictHostKeyChecking=no $vm_pip "curl -s http://$aci_ip:8080/api/healthcheck"
    ```
    
    > [!NOTE]
    > The options suggested in the previous SSH command (`-n -o BatchMode=yes -o StrictHostKeyChecking=no`) are not important for this unit, but they are helpful to send batch commands to a remote virtual machine over SSH.
    
1. Before the application can connect to the backend database, the [Azure SQL firewall rules](https://docs.microsoft.com/azure/azure-sql/database/firewall-configure) need to be updated so that the API is allowed to connect. The connection will use public IP addresses, so it is important knowing which source IP address the application will use when accessing the Internet. The application has an endpoint `api/ip` which shows some of its networking attributes, including its public egress IP address. Note that the egress IP address for an Azure Container Instance is not trivial to obtain, in this case the application code itself (the API) has a way of finding out. You will use the obtained egress IP to update the Azure SQL Database. After that, the application should be able to access the Azure SQL Database, what you can verify with the application endpoint `api/sqlversion`, which will show the version of the target database.

    ```azurecli
    # Update Azure SQL firewall rules and test API
    aci_pip=$(ssh -n -o BatchMode=yes -o StrictHostKeyChecking=no $vm_pip "curl -s http://$aci_ip:8080/api/ip" | jq -r .my_public_ip) && echo $aci_pip
    az sql server firewall-rule create -g $rg -s $sql_server_name -n public_sqlapi_aci-source --start-ip-address $aci_pip --end-ip-address $aci_pip
    ssh -n -o BatchMode=yes -o StrictHostKeyChecking=no $vm_pip "curl -s http://$aci_ip:8080/api/sqlversion"
    ssh -n -o BatchMode=yes -o StrictHostKeyChecking=no $vm_pip "curl -s http://$aci_ip:8080/api/sqlsrcip"
    ```
    
1. You can see in the last command of the previous block that the Azure SQL Database sees the application coming from its public IP address. You can see this when calling the application's endpoint `api/sqlsrcip`, which sends a SQL query to the backend database asking for the source IP address as seen by the database. As next step, you can delete the container created in this unit, so that we can move on to the next one.

    ```azurecli
    # Cleanup unit 2
    az container delete -n $aci_name -g $rg -y
    ```

## Summary

You created an Azure Container Instance that is only accessible from within an Azure Virtual Network.

Using an Azure Virtual Machine as jump host, you verified the correct operation of the container, and the connectivity from the Azure Container Instance to an Azure SQL Database.
