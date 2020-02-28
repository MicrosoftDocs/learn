# Module design

## Title

Move large amounts of data to the cloud by using Azure Data Box family

## Role(s)

Administrator

## Level

Beginner

## Product(s)

- Azure Data Box Disk
- Azure Storage
- Azure Blobs

## Prerequisites

Familiarity with Azure Storage and Azure Blobs

## Summary

Evaluate Azure Data Box family to import TBs of data from a local computer to Azure Blob storage. Order disks. Copy data to disks and return them. Verify the data is uploaded to Azure.

## Learning objectives

1. Decide which Azure Data Box device to use
1. Identify the steps to import data by using Azure Data Box Disk

## Chunk your content into subtasks

Identify the subtasks of *Move large amounts of data to the cloud by using Azure Data Box family*

| Subtask | What part of the introduction scenario does this subtask satisfy? | How will you assess it: **Exercise or Knowledge check**? | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
| ---- | ---- | ---- | ---- | ---- |
| Decide which Azure Data Box device to use | Import 5 - 20 TB of telemetry data daily without tying up network bandwidth | Knowledge Check | 1 | Yes |
| Identify the steps to import data by using Azure Data Box Disk | Select an easy, secure, and relatively inexpensive way to regularly import the data to Azure | Knowledge Check | 2 | Yes |
| | | | | |

## Outline the units

1. **Introduction**

     Some organizations need to import very large quantities of data in Azure.

     Suppose you're an administrator for an organization that's developing autonomous vehicles. These vehicles can generate anywhere from 5 to 20 TB of telemetry data every day. Your organization needs to keep this data for research and legal purposes. You decide to store the data in Azure Blob storage. But you need an easy, secure, and relatively inexpensive way to regularly import the data to Azure without tying up your network bandwidth.

     In this module, you will learn how to use the Azure Data Box family to import terabytes of data into an Azure Storage account.

1. **What is the Azure Data Box family?**

    List the content that will enable the learner to *Describe the Azure Data Box family*:

    - Describe Azure Data Box Disk and its benefits in detail:
        - Enables terabytes of data to be sent quickly, inexpensively, and securely.
        - Minimal setup via the portal.
        - Speedy, no software to install, and secured via AES-128 encryption and other Azure security protocols.
        (Notes from SME to contrast with other devices: All but Disk device offer portal AND local web UI setup. Also the other devices offer AES-256 unlike disk.)
   - Describe Azure Data Box devices for offline scenarios and their benefits and limitations:
        - Offline data transfer allows large amounts of data to be moved to Azure when there are time, network bandwidth, or cost constraints.
        - Data Box provides one 80TB transfer per order via network interfaces (SMB/NFS).
        - Data Box Disk provides one 35TB transfer via USB (Robocopy or Windows Explorer).
        - Data Box Heavy provides one 800TB transfer via high-throughput network interfaces (SMB/NFS/REST). (Note from SME: Data Box Heavy is like 2 Data Boxes. It has two nodes and they’re not aware of each other. You place one order though to get that versus 2 for Data Box.)
    - Describe Azure Data Box devices for online scenarios and their benefits and limitations
        - Online data transfer allows a link from your premises and makes transferring huge amounts of data into Azure similar to accessing a networking share.
        - Online devices have similar capabilities and limits:
            - Data Box Edge offers a dedicated appliance with 12TB of local SSD storage, which can pre-process data and run machine learning on data before upload to Azure.
            - Data Box Gateway is a virtual appliance. 
    - Include a diagram to show the difference between the devices. Use this one or modify so it just includes Data Box family: <https://docs.microsoft.com/azure/storage/common/storage-choose-data-transfer-solution?toc=%2fazure%2fstorage%2fblobs%2ftoc.json>. Diagram is going to be updated by SME. But we could use a version just comparing Data Box devices for now. May need to update it later when they publish a new version of diagram. 
    - Finish the unit by explaining how Data Box Disk will work as a solution for the scenario. They can stick it in the car and upload data while the car sensors are generating data.

    **Knowledge check** - Learn about the Azure Data Box family of devices

    What types of questions will test *Decide which Azure Data Box device to use*?

    - You have network bandwidth constraints and around 70TB of data to import into Azure. Which Azure Data Box device should you order? Per SME answer could be a Data Box or multiple orders of Data Box Disk. 
    - You have a huge amount of data being generated by smart devices and applications at your data center. You need to perform data preprocessing and machine learning on the data before moving it to Azure for deeper analysis. Which Azure Data Box device would use to do this? Per SME: Data Box Edge. Changed "office" to "data center" as we thought office implies personal office and smaller business. 

