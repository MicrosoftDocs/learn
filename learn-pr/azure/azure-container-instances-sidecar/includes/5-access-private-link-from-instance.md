
Your customers have realized that the database behind the API is exposed with a public IP address. While they are aware that this public IP address is protected by a firewall so that only the Azure Container Instance can access it, they have asked you to use private IP addresses between the API and the database.

Azure PaaS services can normally be accessed with a public endpoint, using a public IP address reachable over the public Internet. However, many Azure services support creating private endpoints too, where the Azure service is only reachable from inside of a Virtual Network. You will create a private endpoint for the Azure SQL Database created in previous units, and make sure that the container is still able to reach it.

[Private Link](https://docs.microsoft.com/azure/private-link/private-link-overview) is a technology that can be used to secure connectivity to an Azure PaaS resource such as Azure SQL Database. In previous units you have tested the application accessing a database which is available using a public IP address. This public IP address is protected by [Azure SQL Firewall Rules](https://docs.microsoft.com/azure/azure-sql/database/firewall-configure), but the communication can be further restricted to only use private IP addressing.

DNS plays a critical role in the functionality required, since the system accessing the SQL Database (the Azure Container Instance hosting the application) will need to resolve the Azure SQL Fully Qualified Domain Name (FQDN) to its private IP, instead of to its public IP.

![Topology Overview](../media/4-plink-overview.png)

1. First you will create a new subnet in the Virtual Network, and then you will create the Azure SQL private endpoint in that subnet:

    ```azurecli
    # Create new subnet for the SQL private endpoint
    sql_subnet_name=sql
    sql_subnet_prefix=192.168.3.0/24
    az network vnet subnet create -g $rg --vnet-name $vnet_name -n $sql_subnet_name --address-prefix $sql_subnet_prefix
    az network vnet subnet update -n $sql_subnet_name -g $rg --vnet-name $vnet_name --disable-private-endpoint-network-policies true
    # SQL Server private endpoint
    sql_endpoint_name=sqlep
    sql_server_id=$(az sql server show -n $sql_server_name -g $rg -o tsv --query id)
    az network private-endpoint create -n $sql_endpoint_name -g $rg \
      --vnet-name $vnet_name --subnet $sql_subnet_name \
      --private-connection-resource-id $sql_server_id --group-id sqlServer --connection-name sqlConnection
    ```
    
1. You can verify the IP address assigned to the private endpoint using the `az network nic` command, since private endpoints are represented in Azure as Network Interface Cards (NICs):

    ```azurecli
    # Get endpoint's private IP address
    sql_nic_id=$(az network private-endpoint show -n $sql_endpoint_name -g $rg --query 'networkInterfaces[0].id' -o tsv)
    sql_endpoint_ip=$(az network nic show --ids $sql_nic_id --query 'ipConfigurations[0].privateIpAddress' -o tsv) && echo $sql_endpoint_ip
    ssh -n -o BatchMode=yes -o StrictHostKeyChecking=no $vm_pip "nslookup ${sql_server_name}.database.windows.net"
    ```

1. If you look closely at the result of the `nslookup` command in the previous section, the Fully-Qualified Domain Name of the Azure SQL Database is still resolved inside of the Virtual Network to its public IP address. In order to force the systems deployed in the Virtual Network to use the private IP address of the Azure SQL Database, you will create a private DNS zone. Azure SQL Databases with configured private links use the intermediate domain `privatelink.database.windows.net`, so you will create a private zone for this domain and add an A-record for the IP address of the Azure SQL private endpoint created earlier. Instead of manually adding the A-record, you will connect the private endpoint and the private DNS zone with the `az network private-endpoint dns-zone-group create` command, so that the A-record is automatically created with the correct IP address:

    ```azurecli
    # Create Azure DNS private zone and records
    dns_zone_name=privatelink.database.windows.net
    az network private-dns zone create -n $dns_zone_name -g $rg 
    az network private-dns link vnet create -g $rg -z $dns_zone_name -n myDnsLink --virtual-network $vnet_name --registration-enabled false
    az network private-endpoint dns-zone-group create --endpoint-name $sql_endpoint_name -g $rg -n zonegroup --zone-name zone1 --private-dns-zone $dns_zone_name
    ssh -n -o BatchMode=yes -o StrictHostKeyChecking=no $vm_pip "nslookup ${sql_server_name}.database.windows.net"
    ```
    
    Note that the VM in the Virtual Network should now resolve the FQDN for the Azure SQL Database to the private IP address of the private endpoint.
    
1. If you deleted the Azure Container Instance from the previous unit you can recreate it using the same YAML file. Note that nothing has changed for the Azure Container Instance, since it is still accessing the database using the same FQDN.

    ```azurecli
    # Deploy ACI if you had deleted it
    az container create -g $rg --file $aci_yaml_file
    ```
    
1. You can verify that the Azure Container Instance is up and running with the `api/healthcheck` endpoint. You can verify the correct name resolution to a private IP address with the `api/dns` endpoint, and you can verify reachability to the database with the `api/sqlversion` and `api/sqlsrcip` endpoints.

    ```azurecli
    # Test
    aci_ip=$(az container show -n $aci_name -g $rg --query 'ipAddress.ip' -o tsv) && echo $aci_ip
    ssh -n -o BatchMode=yes -o StrictHostKeyChecking=no $vm_pip "curl -ks https://$aci_ip/api/healthcheck"
    ssh -n -o BatchMode=yes -o StrictHostKeyChecking=no $vm_pip "curl -ks https://$aci_ip/api/dns?fqdn=${sql_server_name}.database.windows.net"
    ssh -n -o BatchMode=yes -o StrictHostKeyChecking=no $vm_pip "curl -ks https://$aci_ip/api/sqlversion"
    ssh -n -o BatchMode=yes -o StrictHostKeyChecking=no $vm_pip "curl -ks https://$aci_ip/api/sqlsrcip"
    ```

    > [!NOTE]
    > Some Azure services automatically disable their public endpoint when there is a private endpoint, but not all. In the case of Azure SQL Databases, the public endpoint will still be active even after configuring the private one. If access to the database over the Internet is to be disabled, further configuration in the Azure SQL Server firewall settings is required.

1. Note in the previous output that the Azure SQL API now sees the Azure Container Instance as coming from its private IP address. Since the firewall in the Azure SQL Database is only used to protect the public endpoint, that is the reason why you did not have to change the firewall rules for this exercise. You can now delete the Azure Container Instance before proceeding to the next unit:

    ```azurecli
    # Cleanup unit 5
    az container delete -n $aci_name -g $rg -y
    ```
  
## Summary

You configured access from the Azure Container Instance to the Azure SQL Database using private addresses. You connected the Azure SQL Database to the Virtual Network using Private Link, and you used Azure Private DNS Zones to make sure that the Azure Container Instances reaches the Azure SQL Database over its private endpoint.