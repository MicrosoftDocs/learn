<introduction paragraph>

## <Part 1 title>

<introduction paragraph>

1. <step 1>

1. <step 2>

1. <step n>

## <Part 2 title>

<introduction paragraph>

1. <step 1>

1. <step 2>

1. <step n>

## <Part n title>

<introduction paragraph>

1. <step 1>

1. <step 2>

1. <step n>

## <Result part title>

<introduction paragraph>

1. <optional step 1>

1. <optional step 2>

1. <optional step n>


## Notes from design doc
**Exercise - Create an image of an Azure VM from the Azure CLI and provision a new VM.**

(Exercise uses zone pivots for Windows and Linux; each pivot starts by running a script to create a VM).

You need to take an existing VM and turn it into a reusable custom image that you can use to create new VM instances. To complete the example in this tutorial, you must have an existing virtual machine. If needed, this [script](https://docs.microsoft.com/azure/virtual-machines/scripts/virtual-machines-linux-cli-sample-create-vm-nginx) sample can create one for you. When working through the tutorial, replace the resource group and VM names and IPs where needed.

Windows pivot

1.  Open Cloud shell
2.  Run script to deploy source VM
3.  Use Azure portal to launch RDP connection to VM
4.  Run sysprep to generalize the VM

Linux pivot

1.  Open Cloud Shell
2.  Run script to deploy source VM
3.  Connect to the VM`ssh azureuser@52.174.34.95`
4.  Deprovision the VM`sudo waagent -deprovision+user -force; exit`

Common pivot

1.  

Deallocate and mark the VM as generalized`az vm deallocate --resource-group myResourceGroup --name myVM`

2.  

Set the state of the VM as generalized so the Azure platform knows the VM has been generalized`az vm generalize --resource-group myResourceGroup --name myVM`

3.  

Create the image`az image create --resource-group myResourceGroup --name myImage --source myVM`

4.  

Create VMs from the image

`az vm create \  --resource-group myResourceGroup \  --name myVMfromImage \  --image myImage \  --admin-username azureuser \  --generate-ssh-keys`
