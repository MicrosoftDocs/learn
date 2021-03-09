
Your customers have asked you to be able to reach the API using a Fully Qualified Domain Name (FQDN) instead of an IP address, and to make sure that the FQDN does not change in case the container needs to be recreated. You can use init containers to provide this functionality. Some times you need to perform certain tasks before the actual application starts. These tasks could include many different things such as configuring certain services to accept inbound connectivity from the container, or injecting secrets from an Azure Key Vault into a volume. In this unit you will use an init container to update DNS so that customers can access the API using a domain name, instead of an IP address.

An initialization container is one of the practical uses of the [Sidecar Pattern](https://docs.microsoft.com/azure/architecture/patterns/sidecar) that you saw in a previous unit. However, the initialization container will be run before any other container in the container group is started. Hence, you can implement different concepts in init containers such as prerequisite validation or initialization tasks.

The actual application containers in your Azure Container instance will only be started when any defined init containers have completed their execution successfully.

ACI Init Containers are the same concept as [Kubernetes Init Containers](https://kubernetes.io/docs/concepts/workloads/pods/init-containers/).

![Init container](../media/5-init-container.png)

In this unit, the init container will retrieve the IP address allocated to the Azure Container Instance, and it will update the DNS entry that the API clients use to reach it. The init container and the application container share the same network stack, so the IP address visible to the init container will be the same that the application containers will use.

1. The first thing you will do is creating an Azure Service Principal that will be used by the init container to interact with Azure, to retrieve its IP address and update DNS. In this example you will assign it Contributor access to the resource group for simplicity reasons, in production environments you might want to be more restrictive.

    ```azurecli
    # Create SP
    scope=$(az group show -n $rg --query id -o tsv)
    new_sp=$(az ad sp create-for-rbac --scopes $scope --role Contributor --name acilab -o json)
    sp_appid=$(echo $new_sp | jq -r '.appId') && echo $sp_appid
    sp_tenant=$(echo $new_sp | jq -r '.tenant') && echo $sp_tenant
    sp_password=$(echo $new_sp | jq -r '.password')
    ```
    
1. In this step you will create the Azure private DNS zone that will be used by application clients to access the Azure Container Instance and associate it to the Virtual Network. This DNS zone is different from the zone created in the previous task for private link, which was used by the Azure Container Instance to access the Azure SQL Database:

    ```azurecli
    # Create Azure DNS private zone and records
    dns_zone_name=contoso.com
    az network private-dns zone create -n $dns_zone_name -g $rg 
    az network private-dns link vnet create -g $rg -z $dns_zone_name -n contoso --virtual-network $vnet_name --registration-enabled false
    ```
    
1. There are many ways to inject a script into the init container. In this unit, you will use an Azure Files share to store the script. Create an Azure File share and upload the initialization script:

    ```azurecli
    # Create script for init container
    storage_account_name="acilab$RANDOM"
    az storage account create -n $storage_account_name -g $rg --sku Standard_LRS --kind StorageV2
    storage_account_key=$(az storage account keys list --account-name $storage_account_name -g $rg --query '[0].value' -o tsv)
    az storage share create --account-name $storage_account_name --account-key $storage_account_key --name initscript
    init_script_filename=init.sh
    init_script_path=/tmp/
    cat <<EOF > ${init_script_path}${init_script_filename}
    echo "Logging into Azure..."
    az login --service-principal -u \$SP_APPID -p \$SP_PASSWORD --tenant \$SP_TENANT
    echo "Finding out IP address..."
    my_private_ip=\$(az container show -n \$ACI_NAME -g \$RG --query 'ipAddress.ip' -o tsv) && echo \$my_private_ip
    echo "Creating DNS record..."
    az network private-dns record-set a create -n \$HOSTNAME -z \$DNS_ZONE_NAME -g \$RG
    az network private-dns record-set a add-record --record-set-name \$HOSTNAME -z \$DNS_ZONE_NAME -g \$RG -a \$my_private_ip
    EOF
    az storage file upload --account-name $storage_account_name --account-key $storage_account_key -s initscript --source ${init_script_path}${init_script_filename}
    ```
    
    Note that the initialization script uses the Azure CLI to run the commands that find out the IP address of the container instance and create an A-record in the private DNS zone. It will authenticate using the Service Principal application ID and secret that it expects to find as environment variables.

1. At this point, you can create the YAML file building on the ones you used in previous units. Take note of the following items:

    - There is now a `initContainers` section
    - The `initContainer` is using the `microsoft/azure-cli:latest` image, which already has the Azure CLI installed
    - The init container runs a script stored in the `/mnt/init/` folder, which is mounted from an Azure Files volume
    - The resource group, Azure Container Instance name and Service Principal Credentials are passed as environment variables
    - The Service Principal secret is passed as a secure environment variable
    - The rest of the container YAML definitions are unchanged when compared to the previous unit
    
    ```azurecli
    # Create YAML
    aci_yaml_file=/tmp/acilab.yaml
    cat <<EOF > $aci_yaml_file
    apiVersion: 2019-12-01
    location: westus
    name: $aci_name
    properties:
      networkProfile:
        id: $nw_profile_id
      initContainers:
      - name: azcli
        properties:
          image: microsoft/azure-cli:latest
          command:
          - "/bin/sh"
          - "-c"
          - "/mnt/init/$init_script_filename"
          environmentVariables:
          - name: RG
            value: $rg
          - name: SP_APPID
            value: $sp_appid
          - name: SP_PASSWORD
            secureValue: $sp_password
          - name: SP_TENANT
            value: $sp_tenant
          - name: DNS_ZONE_NAME
            value: $dns_zone_name
          - name: HOSTNAME
            value: $aci_name
          - name: ACI_NAME
            value: $aci_name
          volumeMounts:
          - name: initscript
            mountPath: /mnt/init/
      containers:
      - name: nginx
        properties:
          image: nginx
          ports:
          - port: 443
            protocol: TCP
          resources:
            requests:
              cpu: 1.0
              memoryInGB: 1.5
          volumeMounts:
          - name: nginx-config
            mountPath: /etc/nginx
      - name: sqlapi
        properties:
          image: erjosito/sqlapi:1.0
          environmentVariables:
          - name: SQL_SERVER_FQDN
            value: $sql_server_fqdn
          - name: SQL_SERVER_USERNAME
            value: $sql_username
          - name: SQL_SERVER_PASSWORD
            secureValue: $sql_password
          ports:
          - port: 8080
            protocol: TCP
          resources:
            requests:
              cpu: 1.0
              memoryInGB: 1
          volumeMounts:
      volumes:
      - secret:
          ssl.crt: "$ssl_crt"
          ssl.key: "$ssl_key"
          nginx.conf: "$nginx_conf"
        name: nginx-config
      - name: initscript
        azureFile:
          readOnly: false
          shareName: initscript
          storageAccountName: $storage_account_name
          storageAccountKey: $storage_account_key
      ipAddress:
        ports:
        - port: 443
          protocol: TCP
        type: Private
      osType: Linux
    tags: null
    type: Microsoft.ContainerInstance/containerGroups
    EOF
    ```
    
1. You may want to verify the generated YAML file, to check that variable substitution worked correctly

    ```azurecli
    # Check YAML file
    more $aci_yaml_file
    ```
    
1. At this point, you can create the Azure Container Instance. This time it will take a bit longer to be created, since the init container will run before the application and nginx containers are started:

    ```azurecli
    # Deploy ACI
    az container create -g $rg --file $aci_yaml_file
    ```
    
1. You can use the SQL API endpoints to test that the container is now reachable. In this case you are using the domain name to access the container, and not its IP address:

    ```azurecli
    # Test
    aci_fqdn=${aci_name}.${dns_zone_name} && echo $aci_fqdn
    ssh -n -o BatchMode=yes -o StrictHostKeyChecking=no $vm_pip "nslookup $aci_fqdn"
    ssh -n -o BatchMode=yes -o StrictHostKeyChecking=no $vm_pip "curl -ks https://$aci_fqdn/api/healthcheck"
    ssh -n -o BatchMode=yes -o StrictHostKeyChecking=no $vm_pip "curl -ks https://$aci_fqdn/api/sqlversion"
    ssh -n -o BatchMode=yes -o StrictHostKeyChecking=no $vm_pip "curl -ks https://$aci_fqdn/api/sqlsrcip"
    ```
    
1. You can inspect the logs of each individual container in the Azure Container Instance. For example, for the logs of the init container:

    ```azurecli
    # Init container logs
    az container logs -n $aci_name -g $rg --container-name azcli
    ```
    
1. You can now cleanup all the resources created for this unit and for the module:

    ```azurecli
    # Cleanup module
    az group delete -n $rg -y --no-wait
    ```

## Summary

You used an init container inside of an Azure Container Instance to update an Azure Private DNS Zone, so that other applications can find the Container Instance using DNS names instead of IP addresses.
