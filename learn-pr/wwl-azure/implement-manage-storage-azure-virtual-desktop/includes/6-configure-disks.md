You will see how to add and configure a new managed data disk to a Windows virtual machine (VM) by using the Azure portal. The size of the VM determines how many data disks you can attach.

## Add a data disk

1.  Go to the Azure portal to add a data disk. Search for and select **Virtual machines**.
2.  Select a virtual machine from the list.
3.  On the **Virtual machine** page, select **Disks**.
4.  On the **Disks** page, select **Add data disk**.
5.  In the drop-down for the new disk, select **Create disk**.
6.  In the **Create managed disk** page, type in a name for the disk and adjust the other settings as necessary. When you're done, select **Create**.:::image type="content" source="../media/create-a-disk-1906b02f.png" alt-text="Image of the create managed disk page.":::
    

7.  In the **Disks** page, select **Save** to save the new disk configuration for the VM.
8.  After Azure creates the disk and attaches it to the virtual machine, the new disk is listed in the virtual machine's disk settings under **Data disks**.

## Initialize a new data disk

1.  Connect to the VM.
2.  Select the Windows **Start** menu inside the running VM and enter **diskmgmt.msc** in the search box. The **Disk Management** console opens.
3.  Disk Management recognizes that you have a new, uninitialized disk and the **Initialize Disk** window appears.
4.  Verify the new disk is selected and then select **OK** to initialize it.
5.  The new disk appears as **unallocated**. Right-click anywhere on the disk and select **New simple volume**. The **New Simple Volume Wizard** window opens.
6.  Proceed through the wizard, keeping all of the defaults, and when you're done select **Finish**.
7.  Close **Disk Management**.
8.  A pop-up window appears notifying you that you need to format the new disk before you can use it. Select **Format disk**.
9.  In the **Format new disk** window, check the settings, and then select **Start**.
10. A warning appears notifying you that formatting the disks erases all of the data. Select **OK**.
11. When the formatting is complete, select **OK**.
