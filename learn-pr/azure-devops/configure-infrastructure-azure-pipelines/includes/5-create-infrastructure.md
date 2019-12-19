Here, you create two Linux VMs that you'll later use to configure user accounts by using Ansible. Although you could use an infrastructure tool such as an Azure Resource Manager template, Terraform, or even Ansible to bring up your VMs, for learning purposes, here you use the Azure CLI.

> [!IMPORTANT]
> The [Clean up Azure resources](/learn/modules/configure-infrastructure-azure-pipelines/10-cleanup-resources?azure-portal=true) page in this module contains important cleanup steps. These steps ensure that you're not charged for Azure resources you no longer need. Be sure to perform the cleanup steps even if you don't complete this module.

## Select an Azure region

A _region_ is one or more Azure datacenters within a specific geographic location. East US, West US, and North Europe are examples of regions. Every Azure resource, including an app service instance, is assigned a region.

To make the commands easier to run, start by selecting a default region. After you specify the default region, later commands use that region unless you specify a different region.

1. From Cloud Shell, run the following `az account list-locations` command to list the regions that are available from your Azure subscription.

    ```azurecli
    az account list-locations \
      --query "[].{Name: name, DisplayName: displayName}" \
      --output table
    ```

1. From the **Name** column in the output, choose a region that's close to you, for example, **eastasia** or **westus2**.

1. Run `az configure` to set your default region. Replace **\<REGION>** with the name of the region you chose for your database.

    ```azurecli
    az configure --defaults location=<REGION>
    ```

    Here's an example that sets **northeurope** as the default region.

    ```azurecli
    az configure --defaults location=northeurope
    ```

## Create a resource group

A _resource group_ holds related Azure resources. Here, you create a resource group that holds your Linux VMs.

Run the following `az group create` command to create a resource group that's named **learn-ansible-rg**.

```azurecli
az group create --name learn-ansible-rg
```

## Create the virtual machines

Here you create two virtual machines, each running Ubuntu.

1. Run the following `az vm create` command to create a virtual machine that's named **vm1**:

    ```azurecli
    az vm create \
      --resource-group learn-ansible-rg \
      --name vm1 \
      --admin-username azureuser \
      --image UbuntuLTS \
      --tags Ansible=mslearn \
      --ssh-key-values ~/.ssh/ansible_rsa.pub
    ```

    This command specifies *azureuser* as the administrator user.

    The `--ssh-key-values` argument specifies your SSH public key. The VM stores this file. Later, you use the private key to connect.

    The `--tags` argument specifies a tag to apply to the VM. Think of a tag as metadata that helps you logically organize your resources. This syntax creates the tag as a key-value pair, where "Ansible" is the key and "mslearn" is its value. Ansible uses this tag to form groups within the inventory.

1. Run `az vm create` a second time to create a VM that's named **vm2**:

    ```azurecli
    az vm create \
      --resource-group learn-ansible-rg \
      --name vm2 \
      --admin-username azureuser \
      --image UbuntuLTS \
      --tags Ansible=mslearn \
      --ssh-key-values ~/.ssh/ansible_rsa.pub
    ```

1. Run the following `az vm list` command to verify that your VMs were successfully created:

    ```azurecli
    az vm list \
      --resource-group learn-ansible-rg \
      --query [].{Name:name} \
      --output table
    ```

    You see this:

    ```output
    Name
    ------
    vm1
    vm2
    ```