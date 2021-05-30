> [!NOTE]
> The first time you activate a sandbox and accept the terms, your Microsoft account is associated with a new Azure directory named Microsoft Learn Sandbox. You're also added to a special Concierge Subscription.

## Exercise: Change the performance tier of Azure managed disk

Suppose you run an accounting application that stores data on Azure VMs that are running SQL Server. The application runs periodic jobs that demand higher performance for short periods. However, most of the time, it runs at a baseline performance level. To manage these performance requirements, you must:

- Create a managed disk and add that to a VM.
- Change the disk-performance settings on a VM.

In this exercise, you'll make changes to a VM by using the Azure portal. You’ll first sign in to the portal. You’ll then create a VM with an additional managed data disk.

### Task 1: Create a VM

1. Sign in to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com) using your subscription account.
2. On the Azure portal menu or from the  **Home**  page, select  **Create a resource**.
3. From the list of  **Popular** elements in Azure Marketplace, select **Windows Server 2019 VM**.
4. On the **Basics** tab, enter the following values for each setting.

    | **Setting** | **Value** |
    | --- | --- |
    | Subscription | Select your subscription |
    | Resource group | Create a new resource group. |
    | Virtual machine name | **accountingVM** |
    | Region | **West Central US** |
    | Availability options | No infrastructure redundancy is required. |
    | Image | **Windows Server 2019 Datacenter – Gen 1** |
    | Azure Spot instance | Do not select the checkbox.|
    | Size | Retain the default size of  **Standard_D1s_v2 - 1 vcpu 3.5 GiB memory**. |
    | Username | **Student** |
    | Password/Confirm password | **Pa55w.rd1234** |

5. Retain the default entries for the remaining fields, and then select  **Next : Disks >**.
6. On the  **Disks**  pane, notice that the VM has one disk (the OS disk).
7. Retain the default setting for **Encryption type**.
8. In the **Data disks** section, select the **Create and attach a new disk** link.
9. On the **Create a new disk** pane, accept the defaults for **Name** and **Source type**, and then select the **Change size** link.
10. On the **Select a disk size** pane, from the **Disk SKU** drop-down menu, select **Ultra Disk**.
11. Enter the following values for each setting:

    | Setting | Value |
    | --- | --- |
    | Custom disk size (GiB) | 4 |
    | Performance tier | P1 - 120 IOPS, 25 MBps (default) |

12. Select **OK** twice to finish creating the data disk.
13. Retain the default values for the remaining settings, and then select **Review + create**.
14. After reviewing your new VM settings, select  **Create**  to start deploying your new VM.

    > [!Note]
    > VM creation can take a few minutes as it creates resources that are required to support the VM, such as storage and network interface. Wait until the VM finishes deploying before you continue with the exercise.

### Task 2: Initialize a new data disk

1. In the Azure portal, in the **Search resources, services, and docs** text box, enter **virtual machines**, and then select Enter.
2. On the **Virtual machines** page, locate and select the **accountingvm** VM.
3. On the toolbar, select **Connect**, and then select **RDP**. In the **Connect with RDP** section, select **Download RDP File**, and open it to initialize the remote desktop connection (RDP) to the VM.
4. Sign in to the VM using the following credentials:

- Username: **Student**
- Password: **Pa55w.rd1234**

5. After you connect to the VM, select the **Start**  menu in the running VM, and then enter **diskmgmt.msc**  in the search box. The **Disk Management** console opens.
6. Disk Management recognizes that you have a new, uninitialized disk and the  **Initialize Disk**  window appears.
7. Verify the new disk is selected, and then select  **OK**  to initialize it.
8. The new disk appears as **unallocated**. Right-click anywhere on the disk, and then select  **New simple volume**. The **New Simple Volume Wizard** window opens.
9. Proceed with the next steps in the wizard and retain all default settings. When you're done, select  **Finish**.
10. Close  **Disk Management**.
11. Minimize the RDP connection.

### Task 3: Change the performance of the data disk in the portal

1. Select the **accountingVM** resource to open the VM details in the portal. Alternatively, you can select  **All resources** , and then select your VM,  **accountingVM**.
2. On the left pane, under  **Settings**, select **Disks**.
3. On the **accountingVM_DataDisk_0** pane, observe that the VM has one OS disk and one data disk.
4. Select the link with the name of the data disk.
5. On the **disk** page, from the **Settings** section, select **Size + performance**.
6. On the **accountingVM_DataDisk_0 | Size + performance** page, enter the following values for each setting:

| Setting | Value |
| --- | --- |
| Custom disk size (GiB) | 4 |
| Performance tier | P10 - 500 IOPS, 100 MBps |

7. Select **Resize** to change the performance of the disk.

    > [!Note]
    > Notice that you don't need to deallocate the disk to perform the resize operation.

In this exercise, you used the Azure portal to add a data disk on a new VM and change the data disk’s performance.