1. **How the Azure Data Box family works**
   
    List the content that will enable the learner to *How the Azure Data Box family works*:
    
    Outline a typical workflow for using Azure Data Box Disk for data migration and include process diagram:
    
    - Order the requisite number of disks and establish a destination storage account in the portal
    - Receive the disks, connect and unlock them
    - Copy the relevant data
    - Ship them back to the Azure datacenter
    - Upload at the Azure datacenter and secure erasure
      
    Point out that the process is not very different between the devices. Provide high-level outline for all devices and call out any differences.
    
    - Relate it to the scenario of the telemetry data being generated by and stored in the vehicle.
    - Reiterate the workflow: order disks via the portal, receive and unlock them, copy the data, ship back to the Azure datacenter, upload.
    - Explain the tools which can be used to copy the data over.
    - Describe how the process can be sped up, especially in the case of small files.
    - Analyze naming conventions and folder hierarchies to be followed, and verification methods to use, for error-free upload.
    - Explain how the process can be easily repeated for the periodic uploads use case, which is most appropriate for repeatedly shipping telemetry data from vehicles.
    
    **Knowledge check - How Azure Data Box family works**
    
    What types of questions will test *Identify the steps to import data by using Azure Data Box Disk*?
    
    - What method would you use to unlock the disks you have received?
    - What tool can you use to validate the data prior to shipping to Azure? (note that validation tool is only available for Windows not Linux)
    - You are copying a VHD to an Azure Data Box Disk that you have received. The disk already has a folder structure. Where should you copy the VHD? (page blob folder)
    
1. **When to use Azure Data Box family**

    List the content that will enable the learner to *Decide when to use Azure Data Box*:

    - Relate back to the vehicle telemetry scenario.
        
    - Describe typical use cases for Azure Data Box Disk:
        
        - One-time migration
        - Incremental transfer, after using Data Box Disk for the initial seed
        - Periodic uploads (the most appropriate for this module's introductory scenario)
        
    - Briefly compare with other tools, and explain when why you'd use these devices over the other options, and why you'd use this over Azure Import/Export. Use [Key capabilities table](https://docs.microsoft.com/azure/storage/common/storage-solution-large-dataset-low-network?toc=%2fazure%2fstorage%2fblobs%2ftoc.json#comparison-of-key-capabilities) as a reference.
      
        (Compare notes with this module: <https://github.com/MicrosoftDocs/learn-pr/blob/NEW-export-data-azure-import-export/learn-pr/azure/export-data-with-azure-import-export/resources/design-doc.md>. These will be in the same learning path - so don't want to repeat too much. Do a lighter comparison here - maybe just have a diagram to illustrate. The Azure Import/Export module can go into it more).
    
    **Knowledge check** - When to use Azure Data Box
    
    What types of questions will test *Decide when to use Azure Data Box*?
    
    - Which data import method is best for importing daily traffic camera video data when you have low to moderate network bandwidth? Gateway. Scenarios you'd use Edge is where you need to make changes to images (like blur faces)before sending to Azure and you have high bandwidth. Edge is a physical device you have to install. Gateway is just download of VHDX – so quick to install. So as question was written with continuous ingestion and low to moderate network bandwidth, use Gateway to get started quickly.
    - What is the maximum amount of data that can be transferred to Azure in one operation via the Azure Data Box Disk? (35 TB)
    
1. **Summary**

    How did you solve the problem in the initial scenario with the knowledge learned in the module?
    
    Notes have some reasoning to put in as to why you would pick Data Box Disk for the solution to the scenario.

## Notes

- Cover Azure Data Box family device options but focus on Data Box Disk as the solution for this scenario. With that solution, you'd have a compact and portable device that you can put in the vehicle. It doesn't require a power supply or the network. You can have the Data Box Disk copy the telemetry data from the vehicle while it's moving and generating data.
- We can't use sandbox for this option.
- We'd need to assess with knowledge checks as you can't have users do this in sandbox or their own account. They probably don't want to receive or be charged for disks they're not going to use.

## Resources

- [What is Azure Data Box Disk?](https://docs.microsoft.com/azure/databox/data-box-disk-overview) 
- [Quickstart: Deploy Azure Data Box Disk using the Azure portal](https://docs.microsoft.com/azure/databox/data-box-disk-quickstart-portal)
- [Tutorials](https://docs.microsoft.com/azure/databox/data-box-disk-deploy-ordered)
- [Data transfer for large datasets with low or no network bandwidth](https://docs.microsoft.com/azure/storage/common/storage-solution-large-dataset-low-network?toc=%2fazure%2fstorage%2fblobs%2ftoc.json)
- [Pricing](https://azure.microsoft.com/pricing/details/databox/disk/)