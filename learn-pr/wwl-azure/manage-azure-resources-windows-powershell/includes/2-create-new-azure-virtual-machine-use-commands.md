To create a new Azure virtual machine (VM) with PowerShell commands, you can use the locally installed Windows PowerShell with Az module, or you can use the Cloud Shell environment that's available in Azure portal. If you choose to use your locally installed PowerShell, it's recommended that you use Windows PowerShell 7.1. You should also install the Az module, so you can have Azure-related commands available. Also, when using locally installed PowerShell, you first need to use the **Connect-AzAccount** command to authenticate and connect to your Azure tenant. When you run this command in your PowerShell environment, you'll be prompted to authenticate. You need to use credentials from your Azure tenant, with privileges that allow you to create the resources needed for Azure VMs.

To create an Azure VM, you need to perform the following tasks:

1. Create a resource group.
1. Create an Azure VM.
1. Connect to the Azure VM.

## Create a resource group

An Azure resource group is a logical container into which Azure resources are deployed and managed. You must create a resource group before you create a VM. In the following example, a resource group named **myResourceGroup** is created in the West Europe region:

```powershell
New-AzResourceGroup -ResourceGroupName "myResourceGroup" -Location "westeurope"
```

The resource group is later used when creating or modifying a VM or the resources attached to a VM.

## Create an Azure VM

The **New-AzVM** cmdlet creates a VM in Azure. This cmdlet uses a VM object as input. Use the **New-AzVMConfig** cmdlet to create a virtual machine object. When you're creating a VM, several options are available, such as operating system image, network configuration, and administrative credentials. You can use other cmdlets to configure the VM, such as **Set-AzVMOperatingSystem**, **Set-AzVMSourceImage**, **Add-AzVMNetworkInterface**, and **Set-AzVMOSDisk**.

> **Additional reading:** For more information about the parameters that you can use with the **New-AzVM** command, refer to [New-AzVM](https://aka.ms/new-azvm).

Before you run the **New-AzVM** command, you need to specify the credentials that you'll use to sign in to the newly created Azure VM. The credentials that you specify during this process will be assigned with local administrative privileges on the VM you're creating. It's easiest to store these credentials in a variable, before creating a new Azure VM. To do this, run this command:

```powershell
$cred = Get-Credential
```

When you run this command, you'll be prompted to provide the username and password for the Azure VM. These credentials will be stored in the `$cred` variable.

After you store administrative credentials, you need to define parameters for the new VM. You don't need to provide all the parameters that **New-AzVM** supports. Most of them are optional, and if you don't provide them, their default values will be selected. You can also change most of these parameters later.

You can choose to provide VM parameters directly with the **New-AzVM** command, or you can define these parameters in a variable, and then use this variable with the **New-AzVM** command.

The following code depicts an example of defining VM parameters:

```powershell
$vmParams = @{
  ResourceGroupName = 'myResourceGroup'
  Name = 'TestVM'
  Location = 'westeurope'
  ImageName = 'Win2016Datacenter'
  PublicIpAddressName = 'TestPublicIp'
  Credential = $cred
  OpenPorts = 3389
}
```

When you define VM parameters as the previous example depicts, you can then use the following command to create a new Azure VM, based on these parameters:

```powershell
New-AzVM @vmParams
```

Alternatively, you can also choose to provide VM parameters directly with **New-AzVM** as in the following example:

```powershell
New-AzVm `
    -ResourceGroupName "myResourceGroup"
    -Name "myVM"
    -Location "EastUS"
    -VirtualNetworkName "myVnet"
    -SubnetName "mySubnet"
    -SecurityGroupName "myNetworkSecurityGroup"
    -PublicIpAddressName "myPublicIpAddress"
    -Credential $cred
```

## Connect to the Azure VM

After a new Azure VM is created, you need to connect to it to verify the deployment. After the deployment has completed, create a remote desktop connection with the VM.

Run the following commands to return the public IP address of the VM. Take note of this IP address so you can connect to it with your browser to test web connectivity in a future step.

```powershell
Get-AzPublicIpAddress -ResourceGroupName "myResourceGroup"  | Select IpAddress
```

To create a remote desktop session with the VM, use the following command on your local machine. Replace the IP address with the *publicIPAddress* of your VM. When prompted, enter the credentials you used when creating the VM.

```powershell
mstsc /v:<publicIpAddress>
```

When you run this command, you'll be prompted for credentials to connect to the VM. In the Windows Security window, select **More choices**, and then select **Use a different account**. Enter the username and password you created for the VM, and then select **OK**. After you connect to your Azure VM through Remote Desktop Protocol (RDP), you'll be able to manage it the same way as any other computer.
