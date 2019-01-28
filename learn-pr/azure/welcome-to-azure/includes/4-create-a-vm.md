As a technology professional, you likely have expertise in a specific area. Perhaps you're a storage admin or virtualization expert, or maybe you focus on the latest security practices. If you're a student, you may still be exploring what interests you most.

::: zone pivot="windows-cloud"

No matter your role, most people get started with the cloud by creating a virtual machine. Here you'll deploy a virtual machine running Windows Server 2016.

::: zone-end

::: zone pivot="linux-cloud"

No matter your role, most people get started with the cloud by creating a virtual machine. Here you'll deploy a virtual machine running Ubuntu 16.04.

::: zone-end

There are many ways to create a virtual machine on Azure. Here, you'll create a Windows or Linux virtual machine using an interactive terminal called Cloud Shell. If you work from the terminal on a daily basis, you know this is often the fastest way to get the job done.

::: zone pivot="windows-cloud"

> [!TIP]
> Prefer Linux or want to try something new? Select **Linux** from the top of this page to run a Linux virtual machine.

::: zone-end

::: zone pivot="linux-cloud"

> [!TIP]
> Prefer Windows or want to try something new? Select **Windows** from the top of this page to run a Windows Server virtual machine.

::: zone-end

Let's review some basic terms and get your first virtual machine up and running.

## What is a virtual machine?

A virtual machine, or VM, is a software emulation of a physical computer. Because VMs exist as software, dozens, hundreds, or even thousands of Azure VMs can be generated in minutes, then deleted when you don't need them. With low-cost, per-minute billing, you pay only for the compute resources you use, for as long as you are using them. Plus, there are many ways to configure the VMs to fit your needs.

::: zone pivot="windows-cloud"

A snapshot of a running VM is called an _image_. Azure provides images for Windows and several flavors of Linux. You can also create your own preconfigured images to make deployments go faster. Here you'll bring up a Windows Server 2016 VM, provided by Microsoft.

::: zone-end

::: zone pivot="linux-cloud"

A snapshot of a running VM is called an _image_. Azure provides images for Windows and several flavors of Linux. You can also create your own preconfigured images to make deployments go faster. Here you'll bring up an Ubuntu 16.04 VM, provided by Canonical.

::: zone-end

## What defines a virtual machine on Azure?

A virtual machine is defined by a number of factors, including its size and location. Before you bring up your VM, let's briefly cover what's involved.

:::row:::
    :::column:::
        **Size**
    :::column-end:::
    :::column span="3":::
A VM's _size_ defines its processor speed, amount of memory, initial amount of storage, and expected network bandwidth. Some sizes even include specialized hardware such as GPUs for heavy graphics rendering and video editing.
    :::column-end:::
:::row-end:::

:::row:::
    :::column:::
        **Region**
    :::column-end:::
    :::column span="3":::
Azure is made up of data centers distributed throughout the world. A _region_ is a set of Azure data centers in a named geographic location. Every Azure resource, including virtual machines, is assigned a region. East US and North Europe are examples of regions.
    :::column-end:::
:::row-end:::

:::row:::
    :::column:::
        **Network**
    :::column-end:::
    :::column span="3":::
A _virtual network_ is a logically isolated network on Azure. Each virtual machine on Azure is associated with a virtual network. Azure provides cloud-level firewalls for your virtual networks called _network security groups_.
    :::column-end:::
:::row-end:::

:::row:::
    :::column:::
        **Resource groups**
    :::column-end:::
    :::column span="3":::
Virtual machines and other cloud resources are grouped into logical containers called _resource groups_. Groups are typically used to organize sets of resources that are deployed together as part of an application or service. You refer to a resource group by its name.
    :::column-end:::
:::row-end:::

## What is Azure Cloud Shell?

Azure Cloud Shell is a browser-based command-line experience for managing and developing Azure resources. Think of Cloud Shell as an interactive console that you run in the cloud.

Cloud Shell provides two experiences to choose from: Bash and PowerShell. Both include access to the Azure CLI, the command-line interface for Azure.

