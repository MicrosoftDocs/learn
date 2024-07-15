In the previous unit, you used Azure CLI commands like `az container create` and their arguments to specify Azure Container Instances options. In this unit, you learn to use YAML markup to specify more sophisticated configurations for container instances.

YAML stands for "Yet Another Markup Language," and provides a more human-readable description language than XML or JSON. YAML avoids delimiters such as curly and square brackets that make human readability difficult, but relies on indentation to structure information in a hierarchy. An advantage of YAML-based configurations is that you can store them in version-control systems and treat them the same as application code.

Kubernetes is a container orchestration system that uses YAML to describe its objects, and its popularity means that YAML has become a de facto standard for declarative container definitions. Kubernetes YAML uses many of the same constructs as Container Instances YAML.

Azure Resource Manager (ARM) templates and Terraform are alternative methods to declaratively deploy Azure Container Instances. One method isn't inherently better than the others, but YAML is convenient for working with more complex container groups, such as the sidecar pattern in this module.

## Extract YAML code out of an existing container

You can inspect the properties of your existing Azure container instance in YAML format, and save the YAML code to a file for later reference and to create new instances. In Cloud Shell in the Azure portal, run the following Azure CLI command:

```azurecli
# Browse YAML
az container export -n $aci_name -g $rg -f /tmp/aci.yaml
more /tmp/aci.yaml
```

Inspect the generated YAML code, for example by using `cat /tmp/aci.yaml`. You should see something similar to the following output:

```yml
additional_properties: {}
apiVersion: '2023-05-01'
extended_location: null
location: northeurope
name: learnaci
properties:
  containers:
  - name: learnaci
    properties:
      environmentVariables:
      - name: SQL_SERVER_USERNAME
        value: azure
      - name: SQL_SERVER_PASSWORD
        value: NAwzq6sjdItw7Ot
      - name: SQL_SERVER_FQDN
        value: <server-name>.database.windows.net
      image: erjosito/sqlapi:1.0
      ports:
      - port: 8080
        protocol: TCP
      resources:
        requests:
          cpu: 1.0
          memoryInGB: 1.5
  initContainers: []
  ipAddress:
    ip: 192.168.2.4
    ports:
    - port: 8080
      protocol: TCP
    type: Private
  isCustomProvisioningTimeout: false
  osType: Linux
  provisioningTimeoutInSeconds: 1800
  restartPolicy: Always
  sku: Standard
  subnetIds:
  - id: /subscriptions/<<subscriptionid>>/resourceGroups/acilab/providers/Microsoft.Network/virtualNetworks/acivnet/subnets/aci
tags: {}
type: Microsoft.ContainerInstance/containerGroups
```

> [!TIP]
> The sections in the auto-generated YAML file are ordered alphabetically.

Notice the following characteristics of the YAML description:

- YAML is sensitive to indentation. Removing or adding a blank space before a line makes it syntactically incorrect. Only spaces, not tabs, are supported for indentation, so be careful with your text editor.
- Properties and attributes are specified hierarchically in key-value pairs.
- Many of the labels are familiar from Kubernetes. For example, resource requests follow the same syntax. However, don't expect all properties to be identical with Kubernetes. For example, ACI environment variables are defined in the `environmentVariables` property, while Kubernetes uses the `env` keyword.
- The environment variables are in clear text. Clear text is probably acceptable for most environment variables, but others, such as the SQL password in this example, shouldn't be openly visible. A better way to define this sensitive information is with a secure value, which you implement in the next section.

## Modify and deploy the YAML file

You don't want the SQL database password to be visible to customers, so you need to mask it using secure values for the environment variables instead of standard values. To generate the required YAML, you manually edit the automatically generated YAML file and redeploy it to create a modified container instance. While you could change the environment variable into a secure environment variable by using the Azure CLI, you use YAML in preparation for future requirements.

1. Use your favorite text editor to change line 13 of */tmp/aci.yaml* from <br>`        value: <your Azure SQL password>` <br>to <br>`        secureValue: <your Azure SQL password>`.<br>Be careful not to change indentation. You can also use the online text editor `sed` to make the change. You should also remove any other line you don't need, such as the `provisioningTimeoutInSeconds` attribute, which isn't supported by the `2023-05-01` API.

    ```bash
    # Modify auto-generated YAML
    sed -i "s/        value: $sql_password/        secureValue: $sql_password/g" /tmp/aci.yaml
    # Delete the provisioningTimeoutInSeconds attribute
    sed -i /provisioningTimeoutInSeconds/d /tmp/aci.yaml
    ```

1. After modifying the file, run the following commands to delete your old container and redeploy the new YAML. The Azure CLI command `az container create` takes the argument `--file`, where you can input the YAML description of the container to create. You only need to specify the resource group, because all the other information is contained in the YAML file, including the container instance name.

    ```azurecli
    # Recreate container using updated YAML
    az container delete -n $aci_name -g $rg -y
    az container create -g $rg --file /tmp/aci.yaml
    ```

1. Export the new container instance to a different YAML file */tmp/aci2.yaml*, and note that the SQL password is no longer exposed as clear text in the file.

    ```bash
    # Recreate container
    az container export -n $aci_name -g $rg -f /tmp/aci2.yaml
    more /tmp/aci2.yaml
    ```

1. Delete the container you created in this unit, because you don't need it anymore.

    ```azurecli
    # Cleanup unit 3
    az container delete -n $aci_name -g $rg -y
    ```

You can find more properties to use in Container Instances YAML declarations in the Azure Container Instances YAML reference.

