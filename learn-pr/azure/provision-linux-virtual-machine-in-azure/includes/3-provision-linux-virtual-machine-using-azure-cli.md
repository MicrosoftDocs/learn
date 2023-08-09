You can install Azure CLI locally on Linux, macOS, and Windows operating systems. The installation details depend on the operating system and in the case of Linux, also on the distribution.

> [!NOTE]
> 
> For more information about the installation options for Linux, refer to [Install the Azure CLI on Linux](/cli/azure/install-azure-cli-linux).

To use Azure CLI interactively, launch a shell available within your operating system, such as cmd.exe in Windows, or Bash in Linux or macOS&mdash;and then issue a command at the command prompt. To automate repetitive tasks, assemble the CLI commands into a shell script using the script syntax of your chosen shell, and then run the script.

If you want to avoid installing Azure CLI, you can use Azure Cloud Shell. Azure Cloud Shell is an interactive, authenticated shell that you can use to manage Azure resources from a web browser. Azure Cloud Shell can run Bash and Azure PowerShell, and it has the current version of Azure CLI already preinstalled. To access Azure Cloud Shell, open the [Azure Cloud Shell](https://shell.azure.com/) link in a web browser or launch it from the Azure portal by selecting the Azure Cloud Shell icon next to the global search textbox.

![Screenshot showing the Azure Cloud Shell icon in the Azure portal.](../media/azure-portal-cloud-shell-icon.png)

Azure Cloud Shell provides the benefit of built-in authentication, which uses the credentials you provide when accessing your Azure subscription from your web browser. This eliminates the need for running the `az login` command at the beginning of each session, which is required when you run Azure CLI locally.

## Deploy a Linux VM by using Azure CLI

The process of provisioning an Azure VM running Linux by using Azure CLI typically involves the following sequence of high-level steps:

- Identify a suitable VM image.
- Identify the suitable VM size.
- Create a resource group.
- Create and configure a virtual network.
- Create an Azure VM.

Depending on your existing environment and requirements, it might not be necessary to complete each of the preceding steps. For example, you might use an existing resource group or a virtual network subnet for your deployment. In addition, Azure CLI supports a wide range of default settings, which automatically apply if you decide not to explicitly assign values to some of the resource settings. For example, as with the Azure portal-based deployment, if you don't specify an existing virtual network Azure CLI will automatically provision one for you. In this module, you'll rely on the Azure CLI default settings and skip the process of creating a virtual network.

> [!NOTE]
> 
> For information regarding implementing virtual networks by using Azure CLI, refer to [Quickstart: Create a virtual network using the Azure CLI](/azure/virtual-machines/linux/quick-create-cli).

### Identify a suitable VM image

Before you start your provisioning process, first you need to determine the VM image that you want to use. You must also verify that image's availability in the Azure region that will host your deployment.

To list the Azure regions available in your subscription, run the following command from a Bash session in the Azure Cloud Shell pane:

```azurecli
az account list-locations --output table
```

Review the output and identify the value in the Name column for the region you intend to use. Assume you chose the East US region as your target, so that the name is Eastus.

To identify the suitable image, you'll need to determine its publisher, offer, and sku. To narrow down the list of available options, list the non-Microsoft publishers for the region you identified earlier by running the following command:

```azurecli
az vm image list-publishers --location eastus --query [].name --output tsv | grep -v "Microsoft" | more
```

> [!NOTE]
> 
> The list is quite extensive, so you should ensure that you limit the output to the available session buffer.

Assume you chose `Canonical`. Next, identify the offers available from that publisher by running the following command:

```azurecli
az vm image list-offers --location eastus --publisher Canonical --query [].name --output tsv
```

Assume you chose `0001-com-ubuntu-server-jammy`. Next, run the following command to identify SKUs available with that offer by running the following command:

```azurecli
az vm image list-skus --location eastus --publisher Canonical --offer 0001-com-ubuntu-server-focal --query [].name --output tsv
```

> [!NOTE]
> 
> Canonical has recently been changing the offer names. Before Ubuntu 20.04, the offer name was `UbuntuServer`. For Ubuntu 20.04 the offer name is `0001-com-ubuntu-server-focal`, and for Ubuntu 22.04 it's `0001-com-ubuntu-server-jammy`.

To deploy an Azure VM using a specific image, you need to determine the value of its `Urn` property. This value consists of the publisher, offer, SKU, and optionally a version number that uniquely identifies the image. You can also set the version number to _latest_, which designates the latest version of the distribution. To display the value of the `Urn` property for all Ubuntu's 22_04-lts images in the East US region, run the following command:

```azurecli
az vm image list --location eastus --publisher Canonical --offer 0001-com-ubuntu-server-jammy --sku 22_04-lts --all --output table
```

> [!NOTE]
> 
> You can use the `UrnAlias` property for a simpler, although much less flexible approach to designating an image to use during deployment. This property is readily available for the most common images and you can retrieve its values by running the `az vm image list --output table` Azure CLI command. For example, the `UrnAlias` `UbuntuLTS` corresponds to the image `Canonical:UbuntuServer:18.04-LTS:latest`.

### Identify the suitable VM size

In addition to image availability, you also should ensure that the VM size you intend to use is available in the Azure region that will host your deployment. To confirm this, run the following command:

```azurecli
az vm list-sizes --location eastus --output table
```

Identify the VM size suitable for your sample deployment from the listing and note the value in the Name column. You'll need to enter the name in the identical format when running the Azure CLI command that initiates the Azure VM provisioning. Assume you chose Standard_F4s.

> [!IMPORTANT]
> 
> Before you proceed, verify that this VM size is available in the Azure region you're targeting, and if needed, adjust the values of parameters in the subsequent commands accordingly.

### Create a resource group

After identifying the Azure VM image and size, you can now begin the provisioning process. Start by creating a resource group that will host the Azure VM and its dependent resources. To create a resource group, use the az group create command. This command requires that you specify both the value of the name and location parameters, which designates the resource group name and the target Azure region, respectively.

```azurecli
az group create --name rg_lnx-cli --location eastus
```

The output of the command should resemble the following example:

```json
{
  "id": "/subscriptions/fd7edadd-187f-41dd-a5df-f80bad63c167/resourceGroups/sample-RG",
  "location": "eastus",
  "managedBy": null,
  "name": "rg_lnx-cli",
  "properties": {
    "provisioningState": "Succeeded"
  },
  "tags": null,
  "type": "Microsoft.Resources/resourceGroups"
}
```

### Create an Azure VM

To create a VM, use the az vm create command. This command supports a wide range of parameters, including the OS image, disk size, and administrative credentials. In the following example, the az vm create command triggers deployment of an Azure VM named sample-cli-vm0, which hosts the latest Ubuntu 22_04-lts-gen2 SKU version. The provisioning process configures an administrative user account named azureuser with authentication based on an SSH key pair. The private and public key are generated and stored locally in their default location (~/.ssh) to allow SSH access to the Azure VM. Use the following code example to create an Azure VM:

```azurecli
az vm create \
    --resource-group rg_lnx-cli \
    --name lnx-cli-vm \
    --image Canonical:0001-com-ubuntu-server-jammy:22_04-lts-gen2:latest \
    --size Standard_F4s \
    --admin-username azureuser \
    --generate-ssh-keys
```

> [!NOTE]
> 
> The `--size` parameter is optional. If you decide to exclude it, the resulting size will depend on the image you chose.

The Azure VM will begin running shortly afterwards, usually within a couple of minutes. The output of the Azure CLI command will include JSON-formatted information about the newly deployed Azure VM:

```json
{
  "fqdns": "",
  "id": "/subscriptions/fd7edadd-187f-0000-0000-000000000000/resourceGroups/rg_lnx-cli/providers/Microsoft.Compute/virtualMachines/lnx-cli-vm",
  "location": "eastus",
  "macAddress": "00-0D-3A-8C-C6-AE",
  "powerState": "VM running",
  "privateIpAddress": "10.0.0.4",
  "publicIpAddress": "20.51.149.212",
  "resourceGroup": "rg_lnx-cli",
  "zones": ""
}
```

At this point, you'll be able to connect to the Azure VM by running the following command (after replacing the *\<public_ip_address>* placeholder with the IP address you identified in the Azure CLI-generated output) from the computer where the private key is stored:

```azurecli
ssh azureuser@<public_ip_address>
```
