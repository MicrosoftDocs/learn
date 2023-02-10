You can protect your data by taking backups at regular intervals. Azure provides several backup options for virtual machines to support different scenarios and configuration requirements.

### Things to know about backup options for virtual machines 

Let's examine four options for backing up your virtual machines: Azure Backup, Azure Site Recovery, and Azure managed disks snapshots and images. The following table summarizes these options and provides scenarios for using the different methods. As you review these options, think about which method can support the requirements for the business scenario presented in this module.

| **Backup option** | **Configuration scenarios** | **Description** | 
| --- | --- | --- |
| **Azure Backup** | _Back up Azure virtual machines running production workloads_ <br><br> _Create application-consistent backups for both Windows and Linux virtual machines_ | Azure Backup takes a snapshot of your virtual machine and stores the data as recovery points in geo-redundant recovery vaults. When you restore from a recovery point, you can restore your entire virtual machine or specific files only. | 
| **Azure Site Recovery** |_Quickly and easily recover specific applications_ <br><br> _Replicate to the Azure region of your choice_ | Azure Site Recovery protects your virtual machines from a major disaster scenario when a whole region experiences an outage due to a major natural disaster or widespread service interruption. | 
| **Azure managed disks snapshot** | _Quickly and easily back up your virtual machines that use Azure managed disks at any point in time_ <br><br> _Support development and test environments_ | An Azure managed disks snapshot is a read-only full copy of a managed disk that's stored as a standard managed disk by default. A snapshot exists independent of the source disk and can be used to create new managed disks. Each snapshot is billed based on the actual size used. If you create a snapshot of a managed disk with a capacity of 64 GB that's used only 10 GB, you're billed for 10 GB. | 
| **Azure managed disks image** | _Create an image from your custom VHD in an Azure storage account or directly from a generalized (via Sysprep) virtual machine_ <br><br> _Create hundreds of virtual machines by using your custom image without copying or managing any storage account_ | Azure managed disks also support creating a managed custom image. This process captures a single image that contains all managed disks associated with a virtual machine, including both the operating system and data disks. | 

### Things to consider when creating images versus snapshots

It's important to understand the differences and benefits of creating an image and a snapshot backup of an Azure managed disk.

- **Consider images**. With Azure managed disks, you can take an image of a generalized virtual machine that's been deallocated. The image includes all of the disks attached to the virtual machine. You can use the image to create a virtual machine that includes all of the disks.

- **Consider snapshots**. A snapshot is a copy of a disk at the point in time the snapshot is taken. The snapshot applies to one disk only, and doesn't have awareness of any disk other than the one it contains. Snapshot backups are problematic for configurations that require the coordination of multiple disks, such as striping. In this case, the snapshots need to coordinate with each other, but this functionality isn't currently supported.

- **Consider operating disk backups**. If you have a virtual machine with only one disk (the operating system disk), you can take a snapshot or an image of the disk. You can create a virtual machine from either a snapshot or an image.