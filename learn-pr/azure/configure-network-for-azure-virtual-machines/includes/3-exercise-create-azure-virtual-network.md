In this exercise, you will create a virtual network in Microsoft Azure. You will then create two virtual machines and use the virtual network to connect the virtual machines and to the Internet.

> [!IMPORTANT]
> The exercises in this module require a full Azure subscription. The exercises are optional and are not required to complete this module. Participating in the interactive exercises in this module will result in charges billed to the Azure subscription you use to complete them.  Incurred charges can be minimized by cleaning up the resources you create as soon as possible. Cleanup directions are in the final unit.

## Log in to your subscription with the Azure CLI

This first exercise will use the Azure CLI. If you have a local installation of the Azure CLI, feel free to use it &mdash; make sure to use `az account` to log in to the subscription you want to use. If not, you can log into your Azure account on [shell.azure.com](https://shell.azure.com) and use the shell from there.

> [!NOTE]
> If you are using the CloudShell environment, select the **Bash** shell option. If you are using PowerShell, locally or in the cloud, then you will need to escape all empty parameters by changing `""` to `'""'` to properly pass an empty string into the command. Without this, PowerShell will not pass the empty string, and you will get an error from the command indicating it's missing a parameter.

## Create a resource group

First, create a resource group to contain all of the resources you'll create in this module. Name it `vm-networks`.

```azurecli
az group create --name vm-networks
```

## Create a virtual network

To create a virtual network, enter the following command and press Enter.

```azurecli
az network vnet create \
    --name myVnet \
    --resource-group vm-networks \
    --subnet-name default
```

## Create two virtual machines

All Azure virtual machines are connected to a virtual network. If you create a virtual machine using the Azure CLI and don't specify the name of an existing virtual network, the CLI will search the target resource group for an appropriate virtual network to use, based on location and subnet availability. If no match is found, a new virtual network will be created automatically.

Here, we create two virtual machines without specifying any virtual network information. The default network specifications match the attributes of `myVnet`, so the CLI will automatically locate and use it.

1. To create the first virtual machine, execute the following command to create a Windows VM with a public IP address that is accessible over port 3389 (Remote Desktop). This will create a Windows 2016 Datacenter VM named `dataProcStage1`.

    ```azurecli
    az vm create \
        --name dataProcStage1 \
        --resource-group vm-networks \
        --admin-username "DataAdmin" \
        --image Win2016Datacenter
    ```

1. Supply values for your password at the prompts. Remember to write this password down as you'll need it later to access the server.

1. Copy the **publicIpAddress** value in the returned JSON from creating your VM so you can use it later.

1. You'll now create the second VM. This VM will be named `dataProcStage2` and will not have a public IP address.

    ```azurecli
    az vm create \
        --name dataProcStage2 \
        --resource-group vm-networks \
        --public-ip-address "" \
        --admin-username "DataAdmin" \
        --image Win2016Datacenter
    ```

## Connect to dataProcStage1 using Remote Desktop

1. Open Remote Desktop and connect to `dataProcStage1` with the public IP address you noted from the previous steps.

1. Log into the remote machine with the username `DataAdmin` and the password you created.

1. In the remote session, open the Windows command prompt and run the following command:

    ```cmd
    ping dataProcStage2 -4
    ```

1. In the results, you'll see that all requests to `dataProcStage2` time out. This is because the default Windows Firewall configuration on `dataProcStage2` prevents it from responding to pings.

## Connect to dataProcStage2 using Remote Desktop

You'll configure the Windows Firewall on `dataProcStage2` using a new remote desktop session. However, you'll not able to access `dataProcStage2` from your desktop. Recall, `dataProcStage2` does not have a public IP address. You will use remote desktop from `dataProcStage1` to connect to `dataProcStage2`.

1. In the `dataProcStage1` remote session, open Remote Desktop.

1. Connect to `dataProcStage2` by name. Based on the default network configuration, `dataProcStage1` can resolve the address for `dataProcStage2` using the computer name.

1. Log in to `dataProcStage2` with the username `DataAdmin` and the password you created.

1. On `dataProcStage2`, click the Start Menu, type **Firewall**, and press Enter. The **Windows Firewall with Advanced Security** console appears.

1. In the left-hand pane, click **Inbound Rules**.

1. In the right-hand pane, scroll down, and right-click **File and Printer Sharing (Echo Request - ICMPv4-In)**, and then click **Enable Rule**.

1. Switch back to the `dataProcStage1` remote session and run the following command in the command prompt.

    ```cmd
    ping dataProcStage2 -4
    ```

1. `dataProcStage2` responds with four replies, demonstrating connectivity between the two VMs.

You have successfully created a virtual network, created two VMs that are attached to that virtual network, connected to one of the VMs and shown network connectivity to the other VM within the same virtual network. You can use Azure Virtual Network to connect resources within the Azure network. However, those resources need to be within the same resource group and subscription. Next, we will look at VPN gateways, which enable you to connect virtual network in different resource groups, subscriptions, and even geographical regions.
