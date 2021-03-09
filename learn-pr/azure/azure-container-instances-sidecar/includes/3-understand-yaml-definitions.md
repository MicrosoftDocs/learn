
In the previous unit you specified the container options as arguments to the `az container create` Azure CLI command, such as the Virtual Network or the environment variables. However, this is not your only choice: You can specify the Azure Container Instance properties in YAML format as well, to specify more sophisticated configuration in your Azure Container Instance. YAML stands for "Yet Another Markup Language", and it was born to provide a more human-readable description language than XML or JSON. It avoids using delimiters such as curly or square brackets that make human readability difficult. Instead, it relies on a prescriptive usage of indentation to structure information in a hierarchy.

Kubernetes is a container orchestration system that uses YAML to describe its [objects](https://kubernetes.io/docs/concepts/overview/working-with-objects/kubernetes-objects/). The popularity of Kubernetes has driven YAML to become a *de facto* standard for declarative definitions of containers structures. If you are already familiar with Kubernetes YAML, you will recognize many of the constructs used in Azure Container Instances YAML.

YAML is one of the different ways in which you can declaratively deploy Azure Container Instances, others include [ARM templates](https://docs.microsoft.com/azure/container-instances/container-instances-quickstart-template) and [Terraform](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_group). There is not a specific reason why one would be better than the other, but YAML tends to be very convenient when working with more complex container groups, such as the sidecar pattern you will deploy in this unit.

1. If you deleted your Azure Container Instance as instructed by the previous unit, you can recreate it with the following Azure CLI command. If you did not delete it, you can skip this step.

    ```azurecli
    # Create Azure Container if not existing
    az container create -n $aci_name -g $rg -e "SQL_SERVER_USERNAME=$sql_username" \
      "SQL_SERVER_PASSWORD=$sql_password" \
      "SQL_SERVER_FQDN=${sql_server_fqdn}" \
      --image erjosito/sqlapi:1.0 \
      --ip-address private --ports 8080 --vnet $vnet_id --subnet $aci_subnet_id
    ```

2. You can inspect properties of your existing Azure Container Instance in YAML format with the Azure CLI, and save the YAML code to a file for later reference:

    ```azurecli
    # Browse YAML
    az container export -n $aci_name -g $rg -f /tmp/aci.yaml
    more /tmp/aci.yaml
    ```
    
    Here a sample output, you should see something similar when inspecting the generated YAML code, for example with `cat /tmp/aci.yaml`:
    
    ```yml
    additional_properties: {}
    apiVersion: '2018-10-01'
    identity: null
    location: westeurope
    name: learnaci
    properties:
      containers:
      - name: learnaci
        properties:
          environmentVariables:
          - name: SQL_SERVER_USERNAME
            value: azure
          - name: SQL_SERVER_PASSWORD
            value: Microsoft123!
          - name: SQL_SERVER_FQDN
            value: sqlserver5441.database.windows.net
          image: erjosito/sqlapi:1.0
          ports:
          - port: 8080
            protocol: TCP
          resources:
            requests:
              cpu: 1.0
              memoryInGB: 1.5
      ipAddress:
        ip: 192.168.2.4
        ports:
        - port: 8080
          protocol: TCP
        type: Private
      networkProfile:
        id: /subscriptions/e7da9914-9b05-4891-893c-546cb7b0422e/resourceGroups/acilab/providers/Microsoft.Network/networkProfiles/aci-network-profile-acivnet-aci
      osType: Linux
      restartPolicy: Always
    tags: {}
    type: Microsoft.ContainerInstance/containerGroups
    ```
    
    > [!NOTE]
    > The sections in the auto-generated YAML file are ordered alphabetically.
    
    There are some interesting characteristics of this YAML description worthy to highlight:
    
    - Note that YAML is very sensitive to indentation. If you remove or add a blank space in the previous file, it will not be syntactically correct any more. Only spaces are supported for indentation (no tabs), so be careful with the your text editor.
    - Properties and attributes are specified hierarchically in key-value pairs.
    - If you are familiar with Kubernetes, you will recognize many of the labels. For example, resource requests follow the same syntax. However, do not expect all properties to be identical with Kubernetes. For example, ACI environment variables are defined in the `environmentVariables` property, while Kubernetes would use the `env` key word.
    - If you look into the environment variables, you see them in clear text. While this is probably acceptable for most environment variables, others should not be written in the open, such as the SQL password used in this example. A better way of defining this sensitive information would be with [ACI Secure Values](https://docs.microsoft.com/azure/container-instances/container-instances-environment-variables#secure-values). In your case, you do not want that your customer is able to see the database password, so you need to masquerade it.
    
1. While you could change the environment variable for the SQL password into a secure environment variable using the Azure CLI, you will use YAML in preparation for future requirements. In order to generated the required YAML, you can manually edit the file automatically generated in this unit and redeploy it to created the modified Azure Container Instance. Use your favorite text editor to change line 13 of `/tmp/aci.yaml` from `        value: Microsoft123!` into `        secureValue: Microsoft123!` (do not change indentation). Alternatively, you can use the online text editor `sed` to perform the change:

    ```bash
    # Modify auto-generated YAML
    sed -i 's/        value: Microsoft123!/        secureValue: Microsoft123!/g' /tmp/aci.yaml
    ```
    
1. After modifying the file, you can redeploy the new YAML. The Azure CLI command `az container create` takes the argument `--file` where you can input the YAML description of the container to be created. Note that you only need to specify the resource group where the new Azure Container Instance should be created, since all other information is contained in the YAML file, including the Azure Container Instance name:

    ```azurecli
    # Recreate container using updated YAML
    az container delete -n $aci_name -g $rg -y
    az container create -g $rg --file /tmp/aci.yaml
    ```
    
1. If you export the new Azure Container Instance to a different YAML file `/tmp/aci2.yaml`, you will note that the changes you did to the YAML are now in effect: the SQL password is not exposed any more as clear text.

    ```bash
    # Recreate container
    az container export -n $aci_name -g $rg -f /tmp/aci2.yaml
    more /tmp/aci2.yaml
    ```
    
    You can find additional properties that can be used in Azure Container Instances YAML declarations in the [ACI YAML Reference](https://docs.microsoft.com/azure/container-instances/container-instances-reference-yaml).
    
1. As next step, you can delete the container created in this unit, so that we can move on to the next one.

    ```azurecli
    # Cleanup unit 3
    az container delete -n $aci_name -g $rg -y
    ```

## Summary

You exported the properties of an existing Azure Container Instance to YAML format. You modified the YAML file to change some of its attributes, and deployed a new Azure Container Instance with updated properties.