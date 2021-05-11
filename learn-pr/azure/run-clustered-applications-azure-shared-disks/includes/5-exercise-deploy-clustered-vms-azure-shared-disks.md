> [!NOTE]
> The first time you activate a sandbox and accept the terms, your Microsoft account is associated with a new Azure directory named Microsoft Learn Sandbox. You're also added to the special Concierge Subscription.

## Exercise: Using Azure shared disks

Your CTO needs to provide proof of concept for using Azure shared disks to deploy a clustered application in Azure VMs. You've been asked to test clustered scenarios with both Linux and Windows VMs.

## Exercise 1: Use Linux VMs with Azure shared disks

To provide proof of concept you will deploy two Linux VMs running the Ubuntu Server OS and test the SCSI PR commands on the Azure shared disk.
In this exercise, you'll explore Azure shared disk deployment and perform the following tasks:

- Create an Azure shared disk.
- Create a proximity placement group.
- Create an availability set.
- Deploy two VMs that are running Ubuntu Server OS, and then attach a shared disk to the two VMs.
- Test SCSI PR commands.

## Task 1: Create Azure shared disk

1. Open a browser and navigate to the following URL:

     [https://portal.azure.com](https://portal.azure.com/)

2. Log into Azure portal using your subscription credentials.
3. From the Azure portal tool bar, select **Cloud Shell** icon.

    > [!Note]
    > Perform the next step if you are opening the cloud shell for the first time, otherwise proceed with step 5.

4. In the  **You have no storage mounted**  pane, select **Show advanced settings**, and then perform the following tasks:

    - Retain the default value for the **Subscription**  drop-down list item.
    - In the  **Cloud Shell region**  drop-down list, select the Azure region matching or near the location where you intend to deploy resources in this exercise.
    - In the  **Resource group**  section, select or create a new resource group.
    - In the  **Storage account**  section, ensure that the  **Create new**  option is selected and then, in the text box under that option, enter a unique name consisting of a combination of between 3 and 24 characters and digits.
    > [!Note]
    > Storage Account names must be lowercase.
    - In the  **File share**  section, ensure that the  **Create new**  option is selected and then, in the text box below, enter **cloudshell**.
    - Select  **Create storage**.

5. Wait until the cloud shell is initialized, and then in the Bash shell, run the following commands:

    Azure CLI

```bash
#Create a resource group
az group create --name myResourceGroup --location eastus

# Create Azure Shared disk with support concurent access from two VMs.
az disk create -g myResourceGroup -n mySharedDisk --size-gb 1024 -l eastus --sku Premium\_LRS --max-shares 2
```

## Task 2: Create proximity placement group and availability set

1. While you are still in the cloud shell, run the following commands to create a proximity placement group.

```bash
# Create proximity placement group.
az ppg create \
-n myPPG \
-gmyResourceGroup \
-l eastus \
-t standard
```

>[Note!]
>Proximity placement group is not required for using shared disk with clustered applications, but in general provides better performance when is used.

2. Run the following command to create an availability set:

```bash
# Create a managed availability set by using New-AzAvailabilitySet with the -sku aligned parameter.
az vm availability-set create \
--resource-group myResourceGroup \
--name myAvailabilitySet \
--platform-fault-domain-count 2 \
--platform-update-domain-count 2 \
--ppg myPPG
```

## Task 3: Create two VMs that are running Ubuntu Server

1. While you're still in the cloud shell, run the following commands to create two VMs running Ubuntu OS:

```bash
for i in `seq 1 2`; do

az vm create --resource-group myResourceGroup --name myVM$i --availability-set myAvailabilitySet --ppg myPPG --size Standard_DS1_v2 --vnet-name myVnet --subnet mySubnet --image UbuntuLTS --admin-username azureuser --generate-ssh-keys

done
```

2. Record the public IP addresses that are created for both VMs. You'll need them to connect to the VMs using secure shell (SSH).

## Task 4: Attach an Azure shared disk on both VMs

1. While you're still in the cloud shell, attach the Azure shared disk to both VMs: 

```bash
diskId=$(az disk show -g myResourceGroup -n mySharedDisk --query 'id' -o tsv)

# attach the shared disk to the first VM.
az vm disk attach -g myResourceGroup --vm-name myVM1 --name $diskId

# attach the shared disk to the second VM.
az vm disk attach -g myResourceGroup --vm-name myVM2 --name $diskId
```

2. When finished with this task, the shared disk is attached to two VMs at the same time.

## Task 5: Test SCSI persistent reservations using the "sg3-utils" tools

1. While you're still in the cloud shell, connect to the first VM by using SSH.
2. Use the following command to retrieve the IP addresses of VM1: 

```bash
az network public-ip show --resource-group myResourceGroup --name myVM1PublicIP --query [ipAddress,publicIpAllocationMethod,sku] --output table
```

3. Connect to the first VM by using SSH:

```bash
ssh azureuser@myPublicIP1
```

4. When prompted for **Are you sure you want to continue connecting (yes/no)?**, enter **yes**, and then select **Enter.**
5. To install **sg3-utils**, run the following command, select **Enter**, enter **Y**, and then select **Enter** to continue installing.

```bash
# Install sg3-utils
sudo apt-get install sg3-utils

# Read the current reservation. This command will identify the current reservations that exist for the shared disk. Since this is the first time that we run, there should be no new reservations.
sudo sg\_persist /dev/sdc -s
```

:::image type="content" source="../media/05-Disk-status-without-VM-registration.PNG" alt-text="Disk-status-without-VM-registration." border="true":::

```bash
# Register new reservation key 1234 on **myVM1**. This command will provide SCSI_PR registration, which ensure that VM1 can read or write to the new shared disk.
sudo sg\_persist --register --device /dev/sdc --param-rk=0 --param-sark=1234 --out

# Read back the keys on VM1. Now the command should show one reservation  to the shared disk for VM1.
 sudo sg\_persist /dev/sdc -s

# Exit the secure shell session from **myVM1**
Exit
```
:::image type="content" source="../media/05-Disk-status-with-VM1-registration.PNG" alt-text="Disk-status-with-VM1-registration." border="true":::


5. Connect to the second VM by using SSH:

```bash
az network public-ip show --resource-group myResourceGroup --name myVM2PublicIP --query [ipAddress,publicIpAllocationMethod,sku] --output table

ssh azureuser@myPublicIP2
```

6. When prompted for **Are you sure you want to continue connecting (yes/no)?**, enter **yes**, and then select **Enter.**
7. To install **sg3-utils**, run the following command, select **Enter**, enter **Y**, and then select  **Enter** to continue installing.

```bash
# Install sg3-utils
sudo apt-get install sg3-utils

# Register the key 1235 on VM2. This command will provide SCSI_PR registration for VM2, so it can read or write on the shared disk.
sudo sg\_persist --register --device /dev/sdc --param-rk=0 --param-sark=1235 --out

# Read back the keys for the shared disk. Now it should show 2 reservation to the shared disk for both VM1 and VM2.
sudo sg\_persist /dev/sdc -s

exit
```

:::image type="content" source="../media/05-Disk-status-with-VM1-and-VM2-registrations.PNG" alt-text="Disk-status-with-VM1-and-VM2-registrations." border="true":::

8. Connect to **myVM1** using SSH:

```bash
ssh azureuser@myPublicIP1

# Reserve the device with exclusive write permission. This command will ensure that VM1 has exclusive write to the disk, while any write from VM2 will not succeed.
sudo sg\_persist --reserve --device /dev/sdc --param-rk=1234 --prout-type=1 --out

# Check the reservation on the device.
sudo sg\_persist /dev/sdc -s
exit
```

:::image type="content" source="../media/05-Disk-status-with-VM1-reservation.PNG" alt-text="Disk-status-with-VM1-reservation." border="true":::

9. Connect to **myVM2** by using SSH:

```bash
ssh azureuser@myPublicIP2

# Preemt the DEVICE from **myVM2**. This command will take over the exclusive write operation from VM1. Now VM2 has write access to the disk.
sudo sg\_persist --preempt --device /dev/sdc --param-rk=1235 --param-sark=1234 --prout-type=5 --out

# Report capabilities. Verify that reservation exist for VM2 with key 1235.
sudo sg\_persist /dev/sdc -c
```

:::image type="content" source="../media/05-Disk-status-with-VM2-reservation.PNG" alt-text="05-Disk-status-with-VM2-reservation." border="true":::

```bash
# Unregister from **myVM2**. This command release access to the shared disk.
sudo sg\_persist --out --register --param-rk=1235 --param-sark=0 --device /dev/sdc

# Report capabilities.
sudo sg\_persist /dev/sdc -s

# Exit the SSH from VM2
exit
```

## Task 6. Clean up the resources

When you no longer need a resource group, use **az group delete** to remove the resource group and all of the resources it contains.

Azure CLI

```bash
az group delete --name myResourceGroup --yes
```

> [!Note]
> Exercise 2 uses the same resource group name, so you should delete the previouse one from Exercise 1, or start the Exercise 2 with a new resource group that has a different name.

## Exercise 2: Use Windows VMs by using Azure shared disks

To further demonstrate the functionality of Azure shared disk you will deploy two Windows VMs running Windows server operating system (OS) and test SCSI PR commands on the Azure shared disk.

In this exercise, you&#39;ll explore Azure shared disk deployment and perform the following tasks:

- Create an Azure shared disk.
- Create a proximity placement group.
- Create an availability set.
- Deploy two VMs running Windows Server OS and configure clustered services.
- Test SCSI PR commands.

## Task 1: Create an Azure shared disk

1. Open a browser, and then navigate to the following URL:

    [https://portal.azure.com](https://portal.azure.com/)

2. Sign in to the Azure portal using your subscription credentials.
3. In the Azure portal tool bar, select **Cloud Shell** icon.

    > [!Note]
    > Perform the next step if you're opening the cloud shell for the first time. Otherwise, proceed with step 5.

4. In the  **You have no storage mounted**  pane, select **Show advanced settings**, and then perform the following tasks:

    - Retain the default value for the **Subscription** drop-down list item.
    - In the  **Cloud Shell region**  drop-down list, select the Azure region matching, or near, the location where you intend to deploy resources.
    - In the  **Resource group**  section, select or create a new resource group.
    - In the  **Storage account**  section, ensure that the  **Create new**  option is selected, and then in the text box, under that option, enter a unique name consisting of a combination of between three and 24 characters and digits.
    
        > [!Note]
        > Storage account names must be lowercase.
        
    - In the  **File share** section, ensure that the  **Create new**  option is selected, and then in the text box under that option, enter **cloudshell**.
    - Select the **Create storage** button.

5. Run the following commands:

    Azure PowerShell

```powershell
# Create a resource group
New-AzResourceGroup -Name myResourceGroup -Location "EastUS"

# Create Azure Shared disk
$dataDiskConfig=New-AzDiskConfig -Location "EastUs" -DiskSizeGB 1024 -AccountType Premium_LRS -CreateOption Empty -MaxSharesCount 2
$dataDisk=New-AzDisk -ResourceGroupName "myResourceGroup" -DiskName "mySharedDisk1" -Disk $dataDiskConfig
```

## Task 2: Create a proximity placement group and an availability set

1. While still in the cloud shell, run the following commands to create a proximity placement group:

```powershell
# Create proximity placement group
$ppgName="myPPG"
$resourceGroup="myResourceGroup"
$ppg=New-AzProximityPlacementGroup `
-Location EastUs `
-Name $ppgName `
-ResourceGroupName $resourceGroup `
-ProximityPlacementGroupType Standard
```

2. Run the following command to create an availability set:

```powershell
# Create a managed availability set by using New-AzAvailabilitySet with the -sku aligned parameter.
New-AzAvailabilitySet `
-Location "EastUS" `
-Name "myAvailabilitySet" `
-ResourceGroupName "myResourceGroup" `
-Skualigned `
-PlatformFaultDomainCount 2 `
-PlatformUpdateDomainCount 2 `
-ProximityPlacementGroup $ppg.Id
```

## Task 3: Create two VMs that are running Windows Server

1. While still in the cloud shell, run the following commands to define a credential object for logging to the VMs:

```powershell
$cred = Get-Credential
```

2. Use the following credentials:

- User: **Student**
- Password: **Pa55w.rd1234**

3. Create two VMs that are running Windows OS:

```powershell

for ($i=1; $i-le2; $i++)
{
New-AzVm `
-ResourceGroupName "myResourceGroup" `
-Name "myVM$i" `
-Locationeastus `
-VirtualNetworkName "myVnet" `
-SubnetName "mySubnet" `
-ImageName "MicrosoftWindowsServer:WindowsServer:2019-Datacenter:latest" `
-SecurityGroupName "myNetworkSecurityGroup" `
-PublicIpAddressName "myPublicIpAddress$i" `
-AvailabilitySetName "myAvailabilitySet" `
-ProximityPlacementGroup $ppg.Id `
-Credential $cred
}
```

4. Review the VMs in the placement group.

```powershell
Get-AzProximityPlacementGroup -ResourceId $ppg.Id |
Format-Table -Property VirtualMachines -Wrap
```

## Task 4: Attach an Azure shared disk to both VMs

1. Attach the Azure shared disk to the first VM:

```powershell

$vm1 = Get-AzVM -Name "myvm1" -ResourceGroupName "myResourceGroup"
$vm1 = Add-AzVMDataDisk -VM $vm1 -CreateOption Attach -ManagedDiskId $dataDisk.Id -Lun 0

Update-AzVM -VM $vm1 –ResourceGroupName "myResourceGroup"
```

2. Attach the Azure shared disk to the second VM:

```powershell
$vm2 = Get-AzVM -Name "myvm2" -ResourceGroupName "myResourceGroup"
$vm2 = Add-AzVMDataDisk -VM $vm2 -CreateOption Attach -ManagedDiskId $dataDisk.Id -Lun 0

Update-AzVM -VM $vm2 –ResourceGroupName "myResourceGroup"
```

## Task 5: Install Windows Failover Clustering Service on myVM1

1. In the Azure portal, in the **search resources, services, and docs (G+/)** field, enter **virtual machines** and select **virtual machines.** 
2. Select the first VM, **myVM1**, from the tool bar, select **Connect**, and then select **RDP**.
3. Select **Download RDP File**, and then connect using the following credentials:

    - Username: **Student**
    - Password: **Pa55w.rd1234**
    
4. In Server Manager, from the **Tools** menu, select the **Computer Management** snap in.
5. In the **Computer Management (Local)** management console, select **Disk Management**.
6. In the **Initialize Disk** window , verify that **Disk 2** is selected, and then select **OK**.
7. Right-click or select the black label on **Disk 2**, and then select **New Simple Volume**. Accept the defaults to create new simple volume.
8. Close the **Computer Management** console.
9. In **Server Manager**, select **Add roles and features**. The **Add Roles and Features** wizard opens.
10. In the **Add Roles and Features** wizard, in the **Before you Begin** page, select **Next**.
11. In the **Select installation type** page, select **Role-based or feature-based installation**, and then select **Next.**
12. In the **Server Selection** page, select **Next**.
13. In the **Select server roles** page, select **Next**.
14. In the **Select features** page, select the **Failover Clustering** checkbox.
15. Verify that the **Include management tools (if applicable)** checkbox is selected, and then select **Add Features**. Select **Next** to proceed.
16. In the **Confirmation** page, select the **Restart the destination server automatically if required** checkbox, and then select **Yes**. Select **Install** to install the Failover Clustering role.

    >[!Note]
    >The virtual machine **myVM1** will automatically restart, once that failover cluster feature is installed.

## Task 6: Install Windows Failover Clustering Service on myVM2

1. In the Azure portal, in the **search resources, services, and docs (G+/)** field, enter **virtual machines** and select **virtual machines.**
2. Select the second VM, **myVM2** , from the tool bar, select **Connect**, and then select **RDP.**
3. Select **Download RDP File**, and then connect using the following credentials:

    - Username: **Student**
    - Password: **Pa55w.rd1234**

4. In Server Manager, from the **Tools** menu, select the **Computer Management** snap in.
5. In the **Computer Management (Local)** management console, select **Disk Management**.
6. In the **Initialize Disk** window, verify that **Disk 2** is selected, and then select **OK**.
7. Right-click  or select the black label on **Disk 2**, and then select **New Simple Volume**. Accept the defaults to create a new simple volume.
8. Close the **Computer Management** console.
9. In **Server Manager**, select **Add roles and features**. The **Add Roles and Features** wizard opens.
10. In the **Add Roles and Features** wizard, in the **Before you Begin** page, select **Next**.
11. In the **Select installation type** page, select **Role-based or feature-based installation**, and select **Next**.
12. In the **Server Selection** page, select **Next**.
13. In the **Select server roles** page, select **Next**.
14. In the **Select features** page, select the **Failover Clustering** checkbox.
15. Verify that the **Include management tools (if applicable)** checkbox is selected, and then select **Add Features**. Select **Next** to proceed.
16. In the **Confirmation** page, select the **Restart the destination server automatically if required**, and then select **Yes.** Select **Install** to install the Failover Clustering role.

    >[!Note]
    >The virtual machine **myVM2** will automatically restart, once that failover cluster feature is installed. 

## Task 7: Test the storage for Windows Failover Clustering Service on myVM1

1. In the Azure portal, in the **search resources, services, and docs (G+/)** field, enter and select **virtual machines.**
2. Select the first VM, **myVM1** , from the tool bar, and then select **Connect**, and select **RDP**.
3. Select **Download RDP File**, and then connect using the following credentials:

    - Username: **Student**
    - Password: **Pa55w.rd1234**

4. In Server Manager, from the **Tools** menu, select **Failover Cluster Manager**.
5. In **Failover Cluster Manager**, from the **Action** menu, select **Validate Configuration**. The **Validate a Configuration Wizard** opens.
6. In the **Validate a Configuration Wizard**, in the **Before You Begin** page, select **Next**.
7. In the **Select Servers or a Cluster** page, in the **Enter Name** field, enter **myVM1**, and then select **Add**.
8. Repeat the same procedure to add **myVM**.
9. Select **Next** to proceed with testing the cluster setup.
10. In the **Testing Options** page, select **Run only test I select**, and then select **Next**.
11. Select the **Storage** checkbox, and then select **Next**.
12. In the **Confirmation** page, select **Next**.
13. Verify that all the tests are successful, and then select **Finish**.
14. Close the RDP connection.

    >[!Note]
    >To proceed the creation of the cluster, you need to setup additional prerequsites, such as Active Directory Domain Services, create a static IP address that you will use for internal load balancer.
    >This step is out of scope for this exercise.

## Task 8: Clean up the resources

1. In the Azure portal, select the **myResourceGroup**, and then select **Delete resource group**.
1. Enter the name of the resource group to confirm the deletion, and then select **Delete**.
