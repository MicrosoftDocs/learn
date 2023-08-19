In the previous unit, you used Azure CLI commands like `az container create` and their arguments to specify Azure Container Instances options. In this unit, you learn to use YAML markup to specify Container Instances properties. YAML lets you specify more sophisticated configurations for Azure container instances.

YAML stands for "Yet Another Markup Language," and provides a more human-readable description language than XML or JSON. YAML avoids using delimiters such as curly and square brackets that make human readability difficult, but relies on indentation to structure information in a hierarchy. Another benefit of YAML-based configurations is that you can store them in version-control systems and treat them the same as application code.

Kubernetes is a container orchestration system that uses YAML to describe its objects, and its popularity means that YAML has become a de facto standard for declarative container definitions. Kubernetes YAML uses many of the same constructs as Container Instances YAML. 

Azure Resource Manager (ARM) templates and Terraform are alternative methods to declaratively deploy Azure Container Instances. There isn't a specific reason why one method is better than others, but YAML is convenient for working with more complex container groups, such as the sidecar pattern you deploy in this module.

## Extract YAML code out of an existing container

You can inspect properties of your existing Azure container instance in YAML format, and save the YAML code to a file for later reference. In Cloud Shell in the Azure portal, run the following Azure CLI command:

```azurecli
# Browse YAML
az container export -n $aci_name -g $rg -f /tmp/aci.yaml
more /tmp/aci.yaml
```

You should see something similar to the following sample output when you inspect the generated YAML code, for example by using `cat /tmp/aci.yaml`.

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
    id: /subscriptions/<<subscriptionid>>/resourceGroups/acilab/providers/Microsoft.Network/networkProfiles/aci-network-profile-acivnet-aci
  osType: Linux
  restartPolicy: Always
tags: {}
type: Microsoft.ContainerInstance/containerGroups
```

> [!NOTE]
> The sections in the auto-generated YAML file are ordered alphabetically.

Note the following characteristics of this YAML description:

- YAML is very sensitive to indentation. Removing or adding a blank space before a line makes it syntactically incorrect. Only spaces, not tabs, are supported for indentation, so be careful with your text editor.
- Properties and attributes are specified hierarchically in key-value pairs.
- Many of the labels are familiar from Kubernetes. For example, resource requests follow the same syntax. However, don't expect all properties to be identical with Kubernetes. For example, ACI environment variables are defined in the `environmentVariables` property, while Kubernetes uses the `env` keyword.
- The environment variables are in clear text. This is probably acceptable for most environment variables, but others, such as the SQL password used in this example, shouldn't be visible openly. A better way to define this sensitive information is with secure values.

## Modify and deploy the YAML file

You don't want your customer to be able to see the SQL database password, so you need to mask it. To generate the required YAML, you manually edit the file automatically generated in the preceding step and redeploy it to create a modified container instance. While you could change the environment variable into a secure environment variable by using the Azure CLI, you use YAML in preparation for future requirements.

1. Use your favorite text editor to change line 13 of */tmp/aci.yaml* from <br><br>`        value: Microsoft123!` <br><br>to <br><br>`        secureValue: Microsoft123!`. Be careful not to change indentation. You can also use the online text editor `sed` to make the change:

    ```bash
    # Modify auto-generated YAML
    sed -i 's/        value: Microsoft123!/        secureValue: Microsoft123!/g' /tmp/aci.yaml
    ```

1. After modifying the file, run the following commands to delete the old container and redeploy the new YAML. The Azure CLI command `az container create` takes the argument `--file`, where you can input the YAML description of the container to create. You only need to specify the resource group, because all the other information is contained in the YAML file, including the container instance name.

    ```azurecli
    # Recreate container using updated YAML
    az container delete -n $aci_name -g $rg -y
    az container create -g $rg --file /tmp/aci.yaml
    ```

1. Export the new container instance to a different YAML file */tmp/aci2.yaml*, and note that the changes you made to the YAML are now in effect. The SQL password is no longer5 exposed as clear text.

    ```bash
    # Recreate container
    az container export -n $aci_name -g $rg -f /tmp/aci2.yaml
    more /tmp/aci2.yaml
    ```

You can find more properties to use in Container Instances YAML declarations in the Azure Container Instances YAML reference.

1. Delete the container created in this unit, so that we can move on to the next one.

    ```azurecli
    # Cleanup unit 3
    az container delete -n $aci_name -g $rg -y
    ```