You can use any Azure management interface, including the Azure portal, Azure CLI, and Azure PowerShell, to manage any kind of VM. For learning purposes, here you'll use the Azure CLI to create and manage either a Windows or Linux VM.

[!include[](../../../includes/azure-sandbox-activate.md)]

## Creating resources in Azure

Normally, the first thing we'd do is to create a _resource group_ to hold all the things that we need to create. This allows us to administer all the VMs, disks, network interfaces, and other elements that make up our solution as a unit. We can use the Azure CLI to create a resource group with the `az group create` command. It takes a `--name` to give it a unique name in our subscription, and a `--location` to tell Azure what area of the world we want the resources to be located by default.

Since we are in the free Azure sandbox environment, you don't need to do this step, instead, you will use the pre-created resource group **<rgn>[Resource Group Name]</rgn>**.

## Choosing a location

<!-- Resource selection -->
[!include[](../../../includes/azure-sandbox-regions-first-mention-note.md)]

::: zone pivot="windows-cloud"

## Create a Windows VM

Let's get your Windows VM up and running.

1. In the Cloud Shell on the side of this page, run the following commands to create a username and generate a random password.

    ```bash
    USERNAME=azureuser
    PASSWORD=$(openssl rand -base64 32)
    ```

    The username and password here are stored as Bash variables. If you're a PowerShell user, just know that Bash variables are similar. You'll use these variables in the next step to set the Windows admin name and password.

    This example uses **azureuser** as the username. But the name can be whatever you'd like.

    There are many ways to generate passwords. The command shown here is just one of them.

1. Run the following `az vm create` command to create your VM. The command creates the VM in the "East US" location, but you can change that to any of the locations listed above.

    ```azurecli
    az vm create \
      --name myVM \
      --resource-group <rgn>[sandbox resource group name]</rgn> \
      --image Win2016Datacenter \
      --size Standard_DS2_v2 \
      --location eastus \
      --admin-username $USERNAME \
      --admin-password $PASSWORD
    ```

    [!include[](../../../includes/azure-cloudshell-copy-paste-tip.md)]

    Your VM will take four to five minutes to come up. Compare that to the time it takes to purchase, rack, and configure a system in your data center. Quite a difference!

While you're waiting, let's review the command you just ran.

* The VM is named **myVM**. This name identifies the VM in Azure. It also becomes the VM's internal hostname, or computer name.
* The resource group, or the VM's logical container, is named **<rgn>[sandbox resource group name]</rgn>**.
* **Win2016Datacenter** specifies the Windows Server 2016 VM image.
* **Standard_DS2_v2** refers to the size of the VM. This size has two virtual CPUs and 7 GB of memory.
* The username and password enable you to connect to your VM later. For example, you can connect over Remote Desktop or WinRM to work with and configure the system.

> [!NOTE]
> Although you have everything you need to connect directly to your VM, don't do so quite yet.
> In the next unit, you'll see one way to connect to the VM to make changes to its configuration.

By default, Azure assigns a public IP address to your VM. You can configure a VM to be accessible from the Internet or only from the internal network.

You can also check out this short video about some of the options you have to create and manage VMs.

#### Options to create and manage VMs

