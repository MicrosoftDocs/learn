You need to take an existing VM and turn it into a reusable custom image that you can use to create new VM instances.

### Linux VMs

- Open Cloud Shell
- Run script to deploy source VM
- Connect to the VM ssh azureuser@x.x.x.x
- Deprovision the VM 

       `sudo waagent -deprovision+user -force; exit`

- Deallocate and mark the VM as generalized 

        `az vm deallocate --resource-group myResourceGroup --name myVM`

Set the state of the VM as generalized so the Azure platform knows the VM has been generalized 

        `az vm generalize --resource-group myResourceGroup --name myVM`

Create the image az image create --resource-group myResourceGroup --name myImage --source myVM

Create VMs from the image

az vm create \
  --resource-group myResourceGroup \
  --name myVMfromImage \
  --image myImage \
  --admin-username azureuser \
  --generate-ssh-keys

### Windows VM

- Run a script to build a VM
- Generalize the Windows VM by running sysprep
- In powershell, create some variables:
    
```azurepowershell
- $vmName = "myVM"
    - $rgName = "myResourceGroup"
    - $location = "EastUS"
    - $imageName = "myImage"
```


- Make sure the VM has been deallocated:

        `Stop-AzVM -ResourceGroupName $rgName -Name $vmName -Force`


- Get the virtual machine

        $vm = Get-AzVM -Name $vmName -ResourceGroupName $rgName

- Create the image configuration

        $image = New-AzImageConfig -Location $location -SourceVirtualMachineId $vm.Id

- Create the image

        New-AzImage -Image $image -ImageName $imageName -ResourceGroupName $rgName

The below command creates a VM named myVMFromImagefrom the image named myImage:


```azurepowershell
New-AzVm `
    -ResourceGroupName "myResourceGroup" `
    -Name "myVMfromImage" `
	-ImageName "myImage" `
    -Location "East US" `
    -VirtualNetworkName "myImageVnet" `
    -SubnetName "myImageSubnet" `
    -SecurityGroupName "myImageNSG" `
    -PublicIpAddressName "myImagePIP" `
    -OpenPorts 3389
```
