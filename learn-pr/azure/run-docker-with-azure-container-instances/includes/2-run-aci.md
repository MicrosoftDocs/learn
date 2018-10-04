Here, you create a container in Azure and expose it to the internet with a fully qualified domain name (FQDN).

[!include[](../../../includes/azure-sandbox-activate.md)]

## Why use Azure Container Instances?

Azure Container Instances is useful for scenarios that can operate in isolated containers, including simple applications, task automation, and build jobs. Azure Container Instances offers the following benefits:

- **Fast startup**: Launch containers in seconds.
- **Per second billing**: Incur costs only while the container is running.
- **Hypervisor-level security**: Isolate your application as completely as it would be in a VM.
- **Custom sizes**: Specify exact values for CPU cores and memory.
- **Persistent storage**: Mount Azure Files shares directly to a container to retrieve and persist state.
- **Linux and Windows**: Schedule both Windows and Linux containers using the same API.

For scenarios where you need full container orchestration, including service discovery across multiple containers, automatic scaling, and coordinated application upgrades, we recommend Azure Kubernetes Service (AKS).

## Create a container

You create a container by providing a name, a Docker image, and an Azure resource group to the **az container create** command. You can optionally expose the container to the Internet by specifying a DNS name label. In this example, you deploy a container that hosts a small web app. You can also select the location to place the image - we're defaulting to "East US" below, but you can change it to a location close to you from the following list.

<!-- TODO: fix region list so it's not hardcoded here -->
The free sandbox allows you to create resources in a subset of Azure's global regions. Select a region from the following list when creating any resources:

:::row:::
    :::column:::
        - westus2
        - centralus
        - eastus
        - westeurope
        - southeastasia
    :::column-end:::
:::row-end:::

Execute the following command in the Cloud Shell to start a container instance. The `--dns-name-label` value must be unique within the Azure region you create the instance, so you will need to replace `[dns-name]` with something unique.

```azurecli
az container create --resource-group <rgn>[sandbox resource group name]</rgn> --name mycontainer --image microsoft/aci-helloworld --ports 80 --dns-name-label [dns-name] --location eastus
```

Within a few seconds, you should get a response to your request. Initially, the container is in the **Creating** state, but it should start within a few seconds. You can check the status using the `az container show` command:

```azurecli
az container show \
    --resource-group <rgn>[sandbox resource group name]</rgn> \
    --name mycontainer \
    --query "{FQDN:ipAddress.fqdn,ProvisioningState:provisioningState}" \
    --out table
```

When you run the command, the container's fully qualified domain name (FQDN) and its provisioning state are displayed:

```output
FQDN                                    ProvisioningState
--------------------------------------  -------------------
aci-demo.eastus.azurecontainer.io       Succeeded
```

Once the container moves to the **Succeeded** state, navigate to its FQDN in your browser to verify success.

Here, you created an Azure container instance to run a web server and application. You also accessed this application using the FQDN of the container instance.