> [!VIDEO https://www.microsoft.com/videoplayer/embed/RE2yJKx]

When the VM is ready, you see information about it. Here's an example.

```json
{
  "fqdns": "",
  "id": "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/myResourceGroup/providers/Microsoft.Compute/virtualMachines/myVM",
  "location": "eastus",
  "macAddress": "00-0D-3A-1E-1B-3B",
  "powerState": "VM running",
  "privateIpAddress": "10.0.0.5",
  "publicIpAddress": "104.211.9.245",
  "resourceGroup": "myResourceGroup",
  "zones": ""
}
```

> [!NOTE]
> On Microsoft Learn, you'll often see sample output, like the output shown above. We show you these examples so you can compare them to the output you see. However, it's just an example, so don't enter it into the Cloud Shell session.

## Verify your VM is running

The `az vm create` command succeeded, but let's verify that your VM is up and running.

1. Run the following `az vm get-instance-view` command to verify that the VM was successfully created and is running.

    ```azurecli
    az vm get-instance-view \
      --name myVM \
      --resource-group <rgn>[sandbox resource group name]</rgn> \
      --output table
    ```

    The output you see resembles this.

    ```azurecli
    Name    ResourceGroup                         Location    ProvisioningState    PowerState
    ------  ------------------------------------  ----------  -------------------  ------------
    myVM    <rgn>[sandbox resource group name]</rgn>  eastus      Succeeded            VM running
    ```

    You see the VM's name, its resource group, and its location. You also see that the VM was provisioned, or created, successfully and that it's running.

::: zone-end

::: zone pivot="linux-cloud"

## Create a Linux VM

Let's get your Linux VM up and running.

1. From Cloud Shell on the right side of this page, run the `az vm create` command to create your VM. The following command creates the VM in the "East US" location, you can change that to any of the locations listed above - we recommend you select one close to you.

    ```azurecli
    az vm create \
      --name myVM \
      --resource-group <rgn>[sandbox resource group name]</rgn> \
      --image UbuntuLTS \
      --location eastus \
      --size Standard_DS2_v2 \
      --admin-username azureuser \
      --generate-ssh-keys
    ```

    [!include[](../../../includes/azure-cloudshell-copy-paste-tip.md)]

    Your VM will take about two minutes to come up. Compare that to the time it takes to purchase, rack, and configure a system in your data center. Quite a difference!

While you're waiting, let's review the command you just ran.

* The VM is named **myVM**. This name identifies the VM in Azure. It also becomes the VM's internal hostname, or computer name.
* The resource group, or the VM's logical container, is named **<rgn>[sandbox resource group name]</rgn>**.
* **UbuntuLTS** specifies the Ubuntu 16.04 LTS VM image.
* **Standard_DS2_v2** refers to the size of the VM. This size has two virtual CPUs and 7 GB of memory.
* The `--admin-username` option specifies **azureuser** as the username for the VM. The username can be whatever you want.
* The `--generate-ssh-keys` option creates an SSH key pair to enable you to log in to the VM.

> [!NOTE]
> Although you have everything you need to connect directly to your VM, don't do so quite yet.
> In the next unit, you'll see one way to connect to the VM to make changes to its configuration.

By default, Azure assigns a public IP address to your VM. You can configure a VM to be accessible from the Internet or only from the internal network.

You can also check out this short video about some of the options you have to create and manage VMs.

#### Options to create and manage VMs

> [!VIDEO https://www.microsoft.com/videoplayer/embed/RE2yJKx]

When the VM is ready, you see information about it. Here's an example.

```json
{
  "fqdns": "",
  "id": "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/myResourceGroup/providers/Microsoft.Compute/virtualMachines/myVM",
  "location": "eastus",
  "macAddress": "00-0D-3A-1D-EB-02",
  "powerState": "VM running",
  "privateIpAddress": "10.0.0.4",
  "publicIpAddress": "137.135.110.210",
  "resourceGroup": "myResourceGroup",
  "zones": ""
}
```

> [!NOTE]
> On Microsoft Learn, you'll often see sample output, like the output shown above. We show you these examples so you can compare them to the output you see. However, it's just an example, so don't enter it into the Cloud Shell session.

## Verify your VM is running

The `az vm create` command succeeded, but let's verify that your VM is up and running.

1. Run the following `az vm get-instance-view` command to verify that the VM was successfully created and is running.

    ```azurecli
    az vm get-instance-view \
      --name myVM \
      --resource-group <rgn>[sandbox resource group name]</rgn> \
      --output table
    ```

    The output you see resembles this.

    ```azurecli
    Name    ResourceGroup                         Location    ProvisioningState    PowerState
    ------  ------------------------------------  ----------  -------------------  ------------
    myVM    <rgn>[sandbox resource group name]</rgn>  eastus      Succeeded            VM running
    ```

    You see the VM's name, its resource group, and its location. You also see that the VM was provisioned, or created, successfully and that it's running.

::: zone-end
