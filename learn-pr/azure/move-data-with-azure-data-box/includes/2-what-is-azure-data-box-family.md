As the administrator for the autonomous vehicle company, you need an easy, secure, and relatively inexpensive way to regularly import enormous amounts of telemetry data your vehicles generate every day. However, you can't dedicate your entire network bandwidth to the task. You decide to look at Azure Data Box family, a family of physical and virtual devices that aims to solve this type of scenario. Each device attempts to meet the slightly different needs and priorities of customers looking for a solution in this space.

In this unit, you will learn about the five products in the Azure Data Box family.

## Azure Data Box products

The Azure Data Box family can be divided into two groups, for *offline* and *online* data transfer usage. Offline data transfer allows large amounts of data to be moved to Azure whenever you have time, network bandwidth, or cost constraints. As your organization doesn't want to tie up its network bandwidth while shifting the vehicle data to Azure, this scenario might be ideal.

### Offline data transfer

The devices in the offline grouping include:

- **Data Box Disk**: Provides one ~35-TB transfer to Azure. Connect and copy data over USB.
- **Data Box**: Provides one ~80-TB transfer to Azure per order. Connect and copy data to the device over standard network interfaces protocols like SMB and NFS.
- **Data Box Heavy**: Provides one ~800-TB transfer to Azure. Use the high-throughput network interfaces to connect and copy data to the device using standard network interfaces protocols like SMB and NFS. Data Box Heavy is like two Data Boxes each with an independent node.

### Online data transfer

Online data transfer allows a link between your on-premises assets and Azure. Transferring huge amounts of data into Azure is similar to copying data to a networking share. Online data transfer is ideal when you need to have a continuous link to transfer a massive amount of data.

- **Data Box Edge**: This device is a dedicated appliance with 12 TB of local SSD storage. It can pre-process and run machine learning on data before uploading it to Azure.
- **Data Box Gateway**: This device is an entirely virtual appliance that's based on a virtual machine that you provision in your on-premises environment.

Having considered all these devices, you decide to focus on Azure Data Box Disk. It's a physical device that enables terabytes of data to be sent quickly, cheaply, and securely. You can place the devices in the autonomous vehicles and upload data while the car sensors are generating data.
