> [!NOTE]
> The first time you activate a sandbox and accept the terms, your Microsoft account is associated with a new Azure directory named Microsoft Learn Sandbox. You're also added to a special subscription named Concierge Subscription.

## Exercise - Change the performance tier of Azure managed disk

Suppose you run an accounting application that is storing the data on Azure virtual machines (VM) running SQL Server. The application run periodic jobs that demand higher performance for short periods, but otherwise experience baseline performance most of the time. You want to make the following adjustments:

- You need to create a managed disk and add that to a VM.
- You need to change the disk performance settings on a VM.

You've decided to make these changes through the Azure portal.

In this exercise, you'll walk through making the changes to a VM just described. First, sign in to the portal and create a VM with additional managed data disk.

### Create a virtual machine

1. Sign in to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com) using your subscription account.
2. On the Azure portal menu or from the  **Home**  page, select  **Create a resource**.
3. From the list of  **Popular**  Marketplace elements select **Windows Server 2019 VM**.
4. On the  **Basics**  tab, enter the following values for each setting.

| **Setting** | **Value** |
| --- | --- |
| Subscription | Select your subscription |
| Resource group | Create a new resource group |
| Virtual machine name | **accountingVM** |
| Region | **West Central US** |
| Availability options | No infrastructure redundancy required |
| Image | **Windows Server 2019 Datacenter – Gen 1** |
|Azure Spot instance | do not select the checkbox|
| Size | Leave the default  **Standard_D1s_v2 - 1 vcpu 3.5 GiB memory** |
| Username | **Student** |
| Password/Confirm password | **Pa55w.rd1234** |

5. Leave the defaults for the remaining fields, and select  **Next : Disks >**.
6. On the  **Disks**  pane, the VM has one disk, the OS disk.
7. Leave the default setting for **Encryption type.**
8. In the **Data disks** section select the link for **Create and attach a new disk.**
9. On the **Create a new disk** pane, accept the defaults for **Name** and **Source type** and select the link for **Change size.**
10. On the **Select a disk size** pane, from the **Disk SKU** drop menu select **Ultra Disk.** Enter the following values for each setting:

|||
| --- | --- |
| Custom disk size (GiB) | 4 |
| Performance tier | **P1 - 120 IOPS, 25 MBps (default) |

11. Select **OK** twice to finish creation of data disk.
12. Leave the remaining setting as default and select **Review + create.**
13. After reviewing your new VM settings, select  **Create**  to start the deploying your new VM.

>[!Note]
>VM creation can take a few minutes as it creates all the various resources (storage, network interface, and so on) to support the VM. Wait until the VM has deployed before continuing with the exercise.

## Initialize a new data disk

1. In the Azure portal, in the Search resources, services, and docs text box, enter virtual machines, and then select Enter.
2. On the Virtual machines page, locate and select the **accountingvm** virtual machine.
3. From the toolbar select **Connect** and then **RDP**. In the **Connect with RDP** section select **Download RDP File** and open to initialize remoted desktop connection to the VM.
4. Sign in to the VM using the following credentials:

Username: **Student**

Password: **Pa55w.rd1234**

5. Once that you connect to the VM select the Windows  **Start**  menu inside the running VM and enter  **diskmgmt.msc**  in the search box. The  **Disk Management**  console opens.
6. Disk Management recognizes that you have a new, uninitialized disk and the  **Initialize Disk**  window appears.
7. Verify the new disk is selected and then select  **OK**  to initialize it.
8. The new disk appears as  **unallocated**. Right-click anywhere on the disk and select  **New simple volume**. The  **New Simple Volume Wizard**  window opens.
9. Proceed through the wizard, keeping all of the defaults, and when you're done select  **Finish**.
10. Close  **Disk Management**.
11. Minimize the RDP connection.

**Change the performance of the data disk in the portal**

1. Select the  **accountingVM**  resource to open the VM details in the portal. Alternatively, you can select  **All resources** , and then select your VM,  **accountingVM**.
2. In the left menu pane, under  **Settings** , select  **Disks**.
3. On the  **accountingVM_DataDisk_0**  pane, the VM has one OS disk and one Data disk.
4. Select the link with the name of the data disk.
5. On the disk page, from the **Settings** section, select **Size + performance.**

1. On the **accountingVM_DataDisk_0 | Size + performance** page enter the following values for each setting:

|||
| --- | --- |
| Custom disk size (GiB) | 4 |
| Performance tier | **P10 - 500 IOPS, 100 MBps |

1. Select **Resize** to change the performance of the disk.

>[!Note]
>Notice that you don't need to deallocate the disk to perform the resize operation.

In this exercise, we used the Azure portal to add a data disk on a new VM, and change the performance of the data disk.
