Hyper-V Live Migration transfers the state of a VM between two Hyper-V hosts. In some scenarios, you might need to transfer the VM disk files while the guest operating system remains online.

## What is VM storage migration?

With Hyper-V, you can use **Live Migration** to move VM disk files while the corresponding VM is running. You can perform this task by using the **Live Migration Wizard** in Hyper-V Manager or by using Windows PowerShell. This helps with resolving disk space issues on Hyper-V hosts. For example, if you have storage available on another Hyper-V cluster, you can use storage migration to transfer existing VHD files to it without affecting availability of your virtualized workloads.

Another common reason for moving VM disk files is to update the underlying physical storage. You can also move VM disks between physical storage devices in response to reduced performance resulting from increased I/O demand on one of them.

## How does storage migration work?

Moving a VM to another Hyper-V host is a common procedure. You can perform it by using the export operation, directly from the Hyper-V Manager console. However, the export operation involves manual changes and requires temporary downtime. Additionally, it has several limitations, such as lack of support for exporting IDE disks and checkpoints. VM storage migration eliminates these shortcomings and performs all intermediate steps automatically while the VM workloads remain online.

To copy a VHD file of an online VM, you can run the **Live Migration Wizard** from the Hyper-V Manager or use the `Move-VMStorage` Windows PowerShell cmdlet. This triggers creation of a VHD file on the destination storage volume and initiates a copy process. From that point onward, all changes to the VHD file at the source propagate to the destination VHD file. Read operations continue to take place only at the source.

As soon as the copy process completes, Hyper-V starts using the destination VHD. If you decide to migrate VM and its storage, VM starts running on the target Hyper-V host. In either case, the process concludes by deleting the source VHDs.

:::image type="content" source="../media/m29-vm-storage-migration.png" alt-text="The process of storage migration between two storage devices hosting the VHD file of an online VM." border="false":::

The time required to complete a migration depends on the available bandwidth between the source and destination, storage performance at both locations, and the VHD sizes. The speed of the migration process can benefit significantly if the source and destination storage support Windows Offloaded Data Transfers.

If you migrate VM storage from a non-clustered Hyper-V server, select the **Move** action in Hyper-V Manager and, in the **Move Wizard**, choose one of the following options:

- Move all the virtual machine's data to a single location. This requires that you specify a single destination for VHD files, configuration, checkpoints, and smart paging.
- Move the VM's data to different locations. This allows you to specify individual locations for each VM component.
- Move only the virtual machine's virtual hard disks. This allows you to move only the VHD files.

The same options are available if you migrate VM storage on a Hyper-V cluster by using the **Move Virtual Machine Storage** wizard in Failover Cluster Manager.
